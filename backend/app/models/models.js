const db = require("@config/db");

const getNotesModel = (id_user) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM all_notes WHERE id_user = ?";
    db.query(query, [id_user], (error, results) => {
      if (error) {
        console.error("Kesalahan query: ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          reject(new Error("tidak ada catatan"));
        } else {
          resolve(results);
        }
      }
    });
  });
};

const deleteNoteModel = (id_notes) => {
  return new Promise((resolve, reject) => {
    const query = "DELETE FROM all_notes WHERE id_notes = ?";
    db.query(query, [id_notes], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve({
            success: true,
            message: "Sukses hapus note",
          });
        } else {
          resolve({
            success: false,
            message: "Note tidak ditemukan",
          });
        }
      }
    });
  });
};

const createNoteModel = (addNote) => {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO all_notes SET ?";
    db.query(query, [addNote], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal tambah note"));
        }
      }
    });
  });
};

const editNoteModel = (updatedNote, id_notes) => {
  return new Promise((resolve, reject) => {
    const query = "UPDATE all_notes SET ? WHERE id_notes = ?";
    db.query(query, [updatedNote, id_notes], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal update note"));
        }
      }
    });
  });
};

const searchNoteModel = (titleNote) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM all_notes WHERE title_note LIKE ?";
    const searchKeyword = `%${titleNote}%`;
    db.query(query, [searchKeyword], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          reject(new Error("Note Tidak Ditemukan"));
        } else {
          resolve(results);
        }
      }
    });
  });
};

const getTrashNotesModel = () => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM trash_notes";
    db.query(query, (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          reject(new Error("tidak ada sampah"));
        } else {
          resolve(results);
        }
      }
    });
  });
};

const restoreNoteModel = (id_notes) => {
  return new Promise((resolve, reject) => {
    const query =
      "INSERT INTO all_notes SELECT * FROM trash_notes WHERE id_notes = ?";
    db.query(query, [id_notes], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal restore note"));
        }
      }
    });
  });
};

const permanentDeleteNoteModel = (id_notes) => {
  return new Promise((resolve, reject) => {
    const query = "DELETE FROM trash_notes WHERE id_notes = ?";
    db.query(query, [id_notes], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal Delete Note"));
        }
      }
    });
  });
};

const userLoginModel = (username) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM users WHERE username = ?";
    db.query(query, [username], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Kesalahan Query"));
      } else {
        resolve(results);
      }
    });
  });
};

const userRegisterModel = (createUser) => {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO users SET ?";
    db.query(query, [createUser], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Kesalahan query"));
      } else {
        resolve(results);
      }
    });
  });
};

const checkUsernameExist = (username) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT COUNT(*) as count FROM users WHERE username = ?";
    db.query(query, [username], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Kesalahan query"));
      } else {
        const count = results[0].count;
        resolve(count > 0);
      }
    });
  });
};

module.exports = {
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
};
