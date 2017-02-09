From: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH] i2c: designware: Fix regression when dynamic TAR update
 is disabled
Date: Thu, 9 Feb 2017 21:34:10 +0000
Message-ID: <1486676048.14478.4.camel@intel.com>
References: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
         <1486670858.2133.436.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486670858.2133.436.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <64CE917AA3457243BB34F49A488CF2B1@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "Nehal-Bakulchandra.Shah@amd.com" <Nehal-Bakulchandra.Shah@amd.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>
List-Id: linux-i2c@vger.kernel.org

T24gVGh1LCAyMDE3LTAyLTA5IGF0IDIyOjA3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIEZyaSwgMjAxNy0wMi0xMCBhdCAwMToyMCArMDUzMCwgU2hhaCBOZWhhbC1CYWt1bGNo
YW5kcmEgd3JvdGU6DQo+ID4gVGhlIGZvbGxvd2luZyBjb21taXQgY2F1c2VzIGEgcmVncmVzc2lv
biB3aGVuIGR5bmFtaWMgVEFSIHVwZGF0ZSBpcw0KPiA+IGRpc2FibGVkOg0KPiA+IA0KPiA+IMKg
wqDCoMKgwqBjb21taXQgNjNkMGYwYTY5NTJhMWEwMmJjNGYxMTZiN2RhN2M3ODg3ZTQ2ZWZhMyAo
ImkyYzoNCj4gPiBkZXNpZ253YXJlOg0KPiA+IMKgwqDCoMKgwqBkZXRlY3Qgd2hlbiBkeW5hbWlj
IHRhciB1cGRhdGUgaXMgcG9zc2libGUiKQ0KPiANCj4gUGxlYXNlLCBsZWF2ZSBqdXN0IDEyIGNo
YXJhY3RlcnMsIGl0IHN0aWxsIGVub3VnaC4NCj4gDQo+ID4gSW4gc3VjaCBjYXNlLCB0aGUgRFdf
SUNfQ09OXzEwQklUQUREUl9NQVNURVIgaXMgUi9XLCBhbmQgaXMgY2hhbmdlZA0KPiA+IGJ5IHRo
ZSBsb2dpYyB0aGF0J3MgdHJ5aW5nIHRvIGRldGVjdMKgwqBkeW5hbWljIFRBUiB1cGRhdGUuVGhl
IG9yaWdpbmFsDQo+ID4gdmFsdWUgb2YgRFdfSUNfQ09OXzEwQklUQUREUl9NQVNURVIgYml0IHNo
b3VsZCBiZSByZXN0b3JlZC4NCg0KDQpZb3UgYXJlIHJpZ2h0LCB0aGFua3MgZm9yIHRoZSBmaXgu
ICBUaGlzIG1heSBhbHNvIGV4cGxhaW5zIHdoeQ0KMDMxN2U2YyAoaTJjOiBkZXNpZ253YXJlOiBk
byBub3QgZGlzYWJsZSBhZGFwdGVyIGFmdGVyIHRyYW5zZmVyKSBjYXVzZWQgcHJvYmxlbXMNCmFu
ZCBlbmRlZCB1cCBiZWluZyByZXZlcnRlZC4gIENvdWxkIHlvdSB0cnkgdGhhdCBvbiB5b3VyIGhh
cmR3YXJlPw0KDQpUaGUgZHluYW1pYyB0YXIgdXBkYXRlIGRldGVjdGlvbiB3YXMgb25seSBkb25l
IGFzIHByZXBhcmF0aW9uIHdvcmsgdG8gYWxsb3cgbm90DQpkaXNhYmxpbmcgdGhlIGFkYXB0ZXIs
IHdoaWNoIGlzIHJldmVydGVkLiAgV2UgbWF5IGFsc28ganVzdCByZXZlcnQgdGhpcyBjb21taXQN
Cmluc3RlYWQgb2YgZml4aW5nIHRoZSBsb2dpYy4NCg0KDQp0aGFua3MNCkx1Y2FzIERlIE1hcmNo
aQ==
