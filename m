From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH 1/7] i2c: core: Export I2C module alias
 information in dummy driver
Date: Wed, 26 Aug 2015 18:55:32 +0200
Message-ID: <20150826165532.GC1521@katana>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
 <1440484277-32675-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440484277-32675-2-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 08:31:11AM +0200, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<modalias>"
> regardless of the mechanism that was used to register the device
> (i.e: OF or board code) and the table that is used later to match
> the driver with the device (i.e: I2C id table or OF match table).
>=20
> So drivers needs to export the I2C id table and this be built into
> the module or udev won't have the necessary information to autoload
> the needed driver module when the device is added.
>=20
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

The dummy driver is always loaded when the i2c core inits.


--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3e+EAAoJEBQN5MwUoCm2Yz4QAIJR/FJy4bR6ayp9iARez3Em
YGfKKGbiIZafXJ2E2Vs5HIIcZ42T1KNGs+Iw53C1NdcDCwRtpTprSWYfACKhVJ+5
Ty66dmXkGgpT3C3rSBEbfn6lukUFC03/EVoHzSU7vbyCBk7cxvPnqXlNGgYIPZ1M
3Xc4efd/i40cvy87/PZI93Zo7ljj6I9FpBu/+feqoVNEwpGtL0Mb2MUcxZSGCnCB
X79GhFWWsEVWj+Py+0i4zFxkw2qDovnMycXAbArqLgHP5vZ4KyQbzBn6p8mO3ZZR
HGrEh5gzSMg8nd61Twuo5KYrjtt+K0mDAbJrxepN1tfQ8vx+rJv8e9y5pXknnQ+V
/OEh/cY4ORsKubg93tRxJlWF2W+9/826Wv+Ot0HTIPwAvZAU+vnWnMhyLnlr4D7i
wv2Td3PCfKiXunnfOnqJNQ4YKT/dV4Kd+4f+0F0knk2V0efxkxYOH6VAtvgg63CT
0X9k8rpXYFLBG26TVSnS2hkse4++Y1p3Krkwwn599XTNYVnhcjfD7DWz5oVLImhh
x+CpNu0RzlJ3t7/SYy6/cF/orB1EuNd36PRBHIBZUYBbVShLje2z2ac5zhUJJoDQ
P/2XB9gxhFCbM5siL8IcezJTjhwrCbuEZXmr+PxJoLeJFuYAQxmRQLaw+xAKoSvD
T5JiG99XOYu2KKtGtEqX
=CTjB
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
