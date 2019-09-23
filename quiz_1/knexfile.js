// Update with your config settings.

module.exports = {

  development: {
    client: "pg",
    connection: {
      database: "clucks",

    },
    migrations: {
      directory: "./db/migrations"
    }
  },
}