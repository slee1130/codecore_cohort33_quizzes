const express = require('express');
const knex = require('../db/client');
const router = express.Router();
const COOKIE_MAX_AGE = 1000 * 60 * 60 * 24 * 7;
//router.use(cookieParser());


router.get('/', (req,res)=> {
   knex("clucks")
   .select("*")
   .orderBy("createdAt", "DESC")
   .then((data)=> {
       res.render('index', {
        data: data,
       });
   });
});




function backtoSign_In(req, res, next) {
    if (res.locals.username) {
        next();
    } else {
        res.render('/sign_in')
    }
}


router.post('/', (req, res) => {
    const cluckParams = {
        username: req.cookies.username,
        imageUrl: req.body.imageUrl,
        content: req.body.content
    };
    knex("clucks").insert(cluckParams).returning("*")
    .then((data)=>{
        res.redirect("/");
    }
        // knex("clucks")
        //     .select("*")
        //     .orderBy("createdAt", "DESC")
        //     .then((data) => {
        //         console.log('DATA: ', data);
        //         res.render('index', { data });
        //     })
    )
});


//sign out
router.get('/sign_out', (req, res) => {
    res.clearCookie('username');
    res.redirect('/');
})


router.get('/new', (req, res) => {
    console.log("**************");
    if (req.cookies.username) {
        res.render('new', {
            username: req.cookies.username
        });
    } else {
        res.render('sign_in', {
            username: req.cookies.username
        });
    }
});



//sign in
router.get('/sign_in', (req, res) => {
    res.render('sign_in', {
        username: req.cookies.username
    });
})

router.post('/sign_in', (req, res) => {
    res.cookie('username', req.body.username, {
        maxAge: new Date(COOKIE_MAX_AGE)
    })
    res.redirect('/');

})







module.exports=router;




