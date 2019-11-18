const functions = require('firebase-functions');
const nodemailer = require('nodemailer');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });


let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'rialto.mailer@gmail.com',
        pass: 'mailer-1!23rialto'
    }
})

exports.sendEmail = functions.firestore.document('contactBuyerToSeller/{id}').onWrite((change, context) => {

    var newValue = change.after.data();

    // var contactPerson = newValue[newValue.length - 1];

    console.log(newValue)

    // console.log(`contactPerson.message before replace: ${contactPerson.message}`);
    // var message = contactPerson.message.replace(/(?:\r\n|\r|\n)/g, "<br/>");
    // console.log(`contactPerson.message after replace: ${contactPerson.message}`);

    // const mailOptions = {
    //     from: `Website Mailer <rialto.mailer@gmail.com>`, // Something like: Jane Doe <janedoe@gmail.com>
    //     to: contactPerson.to,
    //     // cc: `${contactPerson}`,
    //     subject: `${contactPerson.name} - Buyer From Rialto`, // email subject
    //     // text: `${contactPerson.message}\n\n\nContact Info:\n${contactPerson.name}\n${contactPerson.email}`,
    //     html: `<p>${message}</p>
    //             <br />
    //             Contact Info:
    //             ${contactPerson.name}
    //             ${contactPerson.email}
    //     `,
    //     // replyTo: [`${contactPerson.email}`]
    //     // html: `<p style="font-size: 16px;">Pickle Riiiiiiiiiiiiiiiick!!</p>
    //     //         <br />
    //     //         <img src="https://images.prod.meredith.com/product/fc8754735c8a9b4aebb786278e7265a5/1538025388228/l/rick-and-morty-pickle-rick-sticker" />
    //     //     ` // email content in HTML
    // };

    // console.log("MAILOPTIONS.CC", mailOptions.cc);

    // return transporter.sendMail(mailOptions, (erro, info) => {
    //     if (erro) {
    //         return res.send(erro.toString());
    //     }
    //     return res.send('Message Sent!');
    // });

});
