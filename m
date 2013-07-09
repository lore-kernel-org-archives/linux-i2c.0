From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 9 Jul 2013 12:54:55 +0200
Message-ID: <201307091254.55872.marex@denx.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <886382023.618771.1372858452205.open-xchange@email.1und1.de> <20130704070348.GB17454@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130704070348.GB17454-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Christoph G. Baumann" <cb-/RsSufbtIHM@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Uwe Kleine-K=F6nig,

> Hello,
>=20
> On Wed, Jul 03, 2013 at 03:34:12PM +0200, Christoph G. Baumann wrote:
> > > > No, I haven't. I saw the report from Christoph in the
> > > > linux-arm-kernel mailing list:
> > > > http://marc.info/?l=3Dlinux-arm-kernel&m=3D137277422127826&w=3D=
2
> > > >=20
> > > > And thought it could be nice if we could get it fixed for mx23 =
and
> > > > mx28.
> > >=20
> > > How/when does this error manifest on the scope/LA?
> >=20
> > the problem turned up when Uwe Kleine-K=F6nig worked on implementin=
g SMBus
> > and I2C_M_RECV_LEN support for i.MX28 (my employer commissioned
> > Pengutronix in that case). The receiving of such messages stops aft=
er
> > the first (length information) byte.
> > Maybe Uwe can comment on that.
>=20
> OK, I'm trying to sum up: To support I2C_M_RECV_LEN in the mxs driver=
 I
> did:

See the other patch I sent , esp. the write PIO command [1], then the o=
rder=20
would be:

      1          // prepare sending SAD+R
      2          CTRL0 =3D RETAIN_CLOCK | PRE_SEND_START | MASTER_MODE =
|
                         DIRECTION | XFER_COUNT(1);
      3          DATA =3D addr_data
      4          CTRL0 |=3D RUN

^ this stuff is explained in MX23 RM, see the comment above=20
mxs_i2c_pio_trigger_write_cmd() in the patch.

>      6          // prepare reading length byte
>      7          CTRL0 =3D RUN | RETAIN_CLOCK | MASTER_MODE | XFER_COU=
NT(1);

I think you can force the controller to send ACK here automatically.

>      8          poll DEBUG0 until DMAREQ is set;

DMAREQ doesn't work in READ xfer :-(

>      9          // read first data indicating length
>     10          data =3D DATA & 0xff
>     11          // send an ack, i.e. clean CTRL0_CLOCK_HELD
>     12          CTRL0 =3D RUN | ACKNOWLEDGE | MASTER_MODE
>     13          sleep 1ms

See above, also don't use RETAIN_CLOCK above then.

>     14          // trigger reading rest of the message
>     15          CTRL0 =3D RUN | SEND_NAK_ON_LAST | MASTER_MODE |
> MXS_I2C_CTRL0_POST_SEND_STOP 16          for (i =3D 0; i < (data + 3)=
 / 4;
> ++i)
>     17                  read from DATA

Use DMA here, you can't PIO READ more than 4 bytes.

> In line 10 the length bit is read out successfully, but sending the A=
CK
> in line 12 doesn't work, the i.MX28 pulls SDA low, but doesn't genera=
te
> a clock pulse on SCL and instead releases SDA and starts reading the
> following byte.
>=20
> Dropping RETAIN_CLOCK in line 7 and/or dropping RUN from line 12 didn=
't
> help.
>=20
> Freescale's support suggested to set CTRL1.ACK_MODE and some other
> things that didn't help and pointed out the imx23 i2c errata. (I.e.
> "when RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generat=
ed.
> However, the SDA line is read at the proper timing interval. If
> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.")
>=20
> The suggested workaround was to either use a Big buffer, read Many by=
tes
> until the slave sends a NACK and interpret the result as smaller read=
=2E
> Or use gpio bit banging.

I suspect is likely doable, but it'd need non-trivial amount of fiddlin=
g. Unless=20
I get motivated enough to implement this, I'm not plumbing in it. Rathe=
r than=20
that, I'd like to find out what's wrong with the PIO on MX23.

> I didn't understand the suggested workaround in the errata document, =
and
> the support guy didn't succeed to explain it to me. "The suggested
> workaround in this errata is to set the ACK_MODE bit in HW_I2C_CTRL1
> register. In i.MX233, this bit is default zero and requires software =
to
> explicitly set it to 1. In i.MX28, this bit is '1' by default already=
=2E
> Unfortunately, this does not solve the 9th clock pulse issue if
> RETAIN_CLOCK is set in the receiving data phase."
>=20
> Best regards
> Uwe

[1] http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg12699.html

Best regards,
Marek Vasut
