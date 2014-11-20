From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Thu, 20 Nov 2014 23:19:53 +0100
Message-ID: <20141120221953.GI27002@pengutronix.de>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416477788-5544-3-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Nov 20, 2014 at 12:03:05PM +0200, Grygorii Strashko wrote:
> According to I2C specification the NACK should be handled as folowing=
:
s/folowing/follows/

> "When SDA remains HIGH during this ninth clock pulse, this is defined=
 as the Not
> Acknowledge signal. The master can then gene rate either a STOP condi=
tion to
s/gene rate/generate/

> abort the transfer, or a repeated START condition to start a new tran=
sfer."
> [http://www.nxp.com/documents/user_manual/UM10204.pdf]
The link is nice, but pointing out that this is the i2c spec would be
nice.

> The same is recomened by TI I2C wiki:
s/recomened/recommended/

>  http://processors.wiki.ti.com/index.php/I2C_Tips
If the specification tells what to do, there is no need to further
support your claim.

> Currently, the Davinci I2C driver interrupts I2C trunsfer in case of =
NACK, but
s/trunsfer/transfer/

> It queries Stop condition DAVINCI_I2C_MDR_REG.STP=3D1 only if NACK ha=
s been received
s/It/it/

> during the last message transmitting/recieving.
s/transmitting/transmitted/; s/recieving/received/

I think I don't understand this sentence even with the typos corrected.
Do you want to say:

Currently the Davinci i2c driver interrupts the transfer on receipt of =
a
NACK but fails to send a STOP in some situations and so makes the bus
stuck.

> This may lead to Bus stuck in "Bus Busy" until I2C IP reset (idle/ena=
ble) if
> during SMBus reading transaction the first I2C message is NACKed.
Did you hit this problem, or is this a theoretical issue?

Assuming this is a candidate for stable, adding a Fixes:-footer would b=
e
nice.

> Hence, fix it by querying Stop condition (STP) always when NACK is re=
ceived.
>=20
> This patch fixes Davinci I2C in the same way it was done for OMAP I2C
> commit cda2109a26eb ("i2c: omap: query STP always when NACK is receiv=
ed").
>=20
> More info can be found at:
> https://lkml.org/lkml/2013/7/16/159
> http://patchwork.ozlabs.org/patch/249790/
I'd drop this "more info" paragraph.

> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Reported-by: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>
Is this Reported-by tag reused from the omap issue?

> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2=
c-davinci.c
> index 9bbfb8f..2cef115 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, s=
truct i2c_msg *msg, int stop)
>  	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return msg->len;
> -		if (stop) {
> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> -			w |=3D DAVINCI_I2C_MDR_STP;
> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> -		}
> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +		w |=3D DAVINCI_I2C_MDR_STP;
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
I think this is a good change, but I wonder if the handling of
I2C_M_IGNORE_NAK is correct here. If the controller reports a NACK say
for the 2nd byte of a 5-byte-message, the transfer supposed to
continue, right? (Hmm, maybe the framework handle this and restarts the
transfer with I2C_M_NOSTART but the davinci driver doesn't seem to
handle this flag?)

Best regards
Uwe

>  		return -EREMOTEIO;
>  	}
>  	return -EIO;

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
