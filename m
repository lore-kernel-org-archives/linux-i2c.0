From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Mon, 10 Mar 2014 11:59:52 +0100
Message-ID: <20140310105952.GA7227@katana>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl>
 <20140309202107.GA2835@katana>
 <531D92F7.7080509@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <531D92F7.7080509-Oq418RWZeHk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Even more, you should complete the whole transfer. There are devices
> >where things can really go wrong if you send a half-complete command and
> >then start with the next one. So, not checking signals at all is the way
> >to go for I2C drivers. There is some cruft left, so I am happy about
> >patches fixing that, with testing on real HW. Like yours here.
>=20
> I agree.
>=20
> I know the Zynq (using a cadence controller) also lets signals
> interrupt I2C transfers, so I'll propose a patch to Xilinx and CC to
> you and linux-i2c to completely remove signal handling from that
> driver as well.

Cool, thanks!


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHZsoAAoJEBQN5MwUoCm2pkAQAJzc2MNUaTFcdCLghtuilnSx
qlQ00rRZmvBlZwUvE+Sb09sJ0hC38/n3gQuW7NDU0/9WWr5doMaCjzI1ySuR5XFQ
Ec2JZ/j8sqbosMXB9REjuWeJOho0qADN5xA8O8Da2IZ4YgguvG8K6Ks/TwD1Z90V
FAQgbkxR4g1fxLj0PkK6UmOvpa+ExfM6d8Pw6G5k0U5DtZxkeWQq/NelaiFzamcM
dPJnrZGjPETALHf0RLWJLf4sidoRx//FeZTpfw5N9IQwUdVH8U6dU4uqlV1DfVmg
KPlC5WwE402r+bBcDixAPrQ2stFwLzJxQZ+QE74ThAuIUEV3MH1N3g408dVPEQIO
Mh5fniK6a7WovHuzFl4BF8TgKIusrrxgNsFDIN9uWAcyfeW898lf33qdCmsswaIK
6p3HToIt+2JInGh6msf8Q+WViLMS7OwlbqE8iqsoC6rqsQJs9+4AKWPan460ty66
M+3Xi1hntFbIQVyU20GHZoGIeWyUZWFf9+DzmKuOsal0gXMIMlJGPeOr7QHPxffn
AglsA4klqL7idRWeYNeS12OLHxpzmSiqKDDdgXlzeJjrN+wmEeTssyGx6Dh0rZZv
5SWFSwc/iEcgGe/fHTzp41B/JTd4fp+34LDPSIok3r8nW6Yin6RlqlJSLSM2vMqa
YUI3dSd09awnigXUIqRF
=jEz2
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
