const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firestore);
const db = admin.firestore();



async function getDeviceTokenUsers(uid){
    const querySnaps = await db.collection('users').doc(uid).collection('tokens').get();
    const tokens = querySnaps.docs.map(doc => doc.id);
    return tokens;
}

async function calculateAverage(data){
    var querySnap = await db.collection('partners').doc(data.partnerId).collection('evaluation').get();
    var average = 0;
    var index =0;
    querySnap.forEach(function(doc){
        index+=1;
        average+= doc.data().averange;
    })
    await db.collection('partners').doc(data.partnerId).update({averange: average / index})   

}

async function sendPushFcm(tokens, title,message,screen,arg){
    if(tokens.length > 0){
        const payload = {
            notification:{
                title:title,
                body:message,
                click_action:'FLUTTER_NOTIFICATION_CLICK'
            },
            data:{
                screen:screen,
            arg:arg
            }
        };
        return await admin.messaging().sendToDevice(tokens,payload).then(
            (response) => {
                console.log("sucessfuly send msg");
            }
        ).catch((error) => {
            console.log("error ", error)
        });
    }
    return;
}

exports.onUpdateOrders = functions.firestore.document('partners/{partnerId}/orders/{orderId}').onUpdate( async (snap,context) => {
    if(snap.empty){
        console.log("vazio");
        return;
    }
    const newValues = snap.after.data();
    const beforeValues = snap.before.data();
    if(beforeValues.status != newValues.status){
        var tokens = await getDeviceTokenUsers(newValues.userId);
        var title = "Pedido alterado";
        var body = "Seu pedido teve uma alteração, confira.";
        sendPushFcm(tokens,title,body,"order",snap.before.id);
    }
})

exports.onEvaluation = functions.firestore.document('partners/{partnerId}/evaluation/{evaluationId}').onCreate(async (snap,context) => {
    if(snap.empty){
        console.log("vazio");
        return;
    }

    const dateCreated = snap.data();
    calculateAverage(dateCreated);
    

})