From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: jz4780: drop superfluous init
Date: Thu, 9 Jun 2016 22:31:17 +0200
Message-ID: <20160609203116.GJ23522@katana>
References: <1465119702-4417-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34946 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbcFIUbV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:31:21 -0400
Content-Disposition: inline
In-Reply-To: <1465119702-4417-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Axel Lin <axel.lin@ingics.com>, David Binderman <dcb314@hotmail.com>


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 05, 2016 at 11:41:42AM +0200, Wolfram Sang wrote:
> David reported that the length for memset was incorrect (element sizes
> were not taken into account). Then I saw that we are clearing kzalloced
> memory, so we can simply drop this code.
>=20
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdIUAAoJEBQN5MwUoCm2IQcP/2X7hHZ1K3/GHIalQdArhaYQ
5YvRS6gfrZagqeoc6oh8amCQSRTTtqwxaHzp4xCUDKxuqtfjy8iHYqF1W4/HFjPH
8sBzUp4hMpwlkfep0hXfIPezIToreYfiwNJuSehWaP4vNTVOFYSldC91wvydr9+j
mwgVWp8p/dlc/v0S0x83lCQG1WIZ7WNZjDwaRrZ1KBh3pA4xmarIUqcFg1F4aYsA
69lJz8vr8CrBahHhw2SYl9psWV9GToRT2/CtQtQ6t5S/3J1cPNMD/y4VAhUs96YN
shvDoiIe0RRrg0oQDw5ZOuSlfV93Y/ineFADsVp64tChZ8LS9/n7anSIDPRPpAHE
5j5R8y7DaT6cjoMVDmkvBI8CeLc1v/s2Df2Uq3cKaFtCthrN37zcwiw+GfvXNdZj
MmLZzAWFalK3ihv342x0+8Q30/VT1YjXahA3sGylzkMAOg94aGsCMv2TPv2gnPlE
DZyymdpyf5gejO4M86gEzD0vERxu3ItdZ/rRRyqr4Cs8C/cGo9yFq8fNJi4V4Yox
GI2v4Vg3j13HMZxUWdc1aievpWGIuNf1d+hFq4A3jf0x2wBcFcBenLrfOf4h2eDP
iq92iE2hrXUFwfET/CrNJBVeJEb6zuFhO6MzF6uHwj5Qwt4m7A6Yu1kQ34AeR/yK
V3FTwG7TBJSKungCNAFl
=CEw+
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
