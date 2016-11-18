From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: i2c: make busses/i2c-pxa-pci.c explicitly non-modular
Date: Fri, 18 Nov 2016 01:45:54 +0100
Message-ID: <20161118004554.GA7785@katana>
References: <20161031175947.10531-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031175947.10531-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 01:59:47PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> drivers/i2c/busses/Kconfig:config I2C_PXA_PCI
> drivers/i2c/busses/Kconfig:     def_bool I2C_PXA && X86_32 && PCI && OF
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>=20
> Since module_pci_driver() uses the same init level priority as
> builtin_pci_driver() the init ordering remains unchanged with
> this commit.
>=20
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to for-next, thanks!


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLk9CAAoJEBQN5MwUoCm2QvUQAIhTNvUjsfb8tOc3nH1SypvW
lL+BtqlJn+PlruN3HFgaZ2V8TVMA72kpcNSuFMjne7YPWlHc8hfgA1/BpHvxL33h
YVagd+1BelV8DaZw11IS5nxruPlLj32TGq0FBCTwdDI0kaCxlvELTodZps3KR8PM
lhVMVxAOzMLiRdW2bhnjbG3nWKJnDZ2yH8fUEIPgiNOWz3WwUL2qJtoWGMFrDL4a
IydW3Ic+M++W6VKMHTs62gRxORfBM+pqVnST5UZTC09/xHMTXomyAdZDUC4wuPte
65dcZ4MZ2+GHSko7va97yFQdnMe6aNV1X+hQgeDBi44Uyqtc2I94o7weTb7sdDRK
lbDIrcH21YMMkUThpMShRoWYzP9jp2wP9OZYtJI2sb1kw2ConOIuxLVUIIAscj2n
bJSupK8MMfgyFLKArTqe7S+Rh9rLy3JB/8pck60XTRv1VaUOsXfMOvnHluRFY68G
Zn8cSJl4oU4MdhNlMB/oXBZaIJBE+3pzgZVITSbiFZQ+MhOwgY/cpRbV7wF07QtH
3dyHEjs3RB10hQw6Ga0EXd63cRTFyuJcN08x95h1dpDDwsrNfBUGTtz9T0cG3GYB
W4SB4nEx2uGJ84l0HRQdMgHXVsob1j/+n1Wa7K6x5mzQWJciyjwNp1kHg+lWFQRi
jDTmlVD4xCFgd9pfETtQ
=7oWk
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
