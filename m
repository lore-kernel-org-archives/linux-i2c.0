From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/9] i2c: xiic: Do not continue in case of errors in Rx
Date: Wed, 17 Jun 2015 13:42:00 +0200
Message-ID: <20150617114159.GA4604@schokonusskuchen.bad>
References: <1434381480-3042-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434381480-3042-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 15, 2015 at 08:47:52PM +0530, Shubhrajyoti Datta wrote:
> Handle error cases in the Rx path
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Your patch descriptions need improvement. They describe what you do,
but this can be seen in the patch as well. What you need to describe is
WHY you need this change. What was wrong before, what is better now.
Because this driver is long in use, we must be very careful about
regressions and every change needs a good reason.

So, please rework your patch descriptions.


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVgV0HAAoJEBQN5MwUoCm2woAP/3Nhb52FibECBZ3xyMEWrL0k
DXPBBvxQwp0K4a+pkRKDx3I75GfhNcdT4jXVMKQoFZVZVEX/RWKSny7SG7uFiJhj
zpvJEQwLGg4lAYtdywAnjWuqbVD/H0FuLx7oGjvzssKUxyfSkabYEhHNKYImjVeC
fYpXftg1/6FxEFOcfkqWpzuELVgw/aVE2ZEEGhrycBpGa65kbaS39esyUwAbaNPe
Pwk4KyRzqiyrCpuWWHOEVfbEHMIQnpdr2WHotU8kYJQrJWV6hAv+5ITNnrnlOeWB
R5KgfgTI/K7+Tfh97P41fLe+XTyPinQGqto04cyJiYaOXJIV88P0o/VDOFU/czh1
aJHq1OHpj2+mjdQE+jDBZbKgSnYOpS9f6f9AqH8NOjr6TRuY2ikcJl2HLJg6IXLx
5WSwbh/CU36OVFSU8DYw3s5maSpiUPdp8Bc+tCyfCl0ISrlw58d6ai6tkzBjnoNk
ZP20GPqGyaze73ivaowzG++0qaQZGAvcUGFxjKYuL/rF7p2KTWxMcYRcFlbSv10f
wcuE10HYkblJDIvV9PHEdEbUIb/CiGKibFhs5TdBfnTa4vnzn3SUUd0I9uArU2le
aZQImA7XWDjWwfCG6g7c3ch3FeoJ19JlauOsjU/dWYvPZsHSkwD+hDl+7l62aa8s
cmTIGjU/dUVUSX7dwQYG
=hkCr
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
