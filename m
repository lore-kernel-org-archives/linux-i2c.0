From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [4/5] i2c: davinci: use bus recovery infrastructure
Date: Fri, 21 Nov 2014 21:33:22 +0200
Message-ID: <546F9382.40102@ti.com>
References: <1416477788-5544-5-git-send-email-grygorii.strashko@ti.com> <20141121190744.GB4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121190744.GB4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 11/21/2014 09:07 PM, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 20, 2014 at 12:03:07PM +0200, Grygorii Strashko wrote:
>> This patch converts Davinci I2C driver to use I2C bus recovery
>> infrastructure, introduced by commit 5f9296ba21b3 ("i2c: Add
>> bus recovery infrastructure").
>>
>> The i2c_bus_recovery_info is configured for Davinci I2C adapter
>> only in case if scl_pin is provided in Platform data at least.
> s/Platform/platform/
>=20
>>
>> Because the controller must be held in reset while doing so, the
> s/Because/As/
>=20
>> recovery routine must re-init the controller. Since this was already
>> being done after each call to i2c_recover_bus, move those calls into
>> the recovery_prepare/unprepare routines and as well.
>>
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-davinci.c | 76 ++++++++++++++++++----------=
------------
>>   1 file changed, 35 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i=
2c-davinci.c
>> index 2cef115..db2a2cd 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -133,43 +133,6 @@ static inline u16 davinci_i2c_read_reg(struct d=
avinci_i2c_dev *i2c_dev, int reg)
>>   	return readw_relaxed(i2c_dev->base + reg);
>>   }
>>  =20
>> -/* Generate a pulse on the i2c clock pin. */
>> -static void davinci_i2c_clock_pulse(unsigned int scl_pin)
>> -{
>> -	u16 i;
>> -
>> -	if (scl_pin) {
>> -		/* Send high and low on the SCL line */
>> -		for (i =3D 0; i < 9; i++) {
>> -			gpio_set_value(scl_pin, 0);
>> -			udelay(20);
>> -			gpio_set_value(scl_pin, 1);
>> -			udelay(20);
>> -		}
>> -	}
>> -}
>> -
>> -/* This routine does i2c bus recovery as specified in the
>> - * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
>> - */
>> -static void davinci_i2c_recover_bus(struct davinci_i2c_dev *dev)
>> -{
>> -	u32 flag =3D 0;
>> -	struct davinci_i2c_platform_data *pdata =3D dev->pdata;
>> -
>> -	dev_err(dev->dev, "initiating i2c bus recovery\n");
>> -	/* Send NACK to the slave */
>> -	flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> -	flag |=3D  DAVINCI_I2C_MDR_NACK;
>> -	/* write the data into mode register */
>> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> -	davinci_i2c_clock_pulse(pdata->scl_pin);
>> -	/* Send STOP */
>> -	flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> -	flag |=3D DAVINCI_I2C_MDR_STP;
>> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>> -}
>> -
>>   static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *=
i2c_dev,
>>   								int val)
>>   {
>> @@ -266,6 +229,33 @@ static int i2c_davinci_init(struct davinci_i2c_=
dev *dev)
>>   	return 0;
>>   }
>>  =20
>> +/* This routine does i2c bus recovery as specified in the
>> + * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
>> + */
> This comment is wrong. The actual bus clear is implemented by
> i2c_generic_gpio_recovery. Also while touching this comment, convert =
it
> to the usual format with /* on its own line. (The file in question ha=
s
> already both types of comment, so consistency is not a reason to keep=
 it
> as is.)

It has been just copy-pasted, but ok.
I'll change this comment as following:
/*=20
 * This routine does i2c bus recovery by using i2c_generic_gpio_recover=
y
 * which is provided by I2C Bus recovery infrastructure.
 */
Is it ok?

>=20
> Even though I remember that I reviewed this bus recovery patch (that
> resulted in 5f9296ba21b3) back then, I don't remember why it was spli=
t
> in prepare + recover + unprepare. But that is unrelated to this patch=
=2E
>=20
>> +static void davinci_i2c_prepare_recovery(struct i2c_adapter *adap)
>> +{
>> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
>> +
>> +	dev_err(dev->dev, "initiating i2c bus recovery\n");
>> +	/* Disable interrupts */
>> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, 0);
>> +
>> +	/* put I2C into reset */
>> +	davinci_i2c_reset_ctrl(dev, 0);
>> +}
>> +
>> +static void davinci_i2c_unprepare_recovery(struct i2c_adapter *adap=
)
>> +{
>> +	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
>> +
>> +	i2c_davinci_init(dev);
>> +}
>> +
>> +static struct i2c_bus_recovery_info davinci_i2c_gpio_recovery_info =
=3D {
> I'd call this only davinci_i2c_recovery_info.

No. Pls, see next patch.

>=20
>> +	.recover_bus =3D i2c_generic_gpio_recovery,
>> +	.prepare_recovery =3D davinci_i2c_prepare_recovery,
>> +	.unprepare_recovery =3D davinci_i2c_unprepare_recovery,
>> +};
> new line here please

:) Ok.
=46ixed in next patch.

>=20
>>   /*
>>    * Waiting for bus not busy
>>    */
>> @@ -286,8 +276,7 @@ static int i2c_davinci_wait_bus_not_busy(struct =
davinci_i2c_dev *dev,
>>   				return -ETIMEDOUT;
>>   			} else {
>>   				to_cnt =3D 0;
>> -				davinci_i2c_recover_bus(dev);
>> -				i2c_davinci_init(dev);
>> +				i2c_recover_bus(&dev->adapter);
>>   			}
>>   		}
>>   		if (allow_sleep)
>> @@ -376,8 +365,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, s=
truct i2c_msg *msg, int stop)
>>   						      dev->adapter.timeout);
>>   	if (r =3D=3D 0) {
>>   		dev_err(dev->dev, "controller timed out\n");
>> -		davinci_i2c_recover_bus(dev);
>> -		i2c_davinci_init(dev);
>> +		i2c_recover_bus(adap);
>>   		dev->buf_len =3D 0;
>>   		return -ETIMEDOUT;
>>   	}
>> @@ -717,6 +705,12 @@ static int davinci_i2c_probe(struct platform_de=
vice *pdev)
>>   	adap->timeout =3D DAVINCI_I2C_TIMEOUT;
>>   	adap->dev.of_node =3D pdev->dev.of_node;
>>  =20
>> +	if (dev->pdata->scl_pin) {
>> +		adap->bus_recovery_info =3D &davinci_i2c_gpio_recovery_info;
>> +		adap->bus_recovery_info->scl_gpio =3D dev->pdata->scl_pin;
>> +		adap->bus_recovery_info->sda_gpio =3D dev->pdata->sda_pin;
>> +	}
>> +
>>   	adap->nr =3D pdev->id;
>>   	r =3D i2c_add_numbered_adapter(adap);
>>   	if (r) {
> Just another general comment about the driver that doesn't influence =
the
> correctness of this patch: The i2c-davinci driver is quite quick to
> reset the bus. I wonder how often this reset triggers. Is the bus in
> question less "stable" than others?

In comparison to ..? :)

regards,
-grygorii
