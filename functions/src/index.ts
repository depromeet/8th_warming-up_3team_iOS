import * as functions from "firebase-functions";
import * as express from "express";
import * as swaggerUi from "swagger-ui-express";
import * as swaggerDocument from "./config/swagger.json";

// eslint-disable-next-line
import {addEntry, getAllEntries, updateEntry, deleteEntry} from "./entryController";

const app = express();

app.get("/", (req, res) => res.status(200).send("Hey there!"));
app.post("/entries", addEntry);
app.get("/entries", getAllEntries);
app.patch("/entries/:entryId", updateEntry);
app.delete("/entries/:enrryId", deleteEntry);
app.use("/swagger", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

exports.app = functions.https.onRequest(app);
