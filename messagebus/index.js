const AWS = require('aws-sdk');
const Consumer = require('sqs-consumer');
const queueConfig = require('../messagebus/config/config.js');
const queueUrl = queueConfig.QueueUrl;
AWS.config.loadFromPath(__dirname + '/../messagebus/config/awsconfig.json');

var sqs = new AWS.SQS( {apiVersion: '2012-11-05'} );

// const app = Consumer.create({
//   queueUrl: queueUrl,
//   handleMessage: (message, done) => {
//     console.log(message);
//     done();
//   },
//   sqs: sqs
// });

// app.on('error', (err) => {
//   console.log(err.message);
// });
// app.start();

module.exports = {sqs, queueUrl};
