import Urbit from "@urbit/http-api";

const api = new Urbit("");
api.ship = window.ship;

export default api;
