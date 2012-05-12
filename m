From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ocore: support 16 and 32-bit wide registers
Date: Sat, 12 May 2012 11:07:25 +0530
Message-ID: <20120512053722.GC23689@jayachandranc.netlogicmicro.com>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1336483529-19140-3-git-send-email-jayachandranc@netlogicmicro.com>
 <CAM=Q2cuYCQu1McDD=otyyBFSG8Tw974Y146tAswZ3dD+USkiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cuYCQu1McDD=otyyBFSG8Tw974Y146tAswZ3dD+USkiTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 08, 2012 at 10:28:34PM +0530, Shubhrajyoti Datta wrote:
> Hi,
>=20
> On Tue, May 8, 2012 at 6:55 PM, Jayachandran C
> <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org> wrote:
> > From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> >
> > Some architectures supports only 16-bit or 32-bit read/write access
> > to their iospace. Add a 'regwidth' platform and OF parameter which
> > specifies the IO width to support these platforms.
> >
> > regwidth can be specified as 1, 2 or 4, and has a default value
> > of 1 if it is unspecified.
> >
> > Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> > ---
> > =A0drivers/i2c/busses/i2c-ocores.c | =A0 32 +++++++++++++++++++++++=
+++++++--
> > =A0include/linux/i2c-ocores.h =A0 =A0 =A0| =A0 =A01 +
> > =A02 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i=
2c-ocores.c
> > index ebd2700..1313145 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -60,6 +64,7 @@
> > =A0struct ocores_i2c {
> > =A0 =A0 =A0 =A0void __iomem *base;
> > =A0 =A0 =A0 =A0int regstep;
> > + =A0 =A0 =A0 int regwidth;
>=20
> Do we need it to be signed?

regstep and regwidth can be both unsigned, but since regstep is already=
=20
defined as int, we just followed that convention.

>=20
> > =A0 =A0 =A0 =A0wait_queue_head_t wait;
> > =A0 =A0 =A0 =A0struct i2c_adapter adap;
> > =A0 =A0 =A0 =A0struct i2c_msg *msg;
> > @@ -102,12 +107,22 @@ struct ocores_i2c {
> >
> > =A0static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8=
 value)
> > =A0{
> > - =A0 =A0 =A0 iowrite8(value, i2c->base + reg * i2c->regstep);
> > + =A0 =A0 =A0 if (i2c->regwidth =3D=3D 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(value, i2c->base + reg * i2=
c->regstep);
> > + =A0 =A0 =A0 else if (i2c->regwidth =3D=3D 2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(value, i2c->base + reg * i2=
c->regstep);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(value, i2c->base + reg * i2c=
->regstep);
> > =A0}
> >
> > =A0static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
>
> Shouldnt the return type also change?
>

No, the registers have only 8bit of data, and we do a 16/32 bit read an=
d
return the lowest 8 bits.

Regards,
JC.
