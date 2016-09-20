From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 1/3] i2c: bcm2835: Fix hang for writing messages larger
 than 16 bytes
Date: Tue, 20 Sep 2016 08:46:58 +0200
Message-ID: <e473206c-7f9c-7b7d-d75d-7879425fc2f9@martin.sperl.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

T24gMTkuMDkuMjAxNiAxNzoyNiwgTm9yYWxmIFRyw7hubmVzIHdyb3RlOgo+IFdyaXRpbmcgbWVz
c2FnZXMgbGFyZ2VyIHRoYW4gdGhlIEZJRk8gc2l6ZSByZXN1bHRzIGluIGEgaGFuZywgcmVuZGVy
aW5nCj4gdGhlIG1hY2hpbmUgdW51c2FibGUuIFRoaXMgaXMgYmVjYXVzZSB0aGUgUlhEIHN0YXR1
cyBmbGFnIGlzIHNldCBvbiB0aGUKPiBmaXJzdCBpbnRlcnJ1cHQgd2hpY2ggcmVzdWx0cyBpbiBi
Y20yODM1X2RyYWluX3J4ZmlmbygpIHN0ZWFsaW5nIGJ5dGVzCj4gZnJvbSB0aGUgYnVmZmVyLiBU
aGUgY29udHJvbGxlciBjb250aW51ZXMgdG8gdHJpZ2dlciBpbnRlcnJ1cHRzIHdhaXRpbmcKPiBm
b3IgdGhlIG1pc3NpbmcgYnl0ZXMsIGJ1dCBiY20yODM1X2ZpbGxfdHhmaWZvKCkgaGFzIG5vbmUg
dG8gZ2l2ZS4KSSByZW1lbWJlciBoYXZpbmcgc2VlbiBzaW1pbGFyIGludGVycnVwdCBpc3N1ZXMg
d2l0aCB0aGUgU1BJIEhXLWJsb2NrLgo+IEluIHRoaXMgc2l0dWF0aW9uIHdhaXRfZm9yX2NvbXBs
ZXRpb25fdGltZW91dCgpIGFwcGFyZW50bHkgaXMgdW5hYmxlIHRvCj4gc3RvcCB0aGUgbWFkbmVz
cy4KVGhhdCBpcyBiZWNhdXNlIGl0IGlzIGEgbGV2ZWwgaXJxIHRoYXQgaW1tZWRpYXRlbHkgdHJp
Z2dlcnMgYW5vdGhlciAKaW50ZXJydXB0IGdpdmluZwpubyBDUFUgbm8gdGltZSB0byBkbyBvdGhl
ciAodGhyZWFkZWQpIE9TIGFjdGl2aXR5IC0gdGhpcyBtaWdodCBiZSBzbGlnaHRseQpkaWZmZXJl
bnQgZm9yIG11bHRpLWNvcmUgbWFjaGluZXMuLi4KPiBUaGUgQkNNMjgzNSBBUk0gUGVyaXBoZXJh
bHMgZGF0YXNoZWV0IGhhcyB0aGlzIHRvIHNheSBhYm91dCB0aGUgZmxhZ3M6Cj4gICAgVFhEOiBp
cyBzZXQgd2hlbiB0aGUgRklGTyBoYXMgc3BhY2UgZm9yIGF0IGxlYXN0IG9uZSBieXRlIG9mIGRh
dGEuCj4gICAgUlhEOiBpcyBzZXQgd2hlbiB0aGUgRklGTyBjb250YWlucyBhdCBsZWFzdCBvbmUg
Ynl0ZSBvZiBkYXRhLgo+ICAgIFRYVzogaXMgc2V0IGR1cmluZyBhIHdyaXRlIHRyYW5zZmVyIGFu
ZCB0aGUgRklGTyBpcyBsZXNzIHRoYW4gZnVsbC4KPiAgICBSWFI6IGlzIHNldCBkdXJpbmcgYSBy
ZWFkIHRyYW5zZmVyIGFuZCB0aGUgRklGTyBpcyBvciBtb3JlIGZ1bGwuCj4KPiBJbXBsZW1lbnRp
bmcgdGhlIGxvZ2ljIGZyb20gdGhlIGRvd25zdHJlYW0gaTJjLWJjbTI3MDggZHJpdmVyIHNvbHZl
ZAo+IHRoZSBoYW5nIHByb2JsZW0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBOb3JhbGYgVHLDuG5uZXM8
bm9yYWxmQHRyb25uZXMub3JnPgpSZXZpZXdlZC1ieTogTWFydGluIFNwZXJsIDxrZXJuZWxAbWFy
dGluLnNwZXJsLm9yZz4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
