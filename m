From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper
 methods
Date: Wed, 21 Feb 2018 16:46:56 +0100
Message-ID: <CAMuHMdVcbgX-Gi7p15JgsF0Ghe2wo4XEkPM2c=uxgqxJ9f2i=Q@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
 <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh@kernel.org>
Cc: Marek Vasut <marex@denx.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

SGkgUm9iLAoKT24gV2VkLCBGZWIgMjEsIDIwMTggYXQgNDoyMyBQTSwgUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4gd3JvdGU6Cj4gT24gV2VkLCBGZWIgMjEsIDIwMTggYXQgNDoyMSBBTSwg
R2VlcnQgVXl0dGVyaG9ldmVuCj4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPj4gWW91
IG1pc3NlZCBvbmUgZml4IEkgaGF2ZSBpbiBteSB0b3BpYy9vdmVybGF5cyBicmFuY2gKPj4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ2VlcnQvcmVuZXNh
cy1kcml2ZXJzLmdpdC9jb21taXQvP2g9dG9waWMvb3ZlcmxheXMmaWQ9MTUwZjk1YjlkZWM3N2Nl
MzcxYzIyOWY3YWM0ZDZkZDg2MjBiZWY0YQo+Cj4gQXJlIHlvdSBwbGFubmluZyB0byB0cnkgdG8g
dXBzdHJlYW0gYWxsIHRoaXM/IElmIG5vdCwgSSdsbCBnZXQgRnJhbmsKCk5vdCByZWFsbHkuIEJ1
dCBJIGRvIG5lZWQgYSB3YXkgdG8gbG9hZCBEVCBvdmVybGF5cyBhdCBydW50aW1lLCBmb3IgdGVz
dGluZwpoYXJkd2FyZSBvbiBleHBhbnNpb24gY29ubmVjdG9ycy4KCj4gdG8ga2VlcCBjaGFuZ2lu
ZyB0aGUgb3ZlcmxheSBBUEkgdG8gbWFrZSBjYXJyeWluZyBpdCBvdXQgb2YgdHJlZSBtb3JlCj4g
cGFpbmZ1bC4gOikKCkhlIGFscmVhZHkgZGlkIGEgdmVyeSBnb29kIGpvYiB3LnIudC4gdGhhdCBp
biB2NC4xNS1yYzEgO14pCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAg
ICAgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0
CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
