From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c-dev: switch from register_chrdev to cdev API
Date: Fri, 27 May 2016 13:17:45 +0200
Message-ID: <20160527111745.GA1663@katana>
References: <1462301143-6084-1-git-send-email-erico.nunes@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47364 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbcE0LR4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 27 May 2016 07:17:56 -0400
Content-Disposition: inline
In-Reply-To: <1462301143-6084-1-git-send-email-erico.nunes@datacom.ind.br>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Erico Nunes <erico.nunes@datacom.ind.br>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2016 at 03:45:43PM -0300, Erico Nunes wrote:
> i2c-dev had never moved away from the older register_chrdev interface to
> implement its char device registration. The register_chrdev API has the
> limitation of enabling only up to 256 i2c-dev busses to exist.
>=20
> Large platforms with lots of i2c devices (i.e. pluggable transceivers)
> with dedicated busses may have to exceed that limit.
> In particular, there are also platforms making use of the i2c bus
> multiplexing API, which instantiates a virtual bus for each possible
> multiplexed selection.
>=20
> This patch removes the register_chrdev usage and replaces it with the
> less old cdev API, which takes away the 256 i2c-dev bus limitation.
> It should not have any other impact for i2c bus drivers or user space.
>=20
> This patch has been tested on qemu x86 and qemu powerpc platforms with
> the aid of a module which adds and removes 5000 virtual i2c busses, as
> well as validated on an existing powerpc hardware platform which makes
> use of the i2c bus multiplexing API.
> i2c-dev busses with device minor numbers larger than 256 have also been
> validated to work with the existing i2c-tools.
>=20
> Signed-off-by: Erico Nunes <erico.nunes@datacom.ind.br>

Applied to for-next, thanks! I'll try to still get it into v4.7.


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSCzZAAoJEBQN5MwUoCm2C+AP/3B6Joh27f0szqqsgYcgYUpR
WgcR43JBTo0eO4tXOuBiBxXYHI4yxbYUhCITvO/g8ywYB3SSsvZ7T5ffVOta2MaN
G9xLn+pc9S4U9zvVhbxSplV9CH32pRLLkmvkqv8YmNj4hLG6rXVPxzOtsdX3rooP
aPOCM30o78Hixb4dIOGYPFPRUjdV1t7DjokTp+rlVjknXuSpS08SToKKYumIDExq
viXFrBZwwoFdIqrhxlBxPanhAhjM+GZMP6bT6flnInjhR162u1a+QZLKOLIitanS
/FppjmwsiUCWZaR7kCI/qv/QvF5WLW/EgMcxBNh1lWhxd93YfIshMkk2OZeuIlXU
lMuJB1oQd35jnNoi1PgS5HO995PoNECjLVhLw7KHuEgnlQ2NGAP2FY1VmP/RmO4Y
5zS33+ltCWJAoN6eMsKCtsGrtQ8huxZbfF3TSqcn7N+XqdjgCpMrutL6rsYiWWq7
PEaqIHkriJW24aKxUzL53gl1sVRx9ltXr0C+GbMMdTONtZKWgnsm7+20gCqy72pu
OIy1Njs8MVoQw2Z+slOjJjrpshGpBU5jYCFPdYt5ZGMCzRcBrKdwZJFqyMoMxgnB
yJW4ZsLlClIXKJfa/F7iHutnJDL6I2+h5LS/rFwUVWlxpPZMkz5sQVcTxldiryTS
z93IqiUcc11/YolVyudh
=gK9r
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
