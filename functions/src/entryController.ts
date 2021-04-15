// eslint-disable-next-line
import {Response} from "express";
import {db} from "./config/firebase";

type EntryType = {
  title: string,
  text: string,
};

type Request = {
  body: EntryType,
  params: {entryId: string},
};

type BookType = {
  title: string,
  colorType: string, 
  lat: number,  
  log: number, 
  phrase: string, 
  reason: string, 
  time: string, 
  author: string,  
  description: string,  
  thumbnail: string, 
  pubDate: string,  
  publisher: string, 
  userID: number,  
  roadAddress: string, 
  jibunAddress: string, 
};

type BookRequest = {
  body: BookType,
  params: {entryId: string},
};

const writeBook = async (req: BookRequest, res: Response) => {
  // eslint-disable-next-line
  const {title, colorType, lat, log, phrase, reason, time, author, description, thumbnail, pubDate, publisher, userID, roadAddress, jibunAddress} = req.body;
  
  try {
    const entry = db.collection("writeBook").doc();
    const entryObject = {
      id: entry.id,
      title,
      colorType,
      lat,  
      log, 
      phrase, 
      reason, 
      time, 
      author,  
      description,  
      thumbnail, 
      pubDate,  
      publisher, 
      userID,  
      roadAddress, 
      jibunAddress, 
    };

    entry.set(entryObject);

    res.status(200).send({
      status: "success",
      message: "entry added successfully",
      data: entryObject,
    });
  } catch (error) {
    res.status(500).json(error.message);
  }
};

const addEntry = async (req: Request, res: Response) => {
  const {title, text} = req.body;
  try {
    const entry = db.collection("entries").doc();
    const entryObject = {
      id: entry.id,
      title,
      text,
    };

    entry.set(entryObject);

    res.status(200).send({
      status: "success",
      message: "entry added successfully",
      data: entryObject,
    });
  } catch (error) {
    res.status(500).json(error.message);
  }
};

const getAllEntries = async (req: Request, res: Response) => {
  try {
    const allEntries: EntryType[] = [];
    const querySnapshot = await db.collection("entries").get();
    querySnapshot.forEach((doc: any) => allEntries.push(doc.data()));
    return res.status(200).json(allEntries);
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

const updateEntry = async (req: Request, res: Response) => {
  const {
    body: {text, title},
    params: {entryId},
  } = req;

  try {
    const entry = db.collection("entries").doc(entryId);
    const currentData = (await entry.get()).data() || {};

    const entryObject = {
      title: title || currentData.title,
      text: text || currentData.text,
    };

    await entry.set(entryObject).catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "entry updated successfully",
      data: entryObject,
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

const deleteEntry = async (req: Request, res: Response) => {
  const {entryId} = req.params;

  try {
    const entry = db.collection("entries").doc(entryId);

    await entry.delete().catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "entry deleted successfully",
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

export {writeBook, addEntry, getAllEntries, updateEntry, deleteEntry};
