From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: detect No Slave Ack on SELECT in PIO mode
Date: Fri, 3 Oct 2014 02:51:59 +0200
Message-ID: <20141003005159.GE1323@katana>
References: <1411469306-15390-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411469306-15390-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2014 at 12:48:26PM +0200, Janusz Uzycki wrote:
> i2cdetect scanned i2c bus slow because the i2c-mxs driver ignored
> the NO_SLAVE_ACK bit during busy-waiting loop.
> Thanks to the patch, the speedup happens.
> The change doesn't break anything else because:
> - on SELECT: NO_SLAVE_ACK bit checking is just welcome
> - on READ: master (the i2c controller, no slave device) generates
>    ACK/NAK bit
> - on WRITE: NO_SLAVE_ACK can be treated as NAK (the same effect)
>    so even the i2c controller sets NO_SLAVE_ACK on NAK (not confirmed)
>    the WRITE is not effected
> - on clock stretching: SCL wire is involved, it has no influence
>    on the ACK bit value on SDA wire
>=20
> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>

Applied to for-next, thanks!


--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULfMvAAoJEBQN5MwUoCm2mgAP/0OxC/UdsEsQ7uAsTVK3ntoH
piUaFJWWOkF6jMgbg3cmBLRD6rtAMeMlYAu3Hyhk2GGTsbHozgeJ+KjzUwO1a6Zs
uE1JdnoaH9332x+8dx4hL+cQU4ZP0jW3zgaa3Pfu07XN/f4rOOaCunHK4+aO7Vje
EvFetIEsd0A0l2/X8D6IdKCXODy/zz1JFmXgjODj4Coj1wtb1iWiYrvPQl23hbBJ
LY9xiQDsPYUWpDePlRsAJXDWu5eFromjcAsZoR0c68ziohh002ZpBQhTfc8szGry
6umWkVLfI531BW/dCzxu5NwJtpuZCk9WAyRciHya0K3JaHK9tj9L32y2yb8E6BR1
Q3YbsSerckyW0UoVGOOdWg5ASHXdOZB5dbyMY3YQ78Imfg+cncgC0XKadCBV7U5t
HASVX8XXJZev3S6s44+y3rIHc6QerNdVKnz3UYfZvb2WKENVCx+9knEGqoFiY03G
1iSlUwgNbwfk+4GPVnPDhAwTBDahOIfsAIE2ACuHA0gojhfgLEO/hpnA5hogg6/R
sYcOKV1Pyf2K8sylAEF2ZRBOZc+h2Gb1g/H9UAjO+T0yfKs9InP6CJAZBrsnnIUk
Nlk2UyMJ5iixDfbVzgN6vhzCyFddyhRUzM9aYA2V3E7JuhtPgYxHMEsKDqnCTOW0
x2GoLWj16EurGOB7GtKX
=X8+0
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
