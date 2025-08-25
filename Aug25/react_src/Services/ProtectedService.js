import axios from "axios"
import AuthHeader from "./AuthHeader";

const ProtectedService = () => {
    const adminDashBoard = async () => {
        try {
            // alert("Hi");
            const response = await axios.get("http://localhost:5030/api/Vehicles", {
            headers: AuthHeader()
        });
          return response;
        }
        catch (error) {
            alert(error);
        }
    }
    return {
        adminDashBoard
    }
}

export default ProtectedService