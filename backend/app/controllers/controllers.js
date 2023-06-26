const {
  getNotesModel,
  deleteNoteModel,
  createNoteModel,
  editNoteModel,
  searchNoteModel,
  getTrashNotesModel,
  restoreNoteModel,
  permanentDeleteNoteModel
} = require("@models/models");


const getNotesController = async (req, res) => {
  try {
    const notes = await getNotesModel();
    res.status(200).json({ data: notes });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const deleteNoteController = async (req, res) => {
  const { id_notes } = req.params;
  try {
    const success = await deleteNoteModel(id_notes);
    if (success) {
      res.status(200).json({ message: "berhasil dihapus" });
    } else {
      res.status(404).json({ message: "catatan tidak ditemukan" });
    }
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const createNoteController = async (req, res) => {
  const addNote = ({ date_note, title_note, text_note } = req.body);
  try {
    const note = await createNoteModel(addNote);
    res.status(201).json({ data: note });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const editNoteController = async (req, res) => {
  const updatedNote = ({ date_note, title_note, text_note } = req.body);
  const { id_notes } = req.params;
  try {
    const update = await editNoteModel(updatedNote, id_notes);
    res.status(201).json({message: "berhasil di update"});
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const searchNoteController = async (req, res) => {
  const { title_note } = req.params;
  try {
    const search = await searchNoteModel(title_note);
    res.status(200).json({ data: search });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const getTrashNotesController = async(req, res) => {
  try {
    const trash = await getTrashNotesModel();
    res.status(200).json({data: trash});
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({error : "Kesalahan Server"});
  }
}

const restoreNoteController = async (req, res) => {
  const {id_notes} = req.params;
  try {
    const restore = await restoreNoteModel(id_notes);
    res.status(201).json({message: "Berhasil di restore"});
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({error: "Kesalahan Server"});
  }
}

const permanentDeleteNoteController = async (req, res) => {
  const {id_notes} = req.params;
  try {
    const success = await permanentDeleteNoteModel(id_notes);
    res.status(201).json({message: "Berhasil dihapus"});
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({error: "Kesalahan Server"});
  }
}

module.exports = {
  getNotesController,
  deleteNoteController,
  createNoteController,
  editNoteController,
  searchNoteController,
  getTrashNotesController,
  restoreNoteController,
  permanentDeleteNoteController
};
