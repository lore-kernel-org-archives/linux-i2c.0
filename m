From: Muthu Mani <muth@cypress.com>
Subject: RE: [PATCH v4 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Sat, 6 Dec 2014 10:54:26 +0000
Message-ID: <BN1PR06MB069DE9058CA3EE9B5635E1DCC660@BN1PR06MB069.namprd06.prod.outlook.com>
References: <1417241944-17799-1-git-send-email-muth@cypress.com>
 <20141201121533.GE15845@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141201121533.GE15845@x1>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGlucHV0cy4NCg0KPiA+ICsvKiBTZXJpYWwgaW50ZXJmYWNlcyAoSTJD
LCBTUEksIFVBUlQpIGRpZmZlciBpbiBpbnRlcmZhY2Ugc3ViY2xhc3MgKi8NCj4gPiArZW51bSBj
eV9zY2JfbW9kZXMgew0KPiA+ICsgICAgICAgQ1lfVVNCU19TQ0JfRElTQUJMRUQgPSAwLA0KPiA+
ICsgICAgICAgQ1lfVVNCU19TQ0JfVUFSVCA9IDEsDQo+ID4gKyAgICAgICBDWV9VU0JTX1NDQl9T
UEkgPSAyLA0KPiA+ICsgICAgICAgQ1lfVVNCU19TQ0JfSTJDID0gMw0KPg0KPiBXaHkgaGF2ZSB5
b3UgbnVtYmVyZWQgdGhlc2UgaW5kaXZpZHVhbGx5Pw0KDQpJIGhhdmUgY2hhbmdlZCB0aGVtIGFz
ICNkZWZpbmUncyBub3cuIFRoZXNlIHZhbHVlcyBhcmUgbm90IGFyYml0cmFyeS4NCg0KPiA+ICsg
ICAgICAgLyogU2VyaWFsIGludGVyZmFjZXMgKEkyQywgU1BJLCBVQVJUKSBkaWZmZXIgaW4gaW50
ZXJmYWNlIHN1YmNsYXNzICovDQo+ID4gKyAgICAgICBzd2l0Y2ggKGludGVyZmFjZS0+Y3VyX2Fs
dHNldHRpbmctPmRlc2MuYkludGVyZmFjZVN1YkNsYXNzKSB7DQo+ID4gKyAgICAgICBjYXNlIENZ
X1VTQlNfU0NCX0kyQzoNCj4gPiArICAgICAgICAgICAgICAgZGV2X2luZm8oJmludGVyZmFjZS0+
ZGV2LCAidXNpbmcgSTJDIGludGVyZmFjZVxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIGN5dXNi
czIzeF9kZXZzID0gY3l1c2JzMjN4X2kyY19ncGlvX2RldnM7DQo+ID4gKyAgICAgICAgICAgICAg
IG5kZXZzID0gQVJSQVlfU0laRShjeXVzYnMyM3hfaTJjX2dwaW9fZGV2cyk7DQo+DQo+IE5vdCBz
dXJlIEkgZ2V0IHRoaXMuICBXaHkgZG8geW91IGhhdmUgbG9jYWwgdmFyaWFibGVzIGZvciB0aGVz
ZSBpbnN0ZWFkIG9mIHVzaW5nDQo+IHRoZW0gZGlyZWN0bHk/DQoNCldlIGFyZSBwbGFubmluZyB0
byBzdXBwb3J0IG90aGVyIHByb3RvY29scyBpbiBmdXR1cmUuIFRvIGZhY2lsaXRhdGUgdGhhdCwg
bG9jYWwgdmFyaWFibGVzIGFyZSB1c2VkLg0KDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiAr
DQo+ID4gK2Vycm9yOg0KPiA+ICsgICAgICAgdXNiX3B1dF9kZXYoY3l1c2JzLT51c2JfZGV2KTsN
Cj4NCj4gSXNuJ3QgdGhlcmUgYSBkZXZtXyogdmVyc2lvbiBvZiB1c2Jfc2V0X2ludGZkYXRhKCk/
DQoNCk5vLg0KDQpUaGFua3MsDQpNdXRodQ0KDQpUaGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBDeXByZXNzIChvciBpdHMgc3Vic2lkaWFyaWVzKSBjb25maWRlbnRp
YWwgaW5mb3JtYXRpb24uIElmIGl0IGhhcyBiZWVuIHJlY2VpdmVkIGluIGVycm9yLCBwbGVhc2Ug
YWR2aXNlIHRoZSBzZW5kZXIgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGlzIG1lc3NhZ2UuDQo=
