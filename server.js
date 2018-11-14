const path = require('path')
const express = require('express')
const app = express()
const port = 3000

app.use('/static', express.static('public'))
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'))
})

app.listen(port, () => console.log(`Example app running on http://localhost:${port}`))
