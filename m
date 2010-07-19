From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix compiler warning, due to missing const
Date: Mon, 19 Jul 2010 10:13:08 +0200
Message-ID: <4C440914.6080500@pengutronix.de>
References: <1276592205-26284-1-git-send-email-mkl@pengutronix.de> <AANLkTiksiKUecR8tVYDEsKVYE7BxF5WAu9KdJISFRBFB@mail.gmail.com> <20100620223400.GB12387@fluff.org.uk> <4C1F0D19.7030901@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4FDA4578EE59DFE6A13FAAA4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C1F0D19.7030901-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FDA4578EE59DFE6A13FAAA4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Ben,

Marc Kleine-Budde wrote:
> Ben Dooks wrote:
>> On Tue, Jun 15, 2010 at 05:52:09PM +0800, Eric Miao wrote:
>>> On Tue, Jun 15, 2010 at 4:56 PM, Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>>>> This patch adds the missing const to "struct platform_device_id" to =
fix
>>>> this warning:
>>>>
>>>> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa=
=2Ec:
>>>> In function 'i2c_pxa_probe':
>>>> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa=
=2Ec:1004:
>>>> warning: initialization discards qualifiers from pointer target type=

>>>>
>>>> Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Ack
>> ok, will apply.

ping,
is there a change to get this patch into 2.6.35? I think compiler
warnings in a kernel release don't look good.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--------------enig4FDA4578EE59DFE6A13FAAA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkxECRQACgkQjTAFq1RaXHPkygCgmi2i+AwCOAo6Ln5HbC6s91Jw
WDoAniUe+99K5o7Ow4yLPPk0QajAzYtM
=pBdU
-----END PGP SIGNATURE-----

--------------enig4FDA4578EE59DFE6A13FAAA4--
