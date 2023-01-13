exports = async function (admin) {
  var isAdmin = admin == 'true'
  const rolesCollection = context.services.get("mongodb-atlas").db("users_permissions").collection("Role");
  const query = { "owner_id": context.user.id };
  const update = {
    "$set": {
      "isAdmin": isAdmin,
      "owner_id": context.user.id
    }
  };
  const options = { "upsert": true };
  rolesCollection.updateOne(query, update, options)
    .then(result => {
      const { upsertedId } = result;
      if (upsertedId) {
        console.log(`Role not found. Inserted a new role with _id: ${upsertedId}`)
      } else {
        console.log(`Successfully updated role.`)
      }
    })
    .catch(err => console.error(`Failed to upsert document: ${err}`))
}