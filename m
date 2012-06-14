From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 14 Jun 2012 11:28:52 +0100
Message-ID: <1339669732.6598.7.camel@hornet>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jochen Friedrich <jochen@scram.de>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCAyMDEyLTA2LTEzIGF0IDIzOjEyICswMjAwLCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4g
Q3VycmVudGx5LCBldmVyeSBkcml2ZXIgaGFzIHRvIGRvIGl0IG9uIGl0cyBvd24sIGJ1dCBpdCBz
aG91bGQgYmUgZG9uZQo+IGluIHRoZSBjb3JlLCBsaWtlIHdlIGFscmVhZHkgZG8gd2l0aCBib2Fy
ZF9pbmZvIHN0cnVjdHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogV29sZnJhbSBTYW5nIDx3LnNhbmdA
cGVuZ3V0cm9uaXguZGU+Cj4gLS0tCj4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdmVyc2F0aWxl
LmMgICAgICAgICAgfCAgICAxIC0KPiAgZHJpdmVycy9pMmMvaTJjLWNvcmUuYyAgICAgICAgICAg
ICAgICAgICAgICB8ICAgIDMgKysrCgpGb3Igd2hhdCBpdCdzIHdvcnRoCgpUZXN0ZWQtYnk6IFBh
d2VsIE1vbGwgPHBhd2VsLm1vbGxAYXJtLmNvbT4KCm9uIFZlcnNhdGlsZSBFeHByZXNzLgoKUmVn
YXJkcwoKUGF3ZcWCCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
