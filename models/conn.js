const pgp = require("pg-promise")({
    query: e => {
        // console.log("QUERY:", e.query);  //Testing to make sure query shows in terminal
    }
});

const options = {
    host: 'prescott-psql-db.co6rvrnkoffq.us-east-2.rds.amazonaws.com',
    database: 'back_end_project',
    user: 'postgres',
    password: 'prescottaws'
};

const db = pgp(options);

module.exports = db;
