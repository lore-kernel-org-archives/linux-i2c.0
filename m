From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ocores: use request_any_context_irq() to register
 IRQ handler
Date: Thu, 29 Aug 2019 22:12:46 +0200
Message-ID: <20190829201246.GP3740@ninjato>
References: <20190822132132.16557-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SavPGzlo48F1Gxyz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822132132.16557-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--SavPGzlo48F1Gxyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 03:21:32PM +0200, Federico Vaga wrote:
> The i2c-ocores device is an HDL component that get instantiated in FPGA.
> The software stack used to drive an FPGA can be very different, and the
> i2c-ocore ip-core must work in different context. With respect to this
> patch the IRQ controller behind this device, and its driver, can have
> different implementations (nested threads). For this reason, it is safer
> to use `request_any_context_irq()` to avoid errors at probe time.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Applied to for-next, thanks!


--SavPGzlo48F1Gxyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1oMb0ACgkQFA3kzBSg
KbaiVhAArWYZe7O8lBaCp2VM5luO9FLbm8BuWRyLAF0RQ/MCM72MJcXcPhol2Fxn
ADg4h/yR+ut9OrRFH89eLdMTp5dSdZD/eLWtXpyyfSVEICHbgppauSZTGEUUbgjA
yZ3XyZNSapyvoVN8KE5g6CblG4MuPcajnqGEdIyBPlorUWPUgpTi/y3R2XPllxKG
VblquMF8/lyFjbA7rcxDy7pf93NciXs3CfP3V6VGz/d3GNaJATmh3ONNjKx3CXMU
kPQkdniHj+JbbrNwuDG0Gf0u1DEDC3Wj5vfowHb6GNHUaQg0mc8tEmk8uZzc7gvx
4ql/uUyV0f5NEMGBbvRQNYNfc+oMkWeDlAzJOjAgop62cEXIMqO+uX5MsSeSY85V
ZFgxoRwovPM1WNN5UH9A63KQ0hABGiMCqiOVFG0BRVmiJCSjGrOHfDPHieEUCPrp
kVwHastSdePDSXC3cy1tw/c5U1nZfLDIyGYV9eT72/OGfUB3OPKBW7J88qh4VZHD
nrLuhCgsY7UWr0/crI2rnaxzdnCeyvOGnvkEUP6RqS8suQ4rO0V64Ac/xYrnA21b
ELDeLpXKm09hJ5ZRc3ckXmtbw1XbsC+grvGKoaCLHmy+BVP73KHEz2hq2cbWkoXt
bW7l3MAi6jSGA0CIepLMQSPpXmkBGi57wil/gLwKYw4f8cm4L7w=
=pBYe
-----END PGP SIGNATURE-----

--SavPGzlo48F1Gxyz--
