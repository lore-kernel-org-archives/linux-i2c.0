From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
Date: Mon, 30 Nov 2015 15:54:15 +0100
Message-ID: <20151130145415.GJ1513@katana>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <20151130135140.GD1513@katana>
Reply-To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Return-path: <linux-sunxi+bncBDP47C6LHEIJZRXRWICRUBG2I5FCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151130135140.GD1513@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 02:51:41PM +0100, Wolfram Sang wrote:
> On Sun, Sep 27, 2015 at 04:57:08PM +0200, Hans de Goede wrote:
> > According to the datasheets to n factor for dividing the tclk is
> > 2 to the power n on Allwinner=C2=A0SoCs, not 2 to the power n + 1 as it=
 is
> > on other mv64xxx implementations.
> >=20
> > I've contacted Allwinner about this and they have confirmed that the
> > datasheet is correct.
> >=20
> > This commit fixes the clk-divider calculations for Allwinner SoCs
> > accordingly.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> Applied to for-current, thanks!

And added stable...

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGMXAAoJEBQN5MwUoCm2bhMP/A3leER++nhh8bi7dPWejKNL
fFlB1lkFRV8Nfqw6Kc6QCnC+dQvl8EX8sGP7DTGfYcdZdnV0XfMoZ20uI90Xvnmc
6r+hGkYd0hVGFkr0wNBrACHY52rN/bIy7bldTSA1RTUy0PE/meyaCakPN7e8wInQ
mTCsR/CxbaAQmpwg58nNxAxJfDHSOZeXVIe2L1+ywH4uQ2ZeOTQ7EWTlwbs+Q8GR
Igo3D1ZeKBdp6MwYjtbJV4UpRfI9uupEH6Meq//tYK7NpcigFeBPAROQzL4iCZqz
vXh1gVT+D6iQOyfqyvZwGnqCkP/u4r2tn5WJrGZMVoMnN2f04uMRkojJ/rduC7ah
mYbMZ+ezeVnbRjMar1/XftybdLQzRKPlniKxl68K+5liqR3+fm/taq1YBdTCu9G1
F3TnPtfkpLObYwwfD7cMl7JH85lgGKmYu/JsYiigejCYZgZX0lsvXeQmhMsiLnhA
pRaWmmf5QkaeytXRHHfnOPmFUMYxmWylcW7jx/pdRIEGS1H67iGfn9RrYMXPA1c4
jGo+5zSsnt5XTSdAO99fwMiYuYyRmqGPIkcxw0Dylf6H8bWkrL0cPFSl44HZuxaZ
Mr3oDQQNVx1S9ydz/AOxeaA4u5DgRJNt6jaEEmupYW7y3sWqjWnTwwowUqNcfF+u
2oJE7poOTW8/zbPvpLc9
=ovaY
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--
