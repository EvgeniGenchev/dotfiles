// ==UserScript==
// @name			Clean Facebook
// @description		Debloat Facebook by removing certain elements
// 
// @version 1.0.0
// @license MIT
// @author Evgeni Genchev
//
// @match *://*.facebook.com/*
// @exclude example.com
// @run-at document-start
// ==/UserScript==



// complementary
// navigation

function fuckYouFacebook(){
	var right = document.querySelectorAll('[role=complementary]');
	var left = document.querySelectorAll('[role=navigation]');
	var stories = document.querySelectorAll('[data-pagelet=Stories]');
	var vid_chat = document.querySelectorAll('[data-pagelet=VideoChatHomeUnit]');

	right[0].remove();
	left[2].remove();
	stories[0].remove();
	vid_chat[0].remove();
}

setTimeout(fuckYouFacebook, 1000);
