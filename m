From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/16] of: dynamic: Add __of_node_dupv()
Date: Wed, 21 Feb 2018 17:16:52 -0600
Message-ID: <CAL_JsqKjsaH1Obyt_kYkvq78q0AU1fnGswa7G2bybH3FSTexgA@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-4-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220231046.32638-4-laurent.pinchart+renesas@ideasonboard.com>
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
bGlzIEFudG9uaW91IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4KPiBBZGQgYW4g
X19vZl9ub2RlX2R1cHYoKSBwcml2YXRlIG1ldGhvZCBhbmQgbWFrZSBfX29mX25vZGVfZHVwKCkg
dXNlIGl0Lgo+IFRoaXMgaXMgcmVxdWlyZWQgZm9yIHRoZSBzdWJzZXF1ZW50IGNoYW5nZXNldCBh
Y2Nlc3NvcnMgd2hpY2ggd2lsbAo+IG1ha2UgdXNlIG9mIGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTog
UGFudGVsaXMgQW50b25pb3UgPHBhbnRlbGlzLmFudG9uaW91QGtvbnN1bGtvLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRl
YXNvbmJvYXJkLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9vZi9keW5hbWljLmMgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
