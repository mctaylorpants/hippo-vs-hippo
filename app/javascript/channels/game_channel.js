import consumer from "channels/consumer"

const gameId = document.getElementById("game-id").value;

// consumer.subscriptions.create({ channel: "GameChannel", game_id: gameId }, {
//   connected() {
//     console.log(`connected to games channel with id ${gameId}`);
//     // Called when the subscription is ready for use on the server
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     console.log("received data", data);
//   }
// });
