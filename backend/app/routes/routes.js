const express = require("express");
const router = express.Router();
const {getNotesController, deleteNoteController, createNoteController, editNoteController, searchNoteController, getTrashNotesController, restoreNoteController, permanentDeleteNoteController, userLoginController, userRegisterController, deleteUserController, updateUserController} = require("@controllers/controllers");

router.get("/notes/:id_user", getNotesController);
router.delete("/delete/:id_notes", deleteNoteController);
router.post("/create-note", createNoteController);
router.put("/edit-note/:id_notes", editNoteController);
router.get("/search-note/:title_note", searchNoteController);
router.get("/trash-notes/:id_user", getTrashNotesController);
router.post("/restore-note/:id_notes", restoreNoteController);
router.delete("/permanent-delete/:id_notes", permanentDeleteNoteController);
router.post("/register-user", userRegisterController);
router.post("/user-login", userLoginController);
router.delete("/delete-user/:id_user", deleteUserController);
router.put("/update-user/:id_user", updateUserController);


module.exports = router;