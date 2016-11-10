From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Thu, 10 Nov 2016 16:39:44 +0100
Message-ID: <20161110153944.GA1585@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
 <20161110153016.GJ26304@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34289 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933658AbcKJPkA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 10:40:00 -0500
Content-Disposition: inline
In-Reply-To: <20161110153016.GJ26304@bigcity.dyn.berto.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Niklas, all,

> Yes, this is a bug in the rcar-vin driver which is addressed in the Gen3=
=20
> patches. However I'm not sure those patches will make it to v4.10, not=20
> much review from the V4L2 side yet (Geert and Sergei have had a few=20
> comments so there will at lest be one more iteration).
>=20
> If this is a big blocker I can try and break out the fix from the Gen3=20
> patch series, but I fear even that series would be quiet large since a=20
> rework on the whole logic is needed to fix this (maybe a workaround can=
=20
> be figure out to fix this until Gen3 patches are accepted). Let me know=
=20
> what you think.

Thanks for your investigation and heads up!

I think we should do the following:

* upstream the patches with no issues for v4.10 (Simon started this already)
* rebase the demux branch on top of the one you mentioned with the vin fixes
  and retest
* if all works in renesas-drivers, then just wait until vin patches are
  upstream and then we upstream the hdmi-demux-patches

And orthogonal to that:

* keep discussing what to do with DFVS (postponed to next week for me
  because of other duties)

Sounds good?

   Wolfram


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJJTAAAoJEBQN5MwUoCm2WyIP/RlX+zfJRkkqWDgk79kZQ5uq
hB5uFyIVXree3HQ0NVkJAXH9Q+nvLUXB0OIa8AHiBp7LYXimhImq4iLCFAHx9k6G
lYGNYhu8Z2Tj3l701WfpLulBriHQl/vWmZzbH7AA+CU+Wo2UfINWlE76Qcs8E0JB
YwLRFyWGNpzLWgvrkbbp0CocjK+mFtA4vjd/uRmUkHUPKv+Ga21FnlLm8cQRfYlW
StRnGRRJQCzXoDW4OwBuMbvhbHukqcFB0Y0ITAF/CIUeIcOVPocor0550/TnVFL8
VwBBwDi5WACMISA92Nf0Pqt/6Xv/XYQ4hqGG4HcI0yWyq8PhVeVNuN9oSkvjP+i7
3m+tMSR1vl+qBTcjyew7E4/RKvFtxnLaHuIEitrlWs9m/mCjhjUuF3GyywBS3WI5
CJDdMXMwtm92uClKz/UKLvBjxbBlJZi6kCbST7uLdYL3a8EVLo782LZmcitcTTiT
cIbH6KZUaAc33uFIFPB4cg8MxVFrs/7Xaj+kcYdFbJ2jiGewovv7woMzVB60F1oF
aUq4P8z83ghmmlezrY7XO3XN1bsbANFBWNliz58wPC6pguOZJOhkWCqqP0MZ6yOR
sqc1S4aup5iZY37XU4WX249Ol8+HA17wG3erw46podsLy8Te/ZXpuXpsr3fev0Ig
splH6VQ7OgyQCWqf+TuC
=mMGv
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
