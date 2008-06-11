From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 14:18:52 +0200
Message-ID: <20080611141852.3ccd89ea@hyperion.delvare>
References: <200806091541.43899.u.luckas@road.de>
	<20080609135739.GE30971@flint.arm.linux.org.uk>
	<484D947D.1090900@bluewatersys.com>
	<200806091359.12791.david-b@pacbell.net>
	<484DA046.4010804@bluewatersys.com>
	<20080610085708.12c2d2a2@hyperion.delvare>
	<484F42AC.9030709@bluewatersys.com>
	<20080611094039.287ac136@hyperion.delvare>
	<485031D5.3020606@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <485031D5.3020606-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
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

On Thu, 12 Jun 2008 08:13:09 +1200, Ryan Mallon wrote:
> Jean Delvare wrote:
> > Which problem are you trying to solve? Is there any actual drawback to
> > abusing subsys_initcall() for the handful of i2c bus drivers which may
> > need to come up early?
>
> On many embedded devices there is a need for i2c to be early since it is
> often used for core functionality. It seems at the moment, that the 
> answer to this is to juggle a few of the drivers which people need to
> get this to work. There are the drivers in drivers/i2c which use 
> subsys_initcall. It does work, but it feels a bit untidy. Some of the i2c
> IO expander drivers are now in drivers/gpio since that comes up early.
> This can lead to confusion (see drivers/gpio/pca953x.c and 
> drivers/i2c/chips/pca9539.c).

The GPIO drivers under drivers/i2c/chips are deprecated and tagged for
removal. We only need a user-space interface for the new GPIO drivers
(I think we do by now) and a way to instantiate these new GPIO devices
from user-space (not done yet) before the deprecated drivers can be
removed. The only remaining users for these deprecated drivers are
electronics enthusiasts controlling GPIO chips over the PC parallel
port. In the context of embedded platforms, there's no room for
confusion here.

>                               As David suggested, if i2c is needed early
> in enough cases, why not just move it early in the link order? My patch
> was just an alternative approach which mimics the current behaviour, but
> makes it possible to get any i2c driver early. Why not just mark all of
> the drivers/busses that get used on embedded devices as subsys_initcall,
> just in case somebody needs them early?

Because this is an abuse of subsys_initcall? I guess that was
acceptable when only a couple drivers were doing that, but making it
official sounds bad.

> (...)
> I just ran a sed script over the drivers/i2c directory. The intent was to
> mark the entire subsystem to come up early if CONFIG_I2C_EARLY is set,
> and use i2c_module_init every where since it makes it more consistent, and
> doesn't cost anything on setups where CONFIG_I2C_EARLY isn't defined.

It costs readability and build time.

> The idea was basically that a board could clearly say: I want i2c early,
> and have any busses and devices drivers it has configured as builtins
> automatically be present early on.

I get the idea, but I don't buy the implementation.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
