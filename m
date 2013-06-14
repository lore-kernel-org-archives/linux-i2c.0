From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Date: Fri, 14 Jun 2013 16:07:20 +0200
Message-ID: <20130614140719.GC2929@katana>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371056017-8166-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> This patchset adds support for the I2C controller found on most of the
> Allwinner SoCs, especially the already supported A10 and A13, and the
> yet to come A31.
>=20
> This driver leverages the Marvel mv64xxx i2c controller driver, that has
> an almost identical logic, with a slightly different register layout.

\o/ Yay, that's more like it. Thanks for the rework!

> It has been tested on a A13-Olinuxino and an A10s-Olinuxino.

I'd love to get some Tested-by or other tags for Marvell hardware. Any
volunteers?

> Changes from v4:
>   * Don't expose the reg offset structure through the platform data

Commit message 2/9 still speaks about pdata, but I will fix this locally
if all goes well with this series.

I will wait a bit more for tags and then pick up patches 1-3. I assume
the rest goes via arm-soc, let me know if I should take them.

Regards,

   Wolfram


--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuyOXAAoJEBQN5MwUoCm2LrwP+gI7G71+5tjLgy8RPMThU0aO
P1Yl9uyHwu52KrSiBGvXmOJD1w/hH8LW2I46EDpqotoG8YxQjqLi2tHJKmhEHyb7
kp/8Y9TaL7UOOlgWRpD8OoAU1OFuNU0PQQ8RXxnN0+nStwd/3JMdmuvtNuhrE515
FHqJDy5NoYdETF0muoLldastiL8d2Fi7ydYOy++zBGZ5py6cJTuqFi6t6LKrGakj
0jCkNSKuD9xXoR0rjI4lpaXSU/hGNq44+D6Q4/Spmtc4epNg6R6nImWtAWZkM1tF
5z0lwn83twoIyIrw1s1VpdySftmR7lleiKonMrDiQtfMcLYuaUyDV/nJXXu42KL9
LVG2yyAjrmlWCPkU7U0y82pl4Cf0VhEm+T9N/NQebD39r5JK8PhSl4Tg59mHxL9P
D1HnNl/FP6Nr+fKRpT+YJbBQwVZ32ke1ojGwSZTx51Jy/wY8+dWfEFg6p5eDX2CL
yQi4+3AvjEe+we9GdObROpbbQ6V5aOnMGdMVNvDQDYwY/Z2CtCzbsR2tA01HpqN4
jh6dASBCvvEqLSk2rPNNvEPoCwu+WCnMn/4C7yW2fdk/zHdY+GB77wA4vyumGpZ6
Gr597yV5Fa1oRroAkVqZ3cM7pNEnXs1orlJ36mBsMAvUklvqr66gtS2aV4ezq8WC
djXhpSpyXvLzpKNT0BHq
=wbnX
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
