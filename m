From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: Silence compiler warning
Date: Mon, 24 Feb 2014 10:14:52 +0100
Message-ID: <20140224091452.GC2617@katana>
References: <1393173726-29479-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393173726-29479-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2014 at 05:42:06PM +0100, Ulf Hansson wrote:
> Commit "i2c: nomadik: Fixup deployment of runtime PM" introduced a
> compiler warning for !CONFIG_PM. Let's fix it here.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>=20
> Wolfram, currently one of the queued patches for i2c nomadik introduced a
> compiler warning. I decided to add a fixup patch on top of these instead =
of
> you dropping them and me resending new versions of the already applied pa=
tches.
>=20
> If you think it's better to drop the queued patches and to resend new ver=
ions,
> please tell me.

I'll fold it into the causing patch since I haven't pushed out yet. I
was waiting for Linus response to the bus speed question.


--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCw2MAAoJEBQN5MwUoCm2r+8P+wY099CiQQv0QnS+gCUtZ8Yq
vRDt2qIra+9nmJz5VYj0G7puiwX2aOoBxejiPl+mxwoKzKaEXgsLOTQHyXJPsxY/
h2YOyXzm6R0D6YABrUTFl3nnhZFRmVnc2Ymh02FQbUVRoFjAxee2MXonEofZ9b3e
LdfGShoCT7zrt1cbVliKf+FlRpOZ7I5fzjYKPfLgGnu5/5stgoe5KgLR2xmNnd/X
aVyA2dlmZ3ZE3Qb13YbqUbWnAncQ+z3Q5iEq+l6inGVtByXrx1UEPVaDlaLZvQI2
N8/okg1Fs8MQryx4vVmkR5FvzKXnR5XyCVm/yUxjDKzle7VrBgrNaAwD7+Ih/MOf
rSVACQzGXYpbhvND1ndCgN3ecv+6lMEjEPZSp/oDI6eZY/7Fck3I3vEgQNBCb6Us
Bt3wY6FhjjRYqiW+wd3CMRNm9I1YmqsgtUV2BaLjsPdsVsiBXczjBLA9UdIo33ep
Ya/UUu4pnbjlI1V0NEsmxrYrJ1LJy7lvKoo72KpEVSGHjKoAsDgbAmr6698yqr+0
VDgIETvrelm/WtoJ/QTvBUUtieYYpdy37BVAoiAeSQdtITiuKpD29be+tZbpSc+k
Enz6hmB7lsbWEhcS7dbPGgd0JPFYjDtRLhnYv2Dip/zxeFLeWADE5BPJv4sF6NPb
NVeV78v8kTCoAlDZG6Fh
=ONTd
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
