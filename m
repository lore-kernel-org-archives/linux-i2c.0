From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: recovery: change input parameter to
 i2c_adapter for prepare/unprepare_recovery
Date: Fri, 13 Mar 2015 10:45:39 -0500
Message-ID: <20150313154539.GF5615@saruman.tx.rr.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
 <55017943.6040603@nokia.com>
 <5502B8DA.70504@linaro.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5502B8DA.70504-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 13, 2015 at 12:15:54PM +0200, Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrot=
e:
> Hi Wolfram,
>=20
> On 03/12/2015 01:32 PM, Alexander Sverdlin wrote:
> > On 01/12/14 16:34, Grygorii Strashko wrote:
> >> This patch changes type of input parameter for .prepare/unprepare_reco=
very()
> >> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
> >> This allows to simplify implementation of these callbacks and avoid
> >> type conversations from i2c_bus_recovery_info to i2c_adapter.
> >> The i2c_bus_recovery_info can be simply retrieved from struct i2c_adap=
ter
> >> which contains pointer on it.
> >>
> >> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> >> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> >> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> >> ---
> >>   drivers/i2c/i2c-core.c | 4 ++--
> >>   include/linux/i2c.h    | 4 ++--
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> index 2f90ac6..72b6e34 100644
> >> --- a/drivers/i2c/i2c-core.c
> >> +++ b/drivers/i2c/i2c-core.c
> >> @@ -563,7 +563,7 @@ static int i2c_generic_recovery(struct i2c_adapter=
 *adap)
> >>   	int i =3D 0, val =3D 1, ret =3D 0;
> >>  =20
> >>   	if (bri->prepare_recovery)
> >> -		bri->prepare_recovery(bri);
> >> +		bri->prepare_recovery(adap);
> >>  =20
> >>   	/*
> >>   	 * By this time SCL is high, as we need to give 9 falling-rising ed=
ges
> >> @@ -588,7 +588,7 @@ static int i2c_generic_recovery(struct i2c_adapter=
 *adap)
> >>   	}
> >>  =20
> >>   	if (bri->unprepare_recovery)
> >> -		bri->unprepare_recovery(bri);
> >> +		bri->unprepare_recovery(adap);
> >>  =20
> >>   	return ret;
> >>   }
> >> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> >> index b556e0a..cf9380f 100644
> >> --- a/include/linux/i2c.h
> >> +++ b/include/linux/i2c.h
> >> @@ -404,8 +404,8 @@ struct i2c_bus_recovery_info {
> >>   	void (*set_scl)(struct i2c_adapter *, int val);
> >>   	int (*get_sda)(struct i2c_adapter *);
> >>  =20
> >> -	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
> >> -	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
> >> +	void (*prepare_recovery)(struct i2c_adapter *);
> >> +	void (*unprepare_recovery)(struct i2c_adapter *);
> >>  =20
> >>   	/* gpio recovery */
> >>   	int scl_gpio;
> >>
> >=20
> > Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> >=20
>=20
> Could I ask you to consider this patch for 4.1?
> Now my I2C Davinci series is based on it and probably I2C OMAP changes
> will need to be based on it too - if Felipe would agree with this of cour=
se.

I can easily fix my i2c-omap series for this, but I need confirmation
that this is what's going to get merged.

--=20
balbi

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAwYjAAoJEIaOsuA1yqREYQUP/1tYY7DBiWLx+yDYjsZnyKH2
Ixo7VcRFqobiLrUY9IfoBO7R/6u1/HGLmHWYkeDCahsr4wn/HwP+YB93llIKL+xs
kom8nfClAIiZzS/nPhwZTDYn2nAGMKGwsqbj5U38eLUN7SgRDmsGtD6va/Lc7h1W
DoKYdd/K1C6G3rKnxW1TjZYofXurHGxsM6IhS5lfVLjlPYf1RZS0MENZF0TNB1I1
cqiuXsRrNNptwqC1y2x5gY6MliFHCWoF7BpKV9oB2Y5No3oW7ExwOQljQ22knSFc
fr18EHu3pD671L0sU//fnHo7ltiyd/gIbSn7qOSIo88whju83DTStF9vxE1OINBB
8mxehZKg1aMbuw8Xf0x04+L3Qic5IsOH1wdm8T4Or2I0IrwGm88NHHJPvoZlea0g
b4XWIyiVV0IDFeQeuolrRbl3x5sWRAbaoV7RAVilpzUNalkB57l8Dl5h0EwrkFbZ
dXHiuLvr8Dyu5PAF0kuhAzIZp6cz7tFdQu3ES9YCiY+1PZ372/kP0DwYz1GMTLe6
TjwTem/axjDzm+VtBSt7eA3P7b9GrHirZK1h1TiThiKByAC/uxmNC4OMOOKRk+3T
STuYv6LQGT4e0rxwHQ0YrdKKDzb/bv5a46nEXJG7QbwG5vhZscgWB0K3VnBum14n
qE0a7hJAK1mmv08GKGWn
=bFlQ
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
