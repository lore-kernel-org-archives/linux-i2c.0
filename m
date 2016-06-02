From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
Date: Thu, 02 Jun 2016 11:02:32 -0700
Message-ID: <8760trbhaf.fsf@eliezer.anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net> <25336b03-76d1-2466-fbc0-9f363d3e7638@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25336b03-76d1-2466-fbc0-9f363d3e7638@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
> Am 02.06.2016 um 00:07 schrieb Eric Anholt:
>> The register at poweron contains 0x40, which at our typical 100khz bus
>> rate means .64ms instead of the desired 25ms.
>>
>> Fixes many clock stretching timeouts when talking to the DSI panel's
>> bridge chip, and will hopefully fix talking to the FXL6408 GPIO
>> expander on the Pi3 as well.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/i2c/busses/i2c-bcm2835.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-b=
cm2835.c
>> index 818b051d25e6..1348f224013d 100644
>> --- a/drivers/i2c/busses/i2c-bcm2835.c
>> +++ b/drivers/i2c/busses/i2c-bcm2835.c
>> @@ -28,6 +28,11 @@
>>  #define BCM2835_I2C_FIFO	0x10
>>  #define BCM2835_I2C_DIV		0x14
>>  #define BCM2835_I2C_DEL		0x18
>> +/*
>> + * 16-bit field for the number of SCL cycles to wait after rising SCL
>> + * before deciding the slave is not responding.  0 disables the
>> + * timeout detection.
>> + */
>>  #define BCM2835_I2C_CLKT	0x1c
>>=20=20
>>  #define BCM2835_I2C_C_READ	BIT(0)
>> @@ -238,6 +243,7 @@ static int bcm2835_i2c_probe(struct platform_device =
*pdev)
>>  	u32 bus_clk_rate, divider;
>>  	int ret;
>>  	struct i2c_adapter *adap;
>> +	u32 clkt;
>>=20=20
>>  	i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
>>  	if (!i2c_dev)
>> @@ -280,6 +286,15 @@ static int bcm2835_i2c_probe(struct platform_device=
 *pdev)
>>  	}
>>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
>>=20=20
>> +	/*
>> +	 * SMBUS says "Devices participating in a transfer will
>> +	 * timeout when any clock low exceeds the value of
>> +	 * T_TIMEOUT,MIN of 25 ms."
>> +	 */
>> +	clkt =3D DIV_ROUND_UP(25 * bus_clk_rate, 1000);
>> +	clkt =3D min(clkt, 0xffffu);
>> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, clkt);
>> +
>
> could we really assume that the clk rate never change after driver probin=
g?
>
> This also affects Gerd's patch [PATCH 28/32] i2c: bcm2835: Set up the
> rising/falling edge delays.

The I2C_DIV register setup you see in this hunk is what is producing the
SCL clock, so this code is in the right place.  If we need to add
switching of bus rates at runtime then we'd have to move all of it,
which would be a separate change.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUHS4AAoJELXWKTbR/J7ouKcP/1PBLhpaIngrYJJevKqJqPXE
Zv1JGL2a6el9hbdx/+CgIoPExWRtuRMYKBDix8ggtblnLGqVAVCuujO3TGF7xbIn
s0MGMG+Y68Ooz4En1C6y1/fF3By4Ufihxd6BjAh4qvKtKUwB8O87csYxCEcVIu1O
V5xTW/34lqhYW6rifNCyyi+VUFvWOaEzkwHoBZMzkZ0OAdjE48EtsY8DKT8Ptccp
UrAQSefJNZHRJPtfzsJbdlwgiXRg26wMn6a80KymZOp+jEp8+5SFO8V2QHqj9bNK
d6PLzQ7pPNQS27gEMYQw4VDzidtaamcpB2kwUTK7t7lCVdFrP5O5IgjbECCLOGdY
eBhFmXbPmYWR+tVELgLS0npkXBcAc5U5pSQldFIMf+Epy5GgA/Gcs+4X+mHDVNqD
E63hjA6zgDaHyP/NEFnX9w7mIai/Tr3KIdjj2+Fqf3w0mV56+ZUJRh4v9MtAkiIw
U+O9VpbZXunomhb3cfS6BJAlZs1KQlpbS35nLLn4z7qh3EmaW5x9amTReF/qFIDh
m/ysd3lZx4gXbJV16zt3vOkYDYvxcWuWFNELNUQZi5UuFxEluzKT04m9EZ+5WxKE
GoE6N01EWizzHp2ZvXkMowjtaRAo4U+r0rbfj5KDkyVn/g0yAFuKkQURholi5rmj
KepjvqdvQk5u1OxYqFbb
=yMdx
-----END PGP SIGNATURE-----
--=-=-=--
