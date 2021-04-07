import * as functions from "firebase-functions";
import * as admin from "firebase-admin"; // firebaseStore
admin.initializeApp();

export const randomNumber = 
functions.https.onRequest((request, response) => {
  const number = Math.round(Math.random() * 100);
  response.send(number.toString());
});

/*
// firestore trigger for tracking activity
export const logActivities = 
functions.firestore.document('/{collection}/{id}').onCreate((snap, context) => {
  console.log(snap.data())

  const collection = context.params.collection;
  const id = context.params.id

  const activities = admin.firestore().collection('activities');
  if (collection === 'requests' ) {
    return activities.add({ text: 'a new tutorial request was added' });
  }
  if (collection === 'users' ) {
    return activities.add({ text: 'a new user signed up' });
  }

  return null;
})
*/
/*
export const firstAPI = 
functions.https.onRequest((_, res) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  res.send("응답으로 텍스트를 줍니당");
});

export const getBostonAreaWeather =
functions.https.onRequest(async (request, response) => {
  try {
    const snapshot = await admin.firestore().doc("areas/greater-boston").get();
    const data = snapshot.data();
    response.send(data);
  } catch (error) {
    // Handle the error
    console.log(error);
    response.status(500).send(error);
  }
});

export const onBostonWeatherUpdate = functions.firestore.document("cities-weather/boston-ma-us").onUpdate((change) => {
  const after = change.after.data();
  // 전송되는 데이터
  const payload = {
    data: {
      temp: String(after.temp),
      conditions: after.conditions,
    },
  };
  return admin.messaging().sendToTopic("weather_bostom-ma-us", payload)
      .catch((error) => {
        console.error("");
      });
});

export const getBostonWeather = functions.https.onRequest((request, response) => {
  admin.firestore().doc("cities-weather/boston-ma-us").get() // get return 값이 Promise
      .then((snapshot) => {
        const data = snapshot.data();
        response.send(data);
      })
      .catch((error) => {
        // Handle the error
        console.log(error);
        response.status(500).send(error);
      });
});
*/