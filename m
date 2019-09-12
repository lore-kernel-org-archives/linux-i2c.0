From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V2 05/13] clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
Date: Thu, 12 Sep 2019 11:52:49 -0700
Message-ID: <87o8zp1h4u.fsf@anholt.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-6-git-send-email-wahrenst@gmx.net>
 <d89bbc4b-b6bc-0d4e-86d1-6be11876ce00@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4451920714567277653=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d89bbc4b-b6bc-0d4e-86d1-6be11876ce00@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

--===============4451920714567277653==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matthias Brugger <matthias.bgg@gmail.com> writes:

> On 13/08/2019 18:20, Stefan Wahren wrote:
>> The new BCM2711 supports an additional clock for the emmc2 block.
>> So add a new compatible and register this clock only for BCM2711.
>>=20
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>> Acked-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/clk/bcm/clk-bcm2835.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835=
.c
>> index 21cd952..fdf672a 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -114,6 +114,8 @@
>>  #define CM_AVEODIV		0x1bc
>>  #define CM_EMMCCTL		0x1c0
>>  #define CM_EMMCDIV		0x1c4
>> +#define CM_EMMC2CTL		0x1d0
>> +#define CM_EMMC2DIV		0x1d4
>>=20
>>  /* General bits for the CM_*CTL regs */
>>  # define CM_ENABLE			BIT(4)
>> @@ -290,7 +292,8 @@
>>  #define BCM2835_MAX_FB_RATE	1750000000u
>>=20
>>  #define SOC_BCM2835		BIT(0)
>> -#define SOC_ALL			(SOC_BCM2835)
>> +#define SOC_BCM2711		BIT(1)
>> +#define SOC_ALL			(SOC_BCM2835 | SOC_BCM2711)
>>=20
>>  /*
>>   * Names of clocks used within the driver that need to be replaced
>> @@ -2003,6 +2006,16 @@ static const struct bcm2835_clk_desc clk_desc_arr=
ay[] =3D {
>>  		.frac_bits =3D 8,
>>  		.tcnt_mux =3D 39),
>>=20
>> +	/* EMMC2 clock (only available for BCM2711) */
>> +	[BCM2711_CLOCK_EMMC2]	=3D REGISTER_PER_CLK(
>> +		SOC_BCM2711,
>> +		.name =3D "emmc2",
>> +		.ctl_reg =3D CM_EMMC2CTL,
>> +		.div_reg =3D CM_EMMC2DIV,
>> +		.int_bits =3D 4,
>> +		.frac_bits =3D 8,
>> +		.tcnt_mux =3D 42),
>> +
>>  	/* General purpose (GPIO) clocks */
>>  	[BCM2835_CLOCK_GP0]	=3D REGISTER_PER_CLK(
>>  		SOC_ALL,
>> @@ -2238,8 +2251,13 @@ static const struct cprman_plat_data cprman_bcm28=
35_plat_data =3D {
>>  	.soc =3D SOC_BCM2835,
>>  };
>>=20
>> +static const struct cprman_plat_data cprman_bcm2711_plat_data =3D {
>> +	.soc =3D SOC_BCM2711,
>> +};
>> +
>>  static const struct of_device_id bcm2835_clk_of_match[] =3D {
>>  	{ .compatible =3D "brcm,bcm2835-cprman", .data =3D &cprman_bcm2835_pla=
t_data },
>> +	{ .compatible =3D "brcm,bcm2711-cprman", .data =3D &cprman_bcm2711_pla=
t_data },
>
> Because the RPi4 FW uses bcm2838-cprman as compatible, we will need to ad=
d this
> here as well.

Upstream has not committed to backwards compat with Pi's firmware.  That
makes the ABI requirement we get held to for upstream's DT absurd, but
that's the state of things.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl16lAEACgkQtdYpNtH8
nuiquBAAqGE/S+glO2WG6bRp748JssNBNyGIYDyPnsgqZMjtxUBeyHT4VXejcHqE
cPsjlLNfppLDxUnHPoPvo7C/gUgcgSG+SyMubALDNdYyOIftGV5VSLK6d6LrhIGf
1yvohK4q5cn5S3I2E1xotOLOAvoZxdX7EA9EpMYrF8BttpkxfX62gftV3wgWf0Yk
3t1JkR9uZKwM623xJzrAom0MmkmuZDqPBmrQAuR4r4rftx4BAYuYIoRIJ6kiOS2w
Lfn9nQ1i8u2l3tBrwSnHTN6yhPsYg0+blqqRmI6MTheILyC1HLFzI7KA2iOfJ/Ea
zsnJ4QCbFbKQvsSVCsAYZRF4ulPtziMhkGNFLvLytSQYpmBGyf7gCTLI6Evca5rS
7CSaB/K1TL9p2DKE2yqZEkn5c0EYugXDXefyzN8HIQpHh4IUL+6DPiGWAUljXdU/
eyRYH5HUYgWON0yScodM/Laa9DI7xfK5RA4Ij0fOgcdCfj6S/NaT0HwVIGxLxabA
u0YMiuVr6q70mUIo0T6fPr7O8WPNCa0PYJkxLis+YshCPcUKNkSCVgq5eFMi8/Xy
7sdsgp31OkxCoqHAT4G87gtrnLkv7iQRFsz59dQe5YenbdCXLxh91BEvzP3Bn+Mj
LWtlPr6KVBlwfx0Tq+uf5xCJ13+sBRnGteamwsrbp/IvBdPH71o=
=qgc8
-----END PGP SIGNATURE-----
--=-=-=--


--===============4451920714567277653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4451920714567277653==--
