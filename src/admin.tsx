
import ActiveUsers from "./Components/admin/activeusers"
import { Navbar } from "./Components/admin/navbar"
import Notification from "./Components/admin/notification"
import Sidenav from "./Components/admin/sidenav"

export const Admin = () => {
    return (<div className="flex h-screen bg-gray-400">
        <Sidenav />
        {/* Content */}
        <div className="w-screen flex flex-col bg-gray-400 justify-start items-center">
            <Navbar />
            <div className="flex flex-wrap gap-4">
                <ActiveUsers/>
                <Notification/>
            </div>

        </div>
    </div>)
}