From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 21 Jun 2012 09:16:35 +0800
Message-ID: <CAGsJ_4xZM0DYV6YLLUyQ1fd-s9DOvKAZ94UcNwGaUN3xTR97Yw@mail.gmail.com>
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
Cc: Viresh Kumar <viresh.kumar@st.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, Jochen Friedrich <jochen@scram.de>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>M
List-Id: linux-i2c@vger.kernel.org

MjAxMi82LzE0IFdvbGZyYW0gU2FuZyA8dy5zYW5nQHBlbmd1dHJvbml4LmRlPjoKPiBDdXJyZW50
bHksIGV2ZXJ5IGRyaXZlciBoYXMgdG8gZG8gaXQgb24gaXRzIG93biwgYnV0IGl0IHNob3VsZCBi
ZSBkb25lCj4gaW4gdGhlIGNvcmUsIGxpa2Ugd2UgYWxyZWFkeSBkbyB3aXRoIGJvYXJkX2luZm8g
c3RydWN0cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8dy5zYW5nQHBlbmd1dHJv
bml4LmRlPgoKQWNrZWQtYnk6IEJhcnJ5IFNvbmcgPGJhcnJ5LnNvbmdAbGlhbmxhYi5vcmc+Cgo+
IC0tLQo+Cj4gQmFzZWQgb24gdjMuNS1yYzIuIE9ubHkgYnVpbGQgdGVzdGVkLCBJIGRvbid0IGhh
dmUgYSBPRiBiYXNlZCBkZXZpY2UKPiBhcm91bmQgYXQgdGhlIG1vbWVudC4KPgo+IEBQZXRlcjog
V2h5IGRvZXMgb2NvcmVzIGRvIHRoZSBkZXZpY2UgcmVnaXN0cmF0aW9uIG1hbnVhbGx5IHZpYQo+
IHBsYXRmb3JtX2RhdGEgaW5zdGVhZCBvZiB1c2luZyBib2FyZF9pbmZvPwo+Cj4gwqBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLWNwbS5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDUgLS0t
LS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1wbGF0ZHJ2LmMgfCDCoCDC
oDEgLQo+IMKgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ncGlvLmMgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaWJtX2lpYy5jIMKgIMKg
IMKgIMKgIMKgIMKgfCDCoCDCoDMgLS0tCj4gwqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5j
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtbXBjLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4gwqBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLW14cy5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0K
PiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMgwqAgwqAgwqAgwqAgwqAgwqAgfCDC
oCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHwgwqAgwqAyIC0tCj4gwqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXBueC5jIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
cHhhLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4gwqBkcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXMzYzI0MTAuYyDCoCDCoCDCoCDCoCDCoCDCoHwgwqAgwqAxIC0KPiDCoGRyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtc2hfbW9iaWxlLmMgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4g
wqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKg
IMKgMiAtLQo+IMKgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12ZXJzYXRpbGUuYyDCoCDCoCDCoCDC
oCDCoHwgwqAgwqAxIC0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMteGlpYy5jIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHwgwqAgwqAyIC0tCj4gwqBkcml2ZXJzL2kyYy9pMmMtY29yZS5jIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDMgKysrCj4gwqAxNyBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKLWJhcnJ5Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
