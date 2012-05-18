var flatiron = require('flatiron'),
	ecstatic = require('ecstatic'),
	crypto = require('crypto'),
	moment = require('moment'),
	_ = require('underscore'),
	Database = require('./lib/db'),
	select = require('./lib/select'),
    app = flatiron.app;

var db = new Database('./db/default.db');
db.load();

var identify = function(req, res, next){	
	var address = res.response.connection.address().address,
		shasum = crypto.createHash('sha1'),
		digested;

	shasum.update(req.headers['user-agent'] + address + moment().format('YYYY-MM-DD'));

	req.identity = shasum.digest('base64');

	next();
};

var voteLimit = function(req, res, next) {
	var limit = 100;
	if(! ~req.url.indexOf('veto')) return next();


	var vetoes = _.reduce(db.places, function(count, place){
		return count + _.map(place.vetoes, function(veto){
			return veto.who === req.identity;
		}).length;
	}, 0);

	if(limit <= vetoes) {
		res.json(500, {
			message : 'Veto limit met for today!'
		});
	} else {
		next();
	}
};

app.use(flatiron.plugins.http);

app.http.before = [
	ecstatic(__dirname+'/public'),
	identify,
	voteLimit
];

app.router.get('/places', function() {
	this.res.json(db.places);
});

app.router.get('/places/veto/:id', function(id) {
	var self = this;
	var place = _.find(db.places, function(place){
		return place.id === parseInt(id);
	});
	
	place.vetoes = place.vetoes || [];

	place.vetoes.push({
		who: this.req.identity,
		created: Date.now()
	});
	
	db.save(function(){
		io.sockets.emit('vote');
		self.res.json(db.places);
	});
});

app.router.get('/places/select', function() {
	this.res.json({
		message: 'Thank you, enjoy your lunch!'
	});

	io.sockets.emit('select', select(db.places));
});

app.start(process.env.PORT || 3000);
var io = require('socket.io').listen(app.server);

io.configure(function () { 
	io.set('transports', ['xhr-polling']); 
	io.set('polling duration', 10); 
});
