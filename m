From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Fri, 21 Nov 2014 14:10:08 +0100
Message-ID: <20141121131008.GQ27002@pengutronix.de>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com>
 <20141120221953.GI27002@pengutronix.de>
 <546F34B9.1000206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546F34B9.1000206-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Nov 21, 2014 at 02:48:57PM +0200, Grygorii Strashko wrote:
> On 11/21/2014 12:19 AM, Uwe Kleine-K=F6nig wrote:
> >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses=
/i2c-davinci.c
> >> index 9bbfb8f..2cef115 100644
> >> --- a/drivers/i2c/busses/i2c-davinci.c
> >> +++ b/drivers/i2c/busses/i2c-davinci.c
> >> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap=
, struct i2c_msg *msg, int stop)
> >>   	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
> >>   		if (msg->flags & I2C_M_IGNORE_NAK)
> >>   			return msg->len;
> >> -		if (stop) {
> >> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >> -			w |=3D DAVINCI_I2C_MDR_STP;
> >> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> >> -		}
> >> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> >> +		w |=3D DAVINCI_I2C_MDR_STP;
> >> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> > I think this is a good change, but I wonder if the handling of
> > I2C_M_IGNORE_NAK is correct here. If the controller reports a NACK =
say
> > for the 2nd byte of a 5-byte-message, the transfer supposed to
> > continue, right? (Hmm, maybe the framework handle this and restarts=
 the
> > transfer with I2C_M_NOSTART but the davinci driver doesn't seem to
> > handle this flag?)
>=20
> Have nothing to say about handling of I2C_M_IGNORE_NAK. I'm not going=
 to
> change current behavior - davinci driver will interrupt transfer of i=
2c_msg always
>  in case of NACK and start transfer of the next i2c_msg (if exist).
> In my opinion, Above question is out of scope of this patch.
Yeah right, that's exactly what I thought.

Thinking again I wonder if with your change handling is correct when th=
e
sender wants to do a repeated start. That would need a more detailed
look into the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
