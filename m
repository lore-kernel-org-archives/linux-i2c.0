From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-bfin-twi: integrate
	timeout timer with completion interface
Date: Tue, 13 Oct 2009 19:17:16 -0400
Message-ID: <8bd0f97a0910131617n73254a77v2a0c514ee884e3af@mail.gmail.com>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
	<20091013225359.GC13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20091013225359.GC13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gVHVlLCBPY3QgMTMsIDIwMDkgYXQgMTg6NTMsIEJlbiBEb29rcyB3cm90ZToKPiBPbiBXZWQs
IE9jdCAwNywgMjAwOSBhdCAxMTozODoxNVBNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gRnJvbTogU29uaWMgWmhhbmcgPHNvbmljLnpoYW5nQGFuYWxvZy5jb20+Cj4+Cj4+IFRoZXJl
IGlzbid0IG11Y2ggcG9pbnQgaW4gbWFuYWdpbmcgb3VyIG93biBjdXN0b20gdGltZW91dCB0aW1l
ciB3aGVuIHRoZQo+PiBjb21wbGV0aW9uIGludGVyZmFjZSBhbHJlYWR5IGluY2x1ZGVzIHN1cHBv
cnQgZm9yIGl0LiDCoFRoaXMgbWFrZXMgdGhlCj4+IHJlc3VsdGluZyBjb2RlIG11Y2ggc2ltcGxl
ciBhbmQgcm9idXN0Lgo+Cj4gTG9va3MgbGlrZSBhIGNhbmRpZGF0ZSBmb3IgbmV4dCBrZXJuZWwg
cmVsZWFzZS4KCm9rID8gIGknbSBub3QgYXNraW5nIGZvciB5b3UgdG8gcHVzaCBldmVyeXRoaW5n
IG5vdywgaSdtIGFza2luZyB5b3UgdG8KdGFrZSB0aGUgcGF0Y2ggYW5kIGdldCBpdCBtZXJnZWQg
YXQgc29tZSBwb2ludC4gIHdoZXRoZXIgaXQncyBmb3IKMi42LjMyIG9yIDIuNi4zMywgaXQgZG9l
c250IHJlYWxseSBtYXR0ZXIuCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClVjbGludXgtZGlzdC1kZXZlbCBtYWlsaW5nIGxpc3QKVWNsaW51eC1k
aXN0LWRldmVsQGJsYWNrZmluLnVjbGludXgub3JnCmh0dHBzOi8vYmxhY2tmaW4udWNsaW51eC5v
cmcvbWFpbG1hbi9saXN0aW5mby91Y2xpbnV4LWRpc3QtZGV2ZWw=
