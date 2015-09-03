From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
Date: Thu, 3 Sep 2015 09:08:06 -0700
Message-ID: <CAD=FV=UOSFeKPHSQE1Mrc_d4yCu54LOTj+TRZc_+kPs1mofLxg@mail.gmail.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
 <20150903093910.GA4151@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150903093910.GA4151@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <treding@nvidia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wolfram Sang <wsa@the-dreams.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

VGhpZXJyeSwKCk9uIFRodSwgU2VwIDMsIDIwMTUgYXQgMjozOSBBTSwgVGhpZXJyeSBSZWRpbmcg
PHRyZWRpbmdAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gUGVyaGFwcyB0aGUgSTJDIGNvcmUgbmVlZHMg
dG8gYmUgdGF1Z2h0IHRvIGxvb2sgYXQgdGhlIGFkYXB0ZXIncwo+IC0+ZGV2LnBhcmVudC0+b2Zf
bm9kZSBpbiBvZl9maW5kX2kyY19hZGFwdGVyX2J5X25vZGUoKS4gQXMgSSB1bmRlcnN0YW5kCj4g
aXQgdGhlIHB1cnBvc2UgZm9yIHJlZ2lzdGVyaW5nIGEgc2VwYXJhdGUgc3RydWN0IGRldmljZSBm
b3IgZWFjaCBJMkMKPiBjb250cm9sbGVyIGlzIHNvIHRoYXQgdGhlcmUncyBhbiBJMkMgcGFyZW50
IGZvciBhbGwgc2xhdmVzLiBBdCB0aGUgc2FtZQo+IHRpbWUgZXZlcnkgY29udHJvbGxlciBzZXRz
IHVwIC0+ZGV2LnBhcmVudCwgYW5kIHRoYXQgcGFyZW50J3MgT0Ygbm9kZSBpcwo+IHdoYXQgd2Ug
cmVhbGx5IHdhbnQgd2hlbiB3ZSBsb29rIHVwIGFuIEkyQyBhZGFwdGVyIGJ5IE9GIG5vZGUuIElu
IG90aGVyCj4gd29yZHMsIHRoZSBPRiBub2RlIGJ5IHdoaWNoIEkyQyBhZGFwdGVycyBhcmUgcmVm
ZXJlbmNlZCBpcyBhbHdheXMgdGhhdAo+IG9mIGl0cyBwYXJlbnQgZGV2aWNlLCBhcyBmYXIgYXMg
SSBjYW4gdGVsbC4KPgo+IFdvbGZyYW0sIGRvIHlvdSBrbm93IG9mIGFueSBjYXNlcyB3aGVyZSBh
ZGFwdGVyLT5kZXYub2Zfbm9kZSB3b3VsZCBub3QKPiBiZSB0aGUgc2FtZSBhcyBhZGFwdGVyLT5k
ZXYucGFyZW50LT5vZl9ub2RlPwoKVGhpcyBzb3VuZHMgcHJldHR5IHJlYXNvbmFibGUgdG8gbWUu
ICBDZXJ0YWlubHkgaXQgd291bGQgYmUgYSBwcmV0dHkKcmVhc29uYWJsZSBmYWxsYmFjayBpZiBh
ZGFwdGVyLT5kZXYub2Zfbm9kZSB3YXMgTlVMTC4KCi1Eb3VnCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
