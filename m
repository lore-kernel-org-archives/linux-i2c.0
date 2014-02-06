From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] ARM: sun6i: Add support for the A31
 I2C controller
Date: Thu, 6 Feb 2014 10:55:44 +0100
Message-ID: <20140206095544.GF3192@lukather>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140127150312.GN3867@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLV2ZWLQKGQETE6KJSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140127150312.GN3867@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, duanmintao-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 04:03:12PM +0100, Maxime Ripard wrote:
> Hi Wolfram,
>=20
> On Mon, Jan 13, 2014 at 11:34:48AM +0100, Maxime Ripard wrote:
> > Hi everyone,
> >=20
> > This patchset adds support the A31 i2c controller. This is mostly the
> > same controller as the one found in the other Allwinner SoCs, except
> > for the interrupts acking.
> >=20
> > On the other SoCs using this driver, the interrupts are acked by
> > clearing the INT_FLAG bit in the control register, while on the A31,
> > the interrupt is acked by writing that bit into the control register.
> >=20
> > The other difference is that the I2C IP is maintained in reset by a
> > reset controller, so we're adding optionnal support for the reset
> > framework in the driver to deassert the device from reset.
>=20
> Do you have any comments on this?

Ping?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS81wfAAoJEBx+YmzsjxAg9yYP/Ren3nzzcPEDRBOrBa/cMaPj
y/19gJVWu3XSQBTjiz2FbA4eZ9e32ThzJP0s9uNoDCHGCEcvAU7bKwkEdawtTvhE
gUCJDmdtI6t3Qml8Ah7ebTmKMs/rud0EMPHXaYEXHXND17QLhNCQnKd3pHLS7VNw
GRHlu0zFv44K4O9KHbjl4oOGt4iDpUqqPHEfmIVc4qxQ3wSBfeG1I54M8Yrw+L0t
PIfX0lx9/QIY72Oiq/uKzMe1My4mPvNh82foVd2QdnIh52Ksv81hZUKM9K9Qz++8
V61jvnKSEJSe1hcD1eDsIyJkHatS+1XOXndek/UuqIUzCktiO12W2LEUYD0Fr6Or
j99aZj4n1ixPj7zrwzF+REYpVPle9IC0fMnjo+YaYq+mB2rL1gj3I6PbITMqRAGo
n4ywau7640DOxWCXX1FVh6AmVTW7DgGsvohWl1pbEVCRFaHVtWt0PqBO1Kej5HVF
64/AiTRnW1qa/Z5auRi0qpePaRIt9fykaPBaCacV7Me2PXXgYHH6g3MpL7t95szk
ZSgi1tuBe9dn0pZ8dJ1bJYQCtd3Hi89momm88rc+mH13r7xpdff0dJ4zKoEiUOBj
+JKqlsWlJYY13+16lhHtkeIL3hAcccOlwTP5Nr+tooJb3MXPUF6tCpu++suFt2Aj
FgUV03CSN++6A45NEOWi
=bCpR
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
