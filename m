From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Date: Thu, 09 Aug 2018 14:06:43 +0200
Message-ID: <87k1ozzquk.fsf@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
        <20180709094304.8814-4-esben.haabendal@gmail.com>
        <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724075919.iyysd7dtbddvbavq@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 24 Jul 2018 09:59:19
 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 09, 2018 at 11:43:03AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Always update the stopped state when busy status have been checked.
>> This is identical to what was done before, with the exception of error
>> handling.
>> Without this change, some errors cause the stopped state to be left in
>> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
>> i2c_imx_xfer().
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> ---
>>  drivers/i2c/busses/i2c-imx.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index d86f152176a4..1db8e6790afc 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct =
*i2c_imx, int for_busy)
>>  			return -EAGAIN;
>>  		}
>>=20=20
>> -		if (for_busy && (temp & I2SR_IBB))
>> +		if (for_busy && (temp & I2SR_IBB)) {
>> +			i2c_imx->stopped =3D 0;
>>  			break;
>> -		if (!for_busy && !(temp & I2SR_IBB))
>> +		}
>> +		if (!for_busy && !(temp & I2SR_IBB)) {
>> +			i2c_imx->stopped =3D 1;
>>  			break;
>> +		}
>
> Would it make sense to assign to ->stopped independent of for_busy?

What do you mean?

Assigning to ->stopped on each check for I2SR_IBB in loop, independent
of the for_busy argument?  I don't think so.  The additional assignments
would be to the same value as it is set to already.

>>  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
>>  			dev_dbg(&i2c_imx->adapter.dev,
>>  				"<%s> I2C bus is busy\n", __func__);
>> @@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_=
imx)
>>  	result =3D i2c_imx_bus_busy(i2c_imx, 1);
>>  	if (result)
>>  		return result;
>> -	i2c_imx->stopped =3D 0;
>>=20=20
>>  	temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>>  	temp &=3D ~I2CR_DMAEN;
>> @@ -569,7 +572,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_=
imx)
>>=20=20
>>  	if (!i2c_imx->stopped) {
>>  		i2c_imx_bus_busy(i2c_imx, 0);
>> -		i2c_imx->stopped =3D 1;
>>  	}
>
> The braces can go away here.

Will do.

/Esben
