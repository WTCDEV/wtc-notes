const db = require("@config/db");

const getNotesModel = (id_user) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM all_notes WHERE id_user = ?";
    const message = "tidak ada catatan";
    db.query(query, [id_user], (error, results) => {
      if (error) {
        console.error("Kesalahan query: ", error);
        reject(new Error("Error"));
      } else {
        resolve(results);
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
    const message = "Note Tidak Ditemukan";
    const searchKeyword = `%${titleNote}%`;
    db.query(query, [searchKeyword], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          resolve(message);
        } else {
          resolve(results);
        }
      }
    });
  });
};

const getTrashNotesModel = (id_user) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM trash_notes WHERE id_user = ?";
    const message = "Tidak ada sampah";
    db.query(query, [id_user], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          resolve(message);
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
          reject(new Error("Note tidak ditemukan"));
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

const deleteUserModel = (id_user) => {
  return new Promise((resolve, reject) => {
    const query = "DELETE FROM users WHERE id_user = ?";
    db.query(query, [id_user], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal Delete User"));
        }
      }
    });
  });
};

const updateUserModel = (updatedUser, id_user) => {
  return new Promise((resolve, reject) => {
    const query = "UPDATE users SET ? WHERE id_user = ?";
    db.query(query, [updatedUser, id_user], (error, results) => {
      if (error) {
        console.error("Kesalhan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.affectedRows > 0) {
          resolve(results);
        } else {
          reject(new Error("Gagal update user"));
        }
      }
    });
  });
};

const getUserByEmailModel = (email) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM users WHERE email = ?";
    db.query(query, [email], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        resolve(results);
      }
    });
  })
}

const saveResetTokenModel = (id_user, resetToken) => {
  return new Promise((resolve, reject) => {
    const query = "UPDATE users SET reset_token = ? WHERE id_user = ?";
    db.query(query, [resetToken, id_user], (error, results) => {
      if (error) {
        console.error("Error : ", error);
        reject(new Error("Error"));
      } else {
        resolve(results);
      }
    })
  })
}

const getUserByResetToken = (resetToken) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM users WHERE reset_token = ?";
    db.query(query, [resetToken], (error, results) => {
      if (error) {
        console.error("Error : ", error);
        reject(new Error("Error"));
      } else {
        if (results === 0) {
          reject(new Error("token tidak valid"));
        } else {
          resolve(results);
        }
      }
    });
  })
}

const resetUserPassword = (id_user, password) => {
  return new Promise((resolve, reject) => {
    const query = "UPDATE users SET password = ? WHERE id_user = ?";
    db.query(query, [password, id_user], (error, results) => {
      if (error) {
        console.error("Error : ", error);
        reject(new Error("Error"));
      } else {
        resolve(results);
      }
    })
  })
}

module.exports = {
  getUserByResetToken,
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
  deleteNoteModel,
  deleteUserModel,
  updateUserModel,
  getUserByEmailModel,
  saveResetTokenModel,
  resetUserPassword,
};
