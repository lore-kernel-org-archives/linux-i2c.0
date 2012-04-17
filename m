From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: About AT91: replace broken TWI driver i2c-at91.c
Date: Tue, 17 Apr 2012 11:59:06 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A78B@wm021.weinmann.com>
References: <4F8C4A8B.2060005@aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D0905AAA1EC@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905AAA1EC-qhZVaJ2D3XF9OWT4OSQXE9BPR1lH4CV8@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, 'Adrian Yanes' <adrian.yanes-uOixanVlb7U@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "'konsta.holtta-uOixanVlb7U@public.gmane.org'" <konsta.holtta-uOixanVlb7U@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Hubert Feurstein' <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Douglas Gilbert' <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Vm9zcywgTmlrb2xhdXMgd3JvdGUgb24gMjAxMi0wNC0xNzoNCj4gQWRyaWFuIFlhbmVzIHdyb3Rl
IG9uIDIwMTItMDQtMTY6DQo+PiBDaGFuZ2luZyB0aGUgdmFsdWUgdG8gNDAwMDAwIGdpdmVzIGFz
IH4zNTZrSHogcmF0ZSBpbnN0ZWFkIG9mIDQwMGtIeiwNCj4+IG1heWJlIGl0IGlzIGR1ZSB0byBv
dXIgcHJvY2Vzc29yL2JvYXJkLCBob3dldmVyLCBjaGVja2luZyB0aGUgc3BlY3Mgb2YNCj4+IHRo
ZSBhdDkxcm05MjAwIChwYWdlIDQwNSkgd2UgZm91bmQgdGhhdCB0aGUgQ0xWSUQgYW5kIHRoZSBD
SERJViBhcmUNCj4+IGNhbGN1bGF0ZWQgYXMgZm9sbG93Og0KPj4gDQo+PiBUX2xvdyA9ICgoIENM
RElWIHggMl5DS0RJVikgKzMpICsgVF9tY2sNCj4+IFRfaGlnaCA9ICgoIENIRElWIHggMl5DS0RJ
VikgKzMpICsgVF9tY2sNCj4+IA0KPj4gd2hpY2ggZGlmZmVycyBvZiB0aGUgbWV0aG9kIHN1Z2dl
c3RlZCBpbiB0aGUgcGF0Y2g6DQo+PiANCj4+IGNvbnN0IGludCBkaXYgPSBESVZfUk9VTkRfVVAo
Y2xrX2dldF9yYXRlKGRldi0+Y2xrKSwgMiAqIHR3aV9jbGspIC0gMjsNCj4gDQo+IEc0NSBzcGVj
IGlzIHNsaWdodGx5IGRpZmZlcmVudDogVF9sb3cgPSAoQ0xESVYgeCAyXkNLRElWICsgNCkgeCBU
X21jaw0KPiBXaXRoDQo+IHR3aV9jbGsgOj0gMSAvIChUX2xvdyArIFRfaGlnaCkgPSAxIC8gKDIg
KiBUX2xvdykNCj4gYW5kDQo+IGRpdiA6PSBDTEtESVYgeCAyXkNLRElWID0gTUNLIC8gKDIgKiB0
d2lfY2xrKSAtIDQNCj4gdGhlIGFib3ZlIGxpbmUgc2hvdWxkIGJlDQo+IGNvbnN0IGludCBkaXYg
PSBESVZfUk9VTkRfVVAoY2xrX2dldF9yYXRlKGRldi0+Y2xrKSwgMiAqIHR3aV9jbGspIC0gNDsN
Cj4gZm9yIEc0NSBhbmQNCj4gY29uc3QgaW50IGRpdiA9IERJVl9ST1VORF9VUChjbGtfZ2V0X3Jh
dGUoZGV2LT5jbGspLCAyICogdHdpX2NsaykgLSAzOw0KPiBmb3IgUk05MjAwLCByaWdodD8NCg0K
U3RyYW5nZTogSSBtZWFzdXJlZCB0aGUgZnJlcXVlbmN5IG9mIHNjbCBhbmQgSSBzdGlsbCBnZXQg
dG9vIGxvdyB2YWx1ZXMNCmZvciBvZmZzZXQgNCAoaW5zdGVhZCBvZiAyKS4gT24gbXkgRzQ1IHRo
ZSBjb3JyZWN0IG9mZnNldCBzZWVtcyB0byBiZQ0KYXMgaGlnaCBhcyAyNy4NCg0KQWRyaWFuLCBj
YW4geW91IHBsZWFzZSBnaXZlIHRoaXMgYSB0cnk/DQoNCk5pa28NCg0K
