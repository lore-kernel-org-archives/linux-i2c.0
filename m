From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
Date: Fri, 14 Sep 2018 07:38:37 +0200
Message-ID: <ccbf7059-77fd-44e8-daee-516582814cb3@kaod.org>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
 <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
 <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Brendan Higgins <brendanhiggins@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, Joel Stanley <joel@jms.id.au>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Pj4+IFRoYXQgc2VlbXMgdG8gc3VnZ2VzdCB0aGF0IG5vbmUgb2YgdGhlIHN0YXR1cyBiaXRzIGF1
dG8tY2xlYXJzLCBhbmQgdGhhdAo+Pj4gdGhlIGFib3ZlIGNvZGUgY2xlYXJpbmcgaW50cl9zdGF0
dXMgc2hvdWxkIGJlIHJlbW92ZWQgZW50aXJlbHkuCj4+PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5n
ID8KPj4KPj4gWW91IGFyZSByaWdodC4gSSBqdXN0IHB1c2hlZCBhbm90aGVyIHZlcnNpb24gb2Yg
dGhlIHByZXZpb3VzIHBhdGNoIHdpdGggdGhpcwo+PiBuZXcgaHVuayA6Cj4+Cj4+IEBAIC0xODgs
NyArMjAwLDYgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfaGFuZGxlX2NtZChBcwo+PiDC
oCB7Cj4+IMKgwqDCoMKgwqAgYnVzLT5jbWQgJj0gfjB4RkZGRjsKPj4gwqDCoMKgwqDCoCBidXMt
PmNtZCB8PSB2YWx1ZSAmIDB4RkZGRjsKPj4gLcKgwqDCoCBidXMtPmludHJfc3RhdHVzID0gMDsK
Pj4gwqAgwqDCoMKgwqDCoCBpZiAoYnVzLT5jbWQgJiBJMkNEX01fU1RBUlRfQ01EKSB7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50OF90IHN0YXRlID0gYXNwZWVkX2kyY19nZXRfc3RhdGUoYnVz
KSAmIEkyQ0RfTUFDVElWRSA/Cj4+Cj4+Cj4+IFRoZSBRRU1VIHBhbG1ldHRvIGFuZCB3aXRoZXJz
cG9vbiBtYWNoaW5lcyBzZWVtIHRvIGJlaGF2ZSBmaW5lLiBDYW4geW91IGdpdmUKPj4gaXQgYSB0
cnkgPwo+Pgo+IAo+IFdvcmtzIGZpbmUgZm9yIG1lIGZvciBhbGwgYWZmZWN0ZWQgcWVtdSBwbGF0
Zm9ybXMuCj4gCj4gSG93IGRvIHlvdSB3YW50IHRvIHByb2NlZWQgd2l0aCB0aGUgcWVtdSBwYXRj
aGVzID8gSSBhdHRhY2hlZCBteSBwYXRjaGVzCj4gZm9yIHJlZmVyZW5jZS4gTWF5YmUgeW91IGNh
biBhZGQgdGhlbSB0byB5b3VyIHRyZWUgaWYgdGhleSBhcmUgb2sgYW5kIHN1Ym1pdAo+IHRoZSBl
bnRpcmUgc2VyaWVzIHRvZ2V0aGVyIHRvIHRoZSBxZW11IG1haWxpbmcgbGlzdCA/Cgp5ZXMuIFRo
ZXkgYXJlIHB1c2hlZCBpbiBteSBhc3BlZWQtMy4xIGJyYW5jaC4gSSB3aWxsIHNlbmQgdGhlIHNl
cmllcyAKb24gdGhlIGxpc3QuCgpUaGFua3MsCgpDLiAKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
