var flatiron = require('flatiron'),
	ecstatic = require('ecstatic'),
	mongoose = require('mongoose'),
	crypto = require('crypto'),
	moment = require('moment'),
    app = flatiron.app,
	Schema = mongoose.Schema,
	ObjectId = Schema.ObjectId;

mongoose.connect('mongodb://localhost/lunch');

var Vote = new Schema({
	created: {
		type: Date,
		"default": Date.now
	}
});

var Place = mongoose.model('Place', new Schema({
	name: String,
	votes: [Vote]
}));

var Hit = mongoose.model('Hit', new Schema({
	who: String,
	created: {
		type: Date,
		"default" : Date.now
	}
}));

var identify = function(req, res, next){	
	var address = res.response.connection.address().address,
		shasum = crypto.createHash('sha1'),
		digested;

	shasum.update(req.headers['user-agent'] + address + moment().format('YYYY-MM-DD'));

	req.identity = shasum.digest('base64');

	next();
};

var voteLimit = function(req, res, next) {
	var limit = 3;
	if(~req.url.indexOf('vote')){
		Hit.find({ who: req.identity}, function(err, hits){
			if(hits.length <= limit - 1){
				var hit = new Hit({
					who: req.identity
				});
				
				hit.save(function(err){
					next();
				});
			} else {
				res.json(500, {
					error: 'Hit request limit.'
				});
			}
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

app.router.get('/places', function () {
	var self = this;

	Place.find({}, function(err, places){
		self.res.json(places);
	});

});

app.router.get('/places/vote/:id', function(id){
	var self = this;

	Place.findById(id, function(err, place){
		place.votes.push({
			who: self.req.identity
		});

		place.save(function(err){
			self.res.json({
				id: place.id
			});
		});
	});
});

app.start(process.env.PORT || 3000);

