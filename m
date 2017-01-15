From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus
 acquire
Date: Sun, 15 Jan 2017 16:17:02 +0100
Message-ID: <20170115151702.GA1739@katana>
References: <20170108134427.8392-1-hdegoede@redhat.com>
 <20170108134427.8392-4-hdegoede@redhat.com>
 <20170112184545.sejbzawnesu6zj5i@ninjato>
 <5aa8a3ab-a527-1f3b-0cf6-92fd4691ddc8@redhat.com>
 <20170115114529.jxwcadse23gdykx5@ninjato>
 <84cabe1f-1129-19b9-f0ed-6ec5f189bb29@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1115472873=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <84cabe1f-1129-19b9-f0ed-6ec5f189bb29@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--===============1115472873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Once I've a patch-set everyone likes I will start talking to people
> to coordinate the merging, I believe it is probably best for all this
> to be merged through the drm-intel tree. But we'll see about that
> when the patch-set is ready.

Agreed.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYe5JtAAoJEBQN5MwUoCm2QgEP/0a6efEeyJP16kxiNunmPC7b
R0fNUy7w/sSXr3C9zyz/QV309NF3pJiIpZ4zXbqZZxN6SWZaPLz7AVQZk+WvLryL
kJlSkPGQ3pK50ZV3dpjRyzusy/h51HUUEHQwkG+z9nMIAy/K92I3E3LM3Zp9x00b
Zx27OrTYNWbDIoud2dU4jFglkAJ6eKh4puB7Ra1qHo9hMpdyBtSrZvIpLFt0saof
z8v45m2n4+G9yXKlz//+pT/oIujfGp9+YQoj6lxJrG9QmxVaRMyR+LWp7z2bpz5j
sxQyZyUouIysoBSgxrOFhoPWY57Vs2ukbTGMmXbI6Yt+q2XezT3exiCdjHJ22sR2
S5HA3GVF+WVVMTQrOSSD9rSwRmr//HlFvzZbOHmdWjxec7FHI+1wF4EF7RRWLQFl
ay0Nip1rYUPJqc9fQj8O4tmR7kIaL+HuWjoKKCgp85RmmUegsg+we9UjYtBtHVQ/
5iIXHk4Mr82l/MVhSQhjTV4TpWaCeRgGyI3O2SHCP4I0hCqVtLelURTQh1axGMLn
BtiM/wbT+dHGKzj4RFa7SW+ZBFMnNsiTiQkbHcnYpic6EmSpOpzoU4lvQluWHIPe
Ccab3h1ORWpwfdmpmoreavjKgocgVSoFzeMo7zXwYEarCICzoLhuvPV0UA28ApEp
3NiHhlfY5QUtFpUAosA2
=w1Ii
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============1115472873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1115472873==--
