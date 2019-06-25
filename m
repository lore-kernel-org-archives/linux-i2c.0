From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 6/9] dt-bindings: i2c: at91: add binding for
 enable-ana-filt
Date: Tue, 25 Jun 2019 08:55:53 +0000
Message-ID: <4e81d3c9-25f3-ca6e-f2d5-17fad5905bb8@axentia.se>
References: <1561449642-26956-1-git-send-email-eugen.hristev@microchip.com>
 <1561449642-26956-7-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561449642-26956-7-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Content-ID: <1181221CAD0DF84EA05524BA6EC34C79@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0wNi0yNSAxMDowNSwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBBZGQgYmluZGluZyBzcGVjaWZpY2F0aW9uIGZvciBhbmFsb2dpYyBmaWx0ZXIgaW5zaWRlIHRo
ZSBpMmMgY29udHJvbGxlcg0KDQpzL2FuYWxvZ2ljL3RoZSBhbmFsb2cvDQoNCj4gU2lnbmVkLW9m
Zi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPiAtLS0N
Cj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLWF0OTEudHh0IHwg
NCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtYXQ5MS50eHQg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dA0KPiBp
bmRleCA4MjY4NTk1Li4yMGQzMzRjIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dA0KPiBAQCAtMjMsNiArMjMsOSBAQCBP
cHRpb25hbCBwcm9wZXJ0aWVzOg0KPiAgLSBlbmFibGUtZGlnLWZpbHQ6IEVuYWJsZSB0aGUgYnVp
bHQtaW4gZGlnaXRhbCBmaWx0ZXIgb24gdGhlIGkyYyBsaW5lcywNCj4gICAgc3BlY2lmaWNhbGx5
IHJlcXVpcmVkIGRlcGVuZGluZyBvbiB0aGUgaGFyZHdhcmUgUENCL2JvYXJkIGFuZCBpZiB0aGUN
Cj4gICAgdmVyc2lvbiBvZiB0aGUgY29udHJvbGxlciBpbmNsdWRlcyBpdC4NCj4gKy0gZW5hYmxl
LWFuYS1maWx0OiBFbmFibGUgdGhlIGJ1aWx0LWluIGFuYWxvZ2ljIGZpbHRlciBvbiB0aGUgaTJj
IGxpbmVzLA0KPiArICBzcGVjaWZpY2FsbHkgcmVxdWlyZWQgZGVwZW5kaW5nIG9uIHRoZSBoYXJk
d2FyZSBQQ0IvYm9hcmQgYW5kIGlmIHRoZQ0KPiArICB2ZXJzaW9uIG9mIHRoZSBjb250cm9sbGVy
IGluY2x1ZGVzIGl0Lg0KPiAgLSBDaGlsZCBub2RlcyBjb25mb3JtaW5nIHRvIGkyYyBidXMgYmlu
ZGluZw0KPiAgDQo+ICBFeGFtcGxlcyA6DQo+IEBAIC02MCw2ICs2Myw3IEBAIGkyYzA6IGkyY0Bm
ODAzNDYwMCB7DQo+ICAJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCj4gIAlpMmMtc2RhLWhvbGQt
dGltZS1ucyA9IDwzMzY+Ow0KPiAgCWVuYWJsZS1kaWctZmlsdDsNCj4gKwllbmFibGUtYW5hLWZp
bHQ7DQoNClBlcmhhcHMNCg0KCW1pY3JvY2hpcCxkaWdpdGFsLWZpbHRlcjsNCgltaWNyb2NoaXAs
YW5hbG9nLWZpbHRlcjsNCg0KPw0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+ICANCj4gIAl3bTg3MzE6
IHdtODczMUAxYSB7DQo+ICAJCWNvbXBhdGlibGUgPSAid204NzMxIjsNCj4gDQoNCg==
