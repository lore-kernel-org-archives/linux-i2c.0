From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
Date: Fri, 27 Mar 2015 16:37:13 +0100
Message-ID: <20150327153713.GC27238@katana>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BL2FFO11FD05378650E02EA6549B4DF50E8030-xjCwUguQ55+9TOEzIYUSF2YJ4DzVTqeXkX/xN29GLwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 09:48:15PM +0530, Nava kishore Manne wrote:
> In slave monitor mode, the I2C interface is set up as a master and
> continues to attempt a transfer to a particular slave until the
> slave device responds with an ACK.
>=20
> Added this feature for zero length transfers enable the controller
> for slave monitor interrupt and get the status. Disable the slave
> monitor mode feature upon successful handling.
>=20
> Signed-off-by: Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Acked-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

I am not sure this is going to work.

How often is this access tried when there is no device? It should be
tried only once.

Those 0byte messages can be read or write, so transferring one bit, one
could say. I assume this one can only read? (which is not a show-stopper
but the cases should be handled)


--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXkpAAoJEBQN5MwUoCm2JqcQAJdzFIVvLi3lmfZDwTZcagLq
pFgwJX/MvzBwsqdnZnXClfKi2Vq5Ptaloe+23P3bu5od4Yj1i+XndWvrPOYLKAjR
uC/T6eUpJUHYkf0i+qRqBBV6kLH923ZavRoFfbugv4Q2wuFuwd4rMTj1uojCnWha
eDmvp3axryPyJOQVnUPO2Le2NydZX8IkdsmvqEyKyDXYk8MhxjtVG7JJBfbyfJLg
UTwo3a9+So42DgDro4UNSUC82RTyjajjyU8S32lKDSmZf+kklO5luMpwTt6eWfGG
udEUX852oM9KjwvHLaSx5+hAAP7EGEvbQrdL3pBp74+/jxrUfA3t+8UNpwtzeHoy
iNMBkf0M8eptnqe38ncs87UjLNCV1V9ZHZsq7+1Fu8rGuGWRtCUvQVAnTy6yuDNv
vRgQltfkPuo5C2/IqsvNgJM0qJWekMq1K8ru89bO1ZhvOD4b6/ywuUGSWHWwJT66
tno9d/SiOehOgHrMTCt3kvyeaorieXQeAmWFMYYk53oWbuTBWiRidSiMtSmznjDI
KPCHUSrg21CR6E9fEtvf4HzoVHtGq06TjVeaMoPE26m4ZFkAmN2/dbNYz6hDaG47
tu2qkijZIsn7VvKuy8XJYbdyQFICUyXiV8U4fJ8pWSf6JifyGgISs2Nbx7adrHMv
nUNQN808pRjdOGGpmtpr
=s65b
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
