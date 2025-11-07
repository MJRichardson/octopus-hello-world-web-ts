import express from 'express';
import path from "node:path";

const port = process.env.PORT || "3000";
const greeting = process.env.GREETING || "Hello";
const environment = process.env.ENVIRONMENT || "Development";

const app = express();
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.static(path.join('public')));

app.get('/', (req, res) => {
    res.render('index',
        {
            greeting: greeting,
            environment: environment
        });
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});