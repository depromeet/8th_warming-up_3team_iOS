// import {Response} from "express";
import {db} from "./config/firebase";

// 타입을 지정함
type EntryType = {
  title: string,
  text: string,
  coverImageUrl: string
};

type Request = {
  body: EntryType,
  params: { entryId: string }
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

export {addEntry};
