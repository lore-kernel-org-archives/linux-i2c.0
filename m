From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 06/16] of: unittest: changeset helpers
Date: Wed, 21 Feb 2018 17:10:25 -0600
Message-ID: <CAL_Jsq+D4wwPSZbSXrJpwcNvB1Xth=Cn-bTyXL2RkSOb9s+d_A@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgNToxMCBQTSwgTGF1cmVudCBQaW5jaGFydAo8bGF1cmVu
dC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+IHdyb3RlOgo+IEZyb206IFBhbnRl
bGlzIEFudG9uaW91IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4KPiBBZGQgYSB1
bml0ZXN0IHNwZWNpZmljIGZvciB0aGUgbmV3IGNoYW5nZXNldCBoZWxwZXJzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogUGFudGVsaXMgQW50b25pb3UgPHBhbnRlbGlzLmFudG9uaW91QGtvbnN1bGtvLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0K3Jl
bmVzYXNAaWRlYXNvbmJvYXJkLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9vZi91bml0dGVzdC5jIHwg
NTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9vZi91bml0dGVzdC5jIGIvZHJpdmVycy9vZi91bml0dGVzdC5jCj4gaW5kZXggN2E5YWJhYWU4
NzRkLi4xYjIxZDJjNTQ5YTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9vZi91bml0dGVzdC5jCj4g
KysrIGIvZHJpdmVycy9vZi91bml0dGVzdC5jCj4gQEAgLTYwOSw2ICs2MDksNTkgQEAgc3RhdGlj
IHZvaWQgX19pbml0IG9mX3VuaXR0ZXN0X2NoYW5nZXNldCh2b2lkKQo+ICAjZW5kaWYKPiAgfQo+
Cj4gK3N0YXRpYyB2b2lkIF9faW5pdCBvZl91bml0dGVzdF9jaGFuZ2VzZXRfaGVscGVyKHZvaWQp
Cj4gK3sKPiArI2lmZGVmIENPTkZJR19PRl9EWU5BTUlDCgpJIHRoaW5rIHRoaXMgY2FuIGJlOgoK
aWYgKCFJU19FTkFCTEVEKENPTkZJR19PRl9EWU5BTUlDKSkKICByZXR1cm47CgpPdGhlcndpc2Us
CgpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
