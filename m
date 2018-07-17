From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 14:57:27 +0000
Message-ID: <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
         <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Simon Horman <horms@verge.net.au>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

SGkgQW5keSwNCg0KT24gMTcgSnVseSAyMDE4IDE1OjQ3LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxNDo0MCArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiBPbiAxNyBKdWx5IDIwMTggMTU6MTksIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
PiA+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxMjo0MiArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiA+DQo+ID4gPiA+ID4gV2hpbGUgeW91ciBwb2ludCBzb3VuZHMgdmFsaWQgKGRvbid0
IHJlbWVtYmVyIGhvdyBjbGtfZ2V0KCkgaXMNCj4gPiA+ID4gPiBpbXBsZW1lbnRlZCksIE5VTEwg
aXMgYWxzbyBPSyB0byBoYXZlLg0KPiA+ID4gPg0KPiA+ID4gPiBPayBhcyBpbiB0aGVyZSBpcyBu
byBidXMgY2xvY2ssIHJpZ2h0Pw0KPiA+ID4gPiBTbyBpdCBzaG91bGQgYmU6DQo+ID4gPiA+ICBp
ZiAoIUlTX0VSUl9PUl9OVUxMIChkZXYtPmJ1c2NsaykpDQo+ID4gPg0KPiA+ID4gTm9wZSwgTlVM
TCBpcyBubyBlcnJvciBjYXNlIGZvciBvcHRpb25hbCBjbG9jay4NCj4gPg0KPiA+IEkgbXVzdCBi
ZSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLi4uDQo+IA0KPiBTZWUgaG93IGNsa19wcmVwYXJlX2Vu
YWJsZSgpIGlzIGltcGxlbWVudGVkLg0KT2ssIGlmIGJ1c2NsayBpcyBOVUxMIHRoZSBjb2RlIGNh
biBzYWZlbHkgY2FsbCBjbGtfcHJlcGFyZV9lbmFibGUoKQ0KDQoNCj4gPiBJIGFncmVlIHRoYXQg
TlVMTCBmb3IgYW4gb3B0aW9uYWwgY2xvY2sgaXMgbm90IGFuIGVycm9yLiBIb3dldmVyLCB0aGUN
Cj4gPiBjb2RlIGFib3ZlIGlzIG5vdzoNCj4gPiArCWlmIChwcmVwYXJlKSB7DQo+ID4gKwkJLyog
T3B0aW9uYWwgYnVzIGNsb2NrICovDQo+IA0KPiA+ICsJCWlmICghSVNfRVJSX09SX05VTEwoZGV2
LT5idXNjbGspKSB7DQo+IA0KPiBDaGVjayBmb3IgTlVMTCBpcyByZWR1bmRhbnQuDQo+IA0KPiA+
ICsJCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGV2LT5idXNjbGspOw0KPiA+ICsJCQlpZiAo
cmV0KQ0KPiA+ICsJCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICAJCXJldHVy
biBjbGtfcHJlcGFyZV9lbmFibGUoZGV2LT5jbGspOw0KPiA+ICsJfQ0KPiA+DQo+ID4gU28sIGlm
IHlvdSBoYXZlIGEgdmFsaWQgYnVzY2xrLCBpdCBnZXRzIGVuYWJsZWQsIG90aGVyd2lzZSBpdCBp
cyBsZWZ0DQo+ID4gYWxvbmUuDQo+IA0KU28gdGhlIGNvZGUgYXMgc2VudCBpbiB0aGUgb3JpZ2lu
YWwgZW1haWwgaXMgY29ycmVjdCAoYXNpZGUgZnJvbSBHZWVydCdzDQpjb21tZW50cyBhYm91dCBF
UFJPQkVfREVGRVIgaGFuZGxpbmcpLg0KDQpNYXliZSBJIG5lZWQgc29tZSBjb2ZmZWUgOlwNClRo
YW5rcw0KUGhpbA0K
