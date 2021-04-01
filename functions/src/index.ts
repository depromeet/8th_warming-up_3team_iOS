import * as functions from "firebase-functions"
import * as admin from "firebase-admin" // firebaseStore
admin.initializeApp()


// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const firstAPI = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true})
  response.send("응답으로 텍스트를 줍니당")
})

export const getBostonWeather = functions.https.onRequest((request, response) => {
    admin.firestore().doc("cities-weather/boston-ma-us").get() // get return 값이 Promise
    .then(snapshot => {
        const data = snapshot.data()
        response.send(data)
    })
    p2.catch(error => {
        // Handle the error 
        console.log(error)
        response.status(500).send(error)
    })
})