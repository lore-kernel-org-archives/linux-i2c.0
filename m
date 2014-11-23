From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Date: Sun, 23 Nov 2014 21:20:08 +0100
Message-ID: <20141123202008.GE4431@pengutronix.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141122182630.GD9698@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141122182630.GD9698@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Sat, Nov 22, 2014 at 07:26:30PM +0100, Wolfram Sang wrote:
>=20
> > this mail is thematically more a reply to patch 1 and maybe just se=
rves
> > my understanding of the slave support.
>=20
> Sure. This shows how badly needed the documentation is :)
>=20
> ...
> > > +		break;
> > > +
> > > +	case I2C_SLAVE_STOP:
> > > +		eeprom->first_write =3D true;
> > > +		break;
> > > +
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > This is the most interesting function here because it uses the new
> > interface, the functions below are only to update and show the simu=
lated
> > eeprom contents and driver boilerplate, right?
>=20
> Yes.
>=20
> > When the eeprom driver is probed and the adapter driver notices a r=
ead
> > request for the respective i2c address, this callback is called wit=
h
> > event=3DI2C_SLAVE_REQ_READ_START. Returning 0 here and provide the =
first
> > byte to send make the adapter ack the read request and send the dat=
a
> > provided. If something !=3D 0 is returned a NAK is sent?
>=20
> We only send NAK on write requests (I use read/write from the master
I don't understand this. Who is "we" in this case?=20

> perspective). Then, we have to say if the received byte was successfu=
lly
> processed. When reading, the master has to ack the successful recepti=
on
> of the byte.
Right, I got this wrong in my question. On a read request (as seen from
the master) the master has to ack.
=20
> > How is the next byte requested from the slave driver? I assume with=
 two
> > additional calls to the callback, first with
> > event=3DI2C_SLAVE_REQ_READ_END, then event=3DI2C_SLAVE_REQ_READ_STA=
RT once
> > more. Would it make sense to reduce this to a single call? Does the
> > driver at READ_END time already know if its write got acked? If so,=
 how?
>=20
> No single call. I had this first, but my experiments showed that it i=
s
> important for the EEPROM driver to only increase the internal pointer
> when the byte was ACKed. Otherwise, I was off-by-one.
Sure, the driver has to know how his read response was received by the
master. But assuming I understand your abstraction right there is some
redundancy. There are only three cases on a read request (well plus err=
or
handling):

 - master sends ACK, reads next byte
   in this case the slave must provide another word
   In your abstraction this implies
     callback(I2C_SLAVE_REQ_READ_END); <-- this is redundant
     callback(I2C_SLAVE_REQ_READ_START);

 - master sends ACK, then P or Sr
     callback(I2C_SLAVE_REQ_READ_END);
     maybe callback(I2C_SLAVE_STOP)

 - master sends NACK
   in this case the message ends and the master has to send Sr or P.
   In your case this results in:
     nothing for the NACK?
     maybe callback(I2C_SLAVE_STOP)

The situations where the slave has to react are:

 - slave was addressed with R
   input: address
   output: NAK or (ACK + data byte)
 - slave was addressed with #W:
   input: address
   output: NAK or ACK
 - data sent by slave-transmitter was acked
   output: next data byte (maybe unused because master sends Sr or P)
 - data sent by slave-transmitter was nacked
   output: void (unless we want to support IGNORE_NAK :-)
 - slave received a data byte (write)
   input: data
   output: NAK or ACK

This looks like a better model in my eyes. In this model the slave
driver doesn't even need to be informed about P. Not entirely sure abou=
t
"data sent by slave-transmitter was nacked".

> Ideally, I2C_SLAVE_REQ_READ_END should be used when the master ACKed =
the
> byte, right. However, the rcar hardware doesn't have an interrupt for
> this, so I imply that the start of a new read request ends the old on=
e.
> I probably should add a comment for that.
>=20
> > This means that for each byte the callback is called. Would it make
> > sense to make the API more flexible and allow the slave driver to r=
eturn
> > a buffer? This would remove some callback overhead and might allow =
to
> > let the adapter driver make use of its DMA mechanism.
>=20
> For DMA, I haven't seen DMA slave support yet. Makes sense to me, we
haha, there is only a single slave driver yet and you're the author.

> wouldn't know the transfer size, since the master can send a stop
> anytime. This makes possible gains of using a buffer also speculative=
=2E
> Also, I2C is still a low-bandwith bus, so usually we have a high numb=
er
> of small transfers.
>=20
> For now, I'd skip this idea. As I said in another thread, we need mor=
e
> use cases. If the need arises, we can come up with something. I don't
> think the current design prevents such an addition?
It would change the API, but starting to get experience with byte
banging is probably OK.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
