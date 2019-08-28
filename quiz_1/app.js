const express = require('express');
const logger = require('morgan');
const path = require('path')
const cookieParser = require('cookie-parser');
const methodOverride = require('method-override');

const indexRouter = require('./routes/index')
const knex = require('./db/client');
const app = express();

app.use(express.static(path.join(__dirname, 'public')));

app.use(express.urlencoded({ extended: true }));

app.use(methodOverride((req, res) => {
    if (req.body && req.body._method) {
        const method = req.body._method
        return method;
    }
}))

// app.set('views', 'views');
app.use(cookieParser());
app.use(getUsernameMiddleware);
app.use(logger('dev'));



function getUsernameMiddleware(req,res,next){
    res.locals.username = req.cookies.username;
    next();
}

function backtoSign_In(req, res, next) {
    if (res.locals.username) {
        next();
    } else {
        res.render('/sign_in')
    }
}

app.set('view engine', 'ejs');
// app.use('/', rootRouter);
app.use( indexRouter);

// app.get('/index', (req, res) => {
//     console.log("*********")
//     res.render('/index',{data:null});
// })

const PORT = 4545
const ADDRESS = 'localhost'
app.listen(PORT, ADDRESS, () => {
    console.log(`listening to http://${ADDRESS}:${PORT}`)
})