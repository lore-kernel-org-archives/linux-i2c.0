From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-bfin-twi: integrate
	timeout timer withcompletion interface
Date: Fri, 9 Oct 2009 01:10:20 -0400
Message-ID: <8bd0f97a0910082210x7d89ac85wf9e9d144b59bdb85@mail.gmail.com>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
	<20091008093817.GB6112@pengutronix.de>
	<0F1B54C89D5F954D8535DB252AF412FA04D6FC09@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04D6FC09-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

T24gRnJpLCBPY3QgOSwgMjAwOSBhdCAwMDo0OSwgWmhhbmcsIFNvbmljIHdyb3RlOgo+IEZyb206
IFdvbGZyYW0gU2FuZyBbbWFpbHRvOncuc2FuZ0BwZW5ndXRyb25peC5kZV0KPj4gT24gV2VkLCBP
Y3QgMDcsIDIwMDkgYXQgMTE6Mzg6MTVQTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6Cj4+
PiBGcm9tOiBTb25pYyBaaGFuZyA8c29uaWMuemhhbmdAYW5hbG9nLmNvbT4KPj4+Cj4+PiBUaGVy
ZSBpc24ndCBtdWNoIHBvaW50IGluIG1hbmFnaW5nIG91ciBvd24gY3VzdG9tIHRpbWVvdXQgdGlt
ZXIgd2hlbgo+Pj4gdGhlIGNvbXBsZXRpb24gaW50ZXJmYWNlIGFscmVhZHkgaW5jbHVkZXMgc3Vw
cG9ydCBmb3IgaXQuIMKgVGhpcyBtYWtlcwo+Pj4gdGhlIHJlc3VsdGluZyBjb2RlIG11Y2ggc2lt
cGxlciBhbmQgcm9idXN0Lgo+Pgo+PiBUaGlzIHNvdW5kcyBsaWtlIGEgZ29vZCB0aGluZyB0byBk
bywgYnV0IGtlZXAgaW4gbWluZCB0aGF0Cj4+IGFkYXB0ZXItPnRpbWVvdXQgdmFsdWVzIHNob3Vs
ZCBiZSBpbiBqaWZmaWVzIChzZWUKPj4gOGE1MmM2YjRkNTViMjk2MGQ5M2E5MGE3Y2Y2YWZkMjUy
MzU3ZmE1NCkuCj4KPiBZZXMsIGppZmZpZXMgaXMgdXNlZCBpbiB0aGlzIHBhdGNoIGZvciB0aW1l
b3V0IHZhbHVlLgoKbm8gaXQgaXNudC4gIHRoZSBjb21taXQgaGUgcmVmZXJzIHRvIGRvZXMgdGhp
bmdzIGxpa2U6Ci0gICBhZGFwLT50aW1lb3V0ID0gMTsKKyAgIGFkYXAtPnRpbWVvdXQgPSBIWjsK
ICAgICAgICByZXQgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dChkZXYtPndxLAot
ICAgICAgICAgICAhKGluXzgoJmlpYy0+c3RzKSAmIFNUU19QVCksIGRldi0+YWRhcC50aW1lb3V0
ICogSFopOworICAgICAgICAgICAhKGluXzgoJmlpYy0+c3RzKSAmIFNUU19QVCksIGRldi0+YWRh
cC50aW1lb3V0KTsKCndlIG5lZWQgdG8gbWFrZSB0aGUgc2FtZSBjaGFuZ2UgYXMgb3VyIGNvZGUg
aXMgY3VycmVudGx5IHdyb25nOgorICAgICAgICAgICAgICAgaWYgKCF3YWl0X2Zvcl9jb21wbGV0
aW9uX3RpbWVvdXQoJmlmYWNlLT5jb21wbGV0ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgYWRh
cC0+dGltZW91dCAqIEhaKSkgeworICAgICAgIHBfYWRhcC0+dGltZW91dCA9IDU7Ci1taWtlCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVjbGludXgtZGlz
dC1kZXZlbCBtYWlsaW5nIGxpc3QKVWNsaW51eC1kaXN0LWRldmVsQGJsYWNrZmluLnVjbGludXgu
b3JnCmh0dHBzOi8vYmxhY2tmaW4udWNsaW51eC5vcmcvbWFpbG1hbi9saXN0aW5mby91Y2xpbnV4
LWRpc3QtZGV2ZWw=
