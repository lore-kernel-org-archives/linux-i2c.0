From: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Thu, 12 Jun 2008 08:23:14 +1200
Message-ID: <48503432.6010105__37811.4590225325$1213172717$gmane$org@bluewatersys.com>
References: <200806091541.43899.u.luckas@road.de>	<484DA046.4010804@bluewatersys.com>	<20080610085708.12c2d2a2@hyperion.delvare>	<200806101355.07792.david-b@pacbell.net>
	<20080611101130.1a667abe@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611101130.1a667abe-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
>
> That's easier to get right if you restrict yourself to a single
> platform. For the vanilla kernel, the order of the dependencies is way
> more difficult to figure out and get right. There are some hints in
> drivers/Makefile but most dependencies aren't spelled out.
>
> My feeling is that we won't be able to solve this without first moving
> the different type of i2c bus drivers (and possibly chip drivers) to
> separate directories. For example, moving external I2C bus drivers
> (i2c-parport-light, i2c-parport, i2c-taos-evm and i2c-tiny-usb) to a
> separate directory that is always initialized late, would remove the
> dependencies on parport, serio and USB for the "must initialize i2c
> early" problem.
>
> I've already attempted a categorization of the i2c bus drivers:
> http://lists.lm-sensors.org/pipermail/i2c/2008-May/003713.html
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-group-bus-drivers.patch
> I would welcome comments on this, and suggestions for further
> categorization of group "other".
>   
I like this idea. Is it possible to move (or mark as subsys_initcall) the
i2c busses which are likely to be needed early: pxa, omap, gpio, etc and
leave the PC/external busses alone. Then having the i2c chip drivers in
the correct place (ie drivers/gpio) would effectively fix the problem.

~Ryan


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
