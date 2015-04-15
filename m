From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: jz4780: Explicitly include linux/io.h
Date: Wed, 15 Apr 2015 20:57:58 +0200
Message-ID: <20150415185758.GA1125@katana>
References: <1429121291-28643-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429121291-28643-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 07:08:11PM +0100, Mark Brown wrote:
> This driver uses readw() and writew() which are declared in asm/io.h but
> does not explicitly include that header, causing build failures on
> architectures where there is not an implicit inclusion such as arm and
> arm64:
>=20
> ../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration of =
function 'readw' [-Werror=3Dimplicit-function-declaration]
> ../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration of =
function 'writew' [-Werror=3Dimplicit-function-declaration]
>=20
> Add an explicit inclusion to fix this.
>=20
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks, I just pushed the same fix from Guenter Roeck to -next.


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLrS2AAoJEBQN5MwUoCm29wYP/R5g2su67X7IZvkd/3Lc5z5g
jZqCKL5wgMCI2n15zTxc9lEMwVtVkCglyrA75WBE/WXF485UFtBzRGKPxY+WJkVN
Q0Ver3vtINm7A1c5PHLLj9mCT/J4A9bJkJ1qyNnEEkkgYSrKn9YbAR+TWNZBZmCX
X35OqFJyxwMcdJcXDc7oBtYDJKa9dcE/k9/8IVfsl+2+eFrE3rDIaS+KYglHN21z
+AGPf4ycSQN4S/NvQv5Bhy9mUo4yYI+V5aYajcOYotc2Q6YLaMog1UJbKmCSM0dx
dVNUama6oPE6Nyzo8fLetvgLfAKBM8eWkV5g6+CQvfSPs7pdX6iEu8jpj5HrFAUw
9SOVqx3etOXqLD4Dj267sZgxt6GG0n9FuSE6AUZHmR52fx+VtQdYLH2yEiRmAvPA
R1h1nBFHygyUkTaWDN4ljIQ8CDd6+l9tRO2MP2VF4FNDrSp8aIN3MlQhIMg2r5na
vVsUUId4PJ38om+1c6Knjk5qwYyOhSMyDbtUu2r5pjZHUWSCoJ05ohPNHz/QdsVk
bsXXcTrf5zJoE+kRR4V+Ye9War2VTky/3KBjUqLAjCaPxyx/TbZ6puOQUSSVaiEY
uHG0mpWuRqFh9w2mg17BwgIu8zlBa+RdP2ZmtyXLrblVpm82HFA70UWSfEbGeP07
70PHo3U7tt3BW4Z5tC1h
=g5tn
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
