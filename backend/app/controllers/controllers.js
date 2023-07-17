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
  getUserByEmailModel,
  saveResetTokenModel,
  getUserByResetToken,
  resetUserPassword,
} = require("@models/models");

const bcrypt = require("bcrypt");
const { hashPassword } = require("../utils/bcrypt");
const xss = require("xss");
const nodemailer = require("nodemailer");
const { v4: uuidv4 } = require('uuid');
require('dotenv').config();

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
  const { id_user, title_note, text_note } = req.body;
  const { id_notes } = req.params;
  const updatedNote = {
    id_user: xss(id_user),
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
  const {id_user} = req.params;
  try {
    const trash = await getTrashNotesModel(id_user);
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
    res.status(200).json({ message: "Berhasil dihapus" });
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
      return res.status(500).json({ message: "Akun tidak ditemukan!" });
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
  const { username, email, password } = req.body;
  try {
    const Username = xss(username);
    const Email = xss(email);

    const isUsernameExist = await checkUsernameExist(Username);
    if (isUsernameExist) {
      throw new Error("Username Sudah Terdaftar");
    }
    const hashedPassword = await hashPassword(password);
    const createUser = { Username, Email, password: hashedPassword };
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


const transporter = nodemailer.createTransport({
  service: "Gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
});

const sendResetPasswordEmail = (email, resetToken) => {
  const mailOptions = {
    from: process.env.EMAIL,
    to: email,
    subject: "Reset Password",
    text: `token reset password anda ${resetToken}`
  };
  transporter.sendMail(mailOptions, (err, info) => {
    if (err) {
      console.log("kesalahan pengiriman email : ", err);
    } else {
      console.log("berhasil kirim ", info.response);
    }
  });
}

const sendUsernameUser = (email, username) => {
  const mailOptions = {
    from: process.env.EMAIL,
    to: email,
    subject: "Your USERNAME",
    text: `username anda adalah "${username}"`
  };
  transporter.sendMail(mailOptions, (err, info) => {
    if (err) {
      console.log("Kesalahan pengiriman email: : ", err);
    } else {console.log("berhasil kirim ", info.response);
      
    }
  })
}

const forgotUsernameController = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await getUserByEmailModel(email);
    if (!user) {
      return res.status(404).json({ error: "Email tidak terdaftar" });
    }
    sendUsernameUser(email, user[0].username);
    res.status(200).json({message: "berhasil kirim username"})
  } catch (error) {
    res.status(500).json({ error: error });
    throw new Error("Error", error);
  }
}


const generateToken = () => {
  const token = uuidv4();
  return token;
}


const forgotPasswordController = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await getUserByEmailModel(email);
    if (!user) {
      return res.status(404).json({ error: "Email tidak terdaftar" });
    }

    const resetToken = generateToken();
    await saveResetTokenModel(user[0].id_user, resetToken);

    sendResetPasswordEmail(email, resetToken);

    res.status(200).json({ message: "Token reset password telah dikirim" });
  } catch (error) {
    console.error("Error : ", error);
    res.status(500).json({ error: "Kesalahan Server" });
  }
}

const checkResetToken = async (reset_token) => {
  try {
    const user = await getUserByResetToken(reset_token);
    if (!user) {
      throw new Error("Token tidak valid");
    }
    return user;
  } catch (error) {
    throw new Error("Token tidak valid");
  }
};

const resetPasswordWithResetToken = async (req, res) => {
  const { resetToken, password } = req.body;
  const user = await checkResetToken(resetToken);

  try {
    const hashedPassword = await hashPassword(password);
    await resetUserPassword(user[0].id_user, hashedPassword);
    res.status(200).json({ message: "suksess update password"});
  } catch (error) {
    res.status(500).json({ error: "Kesalahan Server"});
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
  permanentDeleteNoteController,
  userRegisterController,
  userLoginController,
  deleteUserController,
  updateUserController,
  forgotPasswordController,
  resetPasswordWithResetToken,
  forgotUsernameController,
};