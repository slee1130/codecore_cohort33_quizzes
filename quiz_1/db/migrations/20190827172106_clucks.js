exports.up = function (knex) {
    return knex.schema.createTable('clucks', table => {
        table.bigIncrements('id');
        table.string('username');
        table.string('imageUrl');
        table.text('content');
        table.timestamp('createdAt').defaultTo(knex.fn.now());
        table.timestamp('updatedAt').defaultTo(knex.fn.now());
    });
};

exports.down = function (knex) {
    return knex.schema.dropTable('clucks');
};