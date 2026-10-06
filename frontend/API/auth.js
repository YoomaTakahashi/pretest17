import axios from "axios";
const api = "http://localhost:3001/api/auth/login"

export default {login: (data)=> await axios.post(`${api}`,data)}
