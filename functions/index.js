const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
admin.initializeApp();
const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");

exports.insertElement = onRequest(async (request, response) => {
  try {
    const data = request.body;

    const usuariosCollection = admin.firestore().collection("Usuarios");

    const result = await usuariosCollection.add(data);

    const elementId = result.id;

    logger.info(`Elemento con ID ${elementId} fue insertado correctamente.`, { structuredData: true });

    response.status(200).send(`Elemento con ID ${elementId} fue insertado correctamente.`);
  } catch (error) {
    console.error('Error al insertar el elemento:', error);

    logger.error('Error al insertar el elemento en la base de datos.', { error: error });

    response.status(500).send('Error al insertar el elemento en la base de datos.');
  }
});

exports.deleteElement = functions.https.onRequest(async (request, response) => {
  try {

    const elementId = request.query.elementId;

    if (!elementId) {
      return response.status(400).send('El parámetro elementId es obligatorio.');
    }

    await admin.firestore().collection('Usuarios').doc(elementId).delete();

    functions.logger.info(`El elemento con ID ${elementId} se eliminó correctamente.`, { structuredData: true });

    response.status(200).send(`El elemento con ID ${elementId} se eliminó correctamente.`);
  } catch (error) {
    console.error('Error al eliminar el elemento:', error);

    functions.logger.error('Error al eliminar el elemento en Firestore.', { error: error });

    response.status(500).send('Error al eliminar el elemento en Firestore.');
  }
});

exports.getAllElements = onRequest(async (request, response) => {
  try {

    const usuariosSnapshot = await admin.firestore().collection('Usuarios').get();

    const usuariosData = usuariosSnapshot.docs.map(doc => doc.data());

    logger.info('Se obtuvieron todos los elementos correctamente.', { structuredData: true });

    response.status(200).json(usuariosData);
  } catch (error) {
    console.error('Error al obtener los elementos:', error);

    logger.error('Error al obtener los elementos de Firestore.', { error: error });

    response.status(500).send('Error al obtener los elementos de Firestore.');
  }
});
  exports.addCustomDateOnCreate = functions.firestore
    .document('Usuarios/{userId}')
    .onCreate(async (snapshot, context) => {
      try {
        const docRef = snapshot.ref;
        const customDateField = 'fechaCreacion';
        const currentDate = new Date().toISOString();

        await docRef.update({ [customDateField]: currentDate });

        functions.logger.info(`Se agregó el campo "${customDateField}" al documento ${context.params.userId} con la fecha de creación ${currentDate}.`, { structuredData: true });
        console.log(`Se agregó el campo "${customDateField}" al documento ${context.params.userId} con la fecha de creación ${currentDate}.`);

        return null;
      } catch (error) {
        console.error('Error al agregar la fecha de creación:', error);
        return null;
      }
    });

  exports.archiveDeletedElementWithCustomDate = functions.firestore
    .document('Usuarios/{userId}')
    .onDelete(async (snapshot, context) => {
      try {
        const deletedData = snapshot.data();
        const customDateField = 'deletedFecha';
        const currentDate = new Date().toISOString();

        deletedData[customDateField] = currentDate;
        delete deletedData.deletedTimestamp;
        await admin.firestore().collection('Archivo').doc(context.params.userId).set(deletedData);
        functions.logger.info(`Elemento con ID ${context.params.userId} se archivó correctamente con la fecha de eliminación ${currentDate}.`, { structuredData: true });

        return null;
      } catch (error) {
        console.error('Error al archivar el elemento eliminado:', error);
        return null;
      }
    });
