import * as functions from "firebase-functions";
import * as admin from "firebase-admin"; // firebaseStore
admin.initializeApp();

export const firstAPI = functions.https.onRequest((_, res) => {
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
