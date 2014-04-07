From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 07 Apr 2014 08:39:23 +0200
Message-ID: <5342481B.6020600@monstr.eu>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de> <20140407063100.GN29751@pengutronix.de>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L93OjK7B1IxhuOG0si4mMPQgpkOSI6HVB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407063100.GN29751-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L93OjK7B1IxhuOG0si4mMPQgpkOSI6HVB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 08:31 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
>> During development, the driver first really needed to depend on
>> COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
>> forgotten to update the dependencies, so build errors occured:
>>
>> config: make ARCH=3Di386 allyesconfig
>>
>> All error/warnings:
>>
>>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_h=
old':
>>>> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
>>>> of function 'writel_relaxed' [-Werror=3Dimplicit-function-declaratio=
n]
>>
>> Use a very safe dependency for now.
>>
>> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> ---
>>  drivers/i2c/busses/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 93165ff453ab..3d3b9b3577c5 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>> =20
>>  config I2C_CADENCE
>>  	tristate "Cadence I2C Controller"
>> -	depends on COMMON_CLK
>> +	depends on ARCH_ZYNQ
> I'd suggest:
>=20
> 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
>=20
> This way it's available for compile testing but still it doesn't appear=

> when configuring a kernel for a real machine.

I would suggest to add relaxed IO helper function to asm-generic/io.h
to be available for all archs. Then we can avoid this type of errors.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--L93OjK7B1IxhuOG0si4mMPQgpkOSI6HVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNCSBsACgkQykllyylKDCEArwCdG6ys0qbMSYMFi+QSDFSHUVPn
ZLsAn2VO4LwJNnB+ohXlH0M6Sr7kDXEU
=/yPH
-----END PGP SIGNATURE-----

--L93OjK7B1IxhuOG0si4mMPQgpkOSI6HVB--
