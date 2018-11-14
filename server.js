const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 3000

let count = 0;

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'))
})
app.use('/static', express.static('public'))
app.use(bodyParser.json());

app.get('/api/count', (req, res) => {
  res.json({ count })
})

app.post('/api/count', (req, res) => {
  console.log('count: ', count);
  if (req.body.type === 'increment') {
    count++

    res.json({ count })
  } else if (req.body.type === 'decrement') {
    count--

    res.json({ count })
  } else {
    throw new Error('Unknown type')
  }
})

app.listen(port, () => console.log(`Example app running on http://localhost:${port}`))
