import React from 'react';

function ActiveUsers() {
  const users = [
    { id: 1, name: 'John Doe', status: 'Online' },
    { id: 2, name: 'Jane Smith', status: 'Online' },
    { id: 3, name: 'Sam Johnson', status: 'Online' },
    { id: 4, name: 'Sam Johnson', status: 'Online' },
    { id: 5, name: 'Jane Smith', status: 'Online' },
    
    // Add more users as needed
  ];

  return (
    <div className="max-w-sm mx-auto mt-8 bg-white rounded-lg shadow-lg overflow-y-scroll max-h-[90%] scrollbar-thin">
      <div className="px-6 py-4">
        <h2 className="text-xl font-bold mb-4 text-black">Active Users</h2>
        <ul>
          {users.map((user) => (
            <li
              key={user.id}
              className="flex items-center justify-between py-2 border-b last:border-b-0"
            >
              <div className="flex items-center">
                <div className="h-8 w-8 rounded-full bg-blue-500 flex items-center justify-center text-white">
                  {user.name.charAt(0)}
                </div>
                <span className="ml-4 text-black w-[50%] h-[50%]">{user.name}</span>
              </div>
              <span className="text-green-500">{user.status}</span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default ActiveUsers;
