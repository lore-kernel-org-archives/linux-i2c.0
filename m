From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-bit: Fix spurious SCL timeouts under heavy load
Date: Thu, 15 Mar 2012 18:39:27 +0200
Message-ID: <20120315163927.GK4917@intel.com>
References: <1331713973-7711-1-git-send-email-syrjala@sci.fi>
 <20120315153240.75efc254@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120315153240.75efc254-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 15, 2012 at 03:32:40PM +0100, Jean Delvare wrote:
> Hi Ville,
>=20
> On Wed, 14 Mar 2012 10:32:52 +0200, Ville Syrj=E4l=E4 wrote:
> > When the system is under heavy load, there can be a significant del=
ay
> > between the getscl() and time_after() calls inside sclhi(). That de=
lay
> > may cause the time_after() check to trigger after SCL has gone high=
,
> > causing sclhi() to return -ETIMEDOUT.
> >=20
> > To fix the problem, double check that SCL is still low after the
> > timeout has been reached, before deciding to return -ETIMEDOUT.
> >=20
> > Signed-off-by: Ville Syrj=E4l=E4 <syrjala-ORSVBvAovxo@public.gmane.org>
> > ---
> > I can easily reproduce these spurious timeouts on my HP-compaq nc60=
00
> > laptop with the radeon kms driver. It's enough to have a -j2 kernel
> > build running, and simultaneosly issue xrandr commands in a
> > terminal. Calling xrandr will cause the driver to re-read the EDID
> > from the display. A significant number of the EDID reads will fail.
> > With this fix I have yet to see any failed EDID reads.
>=20
> Thanks for describing a test case, I was able to reproduce the proble=
m
> easily by following your instructions. The problem is real, even with
> the pending fixes I have to radeon's I2C implementation.
>=20
> I only have one concern about your implementation:
>=20
> >=20
> >  drivers/i2c/algos/i2c-algo-bit.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i=
2c-algo-bit.c
> > index 525c734..d25112e 100644
> > --- a/drivers/i2c/algos/i2c-algo-bit.c
> > +++ b/drivers/i2c/algos/i2c-algo-bit.c
> > @@ -104,9 +104,11 @@ static int sclhi(struct i2c_algo_bit_data *ada=
p)
> >  		 * are processing data internally.
> >  		 */
> >  		if (time_after(jiffies, start + adap->timeout))
> > -			return -ETIMEDOUT;
> > +			break;
> >  		cond_resched();
> >  	}
> > +	if (!getscl(adap))
> > +		return -ETIMEDOUT;
>=20
> This means double-check even in the most common case where time_after=
()
> didn't cause the loop break. From a performance perspective, this see=
ms
> undesirable. What would you think of the alternative fix below?

Yeah that fact also occured to today. IIRC I did post an another versio=
n
of the patch to some bugzilla quite a while ago that didn't suffer from
this issue. Ah here [1] it is. By that time I no longer had access to t=
he
machine (a Thinkpad T400) where I initially saw the problem, so I didn'=
t
pursue it further.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D29787

> --- linux-3.3-rc7.orig/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 09=
:33:10.232176790 +0100
> +++ linux-3.3-rc7/drivers/i2c/algos/i2c-algo-bit.c	2012-03-15 14:52:4=
8.127778459 +0100
> @@ -103,8 +103,14 @@ static int sclhi(struct i2c_algo_bit_dat
>  		 * chips may hold it low ("clock stretching") while they
>  		 * are processing data internally.
>  		 */
> -		if (time_after(jiffies, start + adap->timeout))
> +		if (time_after(jiffies, start + adap->timeout)) {
> +			/* Test one last time, as we may have been preempted
> +			 * between last check and timeout test.
> +			 */
> +			if (getscl(adap))
> +				break;
>  			return -ETIMEDOUT;
> +		}
>  		cond_resched();
>  	}
>  #ifdef DEBUG
>
> Functionally it should be equivalent to your proposal, but faster. I'=
ll
> apply that (and send for stable inclusion.)

Looks good. Thanks for taking care of it.

--=20
Ville Syrj=E4l=E4
Intel OTC
