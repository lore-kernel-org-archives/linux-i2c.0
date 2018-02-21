From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 05/16] of: changeset: Add of_changeset_node_move method
Date: Wed, 21 Feb 2018 17:20:36 -0600
Message-ID: <CAL_JsqKv6YvXbpkGbNezTb=C7_kgd8R8NBOSc15PuDrLuMxK1Q@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com>
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
bGlzIEFudG9uaW91IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4KPiBBZGRzIGEg
Y2hhbmdlc2V0IGhlbHBlciBmb3IgbW92aW5nIGEgc3VidHJlZSB0byBhIGRpZmZlcmVudCBwbGFj
ZQo+IGluIHRoZSBydW5uaW5nIHRyZWUuIFRoaXMgaXMgdXNlZnVsIGluIGFkdmFuY2VzIGNhc2Vz
IG9mIGR5bmFtaWMKPiBkZXZpY2UgdHJlZSBjb25zdHJ1Y3Rpb24uCgpUaGlzIG9uZSBJJ20gbm90
IHJlYWwgY2xlYXIgb24gd2hlbiB3ZSdkIHVzZSB0aGlzIGFuZCB3ZSBkb24ndCBoYXZlCmFueSB1
c2VyLCBzbyBsZXRzIGRyb3AgaXQgZm9yIG5vdy4KClJvYgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
