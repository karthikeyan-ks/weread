import React, { useState } from 'react';
import { FaBars } from 'react-icons/fa';
import { MdDashboard } from 'react-icons/md';
import { FaBook } from 'react-icons/fa';
import { FcLibrary } from 'react-icons/fc';
import { BiLibrary, BiUser } from 'react-icons/bi';
import { SidenavFooter } from './sidenavfooter';

const Sidenav = () => {
  const [isOpen, setIsOpen] = useState(false);

  const toggleSidenav = () => {
    setIsOpen(!isOpen);
  };

  return (
    <div className="flex">

      {/* Sidebar */}
      <div className={`fixed top-0 left-0 h-full bg-gray-800 text-white w-54 transition-transform transform ${isOpen ? 'translate-x-0' : '-translate-x-full'} sm:translate-x-0`}>
        <FaBars onClick={toggleSidenav} className="relative h-6 w-6 text-gray-500 ml-[104%] mt-5" />
        <div className="h-full p-4">
          <div className='flex flex-row justify-center gap-4 items-center'>
            <img src="https://as1.ftcdn.net/v2/jpg/02/43/12/34/1000_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg" alt="img" className="w-14 h-14 rounded-full"  />
            <h2 className="sm:text-4xl text-2xl font-bold">Admin</h2>
          </div>
          <nav className="mt-4 h-full">
            <div className='flex flex-row justify-start items-center'>
              <MdDashboard />
              <a href="#" className=" block py-2 px-4 hover:bg-gray-700">Dashboard</a>
            </div>

            <div className='flex flex-row justify-start items-center'>
              <FaBook/>
              <a href="#" className="  block py-2 px-4 hover:bg-gray-700">Book list</a>
            </div>
            <div className='flex flex-row justify-start items-center'>
              <BiLibrary/>
              <a href="#" className=" block py-2 px-4 hover:bg-gray-700">Library list</a>
            </div>
            <div className='flex flex-row justify-start items-center'>
              <BiUser/>
              <a href="#" className=" block py-2 px-4 hover:bg-gray-700">User list</a>
            </div>
            <div className='flex flex-row justify-start items-center'>
              <MdDashboard />
              <a href="#" className=" block py-2 px-4 hover:bg-gray-700">Books Rented</a>
            </div>
            <SidenavFooter/>
          </nav>
          
        </div>
      </div>

      {/* Content */}
      <div className="flex-1">

        <div className="p-4">
          <h1 className="text-3xl">Main Content</h1>
          <p>This is the main content area.</p>
        </div>
      </div>
    </div>
  );
};

export default Sidenav;
