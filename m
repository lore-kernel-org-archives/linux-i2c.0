From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 14:05:15 +0200
Message-ID: <20080611140515.3b464e52@hyperion.delvare>
References: <200806091541.43899.u.luckas@road.de>
	<484DA046.4010804@bluewatersys.com>
	<20080610085708.12c2d2a2@hyperion.delvare>
	<200806101355.07792.david-b@pacbell.net>
	<20080611101130.1a667abe@hyperion.delvare>
	<48503432.6010105@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48503432.6010105-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Jun 2008 08:23:14 +1200, Ryan Mallon wrote:
> Jean Delvare wrote:
> >
> > That's easier to get right if you restrict yourself to a single
> > platform. For the vanilla kernel, the order of the dependencies is way
> > more difficult to figure out and get right. There are some hints in
> > drivers/Makefile but most dependencies aren't spelled out.
> >
> > My feeling is that we won't be able to solve this without first moving
> > the different type of i2c bus drivers (and possibly chip drivers) to
> > separate directories. For example, moving external I2C bus drivers
> > (i2c-parport-light, i2c-parport, i2c-taos-evm and i2c-tiny-usb) to a
> > separate directory that is always initialized late, would remove the
> > dependencies on parport, serio and USB for the "must initialize i2c
> > early" problem.
> >
> > I've already attempted a categorization of the i2c bus drivers:
> > http://lists.lm-sensors.org/pipermail/i2c/2008-May/003713.html
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-group-bus-drivers.patch
> > I would welcome comments on this, and suggestions for further
> > categorization of group "other".
>
> I like this idea. Is it possible to move (or mark as subsys_initcall) the
> i2c busses which are likely to be needed early: pxa, omap, gpio, etc and
> leave the PC/external busses alone. Then having the i2c chip drivers in
> the correct place (ie drivers/gpio) would effectively fix the problem.

That's certainly possible to move them, the only problem is: how do we
select the drivers which need it? As you can see from the categories I
made, there's a fairly large list of "other" drivers are the moment.
All drivers you mentioned, and the ones already using
subsys_initcall(), are there. They fall under the "embedded" category
but I suspect that many drivers in the group "other" are not. So first
of all I think we need to refine my original grouping. If we can't make
a definitive list right away, maybe we can make an "embedded" group and
each developer or maintainer moves the drivers they know are embedded
there.

But that's only one side of the problem. The other side is that is is
entirely possible that some embedded platforms don't need the early i2c
initialization, and non-embedded platforms do. I have no example at the
moment but obviously it could happen. So, while moving the external bus
adapter drivers to a separate directory is fine (they just can't be
initialized early), for the rest it's mainly a per-driver attribute, so
maybe we just want an "early" directory with drivers that must be
initialized early, regardless of their platform type.

If we want a general solution to the problem, then I think that's the
way to go. If you only want to fix the problem at hand, just use
subsys_initcall() in your bus driver for now.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
