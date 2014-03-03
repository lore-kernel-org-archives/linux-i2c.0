From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
Date: Mon, 3 Mar 2014 10:23:33 +0000
Message-ID: <3bbad0af0bc74f04bc386b141dadedb3@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201402272139.36076.marex@denx.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGksIE1hcmVrDQoNCk1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiBUaHVyc2RheSwgRmVicnVhcnkg
MjcsIDIwMTQgYXQgMDc6MDU6MTQgQU0sIFl1YW4gWWFvIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4g
DQo+ID4gK3N0YXRpYyB2b2lkIGkyY19pbXhfZG1hX2ZyZWUoc3RydWN0IGlteF9pMmNfc3RydWN0
ICppMmNfaW14KSB7DQo+ID4gKwlzdHJ1Y3QgaW14X2kyY19kbWEgKmRtYSA9IGkyY19pbXgtPmRt
YTsNCj4gPiArCXN0cnVjdCBkbWFfY2hhbiAqZG1hX2NoYW47DQo+ID4gKw0KPiA+ICsJZG1hX2No
YW4gPSBkbWEtPmNoYW5fdHg7DQo+ID4gKwlkbWEtPmNoYW5fdHggPSBOVUxMOw0KPiA+ICsJZG1h
LT5idWZfdHggPSAwOw0KPiA+ICsJZG1hLT5sZW5fdHggPSAwOw0KPiA+ICsJZG1hX3JlbGVhc2Vf
Y2hhbm5lbChkbWFfY2hhbik7DQo+ID4gKw0KPiA+ICsJZG1hX2NoYW4gPSBkbWEtPmNoYW5fcng7
DQo+ID4gKwlkbWEtPmNoYW5fdHggPSBOVUxMOw0KPiA+ICsJZG1hLT5idWZfcnggPSAwOw0KPiA+
ICsJZG1hLT5sZW5fcnggPSAwOw0KPiA+ICsJZG1hX3JlbGVhc2VfY2hhbm5lbChkbWFfY2hhbik7
DQo+IA0KPiBZb3UgbXVzdCBtYWtlIF9ERUFEXyBfU1VSRV8gdGhpcyBmdW5jdGlvbiBpcyBub3Qg
ZXZlciBjYWxsZWQgd2hpbGUgdGhlDQo+IERNQSBpcyBzdGlsbCBhY3RpdmUuIEluIHlvdXIgY2Fz
ZSwgSSBoYXZlIGEgZmVlbGluZyB0aGF0J3Mgbm90IGhhbmRsZWQuDQo+DQoNClRoYW5rcyBmb3Ig
eW91ciBhdHRlbnRpb24uDQpUaGlzIGZldyBkYXlzIEkgbG9vayB1cCB0aGUgY29kZSBmb3IgdGhl
IHJlYWxpemF0aW9uIG9mIGRtYV9yZWxlYXNlX2NoYW5uZWwoKS4gDQpJIGZvdW5kIHRoYXQgaXQg
d2lsbCBkaXNhYmxlIHRoZSBkbWEgcmVxdWVzdCBmaXJzdC4gU28gaXQncyBtYXkgc2FmZS4gDQpB
bmQgZHJpdmVycyBoYWRuJ3QgY2hlY2sgd2hldGhlciBkbWEgaXMgc3RpbGwgYWN0aXZlIGJlZm9y
ZSBkbWFfcmVsZWFzZV9jaGFubmVsKCkgYXMgYSB1c3VhbGx5IHVzYWdlLg0KQmVjYXVzZSBpdCB3
aWxsIGJlIGRpc2FibGVkIGF1dG9tYXRpYy4NCg0KVGhlIG9ubHkgcHJvYmxlbSBpcyB0aGF0LCBp
dCB3aWxsIGJlIGZvcmNlZCB0byBjYW5jZWwgdGhlIHRyYW5zZmVyIHdoaWNoIHdhcyBub3QgeWV0
IGNvbXBsZXRlZC4NCkxvb2tpbmcgZm9yd2FyZCB0byBoZWFyaW5nIGZyb20geW91Lg0KDQpCZXN0
IHJlZ2FyZHMsDQpZdWFuIFlhbw0K
