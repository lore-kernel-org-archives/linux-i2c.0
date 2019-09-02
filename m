From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4 2/9] dt-bindings: i2c: add bindings for i2c analog and
 digital filter
Date: Mon, 2 Sep 2019 10:49:08 +0000
Message-ID: <9a9c209c-2fb8-0a4c-4e0a-b04fefda3360@axentia.se>
References: <1567418773-2427-1-git-send-email-eugen.hristev@microchip.com>
 <1567418773-2427-3-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567418773-2427-3-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Content-ID: <AC53F3D2C1E25D428E0625D4871D40DB@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pierre-yves.mordret@st.com" <pierre-yves.mordret@st.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0wOS0wMiAxMjoxMiwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBTb21lIGkyYyBjb250cm9sbGVycyBoYXZlIGEgYnVpbHQtaW4gZGlnaXRhbCBvciBhbmFsb2cg
ZmlsdGVyLg0KPiBUaGlzIGlzIHNwZWNpZmljYWxseSByZXF1aXJlZCBkZXBlbmRpbmcgb24gdGhl
IGhhcmR3YXJlIFBDQi9ib2FyZC4NCj4gU29tZSBjb250cm9sbGVycyBhbHNvIGFsbG93IHNwZWNp
ZnlpbmcgdGhlIG1heGltdW0gd2lkdGggb2YgdGhlDQo+IHNwaWtlcyB0aGF0IGNhbiBiZSBmaWx0
ZXJlZC4gVGhlIHdpZHRoIGxlbmd0aCBjYW4gYmUgc3BlY2lmaWVkIGluIG5hbm9zZWNvbmRzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2No
aXAuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMv
aTJjLnR4dCB8IDExICsrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pMmMvaTJjLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJj
LnR4dA0KPiBpbmRleCA0NGVmYWZkLi44ZGJmZjY3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMudHh0DQo+IEBAIC01NSw2ICs1NSwxNyBAQCB3
YW50cyB0byBzdXBwb3J0IG9uZSBvZiB0aGUgYmVsb3cgZmVhdHVyZXMsIGl0IHNob3VsZCBhZGFw
dCB0aGUgYmluZGluZ3MgYmVsb3cuDQo+ICAJTnVtYmVyIG9mIG5hbm9zZWNvbmRzIHRoZSBTREEg
c2lnbmFsIHRha2VzIHRvIGZhbGw7IHQoZikgaW4gdGhlIEkyQw0KPiAgCXNwZWNpZmljYXRpb24u
DQo+ICANCj4gKy0gaTJjLWFuYWxvZy1maWx0ZXINCj4gKwlFbmFibGUgYW5hbG9nIGZpbHRlciBm
b3IgaTJjIGxpbmVzLg0KPiArDQo+ICstIGkyYy1kaWdpdGFsLWZpbHRlcg0KPiArCUVuYWJsZSBk
aWdpdGFsIGZpbHRlciBmb3IgaTJjIGxpbmVzLg0KPiArDQo+ICstIGkyYy1maWx0ZXItd2lkdGgt
bnMNCj4gKwlXaWR0aCBvZiBzcGlrZXMgd2hpY2ggY2FuIGJlIGZpbHRlcmVkIGJ5IGVpdGhlciBk
aWdpdGFsIG9yIGFuYWxvZw0KPiArCWZpbHRlcnMgKGkyYy1hbmFsb2ctZmlsdHIgb3IgaTJjLWRp
Z2l0YWwtZmlsdHIpLiBUaGlzIHdpZHRoIGlzIHNwZWNpZmllZA0KDQpmaWx0ciAtPiBmaWx0ZXIg
KHR3byBpbnN0YW5jZXMpDQoNCldoYXQgaWYgeW91IHdhbnQvbmVlZCB0byBoYXZlIGRpZmZlcmVu
dCBiYW5kd2lkdGggZm9yIHRoZSBkaWdpdGFsIGFuZCBhbmFsb2cNCmZpbHRlcnM/IEFmdGVyIGFs
bCwgdGhpcyBpcyBhIGdlbmVyaWMgYmluZGluZy4uLg0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+ICsJ
aW4gbmFub3NlY29uZHMuDQo+ICsNCj4gIC0gaW50ZXJydXB0cw0KPiAgCWludGVycnVwdHMgdXNl
ZCBieSB0aGUgZGV2aWNlLg0KPiAgDQo+IA0KDQo=
