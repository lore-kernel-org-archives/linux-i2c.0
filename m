From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nforce2: Use IS_ENABLED() instead of checking for
 built-in or module
Date: Tue, 26 Apr 2016 23:38:35 +0200
Message-ID: <20160426213834.GJ4587@katana>
References: <1461691353-22095-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52516 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbcDZVik (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:38:40 -0400
Content-Disposition: inline
In-Reply-To: <1461691353-22095-1-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2016 at 01:22:33PM -0400, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20

Applied to for-next, thanks!


--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH9/aAAoJEBQN5MwUoCm2fzAP/R+d8yakcTykd1L8sE6aOHQj
aQVnXshTuWMefPtotvsnaZ+BNFJeVQwYSlNKDI/Vai/SAyke7F4HX1GLPadxUIlX
b8sFCyImpCIvKGEuTl9XD+pjg84w3UpATtin8dZK6s0frBwIvoMwD56RSxxjx+Hp
uwpdXKqyVwHcWEi62VRR/CZKnEe8zkm1tYOjq6Cl90MHkmkPCBtt3fRcksnrP0G6
/gKpXATPUb7EYt902fJYyIE1aR/0tlYH2FEz0uGddFJnNjxn/Ing6ONO3lOzVLPt
3ny46HzTeNNbveZCzFYGxMryBHD13FjMaOXfBXGg1D9bHBAhpMEtwiKI2e/B1jFm
y6qzigUd5QuoiY3Iy/I0JPwqjhUWXnfOta1nMtc+q0BYy6teJLjGbQthxrYO4kso
39kTneSIovWlnfkNKiaPKbgGoCz8ThAh3HvCjYTs+96aqd30F0Rmrgq8VThR8HzA
uL/wl7IGWWN8ox9swhdNnzIEilqr2aCFhxlZxNbdXBmUPHe0FfIsrmdsekRDbFW9
ZF3OGNiNb3Oo8H8QIIveNahRSUx+NQXUFelWCOhPH8dOZJySHSXXyReP53mVBn0u
fYZpzBoOilRA7TT0xdVQdMvkp0LXSrKoqEzTJuJ2FSm1iR6LYQFum5EXZlaV0dAg
XOqoWp6EjIA31FZYR5UH
=82CA
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
