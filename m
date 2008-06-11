From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 11:14:15 +0200
Message-ID: <20080611111415.2a677a10@hyperion.delvare>
References: <200806091541.43899.u.luckas@road.de>
	<484DA046.4010804@bluewatersys.com>
	<20080610085708.12c2d2a2@hyperion.delvare>
	<200806101355.07792.david-b@pacbell.net>
	<20080611101130.1a667abe@hyperion.delvare>
	<20080611090016.GA5338@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611090016.GA5338-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Russell,

On Wed, 11 Jun 2008 10:00:16 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 11, 2008 at 10:11:30AM +0200, Jean Delvare wrote:
> > Hi David,
> > 
> > On Tue, 10 Jun 2008 13:55:07 -0700, David Brownell wrote:
> > > > Why don't you simply initialize the drivers in question with
> > > > subsys_initcall()? That's what i2c-pnx, i2c-omap, i2c-davinci and
> > > > tps65010 are doing at the moment.
> > > 
> > > If they happen to sit outside the I2C tree and *before* it in
> > > link order, things will misbehave.
> > 
> > Well, i2c system bus drivers shouldn't sit outside of the I2C tree, so
> > that's not a problem. If you start accepting that drivers live at
> > random places in the source tree, then there's simply no way to get
> > things right.
> 
> That's simply not a realistic view.  As I've already pointed out,
> framebuffer devices have I2C busses for reading the DDC information
> from monitors.  These I2C bus drivers live in drivers/video.
> 
> Video grabbers have I2C busses for controlling, eg, tuners and video
> decoders.  These live in drivers/media.
> 
> If I follow your argument, would you like cyber2000fb.c to be moved
> entirely from drivers/video into drivers/i2c/busses because it contains
> an i2c bus driver?  Clearly not.

Please read what I wrote again. I said: I2C SYSTEM BUS drivers should
live under drivers/i2c. DDC channels on graphics adapters and I2C buses
on multimedia adapters definitely do not qualify as system buses (and
don't need to be initialized early, either.)

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
