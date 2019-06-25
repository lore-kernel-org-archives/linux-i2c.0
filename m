From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 3/9] dt-bindings: i2c: at91: add binding for
 enable-dig-filtr
Date: Tue, 25 Jun 2019 08:57:14 +0000
Message-ID: <d6f9cae4-0281-e1da-3c7d-69600f7562cd@axentia.se>
References: <1561449642-26956-1-git-send-email-eugen.hristev@microchip.com>
 <1561449642-26956-4-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561449642-26956-4-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Content-ID: <011A95CE47B3734FB0FAAF2F46BA808C@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0wNi0yNSAxMDowNCwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBBZGQgYmluZGluZyBzcGVjaWZpY2F0b2luIGZvciBkaWdpdGFsIGZpbHRlciBpbnNpZGUgdGhl
IGkyYyBjb250cm9sbGVyDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdl
bi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2kyYy9pMmMtYXQ5MS50eHQgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pMmMvaTJjLWF0OTEudHh0DQo+IGluZGV4IDIyMTBmNDMuLjgyNjg1OTUgMTAw
NjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLWF0
OTEudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJj
LWF0OTEudHh0DQo+IEBAIC0yMCw2ICsyMCw5IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICAg
IGNhcGFibGUgSTJDIGNvbnRyb2xsZXJzLg0KPiAgLSBpMmMtc2RhLWhvbGQtdGltZS1uczogVFdE
IGhvbGQgdGltZSwgb25seSBhdmFpbGFibGUgZm9yICJhdG1lbCxzYW1hNWQ0LWkyYyINCj4gICAg
YW5kICJhdG1lbCxzYW1hNWQyLWkyYyIuDQo+ICstIGVuYWJsZS1kaWctZmlsdDogRW5hYmxlIHRo
ZSBidWlsdC1pbiBkaWdpdGFsIGZpbHRlciBvbiB0aGUgaTJjIGxpbmVzLA0KPiArICBzcGVjaWZp
Y2FsbHkgcmVxdWlyZWQgZGVwZW5kaW5nIG9uIHRoZSBoYXJkd2FyZSBQQ0IvYm9hcmQgYW5kIGlm
IHRoZQ0KPiArICB2ZXJzaW9uIG9mIHRoZSBjb250cm9sbGVyIGluY2x1ZGVzIGl0Lg0KPiAgLSBD
aGlsZCBub2RlcyBjb25mb3JtaW5nIHRvIGkyYyBidXMgYmluZGluZw0KPiAgDQo+ICBFeGFtcGxl
cyA6DQo+IEBAIC01Niw2ICs1OSw3IEBAIGkyYzA6IGkyY0BmODAzNDYwMCB7DQo+ICAJY2xvY2tz
ID0gPCZmbHgwPjsNCj4gIAlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAgCWkyYy1zZGEtaG9s
ZC10aW1lLW5zID0gPDMzNj47DQo+ICsJZW5hYmxlLWRpZy1maWx0Ow0KDQpUaGlzIHNwZWxsaW5n
IGRvZXMgbm90IG1hdGNoIHRoZSBzcGVsbGluZyBpbiB0aGUgc3ViamVjdC4gQnV0IHBsZWFzZSBz
ZWUNCm15IGNvbW1lbnQgb24gcGF0Y2ggNi85Li4uDQoNCkNoZWVycywNClBldGVyDQoNCj4gIA0K
PiAgCXdtODczMTogd204NzMxQDFhIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJ3bTg3MzEiOw0KPiAN
Cg0K
