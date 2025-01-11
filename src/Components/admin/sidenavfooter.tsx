import { CiSettings } from "react-icons/ci"
import { LuLogOut } from "react-icons/lu"

export const SidenavFooter = () => {
    return (<footer className="z-50  bg-gray-800 text-white bottom-0 left-0 bg-gray-800 ml-[-7%]">
        <div className="w-100 flex flex-row justify-start gap-4 ml-4"><CiSettings />
            <p>Settings</p>
        </div>
        <div className="w-100 flex flex-row justify-start gap-4 ml-4"><LuLogOut />
            <p className="text-red-500">Logout</p></div>
        <br />
        <div className=" flex flex-col justify-between items-center w-[100%] h-full bg-black ">
            <br />
            <p className="w-[90%]"> &copy; 2025 WeRead.<br /> All rights reserved.</p>

            <div className="flex flex-row justify-start items-start space-x-4 w-[90%] h-full">
                <a href="#" className="hover:text-gray-400 text-[10px]">Privacy Policy</a>
                <a href="#" className="hover:text-gray-400 text-[10px]">Terms of Service</a>
                <a href="#" className="hover:text-gray-400 text-[10px]">Contact Us</a>
            </div>
            <br />
        </div>
    </footer>
    )
}