const express = require("express");
const router = express.Router();
const {getNotesController, deleteNoteController, createNoteController, editNoteController, searchNoteController, getTrashNotesController, restoreNoteController, permanentDeleteNoteController} = require("@controllers/controllers");

router.get("/notes", getNotesController);
router.delete("/delete/:id_notes", deleteNoteController);
router.post("/create-note", createNoteController);
router.put("/edit-note/:id_notes", editNoteController);
router.get("/search-note/:title_note", searchNoteController);
router.get("/trash-notes", getTrashNotesController);
router.post("/restore-note/:id_notes", restoreNoteController);
router.delete("/permanent-delete/:id_notes", permanentDeleteNoteController);


module.exports = router;