From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v10 0/8] add i2c driver supported for rk3399
Date: Mon, 20 Jun 2016 10:18:19 +0800
Message-ID: <cc893dec-0796-d5f4-4702-bebd6d8819d7@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
 <20160617115611.GC6876@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160617115611.GC6876@tetsubishi>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

SGkgV29sZnJhbe+8jAoK5ZyoIDIwMTYvNi8xNyAxOTo1NiwgV29sZnJhbSBTYW5nIOWGmemBkzoK
PiBBcHBsaWVkIHdob2xlIHNlcmllcyB0byBmb3ItbmV4dCwgdGhhbmtzISBUaGlzIHdhcyBuaWNl
bHkgcmVmYWN0b3JlZCBhbmQKPiBlYXN5IHRvIHJldmlldywgdGhhbmtzLiBBbHNvIHRoYW5rcyB0
byBhbGwgcmV2aWV3ZXJzIHdobyBoZWxwZWQgdGhpcwo+IHNlcmllcy4gSSBmaXhlZCBvbmUgY2hl
Y2twYXRjaCBpc3N1ZSBmb3IgeW91LCB0aG91Z2g6Cj4KPiBXQVJOSU5HOiBTdGF0ZW1lbnRzIHNo
b3VsZCBzdGFydCBvbiBhIHRhYnN0b3AKPiAjMjc4OiBGSUxFOiBkcml2ZXJzL2kyYy9idXNzZXMv
aTJjLXJrM3guYzo3ODk6Cj4gKwkgaWYgKG1pbl9kaXZfZm9yX2hvbGQgPj0gbWluX3RvdGFsX2Rp
dikgewo+CgpUaGFua3MgZm9yIHlvdXIgZmluYWwgcmV2aWV377yBCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGluZyBs
aXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
