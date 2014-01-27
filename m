From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] ARM: sun6i: Add support for the A31
 I2C controller
Date: Mon, 27 Jan 2014 16:03:12 +0100
Message-ID: <20140127150312.GN3867@lukather>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBIHLTGLQKGQEXO233DQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389609293-2824-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, duanmintao-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JvUS8mwutKMHKosv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Mon, Jan 13, 2014 at 11:34:48AM +0100, Maxime Ripard wrote:
> Hi everyone,
>=20
> This patchset adds support the A31 i2c controller. This is mostly the
> same controller as the one found in the other Allwinner SoCs, except
> for the interrupts acking.
>=20
> On the other SoCs using this driver, the interrupts are acked by
> clearing the INT_FLAG bit in the control register, while on the A31,
> the interrupt is acked by writing that bit into the control register.
>=20
> The other difference is that the I2C IP is maintained in reset by a
> reset controller, so we're adding optionnal support for the reset
> framework in the driver to deassert the device from reset.

Do you have any comments on this?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS5nUwAAoJEBx+YmzsjxAgGIYP/RHxCNpVg7r2Qy9UbOvLEvFu
gzkLldapzghjhrNfC/2FiCD/dIJ9EOLekfzTU8t3A1zxqfGZPx3WzfzJCcBpdVjR
SQpEiaukvrptBZygBC0fkXVA9dp59uUpVhSmvJmyIyAFXO00CUR+BwgO5ZiDnRin
mrrX8KwqGGyladk+uF4uIBLKxll8HYnKjX2h73uhZlWF9qmqRMjEa6vh6nCrMwSo
+Pb38clOCvCls2Nh7KFQUFdJi95InTgPSNcNYYlVaKznCy+oIyAiV6gHuHh753a8
+0aXpTFmJBIBMOAHbQ1F2rp8Gy7UKTvAczCaCs21Y2ZvUtMH3dRJNOH1GkyS9nvY
6TbgsgvXJR87huRAhexvhT6lAdW4J7NHizfnRV+se+4FwpjnFncj6uBKQ4597eW2
RrBcIDzTIEg724XznJv2SnhbffxHFK42D61kt/Mgc5nuEtUg8HJGDRIUEMQFxVlt
4TW5Q8Luj6g2xFdAmYPhwZSRMaxXRiqw3GsKBw7EDlsM5l8Lx/W7nz3djhrv+OUo
wELg+1M6kMWXYnmMrRtQA2rSnGC3Id8bQLiHAOwZydggzMEGpJqB+IEsr3/IGN2Y
fIjmF6ND2Wi7IPA4kWTFtD8IkzmD4D7bQ6GoZ0u6/rGEmc4Fdety8+En4npCZDAr
6PvWerTb3uPjvFAcWWF0
=a4a4
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--
