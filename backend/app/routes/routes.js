const express = require("express");
const router = express.Router();
const {getNotesController, deleteNoteController, createNoteController, editNoteController, searchNoteController} = require("@controllers/controllers");

router.get("/notes", getNotesController);
router.delete("/delete/:id_notes", deleteNoteController);
router.post("/create-note", createNoteController);
router.put("/edit-note/:id_notes", editNoteController);
router.get("/search-note/:title_note", searchNoteController);

module.exports = router;