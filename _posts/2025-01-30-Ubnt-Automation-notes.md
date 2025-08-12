---
title: Ubnt automation notes
date: 2025-01-05 00:00:01 -0400
categories: [automation, ubiquiti]
tags: [automation, ubiquiti]
author: dmcken
comments: false
---


## AirFiber 60 and family

Interesting commands:
* prs_*
  * prs_stats -
* rtstat
* tcpdump
* ubinfo
* uibox - Seems to be a replacement of ubntbox
* wave_ai

* As of:
  * Conditions:
    * 1.3.0
    * AF60-XR
  * Notice:
    * ubntbox is missing, seems to be replaced with uibox.
* Done


### Zabbix - Ubiquiti Screen scrape stats

```javascript
try {
	var obj = JSON.parse(value);
	var host = obj.host;
	var password = obj.pass;
	var username = obj.user;
	var result = "";
	var base_url = "https://" + host;
	var login_path = "/api/v1.0/user/login";
	var stat_path = "/api/v1.0/statistics";

	var req = new HttpRequest();
	var resp = req.post(
		base_url + login_path,
		JSON.stringify({'username': username, 'password': password})
	);
	if (req.getStatus() != 200) { throw "Error logging in: " + req.getStatus(); }
	var authheaders = req.getHeaders();
	var authtoken = authheaders["x-auth-token"];

	req.addHeader("x-auth-token: " + authtoken);
	resp = req.get(base_url + stat_path);

	if (req.getStatus() != 200) { throw "Error fetching stats: " + req.getStatus(); }
	result = resp;
} catch (error) {
	Zabbix.log(2, "ERROR - EdgePower stats fetch: " + error);
	result = JSON.stringify({'error': error});
}

return result;
```


