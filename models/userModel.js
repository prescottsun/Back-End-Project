const db = require("./conn");
const bcrypt = require("bcryptjs");

class User {
    constructor(first_name, last_name, email_address, password, about) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email_address = email_address;
        this.password = password;
        this.about = about;
    }

    checkPassword(hashedPassword) {
        return bcrypt.compareSync(this.password, hashedPassword);
    }

    async login() {
        try {
            const response = await db.one(
                `SELECT * FROM users WHERE email = $1;`,
                [this.email_address]
            );
            const isValid = this.checkPassword(response.password);
            // ! = Not True   !! = forces to a boolean
            if (!!isValid) {
                const { id, first_name, last_name } = response;
                return { isValid, id, first_name, last_name };
            } else {
                return { isValid };
            }
        } catch (err) {
            return err.message;
        }
    }

    async save() {
        try {
            const response = await db.one(
                `INSERT INTO users (first_name, last_name, email, password) VALUES ($1, $2, $3, $4) RETURNING id;`,
                [
                    this.first_name,
                    this.last_name,
                    this.email_address,
                    this.password
                ]
            );
            return response;
        } catch (err) {
            return err.message;
        }
    }

    // static async getInfo() {
    //     try {
    //         const query = await db.any(`SELECT * FROM users WHERE id = $1;`, [this.id]);
    //         console.log(query)
    //         return query;
    //     } catch (err) {
    //         return err.message;
    //     }
    // }

    async updateDescription() {
        try {
            const response = await db.one(
                `UPDATE users SET about;`,
                [
                    this.about
                ]
            );
            return response;
        } catch (err) {
            return err.message;
        }
    }
}


module.exports = User;
