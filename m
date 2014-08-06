From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2] i2c: i2c-imx: Fix format warning for dev_dbg
Date: Wed, 6 Aug 2014 21:00:55 +0200
Message-ID: <20140806190055.GB2736@katana>
References: <1407296708-12563-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407296708-12563-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 11:45:08AM +0800, Xiubo Li wrote:
> drivers/i2c/busses/i2c-imx.c: In function i2c_imx_probe()
> drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 4 has type resource_size_t [-Wformat=
=3D]
>   dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
>   ^
> drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 5 has type resource_size_t [-Wformat=
=3D]
>=20
> drivers/i2c/busses/i2c-imx.c:691:2: warning: format %d expects argument
> of type int, but argument 4 has type resource_size_t [-Wformat=3D]
>   dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
>   ^
> drivers/i2c/busses/i2c-imx.c:691:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 5 has type resource_size_t [-Wformat=
=3D]
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-next, thanks!


--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4ntnAAoJEBQN5MwUoCm23wkQAJErVwJNW/t1+Yar1qmkhh78
SEsqGSdnz9nsmxEjfqDhhN9rtvSGQnbd2ZeGbvbMK0UYf+KtMrMf9KlmPZYzMcVA
GwUNDDGHjNGQ6aFzeRMDEzJ/qgLCU/Xz2JEvdcLeXD/2TXA06LXpz/HbzUuGOGkA
rO1U7GY7IPvd3D/BMBU1lkKarGWcHwU/oFGIJ5AvdHJg8PC6bZqrleG6Oqbz0F2f
xny3q4Onog8esSWXj+JrYKUMiImWMYqbtl3vsOFWXJl/xghkuuKDgDHl7CtBa2Bg
8J2/jmEodfsZoSs0VINCqdyj0KYp9FaEvZn7FjKBCMYqdB7aRt52jnLx7bQSMYHf
Al4ZDqLL+I5urd/WCJzP+P5+tOUwv8mbnrw+nYQjL8vn9mHEsfwQ+QXJLsc76i+G
idQCx1YIAowINE2GTv06OlIPLlp+2vCuC7KJZRLdgfxz7w99LAjAdZCRGkotACHG
GVi3D4EY9G+V1c9uzHD358FKjB3e5QGBef1VEgpBufX0GvhrMEijrSadC7pjz1Xi
IsfCsnqAdzbcyXzRbcziiVUstbI07myc01RQh0oVnr8StKYe+kO9ovvbJVkh6IiI
K7j55tAT/qOc9i8UIP7n0zB/V3VGv9QtFahLk2LJYde0mCRfbJY0aD7kUhlmS2kx
ddUEAOVb+AqPX8HoBQ14
=JUOy
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
