From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Mon, 24 Nov 2014 21:02:35 +0100
Message-ID: <20141124200235.GV4431@pengutronix.de>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com>
 <20141120221953.GI27002@pengutronix.de>
 <546F34B9.1000206@ti.com>
 <20141121131008.GQ27002@pengutronix.de>
 <546F5B51.1030006@ti.com>
 <20141123203314.GF4431@pengutronix.de>
 <547333EB.5050403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547333EB.5050403-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On Mon, Nov 24, 2014 at 03:34:35PM +0200, Grygorii Strashko wrote:
> On 11/23/2014 10:33 PM, Uwe Kleine-K=F6nig wrote:
> > A call to .master_xfer with a message sequence implicitly expects A=
CKs
> > from the slave and doesn't tell anything about what should be done =
on a
> > NAK. So IMHO you must not send a P when the slave responds with a N=
AK,
> > but error out and let the sender decide if it wants to reply with P=
 or
> > Sr.
>=20
> Sry, but what should be done is defined by I2C/SMbus specs? Does it?
> For SMBus devices, the specification states (http://smbus.org/specs/)
> "4.2.Acknowledge (ACK) and not acknowledge (NACK)":
> - "The slave device detects an invalid command or invalid data. In th=
is=20
>   case the slave device must not acknowledge the received byte. The m=
aster
>   upon detection of this condition must generate a STOP condition and
>   retry the transaction"
> For I2C devices, the specification states [http://www.nxp.com/documen=
ts/user_manual/UM10204.pdf]:
> "3.1.6 Acknowledge (ACK) and Not Acknowledge (NACK)"
> "When SDA remains HIGH during this ninth clock pulse, this is defined=
 as the Not
> Acknowledge signal. The master can then generate either a STOP condit=
ion to
> abort the transfer, or a repeated START condition to start a new tran=
sfer."
Yes, that's exactly what I meant. The master has the choice, and the
driver should not eliminate options here.
=20
> Let take a look on i2c/smbus xfer:
> i2c_lock_adapter(adap)
>  adap->algo->master_xfer/smbus_xfer()
> i2c_unlock_adapter(adap);
>  |- rt_mutex_unlock(&adapter->bus_lock);
>     |- task switch
> =20
> So, there is no guarantee that next xfer will address the same I2C cl=
ient device,
> which, in turn, may lead to BB detection (will lead to BB detection i=
f previous
> transfer has been not acknowledged by SMbus client device).
That's a valid concern.
=20
> Small summary, I2C core + Davinci I2C driver provide ability to use r=
epeated
> start (Sr) only within one I2C transaction - which is a number of wri=
te/read
> operations specified by i2c_msg array. NACK always interrupts transac=
tion
> with -EREMOTEIO.
>=20
> Also, the I2C core doesn't provide ability to manually send P.
Hmm, Wolfram, what do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
