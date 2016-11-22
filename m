From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Tue, 22 Nov 2016 13:01:06 +0100
Message-ID: <20161122120106.GB3993@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:43394 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755204AbcKVMBJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 22 Nov 2016 07:01:09 -0500
Content-Disposition: inline
In-Reply-To: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> On 11/14/2016 12:50 PM, Jan Glauber wrote:
> >=20
> > Since time is running out for 4.9 (or might have already if you're not
> > going to send another pull request) I'm going for the safe option
> > to fix the Octeon i2c problems, which is:
> >=20
> > 1. Reverting the readq_poll_timeout patch since it is broken
> > 2. Apply Patch #2 from Paul
> > 3. Add a small fix for the recovery that makes Paul's patch
> >    work on ThunderX
> >=20
> > I'll try to come up with a better solution for 4.10. My plan is to get =
rid
> > of the polling-around-interrupt thing completely, but for that we need =
more
> > time to make it work on Octeon.
> >=20
> > Please consider for 4.9.
> >=20
> Hey Jan.
>=20
> This does not work on Octeon 71xx platforms. I will look at it more
> closely tomorrow.

What's the outcome here? It seems we want a bugfix for 4.9 but this
report keeps me reluctant to apply the series.


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNDOCAAoJEBQN5MwUoCm2EeIP/3bmRs70qfkSA8wpYVW6juiB
WnUF2+Dev/vKOGVKXiGuD8Uy58doMpTlpJyE6RSMbtq8f62usdbJHmc48HgfUn50
GCJt4FV/aJefvtEh3pFJd6ldut6XDoz7GEUq7ENwMW/VLYn2fasJYhzCsfUaf2b6
gDyLdrnmoJIzotxL2KDJZ1zop4awLkxTOVWD2LOTvigfZ59r9aFyuSrLo5boeNQv
Udc1iLnD/wgqqAhCCRWrlXJsCQVugwcC1IZEyjqbTevg/m7s+9PTmHZUiVzOoTQJ
Bg8UquVfMYi9o299EPRSkoAsxNSxFXcBekQjBOWbs4c+49M0MvUW2pPINcJRfgt+
jUu41J+otzW8ZO8b5/Ce7F7Fj634x/rNXK54KR8wWcUFNhUSbgy99UFBBuEEM5E+
YCRB3x6A9R4ZV3FONduZbb+OI6C+hZmoE9FkSG1y5Z+DNCuCllszXT+Ig7X6jfQ3
ja9p4kNuSnQ7irZBgkUxbADumq9+XvZEkDT//pGyw6Uthry4Ciouxdq4Wi1YX71T
AhEDZgk1qgqK3LK6wbnXoBvh/TLN4SqLBx3PSq+0ZVWybDDX685A2bNdPtzTsO2m
sM3Q81Jx5GoQqECjBd/06f1wGDHS+u3uPUb9bveFXCAtj3ZldEPxaNzFNto9Ofy/
CaYtT8+N+E9aV8/qG5Nu
=WWOz
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
