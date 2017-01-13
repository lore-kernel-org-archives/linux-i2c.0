From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
Date: Fri, 13 Jan 2017 15:52:00 +0100
Message-ID: <5d1b0fda-38e7-c4bd-46de-318507525c8b@topic.nl>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
 <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
 <20170113083727.GB1446@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113083727.GB1446@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, linux-i2c@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>, soren.brinkmann@xilinx.com
List-Id: linux-i2c@vger.kernel.org

77u/T24gMTMtMDEtMTcgMDk6MzcsIFdvbGZyYW0gU2FuZyB3cm90ZToKPgo+PiBJIHdvdWxkIGFy
Z3VlIHRoYXQgdGhlICJpbmZvIiBtZXNzYWdlIG1lYW5zICJ0aGUgSTJDIGFkYXB0ZXIgaXMgcmVh
ZHkgZm9yCj4+IHRyYW5zYWN0aW9uIG5vdywgYW5kIHdlJ2xsIHN0YXJ0IGluaXRpYWxpemluZyBk
ZXZpY2VzIG9uIHRoZSBidXMiLiBUaGF0IGlzCj4+IHRoZSBjYXNlIGJlZm9yZSBpdCBjYWxscyBp
MmNfYWRkX2FkYXB0ZXIoKS4KPgo+IEkga25vdyB3aGF0IHlvdSBtZWFuLCBidXQgaTJjX2FkZF9h
ZGFwdGVyIGRvZXMgbW9yZSwgYW5kIGl0IGNhbiBmYWlsCj4gYmVjYXVzZSB0aGUgYWRhcHRlciBp
cyAqbm90KiByZWFkeSB0byB0cmFuc2Zlci4gU2VlaW5nIHRoZSBzdWNjZXNzCj4gbWVzc2FnZSBi
ZWZvcmUgaXMgYWxzbyBjb25mdXNpbmcuCj4KPj4gV2hlbiBpMmNfYWRkX2FkYXB0ZXIoKSBydW5z
LCBpdCB3aWxsIHN0YXJ0IHByb2JpbmcgZGV2aWNlcyBvbiB0aGUgYnVzLiBUaGlzCj4+IHlpZWxk
cyB2ZXJ5IGNvbmZ1c2luZyBvdXRwdXQsIGFzIGl0IHdpbGwgb3V0cHV0IHRoaW5ncyBpbiBhIHJl
dmVyc2VkIG9yZGVyOgo+Pgo+PiAtIGRldmljZSBYIG9uIEkyQyBidXMKPj4gLSBkZXZpY2UgWSBv
biBJMkMgYnVzCj4+IC0gY2Rucy1pMmMgZmYwMzAwMDAuaTJjOiAxMDAga0h6IG1taW8gZmYwMzAw
MDAgaXJxIDE5Nwo+Cj4gSSBhZ3JlZS4gVGhhdCBiZWluZyBzYWlkLCBzb21ld2hlbiBJIHN0YXJ0
ZWQgd29ya2luZyBvbiBtb3Zpbmcgc3VjaAo+IG1lc3NhZ2VzIGludG8gdGhlIGNvcmUgdG8gc2F2
ZSBzdHJpbmcgc3BhY2UgYW5kIGhhdmUgY29uc2lzdGVudCBvdXRwdXQuCj4gVGhlbiwgd2UgY2Fu
IHByaW50IGF0IHRoZSBwcm9wZXIgdGltZS4KPgo+IFNvLCB1bnRpbCB0aGVuLCB3ZSBzaG91bGQg
YmUgY29uc2lzdGVudCB3aXRoIHRoZSBvdGhlciBkcml2ZXIsIEknZCBzYXkuCgpNYWtlcyBzZW5z
ZS4KCkknbGwgY3JlYXRlIGEgdjIgcGF0Y2ggdG8ganVzdCBtb3ZlIHRoZSBpMmNfYWRkX2FkYXB0
ZXIgdG8gYWZ0ZXIgd3JpdGluZyB0aGUgCmNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzLCBhbmQgbGVh
dmUgdGhlIGRtZXNnIG91dHB1dCBhcyBpcy4KClRoYW5rcyBmb3IgcmV2aWV3aW5nLApNaWtlLgoK
CktpbmQgcmVnYXJkcywKCk1pa2UgTG9vaWptYW5zClN5c3RlbSBFeHBlcnQKClRPUElDIFByb2R1
Y3RzCk1hdGVyaWFhbHdlZyA0LCBOTC01NjgxIFJKIEJlc3QKUG9zdGJ1cyA0NDAsIE5MLTU2ODAg
QUsgQmVzdApUZWxlZm9vbjogKzMxICgwKSA0OTkgMzMgNjkgNzkKRS1tYWlsOiBtaWtlLmxvb2lq
bWFuc0B0b3BpY3Byb2R1Y3RzLmNvbQpXZWJzaXRlOiB3d3cudG9waWNwcm9kdWN0cy5jb20KClBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
CgoKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
