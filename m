From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/7] i2c: img-scb: add handle for stop detected interrupt
Date: Wed, 29 Jul 2015 22:23:39 +0100
Message-ID: <20150729212339.GA9258@jhogan-linux.le.imgtec.org>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
 <1437998162-32724-7-git-send-email-sifan.naeem@imgtec.com>
 <55B8F271.6060003@imgtec.com>
 <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DE38@hhmail02.hh.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DE38-brIQrgj5TFtJFJhlrACyRFBRoQTxkR7k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 06:06:24PM +0100, Sifan Naeem wrote:
> Hi James,
>=20
> > -----Original Message-----
> > From: James Hogan
> > Sent: 29 July 2015 16:34
> > To: Sifan Naeem; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH 6/7] i2c: img-scb: add handle for stop detected int=
errupt
> >=20
> > On 27/07/15 12:56, Sifan Naeem wrote:
> > > Stop Detected interrupt is triggered when a Stop bit is detected on
> > > the bus, which indicates the end of the current transfer.
> > >
> > > When the end of a transfer is indicated by the Stop bit interrupt,
> > > drain the FIFO and signal completion for the transaction. But if the
> > > interrupt was triggered before all data is written to the fifo or with
> > > more data expected return error with transfer complete signal.
> > >
> > > Halting the bus is no longer necessary after a stop bit is detected on
> > > the bus, as there cannot be a repeated start transfer when the stop
> > > bit has been issued, hence remove the transaction halt bit.
> > >
> > > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-img-scb.c |   28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > > b/drivers/i2c/busses/i2c-img-scb.c
> > > index 10141a9..90faf48 100644
> > > --- a/drivers/i2c/busses/i2c-img-scb.c
> > > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > > @@ -152,6 +152,7 @@
> > >  #define INT_TRANSACTION_DONE		BIT(15)
> > >  #define INT_SLAVE_EVENT			BIT(16)
> > >  #define INT_TIMING			BIT(18)
> > > +#define INT_STOP_DETECTED		BIT(19)
> > >
> > >  #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  |
> > INT_FIFO_FILLING)
> > >
> > > @@ -175,7 +176,8 @@
> > >  					 INT_WRITE_ACK_ERR    | \
> > >  					 INT_FIFO_FULL        | \
> > >  					 INT_FIFO_FILLING     | \
> > > -					 INT_FIFO_EMPTY)
> > > +					 INT_FIFO_EMPTY       | \
> > > +					 INT_STOP_DETECTED)
> > >
> > >  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
> > >  					 INT_ADDR_ACK_ERR     | \
> > > @@ -907,6 +909,18 @@ static unsigned int img_i2c_auto(struct img_i2c
> > *i2c,
> > >  				return ISR_COMPLETE(0);
> > >  			}
> > >  		}
> > > +		if (int_status & INT_STOP_DETECTED) {
> > > +			int ret;
> > > +			/*
> > > +			 * Stop bit indicates the end of the transfer, it means
> > > +			 * we should read all the data (or drain the FIFO). We
> > > +			 * must signal completion for this transaction.
> > > +			 */
> > > +			img_i2c_transaction_halt(i2c, false);
> >=20
> > to get a stop bit detected, wouldn't transaction halt already have to b=
e off?
>=20
> Yes, but in case we were too slow re-enabling the master halt and a stop =
was detected simultaneously to when master halt was set.

Okay, I already checked to make sure the t_halt thing is being done with
the spinlock held in both places, and irqs disabled in non-irq context,
since you wouldn't want a preemption or irq in between to delay t_halt
getting set anyway, in case it reached the stop bit without halting.

So you should be okay. On UP you'll never handle an irq in between as
irqs are disabled, and on SMP the spinlock will ensure the bulk of the
irq handler and t_halt thing in user context can't run concurrently on
different CPUs.

Thanks
James

> >=20
> > > +			img_i2c_read_fifo(i2c);
> > > +			ret =3D (i2c->msg.len =3D=3D 0) ? 0 : EIO;
> >=20
> > If it wasn't fully transferred, wouldn't that already imply an
> > INT_WRITE_ACK_ERR or INT_ADDR_ACK_ERR, which should've already been
> > handled?
> >=20
> This was added as a safety check, yes I guess it's impossible to get a st=
op bit before all data is transferred without an error condition.
> >
> > Could it then be as simple as this? (untested):
> >=20
> Yes, this would do.
>=20
> Thanks,
> Sifan
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-
> > scb.c
> > index 00ffd6613680..f694b47dcf74 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -867,6 +867,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
> >=20
> >  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> >=20
> > +	if (int_status & INT_STOP_DETECTED) {
> > +		/* Drain remaining data in FIFO and complete transaction */
> > +		if (i2c->msg.flags & I2C_M_RD)
> > +			img_i2c_read_fifo(i2c);
> > +		return ISR_COMPLETE(0);
> > +	}
> > +
> >  	if (i2c->msg.flags & I2C_M_RD) {
> >  		if (int_status & INT_FIFO_FULL_FILLING) {
> >  			img_i2c_read_fifo(i2c);
> >=20
> > Cheers
> > James
> >=20
> > > +			return ISR_COMPLETE(ret);
> > > +		}
> > >  	} else {
> > >  		if (int_status & INT_FIFO_EMPTY) {
> > >  			if (i2c->msg.len =3D=3D 0) {
> > > @@ -916,6 +930,18 @@ static unsigned int img_i2c_auto(struct img_i2c
> > *i2c,
> > >  			}
> > >  			img_i2c_write_fifo(i2c);
> > >  		}
> > > +		if (int_status & INT_STOP_DETECTED) {
> > > +			int ret;
> > > +
> > > +			img_i2c_transaction_halt(i2c, false);
> > > +			/*
> > > +			 * Stop bit indicates the end of a transfer and if the
> > > +			 * transfer has ended before all data is written to the
> > > +			 * fifo, return an error with transfer complete signal.
> > > +			 */
> > > +			ret =3D (i2c->msg.len =3D=3D 0) ? 0 : EIO;
> > > +			return ISR_COMPLETE(ret);
> > > +		}
> > >  	}
> > >
> > >  	return 0;
> > >
>=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuURbAAoJEGwLaZPeOHZ6pUgP/RpXKZS/4s3RPU1gz2d3cPn5
NtmYqCGi2Gocf9GEY0HNHuVTGHfCo/Ey0l5RWToVNq2bLD3JC5qP/yph0wQA03ex
FsF4LZE17/7oTcV5IRLhiccxeek2f3LKuP6/qkJ7ikiS0UeXxA5YCmQ3ydpKkIRn
McM+wvjbL4x9frSbi5FOMLCwseARpxcYrD9V0kn5cedSBAJhyAnVelH8KBGjvo9S
sFMQvoyv+O9ESIe2gc8W3LSB+5YNplj/R3AAwFbDet5Hf/azRqKFyKk97FycKskM
/kVe+MmVnFfiXBRstyzgtwSqukGbElPu9odPnir9Ohjg3iLfe+7MV5Ueck65Pa6Z
SA6EP+o1WQ9ve0njj4gXUYJUcuEU59Augh+K0/U903DzZQ7cX0FzgDy+c/dbKKRY
07mnVPQn1Oh9jD9Jp86VX1+rjsr1VkZdUjxiy+vXOPjmi2is7d8WJhr10Qlx2VFX
Pe6884o85Hisp4CDShI/3pEILhJseKxzD80plrYs6LPT3dBmQxSIxufTEHpN8WiR
pO8guDlCoVrZ0piNI/EmLEF1dkfIjaP5CCNps/cgDTZdYOOhoTcHl6HgKt/vWsXt
6zlDqns/cgBL/6zvG+HV2b0/gXli7Wr2DZzIwrSjrtPQRFhCdzxxEhE7FGnfgFhJ
639vEmriXY93iLzfhsde
=SWxr
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
