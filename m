From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: npcm7xx: * add binding for i2c
 controller
Date: Tue, 19 Nov 2019 22:30:19 +0000
Message-ID: <a599e9e7-6b00-2bbc-407a-8f48b17b43c5@axentia.se>
References: <20191119144930.227241-1-tali.perry1@gmail.com>
 <20191119144930.227241-2-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119144930.227241-2-tali.perry1@gmail.com>
Content-Language: en-US
Content-ID: <C6B6B04574D64B46A7E1AA33AC408CDD@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tali Perry <tali.perry1@gmail.com>, "avifishman70@gmail.com" <avifishman70@gmail.com>, "tmaimon77@gmail.com" <tmaimon77@gmail.com>, "venture@google.com" <venture@google.com>, "yuenn@google.com" <yuenn@google.com>, "benjaminfair@google.com" <benjaminfair@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "jdelvare@suse.de" <jdelvare@suse.de>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "arnd@arndb.de" <arnd@arndb.de>, "max@enpas.org" <max@enpas.org>, "krzysztof.adamski@nokia.com" <krzysztof.adamski@nokia.com>, "syniurge@gmail.com" <syniurge@gmail.com>, puwen@hygon
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0xMS0xOSAxNTo0OSwgVGFsaSBQZXJyeSB3cm90ZToNCj4gIGR0LWJpbmRpbmdzOiBp
MmM6IG5wY203eHg6ICogYWRkIGJpbmRpbmcgZm9yIGkyYyBjb250cm9sbGVyDQoNCkkgbWlzc2lu
ZyBhbiBlbXB0eSBsaW5lIGJlZm9yZSB0aGUgYmxvY2sgb2YgdGFncywgYnV0IHRoZSBiaWdnZXIg
cHJvYmxlbQ0KaXMgdGhlIHJlcGVhdGVkIHN1YmplY3QgbGluZS4gQWxzbywgdGhlICcqJyBpbiB0
aGUgc3ViamVjdCBtYWtlcyBubw0Kc2Vuc2UgdG8gbWUuDQoNCj4gU2lnbmVkLW9mZi1ieTogVGFs
aSBQZXJyeSA8dGFsaS5wZXJyeTFAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9p
MmMvaTJjLW5wY203eHgudHh0ICAgfCAyOSArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLW5wY203eHgudHh0DQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbnBjbTd4
eC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1ucGNtN3h4
LnR4dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBlY2Fl
OTUwNzQ4Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pMmMvaTJjLW5wY203eHgudHh0DQo+IEBAIC0wLDAgKzEsMjkgQEANCj4gK051
dm90b24gTlBDTTdYWCBJMkMgYnVzDQo+ICsNCj4gK1RoZSBOUENNNzUweCBpbmNsdWRlcyBzaXh0
ZWVuIEkyQyBidXMgY29udHJvbGxlcnMuIEFsbCBDb250cm9sbGVycyBzdXBwb3J0DQo+ICtib3Ro
IG1hc3RlciBhbmQgc2xhdmUgbW9kZS4gRWFjaCBjb250cm9sbGVyIGhhcyB0d28gMTYgYnl0ZSBI
VyBGSUZPIGZvciBUWCBhbmQNCj4gK1JYLg0KPiArDQo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
PiArLSBjb21wYXRpYmxlICAgICAgOiBtdXN0IGJlICJudXZvdG9uLG5wY203NTAtaTJjIg0KPiAr
LSByZWcgICAgICAgICAgICAgOiBPZmZzZXQgYW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0
IGZvciB0aGUgZGV2aWNlLg0KPiArLSBpbnRlcnJ1cHRzICAgICAgOiBDb250YWluIHRoZSBJMkMg
aW50ZXJydXB0IHdpdGggZmxhZ3MgZm9yIGZhbGxpbmcgZWRnZS4NCj4gKy0gY2xvY2tzICAgICAg
ICAgIDogcGhhbmRsZSBvZiBJMkMgcmVmZXJlbmNlIGNsb2NrLg0KPiArDQo+ICtPcHRpb25hbDoN
Cj4gKy0gYnVzLWZyZXF1ZW5jeSAgIDogQ29udGFpbiB0aGUgSTJDIGJ1cyBmcmVxdWVuY3ksDQo+
ICsJCQl0aGUgZGVmYXVsdCBJMkMgYnVzIGZyZXF1ZW5jeSBpcyAxMDAwMDAuDQo+ICstIHBpbmN0
cmwtMCAgICAgICA6IG11c3QgYmUgPCZzbWJYX3BpbnM+LCBYIGlzIG1vZHVsZSBudW1iZXINCj4g
KwkJCShvbiBOUENNN1hYIGl0J3MgMCB0byAxNSkNCg0KSXNuJ3QgdGhpcyBhIHN0cmFuZ2UgcmVx
dWlyZW1lbnQ/IEFtIEksIGFzIGEgZGV2aWNlIHRyZWUgYXV0aG9yLCBub3QgZnJlZSB0bw0KdXNl
IGFueSBsYWJlbCBuYW1lcyBJIHdhbnQ/IFN1cmVseSwgd2hhdCBpcyBpbXBvcnRhbnQgaXMgd2hh
dCB0aGUgbGFiZWwgcmVmZXJzDQp0byBhbmQgbm90IGl0cyBuYW1lPw0KDQpDaGVlcnMsDQpQZXRl
cg0KDQo+ICstIHBpbmN0cmwtbmFtZXMgICA6IHNob3VsZCBiZSBzZXQgdG8gImRlZmF1bHQiDQo+
ICtFeGFtcGxlOg0KPiArDQo+ICsJaTJjMDogaTJjQDgwMDAwIHsNCj4gKwkJY29tcGF0aWJsZSA9
ICJudXZvdG9uLG5wY203NTAtaTJjIjsNCj4gKwkJcmVnID0gPDB4ODAwMDAgMHgxMDAwPjsNCj4g
KwkJY2xvY2tzID0gPCZjbGsgTlBDTTdYWF9DTEtfQVBCMj47DQo+ICsJCWJ1cy1mcmVxdWVuY3kg
PSA8MTAwMDAwPjsNCj4gKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDY0IElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCQlwaW5jdHJsLTAg
PSA8JnNtYjBfcGlucz47DQo+ICsJfTsNCj4gDQoNCg==
