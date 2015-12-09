From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing
 information
Date: Wed, 09 Dec 2015 14:12:36 +0200
Message-ID: <1449663156.30729.63.camel@linux.intel.com>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <1449572085.30729.28.camel@linux.intel.com> <20151208130323.GB3359@katana>
 <20151208215103.GA1601@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20151208215103.GA1601@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gVHVlLCAyMDE1LTEyLTA4IGF0IDIyOjUxICswMTAwLCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4g
T24gVHVlLCBEZWMgMDgsIDIwMTUgYXQgMDI6MDM6MjNQTSArMDEwMCwgV29sZnJhbSBTYW5nIHdy
b3RlOgo+ID4gCj4gPiA+IFRvbyBtYW55ICYmIHVzZV9kZWZhdWx0cy4gV2hhdCBhYm91dAo+ID4g
PiAKPiA+ID4gbWVtc2V0KHQsIDAsIHNpemVvZigqdCkpOwo+ID4gPiAKPiA+ID4gZGV2aWNlX3By
b3BlcnR5X3JlYWRfdTMyKGRldiwgImkyYy1zY2wtaW50ZXJuYWwtZGVsYXktbnMiLCAmdC0KPiA+
ID4gPiBzY2xfaW50X2RlbGF5X25zKTsKPiA+ID4gCj4gPiA+IGlmICghdXNlX2RlZmF1bHRzKQo+
ID4gPiDCoHJldHVybjsKPiA+IAo+ID4gSSBsaWtlIHRoaXMhIFRoYW5rcyBmb3IgdGhlIGlucHV0
Lgo+IAo+IE9vcHMsIHRvbyBlbnRodXNpYXN0aWMuIFRoaXMgc2tpcHMgcGFyc2luZyBhbGwgdGhl
IG90aGVyCj4gcHJvcGVydGllcy4uLgo+IFRoZSBkZWZhdWx0cyBzaG91bGQgb25seSBiZSBhcHBs
aWVkIGlmIHJlYWRpbmcgdGhlIHByb3BlcnRpZXMgZmFpbHMuCgpMb29rcyBsaWtlIHByb3BlcnR5
IHN0dWZmIGlzIG5vdCBkZXN0cnVjdGl2ZSBpbiBjYXNlIG9mIGVycm9yLCBzbywgd2hhdAphYm91
dAoKcGFyYW1YID0gdXNlX2RlZmF1bHRzID8gZGVmYXVsdFggOiAwOwpkZXZpY2VfcHJvcGVydHlf
cmVhZOKApijigKYsICZwYXJhbVgpOwoKT3IgbWF5YmUganVzdCBiZSBhIGJpdCB2ZXJib3NlIGxp
a2UgdGhlIG9yaWdpbmFsIHZhcmlhbnQKaW50IHJldDsKCnJldCA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFk4oCmKOKApik7CmlmIChyZXQgJiYgdXNlX2RlZmF1bHRzKSB7CuKApgp9CgpBbW9uZyBhbGwg
dmFyaWFudHMgSSBsaWtlIHRoZSBsYXR0ZXIgb25lIGhlcmUuIFdoYXQgZG8geW91IHRoaW5rPwoK
LS0gCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgpJ
bnRlbCBGaW5sYW5kIE95CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1yb2NrY2hpcAo=
