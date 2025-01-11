
import ActiveUsers from "./Components/admin/activeusers"
import { Navbar } from "./Components/admin/navbar"
import Sidenav from "./Components/admin/sidenav"

export const Admin = () => {
    return (<div className="flex h-screen bg-gray-400">
        <Sidenav />
        {/* Content */}
        <div className="w-screen flex flex-col bg-gray-400 justify-start items-center">
            <Navbar />
            <div className="flex gap-2">
                <ActiveUsers/>
            </div>

        </div>
    </div>)
}