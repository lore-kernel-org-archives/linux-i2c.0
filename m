From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Date: Thu, 28 Apr 2011 10:18:01 +0900
Message-ID: <20110428011757.GB15883@verge.net.au>
References: <20110421132254.3725.84300.sendpatchset@t400s>
 <20110427221357.GA12273@verge.net.au>
 <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
> On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wr=
ote:
> > Hi Magnus,
> >
> > On Thu, Apr 21, 2011 at 10:22:54PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> >>
> >> Add support to the i2c-sh_mobile driver for setting
> >> the I2C bus speed using platform data.
> >>
> >> Signed-off-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> >> ---
> >>
> >> =C2=A0drivers/i2c/busses/i2c-sh_mobile.c | =C2=A0 13 +++++++++++--
> >> =C2=A0include/linux/i2c-sh_mobile.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 1=
0 ++++++++++
> >> =C2=A02 files changed, 21 insertions(+), 2 deletions(-)
> >>
> >> --- 0013/drivers/i2c/busses/i2c-sh_mobile.c
> >> +++ work/drivers/i2c/busses/i2c-sh_mobile.c =C2=A0 2011-04-21 20:2=
0:23.000000000 +0900
> >> @@ -32,6 +32,7 @@
> >> =C2=A0#include <linux/clk.h>
> >> =C2=A0#include <linux/io.h>
> >> =C2=A0#include <linux/slab.h>
> >> +#include <linux/i2c-sh_mobile.h>
> >>
> >> =C2=A0/* Transmit operation: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*/
> >> =C2=A0/* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> >> @@ -117,7 +118,7 @@ struct sh_mobile_i2c_data {
> >> =C2=A0 =C2=A0 =C2=A0 struct device *dev;
> >> =C2=A0 =C2=A0 =C2=A0 void __iomem *reg;
> >> =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter adap;
> >> -
> >> + =C2=A0 =C2=A0 unsigned long bus_speed;
> >> =C2=A0 =C2=A0 =C2=A0 struct clk *clk;
> >> =C2=A0 =C2=A0 =C2=A0 u_int8_t icic;
> >> =C2=A0 =C2=A0 =C2=A0 u_int8_t iccl;
> >> @@ -205,7 +206,7 @@ static void activate_ch(struct sh_mobile
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0* We also round off the result.
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> >> =C2=A0 =C2=A0 =C2=A0 num =3D i2c_clk * 5;
> >> - =C2=A0 =C2=A0 denom =3D NORMAL_SPEED * 9;
> >> + =C2=A0 =C2=A0 denom =3D pd->bus_speed * 9;
> >
> > I believe that on the sh73a0 and so far only the sh73a0
> > denom needs to be doubled.
>=20
> Uhm, I don't think this patch is specific to any SoC type. It may of
> course be used on sh73a0 to adjust the denom value, but setting the
> I2C bus speed is something that can be used on any SoC. So I'd say
> that this is a fairly generic feature.

I'm just saying that that I've observed the value being doubled for sh7=
3a0.
