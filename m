From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Sun, 23 Nov 2014 21:33:14 +0100
Message-ID: <20141123203314.GF4431@pengutronix.de>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com>
 <20141120221953.GI27002@pengutronix.de>
 <546F34B9.1000206@ti.com>
 <20141121131008.GQ27002@pengutronix.de>
 <546F5B51.1030006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546F5B51.1030006-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On Fri, Nov 21, 2014 at 05:33:37PM +0200, Grygorii Strashko wrote:
> On 11/21/2014 03:10 PM, Uwe Kleine-K=F6nig wrote:
> > On Fri, Nov 21, 2014 at 02:48:57PM +0200, Grygorii Strashko wrote:
> >> On 11/21/2014 12:19 AM, Uwe Kleine-K=F6nig wrote:
> >>>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/buss=
es/i2c-davinci.c
> >>>> index 9bbfb8f..2cef115 100644
> >>>> --- a/drivers/i2c/busses/i2c-davinci.c
> >>>> +++ b/drivers/i2c/busses/i2c-davinci.c
> >>>> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *ad=
ap, struct i2c_msg *msg, int stop)
> >>>>    	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
> >>>>    		if (msg->flags & I2C_M_IGNORE_NAK)
> >>>>    			return msg->len;
> >>>> -		if (stop) {
> >>>> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >>>> -			w |=3D DAVINCI_I2C_MDR_STP;
> >>>> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> >>>> -		}
> >>>> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >>>> +		w |=3D DAVINCI_I2C_MDR_STP;
> >>>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> >>> I think this is a good change, but I wonder if the handling of
> >>> I2C_M_IGNORE_NAK is correct here. If the controller reports a NAC=
K say
> >>> for the 2nd byte of a 5-byte-message, the transfer supposed to
> >>> continue, right? (Hmm, maybe the framework handle this and restar=
ts the
> >>> transfer with I2C_M_NOSTART but the davinci driver doesn't seem t=
o
> >>> handle this flag?)
> >>
> >> Have nothing to say about handling of I2C_M_IGNORE_NAK. I'm not go=
ing to
> >> change current behavior - davinci driver will interrupt transfer o=
f i2c_msg always
> >>   in case of NACK and start transfer of the next i2c_msg (if exist=
).
> >> In my opinion, Above question is out of scope of this patch.
> > Yeah right, that's exactly what I thought.
> >=20
> > Thinking again I wonder if with your change handling is correct whe=
n the
> > sender wants to do a repeated start. That would need a more detaile=
d
> > look into the driver.
>=20
> Davinci driver will always abort transfer with error -EREMOTEIO in ca=
se if
> NACK received from I2C slave device. And the next omap_i2c_xfer() cal=
l may
> be *not* targeted to the same I2C slave device.
> ^ if !I2C_M_IGNORE_NAK
Does this resolve my concern? I think it doesn't. Also a Sr might well
address another device, doesn't it?

A call to .master_xfer with a message sequence implicitly expects ACKs
from the slave and doesn't tell anything about what should be done on a
NAK. So IMHO you must not send a P when the slave responds with a NAK,
but error out and let the sender decide if it wants to reply with P or
Sr.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
