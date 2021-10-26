module app; 
import vibe.vibe; 

import vibe.appmain;
import vibe.http.auth.basic_auth;
import vibe.http.router;
import vibe.http.server;
import std.functional : toDelegate;

bool checkPassword(string user, string password) 
{
	return user == "koni" && password == "r4MKC(uu2;M:?7/ggRSDVvvgtighwDOFIJF";
}

void main() {
	auto router = new URLRouter; 

	router.get("/", staticTemplate!"index.dt"); 

	router.any("*", performBasicAuth("Site Realm", toDelegate(&checkPassword))); 

	router.get("/admin", staticTemplate!"admin.dt");

	auto settings = new HTTPServerSettings; 
	settings.port = 8000;
	settings.bindAddresses = ["::1", "127.0.0.1"]; 

	auto listener = listenHTTP(settings, router); 
	scope(exit) listener.stopListening(); 
	runApplication();
}