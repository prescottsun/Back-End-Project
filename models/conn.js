const pgp = require("pg-promise")({
    query: e => {
        console.log("QUERY:", e.query);  //Testing to make sure query shows in terminal
    }
});

const options = {
    host: "localhost",
    database: "DB NAME HERE!!!"  // Change to name of database. Keep names the same.
};

const db = pgp(options);

module.exports = db;
