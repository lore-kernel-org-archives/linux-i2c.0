From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
Date: Mon, 20 Aug 2012 18:26:54 +0200
Message-ID: <083DF309106F364B939360100EC290F823A0354A3D@eu1rdcrdc1wx030.exi.nxp.com>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
 <20120818095108.GB24812@pengutronix.de> <5030A81E.5090508@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5030A81E.5090508-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Bakki <srinivas.bakki-3arQi8VN3Tc@public.gmane.org>, "aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Pj4+IFRoaXMgcGF0Y2ggZm9yIGkyYy1wbnggYWZmZWN0cyBQTlg0MDA4IGFuZCBMUEMzMnh4IChh
bmQgTFBDMzF4eCwNCj4+PiBub3QgeWV0IGluIG1haW5saW5lKS4gQ2FuIHlvdSBwbGVhc2UgdGVz
dCBhbmQgZG91YmxlLWNoZWNrIHRoZQ0KPj4+IG1hbnVhbHMgb2YgUE5YNDAwOCBhbmQgTFBDMzF4
eD8gSSBvbmx5IGZvdW5kIHRoaXMgdmlhIHRoZSBtYW51YWwNCj4+PiBvZiBMUEMzMnh4IGJ1dCBh
c3N1bWUgaXQncyB0aGUgc2FtZSBmb3IgdGhlIG90aGVycywgYWxzby4NCj4+PiANCj4+PiBUaGFu
a3MgaW4gYWR2YW5jZSENCj4+IA0KPj4gS2V2aW4sIHNpbmNlIHRoZSBvdGhlciBtYW51YWxzIHNl
ZW0gdG8gYmUgbm90IGVhc2lseSBhdmFpbGFibGUsIGNhbg0KPj4geW91IHBsZWFzZSBjaGVjaz8N
Cj4NCj5ZZXMsIHdvdWxkIGJlIGdyZWF0IGlmIHNvbWVvbmUgYXQgTlhQIGNvdWxkIGNvbmZpcm0g
dGhhdCBQTlggYWN0dWFsbHkNCj51c2VzIHRoZSBzYW1lIElQIGNvcmUgZm9yIHRoZSBJMkMgY29u
dHJvbGxlciBhcyBMUENzIGRvICh3aGljaCBpcw0KPmN1cnJlbnRseSBhc3N1bWVkIGJ5IExpbnV4
IGFueXdheSkuDQoNCkkndmUgbmV2ZXIgaGFkIG15IGhhbmRzIG9uIGEgUE5YNDAwOCBjaGlwIGF0
IE5YUCwgYnV0IEkgZG8gYmVsaWV2ZSB0aGV5DQphcmUgdGhlIHNhbWUgSVAuIFRoYXQgc3BlY2lm
aWMgSTJDIElQIHdhcyB1c2VkIGluIGEgbnVtYmVyIG9mIE5YUC9QaGlsbGlwcw0KY2hpcHMgYmVz
aWRlcyB0aGUgUE5YNDAwOC9MUEMzMnh4LiBJIGRvbid0IHRoaW5rIHRoZXJlIGFyZSBhbnkgUE5Y
NDAwOCdzIGluDQp0aGUgd2lsZCwgYW5kIGV2ZW4gd29ya2luZyBpbiBOWFAsIEkgY2FuJ3QgZmlu
ZCBhbnkgbm9uLW1hcmtldGluZyByZWZlcmVuY2UNCm1hdGVyaWFsIGZvciB0aGF0IHBhcnQgKGlu
Y2x1ZGluZyB0aGUgdXNlciBtYW51YWwpLg0KDQpUaGUgcG54IEkyQyBibG9jayBpcyB1c2VkIGlu
IHRoZSBMUEMzMnh4ICgzIGluc3RhbmNlcyksIHRoZSBMUEMzMTN4LA0KTFBDMjAwMCAoMSBpbnN0
YW5jZSBmb3IgVVNCIE9URyksIGFuZCB0aGUgTFBDMTd4eC9MUEM0MHh4ICgxIGluc3RhbmNlIGZv
cg0KVVNCIE9URykuIFRoZSBMUEMyMDAwLCBMUEMxN3h4LCBhbmQgTFBDNDB4eCBkZXZpY2VzIGFs
c28gdXNlIGFub3RoZXINCmNvbXBsZXRlbHkgZGlmZmVyZW50IChub24tcG54KSBJMkMgYmxvY2sg
Zm9yIG5vbi1PVEcgSTJDLg0KDQo=
