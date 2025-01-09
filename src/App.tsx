import { useState } from 'react'
import './App.css'
import '../index.css'
import { BrowserRouter, Route, Router, Routes } from 'react-router-dom'
import { Index } from './Pages'
import { Login } from './Pages/login'

function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Index/>}/>
        <Route path='/login' element={<Login/>}/>
        
      </Routes>
    </BrowserRouter>
  )
}

export default App
