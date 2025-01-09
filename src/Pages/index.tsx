import logo from "../assets/image.png"; // Make sure the image path is correct
import '../App.css'; // Import your CSS file if you haven't already
import { useNavigate } from "react-router-dom";

export const Index = () => {
    const navigate = useNavigate()
    return (
        <div className="flex flex-col justify-center items-center h-screen w-screen bg-gray-200">
            <div className="flex flex-row justify-center items-center">
                <img
                    src={logo}
                    alt="Logo"
                    className=" sm:h-32 sm:w-32 sm:m-4 sm:p-4 p-4 transition-transform duration-500 transform hover:flip-image w-24 h-24"
                />
                <div className="text-black sm:text-h1 text-h1mobile">
                    WeRead
                </div>
            </div>

            <div className="w-screen text-black flex flex-row justify-center gap-10">
                <button onClick={() => {
                    navigate('/login')
                }} className=" text-black py-2 px-4 rounded-lg hover:border-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    login
                </button>
                <button
                onClick={() => {
                    navigate("/signup")
                }}
                 className=" text-black py-2 px-4 rounded-lg hover:border-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    sign up
                </button>

            </div>
        </div>

    );
};
