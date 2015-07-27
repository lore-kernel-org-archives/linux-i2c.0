From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/8] i2c: img-scb: enable fencing for all versions of the
 ip
Date: Mon, 27 Jul 2015 21:20:55 +0100
Message-ID: <20150727202055.GG18890@jhogan-linux.le.imgtec.org>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
 <1437997641-32575-2-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437997641-32575-2-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--NPukt5Otb9an/u20
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sifan,

On Mon, Jul 27, 2015 at 12:47:14PM +0100, Sifan Naeem wrote:
> The code to read from the master read fifo, and write to the master
> write fifo, checks a bit in an SCB register before every byte to
> ensure that the fifo is not full (write fifo) or empty (read fifo).
> Due to clock domain crossing inside the SCB block the updated value
> of this bit is only visible after 2 cycles.
>=20
> The scb_wr_rd_fence() function does 2 dummy writes (to the read-only
> revision register), and it's called before reading from or writing to the
> fifos to ensure that subsequent reads of the fifo status bits do not read
> stale values.
>=20
> As the 2 dummy writes are required in all versions of the ip, the version
> check is dropped.

Is it anticipated that a future version of the hardware will probably
resolve the clock domain crossing issue? If so fine, but if not its
probably worth removing need_wr_rd_fence.

>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver=
")

I believe 12 digits of SHA1 is recommended now, to avoid collisions. I
suggest doing this:
$ git config --global core.abbrev 12

> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>

That's a fairly non-conventional way to specify stable versions. The
recommended way to Cc stable according to
Documentation/stable_kernel_rules.txt is more like this:
Cc: <stable@vger.kernel.org> # 3.19.x-

Patch looks fine though

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  drivers/i2c/busses/i2c-img-scb.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index 00ffd66..5c3c615 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -278,8 +278,6 @@
>  #define ISR_COMPLETE(err)	(ISR_COMPLETE_M | (ISR_STATUS_M & (err)))
>  #define ISR_FATAL(err)		(ISR_COMPLETE(err) | ISR_FATAL_M)
> =20
> -#define REL_SOC_IP_SCB_2_2_1	0x00020201
> -
>  enum img_i2c_mode {
>  	MODE_INACTIVE,
>  	MODE_RAW,
> @@ -1120,10 +1118,8 @@ static int img_i2c_init(struct img_i2c *i2c)
>  		return -EINVAL;
>  	}
> =20
> -	if (rev =3D=3D REL_SOC_IP_SCB_2_2_1) {
> -		i2c->need_wr_rd_fence =3D true;
> -		dev_info(i2c->adap.dev.parent, "fence quirk enabled");
> -	}
> +	/* Fencing enabled by default. */
> +	i2c->need_wr_rd_fence =3D true;
> =20
>  	bitrate_khz =3D i2c->bitrate / 1000;
>  	clk_khz =3D clk_get_rate(i2c->scb_clk) / 1000;
> --=20
> 1.7.9.5
>=20

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVtpKnAAoJEGwLaZPeOHZ6z6oP/21vZPaNNmagnX2BhPz/Kd/3
oJzkIwor0sXo4LkV+yPGVZcFz+g/L7I2WsqlWIJpp1nNQ5LI1XN7yImRTBbPfIce
LGzn41yPqfOqAjrXofWiCct7M28g9Q4bhbT3pGMm+/XTC2asf5zqzusFl1wO77Qv
rMC4TDFDFp+BMh2z19B7Fp53TqgFaG1+mL48CEhFMzHUYAY4Ou6XBzKeu5pquj+h
s35R7G1CDjD3dmN0QHwHFwk+OBO/ptosRTSYsbOOTK/whcH0Yrc+Fk/U72cyHFLv
Q6sEvoFSN6uIsOR2OP8khg9zahhhA9bIroiyZ1On3ATnDs4AMEq30CIxIL/mrt8U
vxLCF0RUK/NgrVJojjrcI3BJkVZ2cArsaZz3YkpgmzoJih9M3ak2QuzjJm8i1xUN
/Sc8Z9GNE62ujRWzADbfq50PHnms2FHARFE7oba0yMYlfOMuJXo5bfk4T0AgDMsP
9007oiC0grTfZ8FyuWmm0h1vKLJAGfysfx1t0W67+uvFQcEbkBSu97rNZttd++M3
s63jJdaPS2hGCjfDruXUkuUfrgGbioM3o1etnMi2b/2RGqudad0r0UmG70nPdGJQ
p/0gKDVFd3ThuYSoWCVUxCJaSDfw6RkBA4HWerNtBzbUErj/2BqPm2UD7hsGaK8V
DSlzQjZAFiX40lSeLXtU
=sXpV
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
