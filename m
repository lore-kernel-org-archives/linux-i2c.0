From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Date: Wed, 17 Apr 2019 03:17:10 +0000
Message-ID: <AM0PR04MB42110D893D07DFECFE167F5580250@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "eha@deif.com" <eha@deif.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "mojha@codeaurora.org" <mojha@codeaurora.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, "peda@axentia.se" <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Wy4uLl0NCg0KPiA+DQo+ID4gRml4ZXM6IDkwYWQyY2JlODhjMigiaTJjOiBpbXg6IHVzZSBjbGsg
bm90aWZpZXIgZm9yIHJhdGUgY2hhbmdlcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiBQbGVhc2UgYWxzbyBwcm92aWRlIGhvdyB0
byByZXByb2R1Y2UgaXQuDQo+IEFuZCBpdCBzZWVtcyBub3QgYSBuZXcgaXNzdWUsIHNob3VsZCB3
ZSBDQyBzdGFibGU/DQoNCkJlc2lkZXMgYWJvdmUgY29tbWVudHM6DQoNClJldmlld2VkLWJ5OiBE
b25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hl
bmcNCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4gDQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4gYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LWlteC5jIGluZGV4DQo+ID4gYzBjMzA0My4uZmQ3MGIxMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1pbXguYw0KPiA+IEBAIC01MTUsOSArNTE1LDkgQEAgc3RhdGljIGludCBpMmNfaW14X2Nsa19u
b3RpZmllcl9jYWxsKHN0cnVjdA0KPiA+IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiAgCQkJCSAg
ICAgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRhdGEpICB7DQo+ID4gIAlzdHJ1Y3QgY2xr
X25vdGlmaWVyX2RhdGEgKm5kYXRhID0gZGF0YTsNCj4gPiAtCXN0cnVjdCBpbXhfaTJjX3N0cnVj
dCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZigmbmRhdGEtPmNsaywNCj4gPiArCXN0cnVjdCBpbXhf
aTJjX3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZihuYiwNCj4gPiAgCQkJCQkJICAgICAg
c3RydWN0IGlteF9pMmNfc3RydWN0LA0KPiA+IC0JCQkJCQkgICAgICBjbGspOw0KPiA+ICsJCQkJ
CQkgICAgICBjbGtfY2hhbmdlX25iKTsNCj4gPg0KPiA+ICAJaWYgKGFjdGlvbiAmIFBPU1RfUkFU
RV9DSEFOR0UpDQo+ID4gIAkJaTJjX2lteF9zZXRfY2xrKGkyY19pbXgsIG5kYXRhLT5uZXdfcmF0
ZSk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KDQo=
