From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Mon, 24 Nov 2014 15:34:35 +0200
Message-ID: <547333EB.5050403@ti.com>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com> <20141120221953.GI27002@pengutronix.de> <546F34B9.1000206@ti.com> <20141121131008.GQ27002@pengutronix.de> <546F5B51.1030006@ti.com> <20141123203314.GF4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141123203314.GF4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,
On 11/23/2014 10:33 PM, Uwe Kleine-K=F6nig wrote:
> On Fri, Nov 21, 2014 at 05:33:37PM +0200, Grygorii Strashko wrote:
>> On 11/21/2014 03:10 PM, Uwe Kleine-K=F6nig wrote:
>>> On Fri, Nov 21, 2014 at 02:48:57PM +0200, Grygorii Strashko wrote:
>>>> On 11/21/2014 12:19 AM, Uwe Kleine-K=F6nig wrote:
>>>>>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/buss=
es/i2c-davinci.c
>>>>>> index 9bbfb8f..2cef115 100644
>>>>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>>>>> +++ b/drivers/i2c/busses/i2c-davinci.c
>>>>>> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *ad=
ap, struct i2c_msg *msg, int stop)
>>>>>>     	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
>>>>>>     		if (msg->flags & I2C_M_IGNORE_NAK)
>>>>>>     			return msg->len;
>>>>>> -		if (stop) {
>>>>>> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>>>>> -			w |=3D DAVINCI_I2C_MDR_STP;
>>>>>> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>>>>>> -		}
>>>>>> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>>>>>> +		w |=3D DAVINCI_I2C_MDR_STP;
>>>>>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>>>>> I think this is a good change, but I wonder if the handling of
>>>>> I2C_M_IGNORE_NAK is correct here. If the controller reports a NAC=
K say
>>>>> for the 2nd byte of a 5-byte-message, the transfer supposed to
>>>>> continue, right? (Hmm, maybe the framework handle this and restar=
ts the
>>>>> transfer with I2C_M_NOSTART but the davinci driver doesn't seem t=
o
>>>>> handle this flag?)
>>>>
>>>> Have nothing to say about handling of I2C_M_IGNORE_NAK. I'm not go=
ing to
>>>> change current behavior - davinci driver will interrupt transfer o=
f i2c_msg always
>>>>    in case of NACK and start transfer of the next i2c_msg (if exis=
t).
>>>> In my opinion, Above question is out of scope of this patch.
>>> Yeah right, that's exactly what I thought.
>>>
>>> Thinking again I wonder if with your change handling is correct whe=
n the
>>> sender wants to do a repeated start. That would need a more detaile=
d
>>> look into the driver.
>>
>> Davinci driver will always abort transfer with error -EREMOTEIO in c=
ase if
>> NACK received from I2C slave device. And the next omap_i2c_xfer() ca=
ll may
>> be *not* targeted to the same I2C slave device.
>> ^ if !I2C_M_IGNORE_NAK
> Does this resolve my concern? I think it doesn't. Also a Sr might wel=
l
> address another device, doesn't it?
>=20
> A call to .master_xfer with a message sequence implicitly expects ACK=
s
> from the slave and doesn't tell anything about what should be done on=
 a
> NAK. So IMHO you must not send a P when the slave responds with a NAK=
,
> but error out and let the sender decide if it wants to reply with P o=
r
> Sr.

Sry, but what should be done is defined by I2C/SMbus specs? Does it?
=46or SMBus devices, the specification states (http://smbus.org/specs/)
"4.2.Acknowledge (ACK) and not acknowledge (NACK)":
- "The slave device detects an invalid command or invalid data. In this=
=20
  case the slave device must not acknowledge the received byte. The mas=
ter
  upon detection of this condition must generate a STOP condition and
  retry the transaction"
=46or I2C devices, the specification states [http://www.nxp.com/documen=
ts/user_manual/UM10204.pdf]:
"3.1.6 Acknowledge (ACK) and Not Acknowledge (NACK)"
"When SDA remains HIGH during this ninth clock pulse, this is defined a=
s the Not
Acknowledge signal. The master can then generate either a STOP conditio=
n to
abort the transfer, or a repeated START condition to start a new transf=
er."

Let take a look on i2c/smbus xfer:
i2c_lock_adapter(adap)
 adap->algo->master_xfer/smbus_xfer()
i2c_unlock_adapter(adap);
 |- rt_mutex_unlock(&adapter->bus_lock);
    |- task switch
=20
So, there is no guarantee that next xfer will address the same I2C clie=
nt device,
which, in turn, may lead to BB detection (will lead to BB detection if =
previous
transfer has been not acknowledged by SMbus client device).

Small summary, I2C core + Davinci I2C driver provide ability to use rep=
eated
start (Sr) only within one I2C transaction - which is a number of write=
/read
operations specified by i2c_msg array. NACK always interrupts transacti=
on
with -EREMOTEIO.

Also, the I2C core doesn't provide ability to manually send P.

regards,
-grygorii
