// exports.handler = async function(event, context) {
//   console.log("ENVIRONMENT VARIABLES\n" + JSON.stringify(process.env, null, 2))
//   console.log("EVENT\n" + JSON.stringify(event, null, 2))
//   return context.logStreamName
// }

module.exports.handler = async function(event) {
  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify(
      {
        message: 'Your function executed successfully!',
        params: event.queryStringParameters,
        secret: process.env.A_VARIABLE
      },
      null,
      2
    ),
  };
};
