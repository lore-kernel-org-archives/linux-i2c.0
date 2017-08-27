From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: davinci: Preserve return value of
 devm_clk_get
Date: Sun, 27 Aug 2017 15:34:54 +0200
Message-ID: <20170827133454.ffroiht5ayfqyr4k@ninjato>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4uejk634amjwm7z2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170816221715.15027-2-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4uejk634amjwm7z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 05:17:13PM -0500, Franklin S Cooper Jr wrote:
> The i2c driver can run into driver dependency issues if its loaded
> before a clock driver it depends on. Therefore, EPROBE_DEFER may be
> returned by devm_clk_get and should be returned in probe to allow the
> kernel to reprobe the driver at a later time. This patch allows the error
> value returned by devm_clk_get to be passed through and not overwritten.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!

Waiting for V3 of the other patches.


--4uejk634amjwm7z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmiyn4ACgkQFA3kzBSg
KbaVMxAAtL4EAdsFA6OykrTRUUhXG8q7XdppBNIAG2MNNVzAwnke3OXMdUwlMEXg
qM5VvzvBZa9/b+FeZLEjOw5f5TW67JbEWLt6+K9wuWovRnr4ESGECChgFSwKXgDZ
eQYODFbvDua10ayr4USrq1wRiBqXx8OhzFvnBTGKhB/p3dlT5o0FXMd8u5BJU49o
2+dwHBAiuu7YDgiNfyzvmDs2I/2+rPwc+vfIyNDeGO5dh9ckgRbwfSc3l9kokSkK
WXC6jroiRzzPIoExcqrlS6v4y+7kuPruWGNo6m4ff3qDc/FChUr8+NzslzeA//Ur
tLCKOA/zDcDvyIdwwzD/0ZypM3edKJXpibNnr/+ijaob/g8s94dcI9PhyhD5pV65
/Kbx7PHqBCoh5JwgVzklxipF8FJomgmApmdU0+EsMJ66iiXhsz49qkOt06n03AIB
c/DsYWFWxFtpo4ymuMshq8MNMLqm00ntGzvH9aWLw6hirS9AEZYceFUDU7Rlm39i
jigHtOPJlDmN3Rn9R3q3NwE5U5XVNaNW1fDHGGqJ0LqDYBOJbtY24iQycSizC2Ec
DiV7SPJhWtvAhbR2tsmiNC7HfC142Z60S9vUk0HK9kJxl8QKdqyALGRDw13M3xZq
rLQ2uKcg/+Jev9p/iARLgdzdM2CetgvA6uP84X13/+20kWYlabM=
=zCAb
-----END PGP SIGNATURE-----

--4uejk634amjwm7z2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
