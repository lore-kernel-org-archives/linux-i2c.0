From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Thu, 22 Aug 2013 11:06:47 +0200
Message-ID: <20130822090647.GA3491@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
 <20130821210116.GA3130@katana>
 <5215C07D.7040000@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5215C07D.7040000-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> @@ -326,6 +463,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *dr=
v_data)
> >>  			drv_data->reg_base + drv_data->reg_offsets.control);
> >>  		break;
> >> =20
> >> +	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
> >> +		if (mv64xxx_i2c_offload_msg(drv_data) <=3D 0)
> >=20
> > needs to be adjusted when using -EINVAL above. I'd prefer the error case
> > in the else branch, though. Easier to read.
> >=20
>=20
> OK, but in this case ...
>=20
> >> +			break;
> >> +		else
> >> +			drv_data->action =3D MV64XXX_I2C_ACTION_SEND_START;
> >> +		/* FALLTHRU */
>=20
> ... the fall through here is less readable. But it is a matter of
> taste, I will change this.

Ah, I see. Well, try both and decide.

Thanks!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFdSnAAoJEBQN5MwUoCm2wBMP/AvIdvuvwaAqnXMOm8TZP3Br
G0T2Rj1KNUsT3A9o4s085UvOyM7Po91bk4r7olEaSnH9ncbErYyzR/q6dUgdkoiL
WR11iLLOhh/uAHw3nfsl64AO0kIKUmXQbP6rPz71ig7g1rs5/Qx5jpdyrVaCowER
+zDSRlgYP9dcFEgriG9dV7e+u3l0DMyPc6f/oqvWb+hBb96KYe2Y0Km6lwrlG0bn
3h4vEFeVsg0lOqn2wRX1RAOxIoq5/K+j+p7OK4WKsXnQQBICPZHBuPEjjYSAvAsY
MIZhtpS14er2h5RjsC6ybO9sk/wlQn8nmdn13jgD478HeTqSR2FxAoEwnfpxeMvP
Rs8FClwTozxThNpb0sqDfALvrouYJXvf6KLe2TJtgff+TtxM+hhJwzu+3BluACQO
tqlO4sB5F2IdZ/UllGGs0pKpML+Asi5csVclZBknpeGTIbiSRMfc3WErW11tTaHi
tYrgqOFedcLlOrqe1wGHnX6NXSKrh1U2G/mnMJDWvy7l657mhzeuRbEsgQ+qQCHi
NXIyPXV+y2yxQCwrWWkfw/wG7T3K8qVsN8rMmV5muqerhIvwRs+tpBREfFJSSzlF
25+aAdgjRyiXuQEqC3LmfP5nkzeVtcXk/2M/u28DCTEVXtuXvGQpL9PZ4+Gznb+U
hTEARDLG6UIhxty8mBT4
=zN4p
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
