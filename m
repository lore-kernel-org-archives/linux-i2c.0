From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex
 for punit access
Date: Fri, 13 Jan 2017 12:34:54 +0200
Message-ID: <3e46500b-8e22-6aa1-8142-97bcbd5d5571@linux.intel.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-2-hdegoede@redhat.com>
 <20170102141242.GY31595@intel.com>
 <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
 <20170113092644.GD31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170113092644.GD31595@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMDEvMTMvMjAxNyAxMToyNiBBTSwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOgo+IEl0IGFsc28g
ZmVlbHMgcXVpdGUgaGFuZCB3YXZ5IHNpbmNlIHRoZSBwdW5pdCBjb3VsZCBkbyB3aGF0ZXZlciBh
dAo+IGFueSB0aW1lIEFGQUlLLiBFZy4gaWYgdGhlcmUncyBzb21lIHRoZXJtYWwgZXZlbnQgb3Ig
c29tZXRoaW5nIHRoZQo+IHB1bml0IG1pZ2h0IGtpY2sgaW50byBhY3Rpb24uIFNvIHRyeWluZyB0
byBwcm90ZWN0IHRoaXMgZnJvbSB0aGUgT1MKPiBzaWRlIG1pZ2h0IG5vdCBiZSBhYmxlIHRvIGF2
b2lkIHRoZXNlIHByb2JsZW1zIGVudGlyZWx5LiBJdCBmZWVscyBsaWtlCj4gdGhlcmUgcmVhbGx5
IHNob3VsZCBiZSBzb21lIGtpbmQgb2Ygc2hhcmVkIGhhcmR3YXJlL2Zpcm13YXJlIG11dGV4Cj4g
d2l0aCB0aGUgcHVuaXQgdG8gYXJiaXRyYXRlIGFjY2VzcyB0byB0aGUgaTJjIGJ1cy4KPgpUaGVy
ZSBpcyBhbiBIVyBzZW1hcGhvcmUgZm9yIEkyQyBhY2Nlc3MuIEl0IGlzIGltcGxlbWVudGVkIGlu
IApkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtYmF5dHJhaWwuYyBhbmQgYW5vdGhl
ciBzZXQgZnJvbSBIYW5zIAppcyBhZGRpbmcgc3VwcG9ydCBmb3IgQ2hlcnJ5dHJhaWwgaW50byBp
dC4KCi0tIApKYXJra28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwt
Z2Z4Cg==
