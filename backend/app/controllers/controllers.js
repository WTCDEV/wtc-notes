const {
  getNotesModel,
  deleteNoteModel,
  createNoteModel,
  editNoteModel,
  searchNoteModel,
  getTrashNotesModel,
  restoreNoteModel,
  permanentDeleteNoteModel,
  userLoginModel,
  userRegisterModel,
  checkUsernameExist,
  deleteUserModel,
  updateUserModel,
} = require("@models/models");

const bcrypt = require("bcrypt");
const { hashPassword } = require("../utils/bcrypt");
const xss = require("xss");

const getNotesController = async (req, res) => {
  const { id_user } = req.params;
  try {
    const notes = await getNotesModel(id_user);
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
  const { id_user, title_note, text_note } = req.body;
  const addNote = {
    id_user,
    title_note: xss(title_note),
    text_note: xss(text_note),
  };
  try {
    const note = await createNoteModel(addNote);
    res.status(201).json({ message: "Berhasil Ditambahkan" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const editNoteController = async (req, res) => {
  const { title_note, text_note } = req.body;
  const { id_notes } = req.params;
  const updatedNote = {
    title_note: xss(title_note),
    text_note: xss(text_note),
  };
  try {
    const update = await editNoteModel(updatedNote, id_notes);
    res.status(201).json({ message: "berhasil di update" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const searchNoteController = async (req, res) => {
  const title_note = xss(req.params.title_note);
  try {
    const search = await searchNoteModel(title_note);
    res.status(200).json({ data: search });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const getTrashNotesController = async (req, res) => {
  try {
    const trash = await getTrashNotesModel();
    res.status(200).json({ data: trash });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const restoreNoteController = async (req, res) => {
  const { id_notes } = req.params;
  try {
    const restore = await restoreNoteModel(id_notes);
    res.status(201).json({ message: "Berhasil di restore" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const permanentDeleteNoteController = async (req, res) => {
  const { id_notes } = req.params;
  try {
    const success = await permanentDeleteNoteModel(id_notes);
    res.status(201).json({ message: "Berhasil dihapus" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};

const userLoginController = async (req, res) => {
  const { username, password } = req.body;

  try {
    const Username = xss(username);
    const Password = xss(password);
    const userData = await userLoginModel(Username);
    if (userData.length === 0) {
      return res.status(500).json({ message: "Akun tidak ditemukan" });
    }
    const user = userData[0];
    const passwordMatch = await bcrypt.compare(Password, user.password);
    if (!passwordMatch) {
      throw new Error("Username atau Password Salah");
    }
    res.status(200).json({ message: "Login Berhasil", id_user: user.id_user, username: user.username, email: user.email});
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
};


const userRegisterController = async (req, res) => {
  const { username, password } = req.body;
  try {
    const Username = xss(username);
    const Password = xss(password);

    const isUsernameExist = await checkUsernameExist(username);
    if (isUsernameExist) {
      throw new Error("Username Sudah Terdaftar");
    }
    const hashedPassword = await hashPassword(Password);
    const createUser = { username, password: hashedPassword };
    await userRegisterModel(createUser);
    res.status(201).json({ message: "Register Suksess" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ message: "Kesalahan Server" });
  }
};

const deleteUserController = async (req, res) => {
  const { id_user } = req.params;
  try {
    const success = await deleteUserModel(id_user);
    res.status(201).json({ message: "Berhasil dihapus" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ message: "Kesalahan Server" });
  }
};

const updateUserController = async (req, res) => {
  const { username } = req.body;
  const { id_user } = req.params;
  const updatedUser = {
    username: xss(username),
  };
  try {
    const updated = await updateUserModel(updatedUser, id_user);
    res.status(201).json({ message: "Update suksess" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ message: "Kesalahan Server" });
  }
};

module.exports = {
  getNotesController,
  deleteNoteController,
  createNoteController,
  editNoteController,
  searchNoteController,
  getTrashNotesController,
  restoreNoteController,
  permanentDeleteNoteController,
  userRegisterController,
  userLoginController,
  deleteUserController,
  updateUserController,
};
