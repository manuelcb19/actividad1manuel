const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
admin.initializeApp();
const logger = require("firebase-functions/logger");

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