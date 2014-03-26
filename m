From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 26 Mar 2014 05:56:34 +0000
Message-ID: <cd88de7e04734400b897c0e2bcf07eab@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com>
 <201403230449.51515.marex@denx.de>
 <1e17ce716618472f9a0146c48f20b976@BL2PR03MB338.namprd03.prod.outlook.com>
 <201403260442.42970.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201403260442.42970.marex-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkbmVzZGF5LCBNYXJjaCAyNiwgMjAxNCBhdCAxMTo0MzoyNyBBTSwgTWFyZWsgVmFzdXQg
d3JvdGU6DQo+IE9uIFdlZG5lc2RheSwgTWFyY2ggMjYsIDIwMTQgYXQgMDQ6MDg6MjcgQU0sIFlh
byBZdWFuIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiA+ICsJCWkyY19pbXgtPnVzZV9k
bWEgPSBmYWxzZTsNCj4gPiA+ID4gKwl9IGVsc2UgaWYgKGkyY19pbXhfZG1hX3JlcXVlc3QoaTJj
X2lteCwgKGRtYV9hZGRyX3QpcGh5X2FkZHIpKQ0KPiB7DQo+ID4gPiA+ICsJCWRldl9pbmZvKCZw
ZGV2LT5kZXYsDQo+ID4gPiA+ICsJCQkJImNhbid0IHJlcXVlc3QgZG1hIGNoYW4sIGZhaWxkIHVz
ZSBkbWEuXG4iKTsNCj4gPiA+ID4gKwkJaTJjX2lteC0+dXNlX2RtYSA9IGZhbHNlOw0KPiA+ID4g
PiArCX0gZWxzZSB7DQo+ID4gPiA+ICsJCWkyY19pbXgtPnVzZV9kbWEgPSB0cnVlOw0KPiA+ID4g
PiArCX0NCj4gPiA+DQo+ID4gPiBDYW4geW91IG5vdCBqdXN0IGNoZWNrIGlmIGkyY19pbXgtPmRt
YSBpcyB2YWxpZCBwb2ludGVyIG9yIE5VTEwNCj4gcG9pbnRlciA/DQo+ID4gPiBUaGVuIHlvdSB3
b24ndCBuZWVkIGEgc2VwYXJhdGUgdmFyaWFibGUsIGZvciB0aGlzIHB1cnBvc2UgLi4uIHJpZ2h0
ID8NCj4gPg0KPiA+IFNvcnJ5IGFuZCBJIHRoaW5rIHdoYXQgSSBrbm93IGlzIGp1c3QgdG8gY2hl
Y2sgd2hldGhlciBpdCBpcyBOVUxMLg0KPiA+IFRoZW4gZm9yIHRoZSBzZWNvbmQgcXVlc3Rpb24s
IG1heWJlIHRoZXJlIGFyZSBzb21lIG90aGVyIHdheXMsIEJ1dCBJDQo+ID4gdGhpbmsgaXQgaXMg
bW9yZSB0aWR5IGFuZCBlYXNpZXIgdW5kZXJzdGFuZGluZyBmb3IgdXNpbmcgYSBzZXBhcmF0ZQ0K
PiA+IHZhcmlhYmxlLCBmb3IgdGhpcyBwdXJwb3NlLg0KPiANCj4gWW91IGFyZSBqdXN0IHdhc3Rp
bmcgc3BhY2UgYW5kIGR1cGxpY2F0aW5nIGRhdGEsIHVubGVzcyBJIGFtIHdyb25nLg0KPiANCg0K
V2VsbCwgRG8geW91IGhhdmUgYSBiZXR0ZXIgaWRlYT8gQWx0aG91Z2ggSSB0aGluayBpdCdzIG5l
Y2Vzc2FyeS4NCg0KDQpCZXN0IHJlZ2FyZHMsDQpZdWFuIFlhbw0K
