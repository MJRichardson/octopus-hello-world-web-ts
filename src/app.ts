import express from 'express';
import path from "node:path";

const app = express();
const port = 3000;
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.get('/', (req, res) => {
    res.render('index', { greeting: 'Hello' });
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});