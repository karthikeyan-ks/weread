export const Navbar = () => {
    return (<nav className="bg-gray-800 text-white pt-4 pb-4 w-[100%] sm:w-[98%] top-0 sm:ml-2">
        <div className="w-[95%] flex items-center justify-between ">
            {/* Logo */}
            <div className="text-lg font-bold">
                <a href="#"></a>
            </div>

            {/* Search Bar */}
            <div className="w-[40%]">
                <div className="flex w-[100%] h-[42px] items-center bg-gray-700 rounded-lg overflow-hidden">
                    <input
                        type="text"
                        placeholder="Search..."
                        className="bg-transparent text-white outline-none"
                    />
                </div>
            </div>


            {/* Navigation Links */}
            <div className="flex flex-row space-x-4">
                <button className="p-2 border border-white">add</button>
                <button className="p-2 border border-white">submit</button>
            </div>
        </div>
    </nav>)
}