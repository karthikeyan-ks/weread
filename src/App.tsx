import { useState } from 'react'
import './App.css'
import '../index.css'
import { BrowserRouter, Route, Router, Routes } from 'react-router-dom'
import { Index } from './Pages'
import { Login } from './Pages/login'
import { Signup } from './Pages/signup'
import { Admin } from './admin'

function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Index/>}/>
        <Route path='/login' element={<Login/>}/>
        <Route path='/signup' element={<Signup/>}/>
        <Route path='/admin' element={<Admin/>}/>
      </Routes>
    </BrowserRouter>
  )
}

export default App
