From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 8/8] i2c: img-scb: verify support for requested bit rate
Date: Wed, 29 Jul 2015 13:02:01 +0100
Message-ID: <55B8C0B9.1070108@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-9-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ilWHSTI11Manu76D6EhhKv3gOetbcHTPw"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-9-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--ilWHSTI11Manu76D6EhhKv3gOetbcHTPw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:47, Sifan Naeem wrote:
> The requested bit rate can be outside the range supported by the driver=
=2E
> The maximum bit rate this driver supports at the moment is 400Khz.
>=20
> Return -EINVAL if the bit rate is larger than 400khz.
>=20
> Maximum speed supported by the driver can be increased to 1Mhz by
> adding support for "fast plus mode" in the future.
>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index bbfee33..07a039c 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1157,6 +1157,12 @@ static int img_i2c_init(struct img_i2c *i2c)
>  			break;
>  		}
>  	}
> +	if (i2c->bitrate > timing.max_bitrate) {
> +		dev_err(i2c->adap.dev.parent,
> +			"requested bitrate (%d) is higher than the max bitrate supported (%=
d)\n",
> +			 i2c->bitrate, timing.max_bitrate);
> +		return -EINVAL;
> +	}

The timing is only chosen if i2c->bitrate <=3D timing.max_bitrate, so
you'd only hit this case if none of the timings were valid, in which
case timing =3D=3D timings[0], so when you print timing.max_bitrate it wo=
n't
be the max bitrate supported, it'll be the max bitrate of the first
timing in the array.

Anyway, I think the original intent of the DT provided clock-frequency
was more as a maximum bitrate. This was used with TZ1090 as a way to
limit the bitrate of the bus if some devices on the bus don't support
the full speed, e.g. we had an HDMI chip that would get confused at 400kh=
z.

So would it be acceptable to change it to just clamp the bitrate to the
maximum rate supported, before the bitrate_khz calculation, such that if
you specified 1MHz in DT, it could safely fall back to 400KHz until the
driver supports the faster mode?

Cheers
James

> =20
>  	/* Find the prescale that would give us that inc (approx delay =3D 0)=
 */
>  	prescale =3D SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
>=20


--ilWHSTI11Manu76D6EhhKv3gOetbcHTPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuMC5AAoJEGwLaZPeOHZ6tLoP/j1XockqwwxufB2t8mC3XIpu
fpeZed3RDuIPNZTF7RSF1kuqh1BM5bHs+QKFyNKgGI5IMRvi/8b6MybhiAL0beUa
E4bJbygeoOIIDkWUVLUB9se3S1LhcgMxVVS/6eOLPIg7s+CryCUADoPDxbIdBSzP
LTIpUkzJ9OPjwYT9x1R7ByM1iBPqwxQ4bRIblv2cd0DiqT/5mWa8jFBX4gP4sTc5
xTW2hAl4zk526vtcH/ieruaaagJ3KpREtWR2wi06X/5PYQfdvp4g9p/dZ2yaF399
roWOp8RH0dm8c/JgmSSFFTazBxE0RYRtF8lgmzVNQFzZK+psQVLink4ahOgoHkyc
PNqel36XM1a0wwcIfWnFIwsRab/pyRYWfVr56IroxuNa0V6VLvNs66xe/j4ELzgy
piBmM+v4ws972cm+ojfq0EA4T0YFdlaeAI+QFNao2MgvpD3EZ9FDe6gYyUlPPAGj
HwKRryNJeiAY7gEs9KD53hAtG1VuvydNSUe3fUvdj8pzw7kASfXZlHoRQ7aIwtAq
yIhvK5fVXdMrktE/dBuZSc2GaSJgV5ywe7f8dpkz7Jp9y7TbBKp6TAMGdwOY8wcL
1TzxNnsLloPtMUFSXqtzL27ewZ+yICYHI2+3lgD9QnZAeMAFKEsYhH4rKnoXl3oJ
FiVCtYrQYb5+Py2NMEEd
=J7nA
-----END PGP SIGNATURE-----

--ilWHSTI11Manu76D6EhhKv3gOetbcHTPw--
