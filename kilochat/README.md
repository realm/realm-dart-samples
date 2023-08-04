# kilochat

A sample chat application loosely based on slack, but build with Flutter, Realm, and Atlas Device Sync.

It aims to give a more thorough and realistic example of how to use Realm and Atlas Device Sync with Flutter, than most of the sample apps.

The app demonstrates how to:

1. Re-use credentials on app restart to allow for _offline login_
1. Use federated jwt-based authentication with Firebase Auth.
1. React to connectivity changes to quickly recover.
1. Display sync connection state.
1. Handle soft synchronization errors.
1. Handle client resets (hard sync errors).
1. Display a snackbar when interesting data is synced to device.
1. Animate list views as changes happen in a realm that impacts a live query.
1. Update flexible sync subscriptions to only sync a subset of data dynamically.
1. Handle presence information in a scalable way, using a body-list.
1. Maintain a leader-board collection using an Atlas function that trigger on changes.
1. Use rule-based permissions to ensure users can only manipulate their own data.

It also serves as an example of an app architecture that works well with Realm.
Depending on how you choose to count, it does so in just 1-2K lines of code, hence the name.

## Getting started

### Prerequisites

You need Flutter 3.10.2 or later.

Create the platform projects you are interested in. Only the bare minimum modifications are added in the repo, so you need to create the platform projects on your end. You can choose any platforms except web.

```shell
flutter create . --platforms=android,ios,macos,windows,linux # realm does not support web (yet)
flutter pub get
```

You will need to login with either a google account or email and password. For the latter we have setup 9 different test users (`test1@test.com`, ..., `test9@test.com`), with passwords matching pattern `test<x>!Atlas`. There is no ongoing moderation, so please behave or we will have to disable these shared accounts.

## Setting up your own backend

To make it easy to get started we have a shared backend setup already, but be aware that it is managed by us at MongoDB and shared with the entire world.

> :warning: This also means that this repo contains a set of Firebase API keys, which while **not** really [secret](https://firebase.google.com/docs/projects/api-keys) as such, is not something we would recommend in general.
>
> The repo also contains an atlas application identifier (`app_id`) which is **not** a secret, but should not be shared if the app service has developer mode enabled. The reason for this being that developer mode allows clients to do automatic schema changes

To setup your own backend you need to setup both Firebase Auth with Google and Atlas Device Sync with MongoDB.

You will need the following CLI tools installed to follow these instructions:

- `flutterfire`,
- `atlas`, and
- `atlas-app-services-cli`.

You can get these with:

```shell
dart pub global activate flutterfire
npm install -g atlas-app-services-cli # TODO: is this officially released yet? (or fo we need to use realm-cli?)
brew install mongodb_atlas_cli # TODO: on macos
```

### Firebase Auth

You can follow Google's [instructions](https://firebase.google.com/docs/auth/flutter/start) for setting up Firebase Authentication with Flutter.

### Atlas Device Sync

First you need to setup a cluster.
Then you need to setup Atlas Device Sync.
Then you need to push the schema. Normally during development you would just enable developer mode, and have the client inform the server of the schema implicitly, but this is not how you would go about it in production, so for this sample we will not enable developer mode.

## Offline login

There really is no such thing as _offline login_. A server handshake is always required to perform a login. However realm will cache the returned credentials, and you can re-use these on app restart.

This is done simply by checking `app.currentUser`

```dart
final app = App(AppConfiguration(...));
final user = app.currentUser;
```

if `user` is not null there is already a valid logged-in user, otherwise we need to initiate authentication.
This is similar to how your email client works on your phone.

Realm will try to refresh the associated tokens whenever needed. Obviously that will require the device to be online, but as tokens only need to be valid when actually performing requests, this will require the device to be online anyway. For most practical purposes a user only needs to login on a given device once.

In this sample we federate authentication to firebase. Firebase also persists the currently logged in user, so even if `app.currentUser == null` then we may still have a valid jwt token from firebase, so that the user avoid actually performing authentication.

## Subscriptions

For scalability we don't want to mindlessly push all messages to all users. Instead we need to define what messages a given user is interested in. This is done by maintaining a set of channels that a given user is
currently _subscribed_ to on the user's profile. The user can search for, add and remove channels in the app.

When this happens the subscriptions on the realm needs to be updated. Note that this needs to happen on all devices where the user is currently logged in, as the set of subscribed channels is user-, not device- specific. Hence we need to sync this information and react to changes on all devices where the user is
currently logged in.

## Presence

Presence information is the small green, empty, or sleeping orb you see on other users avatar in apps like slack.

The first problem with presence information is that you want to update it even if a user is _not_ present. Typically this is done by having each user send heart-beats, so that a missing heart-beat indicates the user is not currently present.

A naive approach ends up sending every heart-beat to every user. Creating a storm of communication in an n-complete graph (n being the number of users).

Instead it is better for the server to detect the missing heart-beat and only update the presence of a user
when it happens. This information can then be pushed out to other online users. If a device is itself offline
it should indicate that the presence information of other users are unreliable, since it may have missed an update. The actual heart-beats are prime candidates for asymmetric sync, but we don't support that yet in the
Flutter Realm SDK, so instead we will just update a `heartbeat` timestamp on the `UserProfile`.

Still, this can amount to a lot of updates. To further reduce the amount of pushed presence data it is common to use body-lists. For each user we maintain a lists of other users that they are interested to know presence about. Explicit friends, or just people they recently communicated with.

In a chat-app like this one you also typically want _super-fresh_ information about who is typing messages in the current channel.

A last thing to notice is that it is okay to skip to the latest presence information in most cases. It is
not important for a user to know how many time a friend went online/offline while she herself was offline.
Realm is build to deliver every update in a reliable manner, but by "resetting" the presence subscription
on startup we can indicate it is okay to skip over un-synced data.

The presence system used here is still rather simple. We refer t [A Scalable Server Architecture for Mobile Presence Service in Social Network Applications](https://www.researchgate.net/publication/232657317_A_Scalable_Server_Architecture_for_Mobile_Presence_Service_in_Social_Network_Applications) for the interested reader.

## Leader-board

## Rule-based permissions

Kilochat is a mostly public system, yet we still wan't to prevent bad actors from impersonating others, and make changes to other peoples data, be it their messages, reactions, or user profile.

While the app as implemented won't allow such edits, we cannot rely on the app to enforce this. A malicious actor could reverse engineer the app and implement a version without such restrictions.

Instead it falls on the server to enforce the rules of the system. In our case it is very simple. A user cannot edit objects created by other users, and cannot impersonate others.

This has some implications on our model classes. First, all model classes has an extra `ownerId` property that must be filled with `user.id` upon creation. The backend will check that `ownerId` on any edit match the user id of the session, or revoke the edit (/creation). If this happens, the perpetrator will receive a compensating write, and undo the invalid change, assuming it was due to a bug and not a malicious intent.

A more subtle implication is that a message cannot contain a list of reactions, as only the message owner would be able to update this list. Instead a reaction refer to the message it pertains to and the reactions are accessible from the message via a named backlink property. Each reaction is owned by the user who added it.

The ownership role goes for channels as well. Anyone can create a channel, but only the owner can update or
delete it. The ability to create channels would usually be reserved for admin users, but alas this is after
all just a toy system.

# A bit about modelling

One of the most fundamental thing for a chat system is to keep messages in order. This can cause some challenges in an offline capable system.

Had this been an online system, we could simply use an auto-incrementing integer on the chat messages
to maintain a global order, but we do not have that luxury. And yes, I know Firebase has auto-incrementing integers, but those won't work when offline. Don't get me started on why Firebase is 
not an offline-first capable storage solution at all.

Instead a simple approach is to stamp each message with the local clock of the originating system, and
order by time. If you have done distributed programming before you are likely aware of the problem with this idea, that is clock-drift. Despite NNTP etc. clocks on different devices are not perfectly aligned. 
Also the clock on a single device can be discontinuous, ie. someone might set the clock back in time. 

A more subtle problem is 

This can all cause a reordering of the messages which obscure the meaning of the conversation in subtle ways. 

For a mostly online chat system you can argue that it might be acceptable to ignore this problem, but for 
sake of argument lets us try to solve it.

First lets do a small detour and briefly elaborate on the problem of interleaving, which is very pertinent in collaborative text editors, so let us that as an example.

Say you have a sequence of characters "AB" and one peer inserts "xy" to get "AxyB" while another peer inserts "12" to get "A12B", we want the sequence to converge to either "Axy12B" or "A12xyB", but avoid interleaving the edits like fx "Ax1y2B". 

You might say, can't I just use a realm list for this? Yes, and no. Realm lists are almost perfect for this. They will automatically resolve conflicts, and maintain an eventually consistent order, even do the right thing with regards to interleaving runs in all but the most unlikely of situations. They are basically build for this, so why not just add a realm list of messages on the channel object and use that?

The problem is ownership. Who should be allowed to edit the list? If we allow everybody to write to the list, anybody could potentially remove other people's messages. We could prevent that in the client code, but as discussed earlier we cannot really trust code running on the clients. So what to do?

Instead of maintaining a list of messages on the channel, we let each messages point to its channel. This
way we can ensure that only the owner of the message can remove or add it. This ends our little detour and brings us right back to the original problem.

So what to do?

Well, while the fact that we are not allowed to edit other people's messages prevents us from using a realm list, the problem is really not to bad as for a full collaborative editor. We can track properties such as an index and owner for each message, which would be prohibitively expensive to do for each character in an editor.

Also, we always add the new messages to the end. This means, that if we _believe_ we did the last message `m` in the channel, and we want to add a new one, we can instead just update `m` by appending. Only if we _know_ we didn't add the latest, we need to create a new one. This will keep our messages and that of our peers lumped together together in runs, if there for some reason is a lag in distributing the messages between peers.

We still need to maintain the order somehow. To do this each new message will be given a new index that is one larger than max index of any seen message in the channel sofar. There may be duplicates if some peers have have not seen all existing messages when creating a new one. To handle this we define the order as the sort of the indexes, and secondarily the owner id to ensure a stable sort.

Note that we may introduce holes in the sequence this way (or by later deletions), but that is alright. Realm will easily find the _n'th_ message in the channel given the sort, irregardless of the actual values of index, and owner id.

# DISCLAIMER

This is low priority work in progress. Eventually we hope to make this a well documented example of best practices, but that is _not_ the current state.