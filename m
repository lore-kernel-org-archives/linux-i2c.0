From: Peter Rosin <peda@axentia.se>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Date: Tue, 26 Mar 2019 10:24:03 +0000
Message-ID: <dcba97d5-639f-2f41-70ff-0ee9de9031d5@axentia.se>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Content-Language: en-US
Content-ID: <CDFA7677229FB2449D8D943498F321F6@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Price <steven.price@arm.com>, "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ying.zhang22455@nxp.com" <ying.zhang22455@nxp.com>
Cc: "upstream-release@linux.nxdi.nxp.com" <upstream-release@linux.nxdi.nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0wMy0yNSAxODoxMiwgU3RldmVuIFByaWNlIHdyb3RlOg0KPiBPbiAyNS8wMy8yMDE5
IDE1OjMwLCBsYXVyZW50aXUudHVkb3JAbnhwLmNvbSB3cm90ZToNCj4+IEZyb206IExhdXJlbnRp
dSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+Pg0KPj4gSWYgdGhlIGRtYSBjb250
cm9sbGVyIGlzIG5vdCB5ZXQgcHJvYmVkLCBkZWZlciBpMmMgcHJvYmUuDQo+PiBUaGUgZXJyb3Ig
cGF0aCBpbiBwcm9iZSB3YXMgc2xpZ2h0bHkgbW9kaWZpZWQgKG5vIGZ1bmN0aW9uYWwgY2hhbmdl
KQ0KDQoqc25pcCoNCg0KPj4gQEAgLTExNjEsMTkgKzExNjIsMjUgQEAgc3RhdGljIGludCBpMmNf
aW14X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgCXBtX3J1bnRpbWVf
bWFya19sYXN0X2J1c3koJnBkZXYtPmRldik7DQo+PiAgCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNw
ZW5kKCZwZGV2LT5kZXYpOw0KPj4gIA0KPj4gKwkvKiBJbml0IERNQSBjb25maWcgaWYgc3VwcG9y
dGVkICovDQo+PiArCXJldCA9IGkyY19pbXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIp
Ow0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+PiAr
CQkJZGV2X2luZm8oJnBkZXYtPmRldiwgImNhbid0IHVzZSBETUEsIHVzaW5nIFBJTyBpbnN0ZWFk
LlxuIik7DQo+PiArCQllbHNlDQo+PiArCQkJZ290byBkZWxfYWRhcHRlcjsNCj4+ICsJfQ0KPj4g
Kw0KPiANCj4gVGhpcyBjYW4gYmUgc2ltcGxpZmllZCBieSByZXZlcnNpbmcgdGhlIGNvbmRpdGlv
bjoNCj4gDQo+IAlpZiAocmV0KSB7DQo+IAkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAJ
CQlnb3RvIGRlbF9hZGFwdGVyOw0KPiAJCWRldl9pbmZvKCk7DQo+IAl9DQo+IA0KPiBvciBldmVu
Og0KPiANCj4gCWlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gCQlnb3RvIGRlbF9hZGFwdGVy
Ow0KPiAJZWxzZSBpZiAocmV0KQ0KPiAJCWRldl9pbmZvKCk7DQo+IA0KDQpXaGlsZSB3ZSdyZSBs
b29raW5nIGZvciBzdHVmZiB0byB0YWtlIG91dCwgemFwIHRoZSAiZWxzZSIuLi4NCg0KCWlmIChy
ZXQgPT0gLUVQUk9CRV9ERUZFUikNCgkJZ290byBkZWxfYWRhcHRlcjsNCglpZiAocmV0KQ0KCQlk
ZXZfaW5mbyguLi4pOw0KDQpDaGVlcnMsDQpQZXRlcg0K
