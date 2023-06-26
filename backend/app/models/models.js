const db = require("@config/db");
const { resume } = require("../../config/db");

const getNotesModel = () => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM all_notes";
    db.query(query, (error, results) => {
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
        })
    })
}

const searchNoteModel = (titleNote) => {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM all_notes WHERE title_note = ?"
    db.query(query, [titleNote], (error, results) => {
      if (error) {
        console.error("Kesalahan query : ", error);
        reject(new Error("Error"));
      } else {
        if (results.length === 0) {
          reject(new Error("Note Tidak Ditemukan"))
        } else {
          resolve(results);
        }
      }
    })
  })
}

module.exports = { getNotesModel, deleteNoteModel, createNoteModel,  editNoteModel, searchNoteModel};
