From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock
 frequency
Date: Fri, 22 Nov 2013 17:25:41 +0100
Message-ID: <20131122162541.GE7420@katana>
References: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385136523-11962-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2013 at 05:08:43PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> With some devices, transfer hangs during I2C frame transmission. This iss=
ue
> disappears when reducing the internal frequency of the TWI IP. Even if it=
 is
> indicated that internal clock max frequency is 66MHz, it seems we have
> oversampling on I2C signals making TWI believe that a transfer in progress
> is done.
>=20
> This fix has no impact on the I2C bus frequency.
>=20
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSj4WFAAoJEBQN5MwUoCm2DAAP/0d9Gda0tD/j8zTxe6Qx7a45
f+ofVJBgk/RQgkvdwD8wVpzMG5FFcR1CKu3ZgyFbhrZUJq9T2sK5G0mr/UDa0TDd
WlnxJPZZ8lDlpZAK/CMyL82AajNn1tLN3qb2ruBatPbgQSxPSbA4huZnrJQx+u6m
ljba4XnKp0yB2uve07iE3mwHJexEN3EiVx1zHC+k20s8TwSI4XZHIg1Dc8ycTUgd
QnV+CRisIF171McilIn9zRhkmcJoFAGhO858slLZsej58Kr3F9+lI2ZDjRNATO2I
WC1aUaEltND6LLdQCb6yswaGF7as49NVQhR9889DktEmzdGyJrqIYHBjHPmpnEQ4
ERPIXowq141p+F/SRcRt7ioVjcPxmtab+hKSKACOztkLbSSe17NrgCu9aHpoGvli
Kx6zLEQtR/n+EklRaq0gAx+wmbT8PVQ/0TmotP01InyKPhvCP1gzYjaVqbq1j0YL
Io5lyOyl+wIlIzp16Khj7ZDh3ni7UcFdCW7DRfvgNrmX1JxskP90tpmsc2FN5PjK
FqvbKVJvGvnafFiHQn6mHEiEFEPPdHVwMW7al/wt5rZUft+cjCjlHPonFPkyiNLt
1aIs7NOMLxldvF9YzPwvQFixuLncDr2e0jiA5bhqJWugHHBsnaFi79Pu7gLHb82A
IaCLgn7tZgKqaHN6lvu4
=DM0h
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
