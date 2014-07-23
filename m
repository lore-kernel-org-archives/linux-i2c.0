From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 11:11:53 +0000
Message-ID: <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
 <20140723114834.411f6bb4@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140723114834.411f6bb4-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCkxvdGhhciBXYcOfbWFubiB3cm90ZToN
Cj4gWXVhbiBZYW8gd3JvdGU6DQo+ID4gQWRkIGRtYSBzdXBwb3J0IGZvciBpMmMuIFRoaXMgZnVu
Y3Rpb24gZGVwZW5kIG9uIERNQSBkcml2ZXIuDQo+ID4gWW91IGNhbiB0dXJuIG9uIGl0IGJ5IHdy
aXRlIGJvdGggdGhlIGRtYXMgYW5kIGRtYS1uYW1lIHByb3BlcnRpZXMgaW4gZHRzIG5vZGUuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFuIFlhbyA8eWFvLnl1YW5AZnJlZXNjYWxlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyB8IDM3Nw0KWy4uLl0N
Cj4gPiArDQo+ID4gK2ZhaWxfcng6DQo+ID4gKwlkbWFfcmVsZWFzZV9jaGFubmVsKGRtYS0+Y2hh
bl9yeCk7DQo+ID4gK2ZhaWxfdHg6DQo+ID4gKwlkbWFfcmVsZWFzZV9jaGFubmVsKGRtYS0+Y2hh
bl90eCk7DQo+ID4gK2ZhaWxfYWw6DQo+ID4gKwlkZXZtX2tmcmVlKGRldiwgZG1hKTsNCj4gPg0K
PiBObyBuZWVkIGZvciB0aGlzIG9uZSAodGhhdCdzIHRoZSB3aG9sZSBwb2ludCBvZiB1c2luZyBk
ZXZtX2t6YWxsb2MoKSkhDQo+IA0KDQpXaGVuIERNQSByZXF1ZXN0IGZhaWxlZCwgSTJDIHdpbGwg
c3dpdGNoIHRvIFBJTyBtb2RlLiBTbyBpZiB0aGUgZmFpbGVkIHJlYXNvbiBpcyBqdXN0IGxpa2Ug
RE1BIGNoYW5uZWwgcmVxdWVzdCBmYWlsZWQuIEF0IHRoaXMgdGltZSB0aGUgRE1BIHNob3VsZCBm
cmVlIGJ5IGRldm1fa2ZyZWUoKS4gSXMgaXQ/DQoNClsuLi5dDQpUaGFua3MuDQpZdWFuIFlhbw0K
