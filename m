From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 2/4] i2c: at91: implement i2c bus recovery
Date: Mon, 7 Oct 2019 10:17:53 +0000
Message-ID: <3c3e157e-a2bc-eb6d-b59d-0c7415692206@microchip.com>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
 <20191002144658.7718-3-kamel.bouhara@bootlin.com>
 <08e99a4b-851e-0bee-4c5a-8578b42c283e@microchip.com>
 <20191004203933.tfhr6cwbsq2hxrov@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004203933.tfhr6cwbsq2hxrov@pengutronix.de>
Content-Language: en-US
Content-ID: <A41E6E2BDD92C54BA28BFAEBA2B63155@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: u.kleine-koenig@pengutronix.de
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-i2c@vger.kernel.org

DQoNCk9uIDA0LjEwLjIwMTkgMjM6MzksIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBPbiBGcmksIE9jdCAwNCwgMjAxOSBhdCAwOTozNToyM0FN
ICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGkgS2FtZWws
DQo+Pg0KPj4gT24gMDIuMTAuMjAxOSAxNzo0NiwgS2FtZWwgQm91aGFyYSB3cm90ZToNCj4+PiAr
c3RhdGljIGludCBhdDkxX2luaXRfdHdpX3JlY292ZXJ5X2luZm8oc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiwNCj4+PiArCQkJCSAgICAgICBzdHJ1Y3QgYXQ5MV90d2lfZGV2ICpkZXYpDQo+
Pj4gK3sNCj4+PiArCXN0cnVjdCBpMmNfYnVzX3JlY292ZXJ5X2luZm8gKnJpbmZvID0gJmRldi0+
cmluZm87DQo+Pj4gKw0KPj4+ICsJZGV2LT5waW5jdHJsID0gZGV2bV9waW5jdHJsX2dldCgmcGRl
di0+ZGV2KTsNCj4+PiArCWlmICghZGV2LT5waW5jdHJsIHx8IElTX0VSUihkZXYtPnBpbmN0cmwp
KSB7DQo+Pg0KPj4gWW91IG1heSB1c2UgSVNfRVJSX09SX05VTEwoKSBoZXJlLg0KPiANCj4gQ2Fu
IGRldm1fcGluY3RybF9nZXQgcmV0dXJuIE5VTEw/IEZyb20gYSBxdWljayBsb29rLCBpdCBjYW5u
b3QuDQoNCkxvb2tpbmcgcXVpY2tseSB0aG91Z2ggaXQsIHllcywgaXQgc2VlbXMgaXQgY2FuJ3Qu
DQoNCj4gDQo+IHJ1bGUgb2YgdGh1bWI6IElTX0VSUl9PUl9OVUxMIGlzIHdyb25nIGFzIGl0IGlz
IGEgc2lnbiBvZiBwb29yIHJldHVybg0KPiB2YWx1ZSBzZW1hbnRpY3MuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMNCj4gVXdlDQo+IA0K
