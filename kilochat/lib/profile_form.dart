import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';
import 'providers.dart';
import 'router.dart';
import 'widget_builders.dart';

class ProfileForm extends ConsumerStatefulWidget {
  final UserProfile initialProfile;

  const ProfileForm({super.key, required this.initialProfile});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late UserProfile _profile;

  @override
  void initState() {
    super.initState();
    _profile = UserProfile(
      widget.initialProfile.id,
      widget.initialProfile.ownerId,
      name: widget.initialProfile.name,
      email: widget.initialProfile.email,
      age: widget.initialProfile.age,
      genderAsInt: widget.initialProfile.genderAsInt,
    );
  }

  @override
  Widget build(BuildContext context) {
    var repository = ref.watch(repositoryProvider);
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  initialValue: _profile.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profile.name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  initialValue: _profile.email,
                  validator: (value) {
                    if (value == null) return null; // okay to leave out
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profile.email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  initialValue: _profile.age?.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) return null; // okay to leave out
                    if (value.isEmpty) {
                      return 'Please enter your age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _profile.age = int.parse(value!);
                  },
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  value: _profile.gender,
                  items: Gender.values
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _profile.gender = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(children: [
                  TextButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        repository.updateUserProfile(_profile);
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      repository.logoutUser();
                      Routes.chooseWorkspace.go(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ]),
              ]
                  .animate(interval: 100.ms)
                  .fade()
                  .slideX(begin: 1, duration: 300.ms),
            ),
          ),
        ),
      ),
    );
  }
}
