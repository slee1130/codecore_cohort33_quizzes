
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('clucks').del()
    .then(function () {
      // Inserts seed entries
      return knex('clucks').insert([
        {id: 1, username: 'rowValue1', imageUrl: 'image url', content: "some text"},
        {
          id: 2,
          username: 'rowValue2',
          imageUrl: 'image url',
          content: "some text"
        },

        {
          id: 3,
          username: 'rowValue3',
          imageUrl: 'image url',
          content: "some text"
        },
      ]);
    });
};
