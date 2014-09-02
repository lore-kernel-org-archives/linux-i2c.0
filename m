From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c:at91: Fix a race condition during signal handling in
 at91_do_twi_xfer.
Date: Tue, 2 Sep 2014 12:56:23 +0200
Message-ID: <20140902105623.GE1266@katana>
References: <1409080404-19069-1-git-send-email-simon@aqwary.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409080404-19069-1-git-send-email-simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 09:13:24PM +0200, Simon Lindgren wrote:
> There is a race condition in at91_do_twi_xfer when signals arrive.
> If a signal is recieved while waiting for a transfer to complete
> wait_for_completion_interruptible_timeout() will return -ERESTARTSYS.
> This is not handled correctly resulting in interrupts still being
> enabled and a transfer being in flight when we return.
>=20
> Symptoms include a range of oopses and bus lockups. Oopses can happen
> when the transfer completes because the interrupt handler will corrupt
> the stack. If a new transfer is started before the interrupt fires
> the controller will start a new transfer in the middle of the old one,
> resulting in confused slaves and a locked bus.
>=20
> To avoid this, use wait_for_completion_io_timeout instead so that we
> don't have to deal with gracefully shutting down the transfer and
> disabling the interrupts.
>=20
> Signed-off-by: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>

Applied to for-current, thanks!


--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBaJXAAoJEBQN5MwUoCm2lMAQAKtY21GNyxAPYTmQFYw2xJp/
e67Pit9TL1d2VqvNkR3YDpTsgmDC6ws0qSB4BnubmigY92Bq8378VYSKZ5Pkpe+4
UiHy0K0e1VnyDusZm+LnqcnTct3WsR5WLUkphkrlRZnAFnUQtp8M+tw5y9QRXz/u
H97mianmVfm9JCzyVcxMSBfglcsKZRt4RkB4/7A3L0/Hl2Xb5PQttupZU2kUpRex
dOuJT/flLI0F2M6FYhX1SLzW5bZCRtBIZBHtPC4Pfn3fH+J34D3kCKToKfMwnala
PF4axHt3o7cnoTyrRUO5zU24t68Bi/2bZErlOECmTenUkacw7jzYZQz56by8oPIl
XlPsSNMG0Hq3/4zWXYtveVRSikYZ00tKBtlm10tVjUJ9BBPzU+bskprX+dsHylQM
TGnEXd6KOp5ebOABGFqeGKLjT6AMAbANn+MqMLaffAlqe47jrhNeOpLO7T8AOcxl
Y2rLChAJlFFRvyC/1hvq7P5JSIrBgHNZmh9OfQRqrw6pe0hN+S7GsKYlHYM8aUVB
jJnBxHtC2L0So8S9PAYBVHXx+0WA9DfP+P9ZllLDNURqfv/5WbJoFX8irp9ZXfrq
HJ+vUXVCzbabpJnin/t8JKF7I9fJ17pK9vOjUy5FESFu1DKTYcVEudezGBeqGgw2
E58vbjTLqlwvrq2RsSM6
=Sm5H
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
