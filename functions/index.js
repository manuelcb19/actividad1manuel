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
})