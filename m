From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Date: Thu, 17 Dec 2015 20:40:17 +0100
Message-ID: <20151217194016.GD1530@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <13702087.6o87OAVdIx@wuerfel>
 <20151217120157.GC3958@katana>
 <7947081.psvz6dklxq@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37904 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbbLQTkY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 17 Dec 2015 14:40:24 -0500
Content-Disposition: inline
In-Reply-To: <7947081.psvz6dklxq@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > My conclusion for now is:
> >=20
> > There needs something to be done surely, but currently I don't have the
> > bandwidth to do it or even play around with it. I am not fully happy
> > with your patches as well because __maybe_unused has some kind of "last
> > resort" feeling to me.
>=20
> I generally like __maybe_unused, but it's a matter of personal preference.
> We could avoid the __maybe_unused if the reg_slave/unreg_slave callback
> pointers are always available in struct i2c_algorithm.

Yes, I was thinking in this direction, looking at how PM does it. Needs
some playing around, though.

> Just for reference, see below for my combined patch, in case you decide
> to use that at a later point.

Thanks a lot!


--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcw+gAAoJEBQN5MwUoCm2DzkP/3FxqV7RYin8IozaADCVRcx+
0WIFzLdEFbEx3YV0mQ9uKYnleRvoQYG/Xfbw5rzwEb5iYW8A+6xEsZoJYCc9PtLc
ZBRcfOcMchIIQhQruwVxDq9LlEC92VpYIcbAa9dXt04en+6zn20GvXbDV9duB/Jw
z35v0k+VgakofHZ3/3C9PKNrd6AV0uwt29sUq2w40LimW1+nzYHJsXy8OBIxoJWs
WTj5RTEgF6QmSzzsV7NccA3Xrc2fvowUUjF/4n8QwASC6bGisGiZxsFOLQ+WyjqU
Fq5TT8ZGglK2W9cNqmbAoL1dYiA2upJAruD+uoGHG3XVnWiO7U24sLX1GMJBWAEK
NR0YdNepKNEY8rQ87A6VSYZjiCrjEwF0B47szGlQa3vctePG4/NiopR+sUXTiwqe
6qj2QhEmkQQcylvQ7v/9qJ1TMs7yoAU0PWsA3OzZX7dYaRFp1RWEW4FXoSfDgIrs
SRoKcRkK6rCyKbbkFYXj/8NKPeR1SvZtEVLMkVHJgr7iQCKbFRrQPBnaWKpdzqzi
c2pzSXOckqvIhTVbdCyTav2yt7OC3EOhS7TkP7UNtRYgsaCCEFNpoQRbIPVLJV9J
zUXbv/dSOyPjjcq5vv3XnbwN/pBIgmxLu80PkGJjhouKWkLvxN8sLxdZ/e4UDyOk
Ti8UfmkfoS9EoTPcnNsh
=kw/d
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
