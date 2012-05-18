var moment = require('moment');
var _ = require('underscore');

var buildCategoricalDistributionFromPlaces = function(places) {
	var distribution = [];
	var totalScore = 0;
	var probabilityAccumulator = 0;
	var place, normalizer, normalizedPlaceScore;

	places.forEach(function(place) {
		totalScore += getScoreFromPlace(place);
	});

	normalizer = 1 / totalScore;

	var addPlaceToDistribution = function(place) {
		var normalizedPlaceScore;

		normalizedPlaceScore = getScoreFromPlace(place) * normalizer;
		distribution.push({ probStart: probabilityAccumulator, probEnd: probabilityAccumulator + normalizedPlaceScore, place: place});
		probabilityAccumulator += normalizedPlaceScore;
	};

	places.forEach(addPlaceToDistribution);

	return distribution;
}
/**
 * All time vetoes has a 10% hit.
 * Todays vetoes 100% hit;
 */
var getScoreFromPlace = function(place) {

	var today = moment().sod().valueOf();
	var todaysVetoes = _.reduce(place.vetoes, function(memo, veto){
		if (moment(veto.created).valueOf() > today) {
			return memo + 1;
		} else {
			return memo;
		}
	}, 0);
	
	var score = 10 - ((place.vetoes.length * 0.1) - todaysVetoes);
	
	return score;
};

var getRandomPlaceFromDistribution = function(distribution) {
	var rand = Math.random();
	var i = 0;

	while (i < distribution.length) {
		if (rand >= distribution[i].probStart && rand <= distribution[i].probEnd) {
			return distribution[i].place;
		}

		i++;
	}

	throw new Error('Reached end of distribution without finding anything. This should not happen!');
};

var select = function(places){
	var distribution = buildCategoricalDistributionFromPlaces(places);
	return getRandomPlaceFromDistribution(distribution);
};

module.exports = select;
