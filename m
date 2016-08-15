From: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH v3 0/3] i2c: designware: improve performance for
 transfers
Date: Mon, 15 Aug 2016 12:34:14 +0000
Message-ID: <1471264451.2394.5.camel@intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
	 <28c393bf-416b-b406-ff39-a2d85317a102@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7079 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbcHOMeR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 15 Aug 2016 08:34:17 -0400
In-Reply-To: <28c393bf-416b-b406-ff39-a2d85317a102@alitech.com>
Content-Language: en-US
Content-ID: <E05D66D332E27C4BAD25FD300A039AE7@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "christian.ruppert@alitech.com" <christian.ruppert@alitech.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>

T24gRnJpLCAyMDE2LTA4LTEyIGF0IDE2OjU5ICswMjAwLCBDaHJpc3RpYW4gUnVwcGVydCB3cm90
ZToNCj4gT24gMjkuMDcuMjAxNiAwMDowMywgTHVjYXMgRGUgTWFyY2hpIHdyb3RlOg0KPiA+IA0K
PiA+IFRoaXMgY2FuIGJlIGNvbnNpZGVyZWQgYSB2MyBvZiAiaTJjOiBkZXNpZ253YXJlOiBkbyBu
b3QgZGlzYWJsZQ0KPiA+IGFkYXB0ZXIgYWZ0ZXINCj4gPiB0cmFuc2ZlciIuIERpZmZlcmVuY2Vz
IGFyZToNCj4gPiANCj4gPiDCoMKgwqDCoC0gTm93IHRoZXJlJ3MgYSBmaXJzdCBwYXRjaCB0aGF0
IGRvZXMgbm90IGRlcGVuZCBvbiBJQ19UQVINCj4gPiBiZWluZyBkeW5hbWljYWxseQ0KPiA+IMKg
wqDCoMKgwqDCoGVuYWJsZWQvZGlzYWJsZWQ6IGl0IGp1c3QgZG9lc24ndCB3YWl0IGZvciB0aGUg
c3RhdGUgY2hhbmdlDQo+ID4gd2hlbiBub3QgbmVlZGVkLg0KPiA+IA0KPiA+IMKgwqDCoMKgLSBX
ZSBhZGRlZCBhIHBhdGNoIHRoYXQgYWxsb3dzIGRldGVjdGluZyBpZiBIVyBzdXBwb3J0cyB0aGUN
Cj4gPiBkeW5hbWljIFRBUiB1cGRhdGVzDQo+ID4gDQo+ID4gwqDCoMKgwqAtIEluIHRoZSBsYXN0
IHBhdGNoIHRoZSBiaXRzIHdlcmUgY2hhbmdlZCBhcyBzdWdnZXN0ZWQgYnkNCj4gPiBKYXJra28u
DQo+ID4gDQo+ID4gwqDCoMKgwqAtIFRoaXMgaXMgdGVzdGVkIG9uIEJheVRyYWlsIGFuZCBDaGVy
cnlUcmFpbCwgYm90aCBvZiB0aGVtDQo+ID4gcmV0dXJuaW5nIHRydWUgZm9yDQo+ID4gwqDCoMKg
wqDCoMKgImR5bmFtaWNhbGx5IHVwZGF0ZSBUQVIiDQo+IA0KPiBUZXN0ZWQtYnk6IENocmlzdGlh
biBSdXBwZXJ0IDxjaHJpc3RpYW4ucnVwcGVydEBhbGl0ZWNoLmNvbT4NCj4gb24gVEIxMDEgd2l0
aCBMaW51eC00LjcNCj4gDQo+IFNlZW1zIHRvIHdvcmsgcGVyZmVjdGx5IG5vdywgY29uZ3JhdHVs
YXRpb25zIGFuZCB0aGFua3MgZm9yIHlvdXINCj4gcGF0aWVuY2Ugd2l0aCBvdXIgcGxhdGZvcm0u
Li4gVGhpcyB3YXMgYSBoYXJkIG9uZSENCg0KQXdlc29tZSwgdGhhbmtzIGZvciB0ZXN0aW5nIHRo
aXMgc2VyaWVzLg0KDQpMb29rcyBsaWtlIEkgZm9yZ290IHRvIENDIFdvbGZyYW0uIENDJ2luZyBu
b3cgb24gdGhpcyBjb3ZlciBsZXR0ZXIsIGxldA0KbWUga25vdyBpZiB5b3UgYWxzbyBuZWVkIHRo
ZSBpbmRpdmlkdWFsIHBhdGNoZXMuDQoNCg0KTHVjYXMgRGUgTWFyY2hpDQoNCj4gDQo+ID4gDQo+
ID4gSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSAoMSk6DQo+ID4gwqAgaTJjOiBkZXNpZ253YXJlOiB3
YWl0IGZvciBkaXNhYmxlL2VuYWJsZSBvbmx5IGlmIG5lY2Vzc2FyeQ0KPiA+IA0KPiA+IEx1Y2Fz
IERlIE1hcmNoaSAoMik6DQo+ID4gwqAgaTJjOiBkZXNpZ253YXJlOiBkZXRlY3Qgd2hlbiBkeW5h
bWljIHRhciB1cGRhdGUgaXMgcG9zc2libGUNCj4gPiDCoCBpMmM6IGRlc2lnbndhcmU6IGRvIG5v
dCBkaXNhYmxlIGFkYXB0ZXIgYWZ0ZXIgdHJhbnNmZXINCj4gPiANCj4gPiDCoGRyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1jb3JlLmMgfCAxMDMNCj4gPiArKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tDQo+ID4gwqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUt
Y29yZS5oIHzCoMKgwqAxICsNCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygr
KSwgMzIgZGVsZXRpb25zKC0pDQo+ID4gDQo+IA==
