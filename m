From: Pan Gao <pandy.gao@nxp.com>
Subject: RE: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
Date: Wed, 16 Mar 2016 02:21:46 +0000
Message-ID: <AM4PR0401MB1780E6F86EC643627A0E7E34F68A0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
 <56E80321.6090105@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0053.outbound.protection.outlook.com ([157.56.112.53]:50272
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754636AbcCPCVt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Mar 2016 22:21:49 -0400
In-Reply-To: <56E80321.6090105@mentor.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>

RnJvbTogVmxhZGltaXIgWmFwb2xza2l5IDxtYWlsdG86dmxhZGltaXJfemFwb2xza2l5QG1lbnRv
ci5jb20+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDE2IDg6NDIgUE0NCj4gVG86IFBhbiBH
YW8gPHBhbmR5Lmdhb0BueHAuY29tPjsgd3NhQHRoZS1kcmVhbXMuZGU7IHUua2xlaW5lLQ0KPiBr
b2VuaWdAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgRnVnYW5nIER1YW4NCj4gPGZ1Z2FuZy5kdWFuQG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUGF0Y2ggdjFdIGkyYzogaW14N3VscDogYWRkIGkuTVg3
VUxQIGkyYyBjb250cm9sbGVyIGJ1cyBkcml2ZXINCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gMTUu
MDMuMjAxNiAxMTo1MSwgR2FvIFBhbiB3cm90ZToNCj4gPiBBZGQgaS5NWDdVTFAgaTJjIGJ1cyBk
cml2ZXIgd2hpY2ggY2FuIGNvbnRpbnVlIG9wZXJhdGluZyBpbiBzdG9wIG1vZGVzDQo+ID4gcHJv
dmlkZWQgYW4gYXBwcm9wcmlhdGUgY2xvY2sgaXMgYXZhaWxhYmxlLg0KPiA+DQo+ID4gSXQgaXMg
YWxzbyBkZXNpZ25lZCBmb3IgbG93IENQVSBvdmVyaGVhZCB3aXRoIERNQSBvZmZsb2FkaW5nIG9m
IEZJRk8NCj4gPiByZWdpc3RlciBhY2Nlc3Nlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdh
byBQYW4gPHBhbmR5Lmdhb0BueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBpMmNfaW14N3VscF9zdGFydChzdHJ1Y3QgaW14N3VscF9pMmNf
c3RydWN0ICppMmNfaW14N3VscCkNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArCXVuc2ln
bmVkIGludCB0ZW1wOw0KPiA+ICsNCj4gPiArCWRldl9kYmcoJmkyY19pbXg3dWxwLT5hZGFwdGVy
LmRldiwgIjwlcz5cbiIsIF9fZnVuY19fKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoaTJjX2lteDd1bHAtPmJ1c19jbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJ
CWRldl9lcnIoJmkyY19pbXg3dWxwLT5hZGFwdGVyLmRldiwNCj4gPiArCQkJImNhbid0IGVuYWJs
ZSBJMkMgYnVzIGNsb2NrLCByZXQ9JWRcbiIsIHJldCk7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoaTJjX2lteDd1bHAt
PnBlcl9jbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoJmkyY19pbXg3dWxw
LT5hZGFwdGVyLmRldiwNCj4gPiArCQkJImNhbid0IGVuYWJsZSBJMkMgcGVyaXBoZXJhbCBjbG9j
aywgcmV0PSVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiBMZWFrZWQgcHJl
cGFyZWQvZW5hYmxlZCBpMmNfaW14N3VscC0+YnVzX2NsayBjbG9jayBvbiBlcnJvciBwYXRoLg0K
IA0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBUaGFua3MhIA0KDQpCZXN0IFJlZ2FyZHMNCkdhbyBQYW4N
Cg==
