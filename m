From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 13:12:05 +0000
Message-ID: <TY1PR01MB1769EA2ACCC9EC9D0F2DC00EF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Simon Horman <horms@verge.net.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDE3IEp1bHkgMjAxOCAxNDowMiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBUdWUsIEp1bCAxNywgMjAxOCBhdCAyOjQyIFBNIFBoaWwgRWR3b3J0aHkgd3Jv
dGU6DQo+ID4gT24gMTcgSnVseSAyMDE4IDEzOjI0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+
ID4gPiBPbiBUdWUsIDIwMTgtMDctMTcgYXQgMTQ6MDcgKzAyMDAsIFNpbW9uIEhvcm1hbiB3cm90
ZToNCj4gPiA+ID4gT24gTW9uLCBKdWwgMTYsIDIwMTggYXQgMDk6NTk6MTNBTSArMDEwMCwgUGhp
bCBFZHdvcnRoeSB3cm90ZToNCj4gPiA+ID4gPiBUaGUgU3lub3BzeXMgSTJDIENvbnRyb2xsZXIg
aGFzIGEgYnVzIGNsb2NrLCBidXQgdHlwaWNhbGx5IFNvQ3MNCj4gPiA+ID4gPiBoaWRlIHRoaXMg
YXdheS4NCj4gPiA+ID4gPiBIb3dldmVyLCBvbiBzb21lIFNvQ3MgeW91IG5lZWQgdG8gZXhwbGlj
aXR5IGVuYWJsZSB0aGUgYnVzIGNsb2NrDQo+ID4gPiA+ID4gaW4gb3JkZXIgdG8gYWNjZXNzIHRo
ZSByZWdpc3RlcnMuDQo+ID4gPiA+ID4gVGhlcmVmb3JlLCBlbmFibGUgYW4gb3B0aW9uYWwgYnVz
IGNsb2NrIHNwZWNpZmllZCBieSBEVC4NCj4gPiA+DQo+ID4gPiA+ID4gKyAgICAgICAgIC8qIE9w
dGlvbmFsIGJ1cyBjbG9jayAqLw0KPiA+ID4gPiA+ICsgICAgICAgICBpZiAoIUlTX0VSUihkZXYt
PmJ1c2NsaykpIHsNCj4gPiA+ID4NCj4gPiA+ID4gSSBzdXNwZWN0IHRoYXQgZXJyb3IgdmFsdWVz
IHN0b3JlZCBpbiBkZXYtPmJ1c2NsaywgIG90aGVyIHRoYW4NCj4gPiA+ID4gLUVOT0VOVCwgc2hv
dWxkIGJlIHRyZWF0ZWQgYXMgZXJyb3JzLg0KPiA+IElTX0VSUiBjYXRjaGVzIGFsbCBlcnJvcnMg
YW5kIGlzIHRoZSBjb3JyZWN0IHdheSB0byBjaGVjayB0aGUgdmFsdWUNCj4gPiByZXR1cm5lZCBi
eSBkZXZtX2Nsa19nZXQuDQo+IA0KPiBXaGF0IGlmIGl0IHJldHVybnMgLUVQUk9CRV9ERUZFUiwg
d2hpY2ggbWVhbnMgdGhlIGNsb2NrIGlzIHJlZmVyZW5jZWQsIGFuZA0KPiB0aHVzIG5vdCBvcHRp
b25hbCwgYnV0IG5vdCB5ZXQgcmVhZHk/DQo+IEZvciBvcHRpb25hbCBjbG9ja3MsIGFsbCBlcnJv
cnMgYnV0IC1FTk9FTlQgc2hvdWxkIGJlIHByb3BhZ2F0ZWQgdXAuDQpHb29kIHBvaW50IQ0KDQpU
aGFua3MNClBoaWwNCg==
