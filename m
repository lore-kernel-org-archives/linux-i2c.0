From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rcar: fixup section mismatch on
 rcar_i2c_probe/remove()
Date: Tue, 13 Nov 2012 11:23:56 +0100
Message-ID: <20121113102356.GD23119@pengutronix.de>
References: <871uk04aa2.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2ctETiVdyKBd_MxY2Ts=1XMPa_cdEJRkQpEySL6du9oLmw@mail.gmail.com>
 <878vczd1hw.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cs5pFpVjqa_MFCLTFqdCo6SSm-1Ep=WtJ7fpABzWEGD9w@mail.gmail.com>
 <20120828101259.409b410b@endymion.delvare>
 <874nnnct03.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cuGiNnduVa+nnNV_02dYwfrSJoFGesiFBm6Q5U3SGQXpQ@mail.gmail.com>
 <877gred4u1.wl%kuninori.morimoto.gx@renesas.com>
 <20121031062128.GA31555@verge.net.au>
 <877gq7m97r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877gq7m97r.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 11:44:44PM -0700, Kuninori Morimoto wrote:
> This patch fixup below WARNING

Yes, but you forgot to remove the __devexit_p reference from the driver
struct. Anyhow...

>=20
> make CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> ...
> WARNING: vmlinux.o(.data+0x11798): Section mismatch in reference from the=
 variable rcar_i2c_drv to the function .devinit.text:rcar_i2c_probe()
> The variable rcar_i2c_drv references
> the function __devinit rcar_i2c_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variabl=
e:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_conso=
le
>=20
> WARNING: vmlinux.o(.data+0x1179c): Section mismatch in reference from the=
 variable rcar_i2c_drv to the function .devexit.text:rcar_i2c_remove()
> The variable rcar_i2c_drv references
> the function __devexit rcar_i2c_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_conso=
le
  ^^^^^^^

=2E.. I like this solution better, renaming to driver. I did the patch
anyhow, so I'll post it in a minute.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCiH7wACgkQD27XaX1/VRv47wCgw+8WI6Gu17AKJYLTBBqHxSTj
UqUAoIEkAV7tDBOJp2YMVWr6/7ph28MM
=viaw
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
