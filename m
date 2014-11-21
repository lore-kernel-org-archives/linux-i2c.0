From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Fri, 21 Nov 2014 17:33:37 +0200
Message-ID: <546F5B51.1030006@ti.com>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com> <20141120221953.GI27002@pengutronix.de> <546F34B9.1000206@ti.com> <20141121131008.GQ27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141121131008.GQ27002@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 11/21/2014 03:10 PM, Uwe Kleine-K=F6nig wrote:
> On Fri, Nov 21, 2014 at 02:48:57PM +0200, Grygorii Strashko wrote:
>> On 11/21/2014 12:19 AM, Uwe Kleine-K=F6nig wrote:
>>>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses=
/i2c-davinci.c
>>>> index 9bbfb8f..2cef115 100644
>>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>>> +++ b/drivers/i2c/busses/i2c-davinci.c
>>>> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap=
, struct i2c_msg *msg, int stop)
>>>>    	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
>>>>    		if (msg->flags & I2C_M_IGNORE_NAK)
>>>>    			return msg->len;
>>>> -		if (stop) {
>>>> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>>> -			w |=3D DAVINCI_I2C_MDR_STP;
>>>> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>>>> -		}
>>>> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>>> +		w |=3D DAVINCI_I2C_MDR_STP;
>>>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>>> I think this is a good change, but I wonder if the handling of
>>> I2C_M_IGNORE_NAK is correct here. If the controller reports a NACK =
say
>>> for the 2nd byte of a 5-byte-message, the transfer supposed to
>>> continue, right? (Hmm, maybe the framework handle this and restarts=
 the
>>> transfer with I2C_M_NOSTART but the davinci driver doesn't seem to
>>> handle this flag?)
>>
>> Have nothing to say about handling of I2C_M_IGNORE_NAK. I'm not goin=
g to
>> change current behavior - davinci driver will interrupt transfer of =
i2c_msg always
>>   in case of NACK and start transfer of the next i2c_msg (if exist).
>> In my opinion, Above question is out of scope of this patch.
> Yeah right, that's exactly what I thought.
>=20
> Thinking again I wonder if with your change handling is correct when =
the
> sender wants to do a repeated start. That would need a more detailed
> look into the driver.

Davinci driver will always abort transfer with error -EREMOTEIO in case=
 if
NACK received from I2C slave device. And the next omap_i2c_xfer() call =
may
be *not* targeted to the same I2C slave device.
^ if !I2C_M_IGNORE_NAK

This discussion is absolutely similar to https://lkml.org/lkml/2013/7/1=
6/235
So, I'm just copy-pasting my answers from there ;)

regards,
-grygorii
