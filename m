From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Thu, 4 Jul 2013 09:03:48 +0200
Message-ID: <20130704070348.GB17454@pengutronix.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
 <20130702181115.GR27010@pengutronix.de>
 <51D31FD1.4080002@freescale.com>
 <201307031520.53637.marex@denx.de>
 <886382023.618771.1372858452205.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <886382023.618771.1372858452205.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: "Christoph G. Baumann" <cb-/RsSufbtIHM@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Jul 03, 2013 at 03:34:12PM +0200, Christoph G. Baumann wrote:
> > > No, I haven't. I saw the report from Christoph in the linux-arm-k=
ernel
> > > mailing list:
> > > http://marc.info/?l=3Dlinux-arm-kernel&m=3D137277422127826&w=3D2
> > >
> > > And thought it could be nice if we could get it fixed for mx23 an=
d mx28.
> >
> > How/when does this error manifest on the scope/LA?
>=20
> the problem turned up when Uwe Kleine-K=F6nig worked on implementing =
SMBus and
> I2C_M_RECV_LEN support for i.MX28 (my employer commissioned Pengutron=
ix in that
> case). The receiving of such messages stops after the first (length i=
nformation)
> byte.
> Maybe Uwe can comment on that.
OK, I'm trying to sum up: To support I2C_M_RECV_LEN in the mxs driver I
did:

     1          // prepare sending SAD+R
     2          CTRL0 =3D RUN | RETAIN_CLOCK | PRE_SEND_START | MASTER_=
MODE | DIRECTION | XFER_COUNT(1);
     3          poll DEBUG0 until DMAREQ is set;
     4          // send SAD+R
     5          DATA =3D addr_data
     6          // prepare reading length byte
     7          CTRL0 =3D RUN | RETAIN_CLOCK | MASTER_MODE | XFER_COUNT=
(1);
     8          poll DEBUG0 until DMAREQ is set;
     9          // read first data indicating length
    10          data =3D DATA & 0xff
    11          // send an ack, i.e. clean CTRL0_CLOCK_HELD
    12          CTRL0 =3D RUN | ACKNOWLEDGE | MASTER_MODE
    13          sleep 1ms
    14          // trigger reading rest of the message
    15          CTRL0 =3D RUN | SEND_NAK_ON_LAST | MASTER_MODE | MXS_I2=
C_CTRL0_POST_SEND_STOP
    16          for (i =3D 0; i < (data + 3) / 4; ++i)
    17                  read from DATA

In line 10 the length bit is read out successfully, but sending the ACK
in line 12 doesn't work, the i.MX28 pulls SDA low, but doesn't generate
a clock pulse on SCL and instead releases SDA and starts reading the
following byte.

Dropping RETAIN_CLOCK in line 7 and/or dropping RUN from line 12 didn't
help.

=46reescale's support suggested to set CTRL1.ACK_MODE and some other
things that didn't help and pointed out the imx23 i2c errata. (I.e.
"when RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generated=
=2E
However, the SDA line is read at the proper timing interval. If
RETAIN_CLOCK is cleared, the ninth clock pulse is generated.")

The suggested workaround was to either use a Big buffer, read Many byte=
s
until the slave sends a NACK and interpret the result as smaller read.
Or use gpio bit banging.

I didn't understand the suggested workaround in the errata document, an=
d
the support guy didn't succeed to explain it to me. "The suggested
workaround in this errata is to set the ACK_MODE bit in HW_I2C_CTRL1
register. In i.MX233, this bit is default zero and requires software to
explicitly set it to 1. In i.MX28, this bit is '1' by default already.
Unfortunately, this does not solve the 9th clock pulse issue if
RETAIN_CLOCK is set in the receiving data phase."

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
