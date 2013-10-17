From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 17 Oct 2013 18:09:46 +0200
Message-ID: <20131017160946.GF14104@ns203013.ovh.net>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>
 <20131017155308.GQ19112@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131017155308.GQ19112@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wsa@the-dreams.de>, srinivas kandagatla <srinivas.kandagatla@st.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen GALLIMORE <stephen.gallimore@st.com>, Grant Likely <grant.likely@linaro.org>, Stuart MENEFY <stuart.menefy@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Landley <rob@landley.net>, Stephen Warren <swarren@wwwdotorg.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime COQUELIN <maxime.coquelin@st.com>
List-Id: linux-i2c@vger.kernel.org

T24gMTY6NTMgVGh1IDE3IE9jdCAgICAgLCBMZWUgSm9uZXMgd3JvdGU6Cj4gT24gVGh1LCAxNyBP
Y3QgMjAxMywgSmVhbi1DaHJpc3RvcGhlIFBMQUdOSU9MLVZJTExBUkQgd3JvdGU6Cj4gCj4gPiBP
biAxMDozMyBUaHUgMTcgT2N0ICAgICAsIHNyaW5pdmFzIGthbmRhZ2F0bGEgd3JvdGU6Cj4gPiA+
IE9uIDE3LzEwLzEzIDA4OjI3LCBNYXhpbWUgQ09RVUVMSU4gd3JvdGU6Cj4gPiA+ID4gLi4uCj4g
PiA+ID4+PiA+PiArCj4gPiA+ID4+PiA+PiArc3RhdGljIHN0cnVjdCBvZl9kZXZpY2VfaWQgc3Rf
aTJjX21hdGNoW10gPSB7Cj4gPiA+ID4+PiA+PiArICAgICB7IC5jb21wYXRpYmxlID0gInN0LGNv
bW1zLXNzYy1pMmMiLCB9LAo+ID4gPiA+PiA+IHRoZSBydWxlcyBpcyB0byBwdXQgdGhlIGZpcnN0
IHNvYyB0aGF0IHVzZSB0aGUgaXAgaW4gdGhlIGNvbXBhdGlibGUKPiA+ID4gPj4gPiBhcyBzdCxz
dGk3MTAwLXNjYy1pMmMKPiA+ID4gPiBPay4gVGhlcmUgYXJlIG5vIHBsYW5zIHRvIHVwc3RyZWFt
IHRoZSBTSDQgcGxhdGZvcm1zLCBpdCB3aWxsIG9ubHkgCj4gPiA+ID4gcmVtYWlucyBpbiBzdGxp
bnV4LmNvbS4KPiA+ID4gPiBNYXliZSBJIGNhbiBzZXQgdGhlIGZpcnN0IEFSTSBwbGF0Zm9ybSAo
U1RpSDQxNSk/Cj4gPiA+ID4gVGhhdCB3b3VsZCBnaXZlIHN0LHN0aWg0MTUtc3NjLWkyYy4KPiA+
ID4gTkFLLCBmb3Igc3Qsc3RpaDQxNS1zc2MtaTJjIG5hbWluZy4KPiA+ID4gCj4gPiA+IElNTywg
dGhpcyBtYWtlcyBzZW5zZSB3aGVuIHRoZSBzYW1lIElQIGludGVncmF0aW9uIGRvbmUgb24gZGlm
ZmVyZW50IFNPQwo+ID4gPiBjaGFuZ2VzIHNsaWdodGx5L3ZlcnkgZGlmZmVyZW50bHkuCj4gPiA+
IAo+ID4gPiBCdXQgaW4gdGhpcyBjYXNlIHRoZSAiY29tbXMiIElQIHJlbWFpbnMgdW5jaGFuZ2Vk
IGFjcm9zcyBhbGwgdGhlIFNPQ3MuCj4gPiA+IAo+ID4gPiBJIHdvdWxkIHN0aWxsIHByZWZlciAi
c3QsY29tbXMtc3NjLWkyYyIsIGFsbG93aW5nIGEgc2luZ2xlIGRldmljZSBkcml2ZXIKPiA+ID4g
dG8gbWF0Y2ggYWdhaW5zdCBzZXZlcmFsIFNvQ3MuIFNUICJjb21tcyIgSVAgaXQgaXMgaW50ZWdy
YXRlZCBhY3Jvc3MgYWxsCj4gPiA+IHRoZSBTVGkgc2VyaWVzIG9mIFNvQ3MsIHNvIHdlIGRvbid0
IHdhbnQgdG8gYWRkIG5ldyBlbnRyeSBpbiBjb21wYXRpYmxlCj4gPiA+IGZvciBldmVyeSBuZXcg
U09DLgo+ID4gCj4gPiB5b3UgbmV2ZXIgbmVlZCB0aGlzIHlvdSBhbHdheXMgdGhlIGZpcnN0IFNv
QyB0aGF0J3MgYWxsCj4gPiAKPiA+IHNlZSBvdGhlciBiaW5kaW5ncyBvbiBhdDkxIGFzIGV4YW1w
bGUgc29ycnkgTkFDSwo+IAo+IEknbSBndWVzc2luZyB0aGF0IHVzaW5nIHRoZSBmaXJzdCBTb0Mg
aXMgYW4gSTJDJ2lzdW0uCj4gCj4gR3V5cywgaWYgeW91IGRvbid0IHdhbnQgdG8gYmUgdG9vIHNw
ZWNpZmljLCBqdXN0IG1ha2UgaXQgYXMgZ2VuZXJpYyBhcwo+IHBvc3NpYmxlIHdoaWxlc3Qgc3Rp
bGwgdXNpbmcgdGhlIFNvQyBhcyBhIFBPUjogc3Qsc3RpaDQxeC1zc2MtaTJjIHdpbGwKPiBkbyBm
b3Igbm93LCBhcyBpdCBjb3ZlcnMgYWxsIGN1cnJlbnQgYmFzZXMuCgpleGNlcHQgdGhpcyBpcyB3
cm9uZyB0aGUgSVAgaXMgdXNlZCBvbiBtdWNoIG9sZGVyIFNvQyB0aGFuIHRoZSByZWNlbnQgQVJN
IG9uZXMKCmFuZCB0aGUgRFQgc28gcGxlYXNlIHJlc3BlY3QgdGhlIHJ1bGUgZmlyc3QgU29DIHVz
ZWQgb24KCkJlc3QgUmVnYXJkcywKSi4KPiAKPiAtLSAKPiBMZWUgSm9uZXMKPiBMaW5hcm8gU1RN
aWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCj4gTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCj4gRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBU
d2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
