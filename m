From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 09:48:37 +0100
Message-ID: <20151112084837.GA2782@katana>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074447.GA24008@pengutronix.de>
 <20151112075238.GA1551@katana>
 <20151112080926.GC24008@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53346 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbbKLIsp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 03:48:45 -0500
Content-Disposition: inline
In-Reply-To: <20151112080926.GC24008@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 09:09:26AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Thu, Nov 12, 2015 at 08:52:38AM +0100, Wolfram Sang wrote:
> > On Thu, Nov 12, 2015 at 08:44:47AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Other than that, the NULL pointer dereference should only happen if t=
he
> > > device was bound using the driver name. That might be worth to point =
out
> > > in the commit log. So maybe make (in a separate patch) the probe
> > > function fail when probed by name?
> >=20
> > RCar is a DT only platform.
>=20
> Does this imply that no checking is needed? I'm not sure.

I don't see how this driver could get probed otherwise. That being said,
for the "better safe than sorry" approach, I'd accept your suggestion.


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRFJlAAoJEBQN5MwUoCm2nqkP+wYVxrWBIOrQpbUmGrsYzlGq
ZavAbC0uLUiX4VzPFRkAg8D3CqFiRSnPuHFNOVVziY2q5VjoEbjxXvbh3v7DM1n2
bPrhlwjBY2xYD+5LS0fZkFzWG6yy737ASt/PtLx0eqkzoXOY3ckb+x+1sCaAmGq+
tjakyDtF7YV4VnvyipT4zlp7U6lsEQWVdQb7IsvV/ea0sPtGqyYVdClfj+nsgb+h
yRGC9M1B/8IhezGdVv4WhBhbRSWqoC1YSSD/NlEFF9RtVRQ1UyGQXA5lW3WsF4cx
8PDI2vz4HwuM4VZesZ8LfgO9XbXD/TYjTVg9uLg8qdsevi6x4fng2Abo6WKcYkFP
GmeG6ZiqKsZUeDrc9m68tAuW5TdtebN2VA3okmm6n5ukArJFjVqO/18P4s4Z2gYc
oVvi+rLdnXydBQsZf/JNm+fr7Zbuxn76AE6nyAaN0qiKWi5II8BHHl5jukUXYV8R
SPNkxV/PjVfUIHQUu/39sk3wzadkgtMYw07Yoao6/3OeDH3VMuFUVgenxRamd/YL
pjztBoV05s6pERdKK23IVvoOL84OKqIIDHS0X2J0qth7npV4cpVdUgC4AadAsARn
7jTe7bLyfSfIc1qKXKSIskGIxVWl9Ly+QopeZt58MRqh32jUiQRbUtsaDJeTqzEU
yl2tgcmpIe1C8lXynC+o
=RwPw
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
