From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 1/7] i2c: i2c-mpc: add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Thu, 15 Aug 2013 14:07:42 +0200
Message-ID: <20130815120742.GA17155@katana>
References: <005501ce8102$faa66690$eff333b0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <005501ce8102$faa66690$eff333b0$@samsung.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 11:28:23AM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
>=20
> drivers/i2c/busses/i2c-mpc.c:724:12: warning: 'mpc_i2c_suspend' defined b=
ut not used [-Wunused-function]
> drivers/i2c/busses/i2c-mpc.c:734:12: warning: 'mpc_i2c_resume' defined bu=
t not used [-Wunused-function]
>=20
> Also, this patch makes mpc_i2c_pm_ops static, because mpc_i2c_pm_ops
> is not exported.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied the series to for-next, thanks!

Consider using --cover-letter next time for a series.


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDMSNAAoJEBQN5MwUoCm2P3YP/1AXel9bd6UNMOrpyzfWtNHK
1FFcWQ96pA/kzBF8GBk6tskgtxRLSV50WXftQjAJ1RcIIk3gjUeLY8tIomdgj4Zo
xpWBw+wC3vJYs5ERafl3YtLbdMq3EeB3jFV3J6CO3AAK9aop7h8bN0kKAYTOev8E
xfI8kQIzwDdbJ0NLnpjh/1Fh3NHM7ZB95u7U9DEJIaWVDO+DAhbm+OOPEDSLZk0y
dk6lGey3tIF14q8LwqCq+0Nq5xIJKdNmAS89ajKr1t4EOjL6R28GqGAy2ebLYCa1
bo6CyTpnL3h2Be/6OntDJPm2R1/RM1wHJM0c4+BthoViFE0NdunTQHem5VwPlsan
7do6olgQEQuAK5PecleYCfIf/8W9VK35LVwJHDBmdkb415SzuGBA/qzQpKh6E49K
MQGO4zbvL5OAH/HeFIofDqiNfs2bpj8QXFHLAzF+bjtZmlD4MORggDTx8Z8ygC/y
6lbGa52IBz2kgSkzYcvpTwuu6WmB/OORIa5Y7tBTawgalcm5hR1R/ambHqfPjkLS
SBdjUK1jjorv0mflyFhOeasGWWI4OwcBeEcCPp/NkocN+2COx2M0SeEbaKNPN4iC
upvZLn3b6JfuHzWbeqshNcWedvx+uHZPMw32XuibrViPsQ1Hd3fzYBo4FOs38EX8
YVjShg1VxXW0leVXjMn3
=GqQD
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
