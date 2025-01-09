import '../index.css'
export const Login = () => {
    return (<div className='w-screen h-screen bg-gray-200'>
        <form className='w-screen h-[50%] sm:p-10 flex flex-row justify-center items-center'>


            <fieldset className="border p-4 w-[90%] sm:w-[50%]">
                <h1 className='font-custom text-black sm:text-h1 text-h1mobile'>Admin Panel</h1>
                <br />
                <br />
                <div className='border border-black p-3 shadow-sm p-6 rounded-px-10'>
                    <div className="flex flex-row justify-between gap-3 mb-4">
                        <label htmlFor="name" className="block text-black">Name:</label>
                        <input type="text" className="sm:w-[80%] w-[60%] bg-white border border-gray-300 p-2 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter Your username" />
                    </div>

                    <div className="flex flex-row justify-between gap-3 mb-4">
                        <label htmlFor="email" className="block text-black">Email:</label>
                        <input type="text" className="sm:w-[80%] w-[60%] bg-white border border-gray-300 p-2 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter Your Email" />
                    </div>
                    <div className="flex flex-row justify-between gap-3 mb-4">
                        <label htmlFor="email" className="block text-black">Password:</label>
                        <input type="text" className="sm:w-[80%] w-[60%] bg-white border border-gray-300 p-2 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter Your Password" />
                    </div>
                </div>

            </fieldset>
        </form>
    </div>)
}