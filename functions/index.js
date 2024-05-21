/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.calculateAverageRating = functions.firestore
  .document('shoes/{shoeId}/reviews/{reviewId}')
  .onWrite(async (change, context) => {
    const shoeId = context.params.shoeId;
    const reviewsRef = admin.firestore().collection(`shoes/${shoeId}/reviews`);
    const shoeRef = admin.firestore().collection('shoes').doc(shoeId);

    const reviewsSnapshot = await reviewsRef.get();
    const numberOfReviews = reviewsSnapshot.size;

    if (numberOfReviews === 0) {
      await shoeRef.update({ averageRating: 0, reviewCount: 0 });
      return;
    }

    let totalRating = 0;
    reviewsSnapshot.forEach(doc => {
      totalRating += doc.data().rating;
    });

    const averageRating = totalRating / numberOfReviews;

    await shoeRef.update({
      averageRating: averageRating,
      reviewCount: numberOfReviews
    });
  });

