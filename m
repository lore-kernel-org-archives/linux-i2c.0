From: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH v3 2/3] i2c: designware: detect when dynamic tar update
 is possible
Date: Wed, 17 Aug 2016 12:48:56 +0000
Message-ID: <1471438125.2406.6.camel@intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
	 <1469743424-2480-3-git-send-email-lucas.demarchi@intel.com>
	 <f4c1fb29-b315-33ee-f029-684ef9cd6264@linux.intel.com>
	 <1471356468.2907.4.camel@intel.com>
	 <c58ce503-580b-34b7-3489-7b8829f88dca@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47442 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019AbcHQMs6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 17 Aug 2016 08:48:58 -0400
In-Reply-To: <c58ce503-580b-34b7-3489-7b8829f88dca@linux.intel.com>
Content-Language: en-US
Content-ID: <D645E705AE4B924A96157772A4DA37F9@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "christian.ruppert@alitech.com" <christian.ruppert@alitech.com>, "Souza, Jose" <jose.souza@intel.com>

T24gV2VkLCAyMDE2LTA4LTE3IGF0IDExOjA1ICswMzAwLCBKYXJra28gTmlrdWxhIHdyb3RlOg0K
PiBPbiAwOC8xNi8yMDE2IDA1OjA3IFBNLCBEZSBNYXJjaGksIEx1Y2FzIHdyb3RlOg0KPiA+IA0K
PiA+IE9uIFR1ZSwgMjAxNi0wOC0xNiBhdCAxNzowMCArMDMwMCwgSmFya2tvIE5pa3VsYSB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gKwnCoCovDQo+ID4gPiA+ICsJcmVnID0gZHdf
cmVhZGwoZGV2LCBEV19JQ19DT04pOw0KPiA+ID4gPiArCWR3X3dyaXRlbChkZXYsIHJlZyBeIERX
X0lDX0NPTl8xMEJJVEFERFJfTUFTVEVSLA0KPiA+ID4gPiBEV19JQ19DT04pOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJaWYgKChkd19yZWFkbChkZXYsIERXX0lDX0NPTikgJg0KPiA+ID4gPiBEV19J
Q19DT05fMTBCSVRBRERSX01BU1RFUikgPT0NCj4gPiA+ID4gKwnCoMKgwqDCoChyZWcgJiBEV19J
Q19DT05fMTBCSVRBRERSX01BU1RFUikpIHsNCj4gPiA+ID4gKwkJZGV2LT5keW5hbWljX3Rhcl91
cGRhdGVfZW5hYmxlZCA9IHRydWU7DQo+ID4gPiA+ICsJCWRldl9kYmcoZGV2LT5kZXYsICJEeW5h
bWljIFRBUiB1cGRhdGUNCj4gPiA+ID4gZW5hYmxlZCIpOw0KPiA+ID4gPiArCX0NCj4gPiA+IA0K
PiA+ID4gSXMgdGhpcyBwb3NzaWJsZSB0byBtb3ZlIHRvIGkyY19kd19wcm9iZSgpPyBJIGd1ZXNz
IHRoZSBlbmFibGVkDQo+ID4gPiBzdGF0dXMNCj4gPiA+IGRvZXNuJ3QgY2hhbmdlIHJ1bnRpbWU/
DQo+ID4gDQo+ID4gSXQgd2FzIGFjdHVhbGx5IHVzZWZ1bCBhdCB0aGlzIHBsYWNlIGR1cmluZyBk
ZXZlbG9wbWVudCBvZiB0aGlzDQo+ID4gcGF0Y2gNCj4gPiBiZWNhdXNlIHdlIGNvdWxkIGNoZWNr
IGFueSB1bmV4cGVjdGVkIGNoYW5nZSBpbiBiZWhhdmlvciB3aGVuDQo+ID4gcmVzdW1pbmcuDQo+
ID4gV2UgZGlkIGNhdGNoIGEgYnVnIGJlY2F1c2Ugb2YgdGhpcyBhbmQgZml4ZWQuDQo+ID4gSSdt
IG5vdCBzdXJlIGlmIG5vdyBpdCBtYWtlcyBtb3JlIHNlbnNlIHRvIG1vdmUgdG8gcHJvYmUgbWV0
aG9kLg0KPiA+IEknZA0KPiA+IGxlYXZlIGl0IHdoZXJlIGl0IGlzLCBidXQgSSdtIG9wZW4gdG8g
bW92ZSBpdCB0aGVyZS4NCj4gPiANCj4gQ2FuIHlvdSBkbyBhIHF1aWNrIHJlLXRlc3QgdGhhdCBj
YXNlIHRvIHNlZSBkb2VzIGl0IGNoYW5nZSBydW50aW1lPw0KPiBJZsKgDQo+IGl0IGRvZXMgdGhl
biB0aGlzIG5lZWRzIGEgY29tbWVudCB3aHkgdGhlcmUgaXMgbmVlZCB0byBkbyB0aGlzIGNoZWNr
wqANCj4gZWFjaCB0aW1lIHdoZW4gSFcgaXMgcmVpbml0aWFsaXplZC4gT3RoZXJ3aXNlIHRoZXJl
IGlzIGNoYW5jZQ0KPiBzb21lb25lwqANCj4gbWF5IG1vdmUgdGhpcyBjb2RlIHRvIHByb2JlIHRp
bWUgaW4gdGhlIGZ1dHVyZS4NCg0KSSBhbHJlYWR5IHRlc3RlZCBhbmQgaXQgZG9lc24ndCBjaGFu
Z2UuIEknbGwgbW92ZSBpdCB0byBpMmNfZHdfcHJvYmUoKQ0KdGhlbi4NCg0KdGhhbmtzDQoNCkx1
Y2FzIERlIE1hcmNoaQ==
