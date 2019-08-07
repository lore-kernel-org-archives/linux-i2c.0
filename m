From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] i2c: imx: Allow the driver to be built for ARM64 SoCs
 such as i.MX8M
Date: Wed, 7 Aug 2019 13:25:45 +0000
Message-ID: <552fae9f-a28d-3dd4-c169-ab860180e794@kontron.de>
References: <20190807114332.13312-1-frieder.schrempf@kontron.de>
 <2445092.UF1PKDTzN1@ws-140106>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2445092.UF1PKDTzN1@ws-140106>
Content-Language: en-US
Content-ID: <F7B35F894732B74CB18AF4C07EB70188@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@mailbox.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Juergen Fitschen <jfi@ssv-embedded.de>, Ajay Gupta <ajayg@nvidia.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Vignesh R <vigneshr@ti.com>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Paul Cercueil <paul@crapouillou.net>, Kamal Dasu <kdasu.kdev@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMDcuMDguMTkgMTQ6MDksIEFsZXhhbmRlciBTdGVpbiB3cm90ZToNCj4gT24gV2VkbmVzZGF5
LCBBdWd1c3QgNywgMjAxOSwgMTo0NDowNiBQTSBDRVNUIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6
DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+Pg0KPj4gVGhlIGlteCBJMkMgY29udHJvbGxlciBpcyB1c2VkIGluIHNvbWUgQVJNNjQgU29D
cyBzdWNoIGFzIGkuTVg4TS4NCj4+IFRvIG1ha2UgdXNlIG9mIGl0LCBhcHBlbmQgQVJNNjQgdG8g
dGhlIGxpc3Qgb2YgZGVwZW5kZW5jaWVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIg
U2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+IC0tLQ0KPj4gICBkcml2
ZXJzL2kyYy9idXNzZXMvS2NvbmZpZyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJj
L2J1c3Nlcy9LY29uZmlnIGIvZHJpdmVycy9pMmMvYnVzc2VzL0tjb25maWcNCj4+IGluZGV4IDA5
MzY3ZmMwMTRjMy4uNDZiNjUzNjIxNTEzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pMmMvYnVz
c2VzL0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29uZmlnDQo+PiBAQCAt
NjY0LDcgKzY2NCw3IEBAIGNvbmZpZyBJMkNfSU1HDQo+PiAgIA0KPj4gICBjb25maWcgSTJDX0lN
WA0KPj4gICAJdHJpc3RhdGUgIklNWCBJMkMgaW50ZXJmYWNlIg0KPj4gLQlkZXBlbmRzIG9uIEFS
Q0hfTVhDIHx8IEFSQ0hfTEFZRVJTQ0FQRSB8fCBDT0xERklSRQ0KPj4gKwlkZXBlbmRzIG9uIEFS
Q0hfTVhDIHx8IEFSQ0hfTEFZRVJTQ0FQRSB8fCBDT0xERklSRSB8fCBBUk02NA0KPiANCj4gSSBk
b24ndCB0aGluayB0aGlzIHNob3VsZCBiZSBuZWNlc3NhcnkgYXQgYWxsIGFzIEFSQ0hfTVhDIGlz
IGFsc28gYXZhaWxhYmxlIGZvciBhcm02NCwgc2VlIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJtNjQv
S2NvbmZpZy5wbGF0Zm9ybXMjbjE2Nw0KPiBJIHJhdGhlciB3b25kZXIgd2h5IEFSQ0hfTVhDIGlz
IG5vdCBzZXQuIFNhbWUgZm9yIGZlYy4NCg0KWW91J3JlIHJpZ2h0IG9mIGNvdXJzZS4gSSBzb21l
aG93IG1hbmFnZWQgdG8gbWVzcyB1cCBteSBkZWZjb25maWcuIEkgDQpzdGFydGVkIG92ZXIgd2l0
aCBhIGNsZWFuIGNvbmZpZyBmcm9tIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgYW5kIA0K
ZXZlcnl0aGluZyBzZWVtcyBmaW5lIG5vdy4gU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KPiANCj4+
ICAgCWhlbHANCj4+ICAgCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0byB1c2UgdGhlIElJQyBi
dXMgY29udHJvbGxlciBvbg0KPj4gICAJICB0aGUgRnJlZXNjYWxlIGkuTVgvTVhDLCBMYXllcnNj
YXBlIG9yIENvbGRGaXJlIHByb2Nlc3NvcnMuDQo+Pg0KPiANCj4gDQo+IA0KPiA=
