From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 20:45:05 -0400
Message-ID: <9e4733910806041745n27a0da42p2fb6145f961fa7b7@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<Pine.LNX.4.58.0806041638080.10290@shell4.speakeasy.net>
	<200806041727.51746.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806041727.51746.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/4/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 04 June 2008, Trent Piepho wrote:
>  > Couldn't you say the probe function is called on a potential device?  The
>  > probe function can return -ENODEV, in which can other driver's probes get
>  > called, and it's perfectly ok if no driver binds to it.
>  >
>  > The way PCI works, is that when a new pci bus is created, each address is
>  > probed
>
>
> ... by config space accessors which all PCI devices support.

I made a mistake comparing this to PCI IDs. I should not have used PCI
IDs as an example and gotten us off on the tangent of not having a
global i2c device namespace.

Adding the address range to search is an unrelated problem to the name
space issue.


>
>
>
>  > and a device is created if anything responds.  The generic bus code
>  > tries to match each device to a driver or drivers
>
>
> ... using a formally managed set of product identifiers.
>
>
>
>  >        and calls those drivers'
>  > probe functions.  The drivers don't have to claim the device in the probe
>  > function.  The bus code handles all the cases of a driver or bus getting
>  > added or removed in various orders.
>  >
>  > So why can't I2C do this too?
>
>
> No such product identifiers, and in general no way to tell
>  what's sitting at a given address.  And in fact, there's no
>  sure way to tell if a device is present there, since when
>  an I2C device is busy, it's not required to ack its address.
>
>
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
