From: Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH v2] i2c: bcm2835: Model Divider in CCF
Date: Mon, 27 May 2019 13:00:00 -0700
Message-ID: <E711B8C3-85B8-435C-97FD-E62BCB88B679@nh6z.net>
References: <20190508071227.18609-1-nh6z@nh6z.net>
 <4174B26B-4E3A-4CCA-A5ED-BE62A3B5E66A@nh6z.net> <20190516075848.GA1033@kunai>
 <2E6EDCD1-E0B1-4859-BD75-EF411D3D4C6B@nh6z.net> <20190527191534.GD8808@kunai>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190527191534.GD8808@kunai>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, swarren@wwwdotorg.org, NWDR Team <team@nwdigitalradio.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Cj4gT24gTWF5IDI3LCAyMDE5LCBhdCAxMjoxNSBQTSwgV29sZnJhbSBTYW5nIDx3c2FAdGhlLWRy
ZWFtcy5kZT4gd3JvdGU6Cj4gCj4gUmVnYXJkbGVzcyB3aGljaCBzb2x1dGlvbiBpcyBmYXZvdXJl
ZCwgSSBhbSBnb2luZyB0byBhcHBseSB0aGlzIHBhdGNoIGluCj4gYSBtaW51dGU6Cj4gCj4gaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwOTc2ODgvCj4gCj4gSXQgZW5hYmxlcyB0
aGlzIGRyaXZlciBmb3IgQVJDSF9CUkNNU1RCLiBTbywgdGhlIHNvbHV0aW9uIHNob3VsZCB3b3Jr
Cj4gZm9yIHRoaXMgYXMgd2VsbC4gKEkgZG9uJ3Qga25vdyBhbnkgb2YgdGhlc2UgcGxhdGZvcm1z
IHdlbGwpCgpJIGRpZCBzb21lIGxvb2tpbmcgdGhlIG90aGVyIGRheSwgYW5kIEkgaGFkIGZvcmdv
dHRlbiB0aGF0IHRoZSBSUGkgaGFzIDMKb2YgdGhlIGkyYy1iY20yODM1IGRldmljZXMgZWFjaCB3
aXRoIHRoZWlyIG93biBkaXZpZGVyIHRoYXQgc2l0cyBpbiB0aGVpcgpyZWdpc3RlciBzcGFjZS4g
IFRoaXMgbWFrZXMgbWUgdGhpbmsgdGhlIGNvcnJlY3Qgc29sdXRpb24gd291bGQgYmUgZm9yCnRo
ZSBkaXZpZGVyIHRvIGJlIGNvbnRyb2xsZWQgaW4gdGhlIGRyaXZlciBhcyB3YXMgaW4gbXkgb3Jp
Z2luYWwgcGF0Y2guCk90aGVyd2lzZSB3ZeKAmWQgaGF2ZSB0byBtYWtlIHRocmVlIGRpZmZlcmVu
dCBkaXZpZGVycyBpbiB0aGUgYmNtMjgzNS1jbGsKZHJpdmVyLCBhbmQgdGhlIGkyYyBkcml2ZXIg
d291bGQgbm8gbG9uZ2VyIHdvcmsgZm9yIG90aGVyIHBsYXRmb3Jtcy4KCkkgaGF2ZW7igJl0IGhl
YXJkIGFueSBjb21tZW50cyBmcm9tIGFueSBvZiB0aGUgY2xvY2sgZm9sa3MuICBJIHdhcyBwZXJ1
c2luZwp0aGUgY29kZSBhbmQgSSBzZWUgdGhlcmXigJlzIGEgU1BJIGRyaXZlciB0aGF0IHJlZ2lz
dGVycyBpdHMgb3duIGNsb2NrIGFuZApzb21lIHZhcmlvdXMgZXRoZXJuZXQgYW5kIE1NQyBkcml2
ZXJzIHRoYXQgZG8gdGhlIHNhbWUgdGhpbmcuCgo+IFJlZ2FyZHMsCj4gCj4gICBXb2xmcmFtCgot
LQpBbm5hbGllc2UgTWNEZXJtb25kCm5oNnpAbmg2ei5uZXQKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
