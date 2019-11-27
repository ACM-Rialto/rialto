const functions = require('firebase-functions');
const nodemailer = require('nodemailer');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();


let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'rialto.mailer@gmail.com',
        pass: 'mailer-1!23rialto'
    }
})

exports.sendEmail = functions.firestore.document('contactBuyerToSeller/{id}').onWrite((change, context) => {

    const newValue = change.after.data();
    // console.log('newValue');
    // console.log(JSON.stringify(newValue));

    // console.log('change.after.data()');
    // console.log(JSON.stringify(change.after.data()));

    const mailOptions = {
        from: `Rialto Mailer <rialto.mailer@gmail.com>`, // Something like: Jane Doe <janedoe@gmail.com>
        to: newValue.to,
        subject: `${newValue.email} - Buyer From Rialto`, // email subject
        html: `<p>${newValue.message}</p>
                <br />
                Contact Info:
                ${newValue.from}`,
    };

    transporter.sendMail(mailOptions, (erro, info) => {
        if (erro) {
            return console.log('error sending mail: ' + JSON.stringify(erro));
        }
        return console.log('Message Sent!');
    });

    return db.doc(`contactBuyerToSeller/${context.params.id}`).delete();
});
