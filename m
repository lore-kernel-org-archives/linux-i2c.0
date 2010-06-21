From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix compiler warning, due to missing const
Date: Mon, 21 Jun 2010 08:56:25 +0200
Message-ID: <4C1F0D19.7030901@pengutronix.de>
References: <1276592205-26284-1-git-send-email-mkl@pengutronix.de> <AANLkTiksiKUecR8tVYDEsKVYE7BxF5WAu9KdJISFRBFB@mail.gmail.com> <20100620223400.GB12387@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF1189466C98D0CCA33286D5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100620223400.GB12387-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF1189466C98D0CCA33286D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ben Dooks wrote:
> On Tue, Jun 15, 2010 at 05:52:09PM +0800, Eric Miao wrote:
>> On Tue, Jun 15, 2010 at 4:56 PM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
> wrote:
>>> This patch adds the missing const to "struct platform_device_id" to f=
ix
>>> this warning:
>>>
>>> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.=
c:
>>> In function 'i2c_pxa_probe':
>>> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.=
c:1004:
>>> warning: initialization discards qualifiers from pointer target type
>>>
>>> Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Ack
>=20
> ok, will apply.

tnx

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBF1189466C98D0CCA33286D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwfDR4ACgkQjTAFq1RaXHMXgACbBE0lyJzScDj/Pskwl3geCZIY
E04An0BJVQS6rcLvfHLbQeN4CsajAWLV
=7+V2
-----END PGP SIGNATURE-----

--------------enigBF1189466C98D0CCA33286D5--
