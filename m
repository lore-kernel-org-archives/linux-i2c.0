From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] ARM: sun6i: Add support for the A31
 I2C controller
Date: Mon, 17 Feb 2014 14:37:55 +0100
Message-ID: <20140217133755.GA3119@lukather>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBP5IRCMAKGQESAGALYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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


--gKMricLos+KVdGMg
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

It's been over a month now, and no sign of life from you on this patch
so far... Should I just take this patchset through my tree? :)

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTAhCzAAoJEBx+YmzsjxAgRe8P/1z2EWxfpxqpPZdM1URcHdG1
qrnd3rhiIQhOHodWM7kxedwOeWKYrxgh2MGSB9ZQGMNC0OoCbe5CpKuYd6zSyHzl
ggGHZfTPqWZdXKFzBHaHRoKadei/vqnpQ4ZvG69ISJ6nezPg9xKfUhQW1vACdox3
mk/6NegDz+40+aZFZI8STuafDugfpsh2ZpzHoqgKYX7kt4xPvAXV8cCScF04GCcU
FMIjo3J85zUl0lKWnrQX4wpIM9xxbKtyQd8+u1evK2AMo5JjdoTHOAe2qNaqCcvP
2BxRS1KInNf/oaDU3m5xDofiPlsS9pMUExuS8GHsz4O1Wm8O378i8BOVimWOJxXC
YwZ0EahZXPRWVC6Mcop8F8/7sbJKzytJc9DWNadcpNE76OxiOnxxl4hX9s1txgyO
SKGHl9NKBhaWP0eVY3u1u2sSwmKqJQXYTl3iF9gZ7xvQLH0T4vTfYZw9doT9ILAT
OYfbTVQwSjYSF8KDidwjADlTy0GVtk2RFj4AqK3mP58fyf4i230uR00I3F+yjvqW
PUggqcxqTdqdsW8sEHFThrogJ3sU9A/uflOZEF741gpSYmiZ/gSYfsIRuLfEbNV0
IgrZTx7dcLqM4huj4ixxB6nuE2ii4ANpUHdgfNxTz8fNme0kdfP+mbxw7lH9uxNF
y3kFBnuBJpI4bj8hf4Tq
=/1n2
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
