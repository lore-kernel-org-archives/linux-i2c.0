From: "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
Subject: RE: [PATCH] i2c: slave: support I2C_SLAVE_STOP event for the read
 transactions
Date: Tue, 31 Mar 2020 08:48:03 +0000
Message-ID: <DB6PR0401MB2438EC4CDA8985BE84F825048FC80@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200330105038.22546-1-biwen.li@oss.nxp.com>
 <DB6PR0401MB24389E2570C242FB9036EC968FCB0@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <20200330111231.x2a57acoy57ycyo6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:26702
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgCaIsL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Mar 2020 04:48:11 -0400
In-Reply-To: <20200330111231.x2a57acoy57ycyo6@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Biwen Li (OSS)" <biwen.li@oss.nxp.com>, Leo Li <leoyang.li@nxp.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Jiafei Pan <jiafei.pan@nxp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiBIaSwNCj4gDQo+IE9uIE1vbiwgTWFyIDMwLCAyMDIwIGF0IDEwOjU2OjI4QU0gKzAwMDAsIEJp
d2VuIExpIHdyb3RlOg0KPiA+IEhpIEFsbCwNCj4gPg0KPiA+IFRoZSBwYXRjaCBiYXNlZCBvbiBo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEyMDM2NDAvDQo+ID4gYW5kIGl0IGlz
IG5vdCBhY2NlcHRlZCwgc28gaXQoaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8x
MjAzNjQwLykNCj4gaXMgbmVlZGVkIGJlZm9yZSBhcHBseSB0aGUgbmV3IHBhdGNoLg0KPiANCj4g
SSdtIG5vdCBzdXJlIHdoYXQgc2hvdWxkIEkgZG8gd2l0aCB0aGlzIGluZm9ybWF0aW9uLiBUaGlz
IGxpbmtzIGFyZSB0byB0aGUgcGF0Y2gNCj4gd2hpY2ggbmVlZGVkIHRvIGJlIHVwZGF0ZSBieSB5
b3UsIGJlZm9yZSBpdCBjYW4gYmUgcmV2aWV3ZWQgYW5kIHRoZW4NCj4gaG9wZWZ1bGx5IGFjY2Vw
dGVkLiBXaHkgZG8geW91IHNlbmRpbmcgb25lIG1vcmUgcGF0Y2ggZm9yIHJldmlldyBmb3IgYSBw
YXRjaA0KPiB3aGljaCBpcyBub3QgYWNjZXB0ZWQ/DQpIaSBPbGVrc2lqLA0KT2theSwgZ290IGl0
LiBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaCBhZnRlciB0aGUgb2xkIHBhdGNoIGlzIGFjY2VwdGVk
IGJ5IHVwc3RyZWFtLiBUaGFuayB5b3UNCmZvciB5b3VyIHJlcGx5Lg0KPiANCj4gPiBCZXN0IFJl
Z2FyZHMsDQo+ID4gQml3ZW4gTGkNCj4gPiA+IFN1cHBvcnQgSTJDX1NMQVZFX1NUT1AgZXZlbnQg
Zm9yIHRoZSByZWFkIHRyYW5zYWN0aW9ucyhtYXN0ZXIgcmVhZA0KPiA+ID4gZnJvbQ0KPiA+ID4g
c2xhdmUpDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQml3ZW4gTGkgPGJpd2VuLmxpQG54
cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jIHwg
MSArDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4gPiA+IGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1pbXguYyBpbmRleA0KPiA+ID4gNjI1MTdhNDFiMzJkLi4xZmQwZDg3
ODg1ZDUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4gPiBAQCAtMTQ2NCw2
ICsxNDY0LDcgQEAgc3RhdGljIGlycXJldHVybl90IGkyY19pbXhfc2xhdmVfaXNyKHN0cnVjdA0K
PiA+ID4gaW14X2kyY19zdHJ1Y3QgKmkyY19pbXgpDQo+ID4gPiAgCQljdGwgJj0gfkkyQ1JfTVRY
Ow0KPiA+ID4gIAkJaW14X2kyY193cml0ZV9yZWcoY3RsLCBpMmNfaW14LCBJTVhfSTJDX0kyQ1Ip
Ow0KPiA+ID4gIAkJaW14X2kyY19yZWFkX3JlZyhpMmNfaW14LCBJTVhfSTJDX0kyRFIpOw0KPiA+
ID4gKwkJaTJjX3NsYXZlX2V2ZW50KGkyY19pbXgtPnNsYXZlLCBJMkNfU0xBVkVfU1RPUCwgJnZh
bHVlKTsNCj4gPiA+ICAJfQ0KPiA+ID4gIAlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gPiAgfQ0K
PiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiANCj4gUmVnYXJkcywNCj4gT2xla3Npag0KPiAtLQ0K
PiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IFN0
ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8IGh0dHA6Ly93d3cucGVu
Z3V0cm9uaXguZGUvDQo+IHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAg
ICAgICAgIHwgUGhvbmU6DQo+ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQg
SGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTct
NTU1NSB8DQo=
