From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 17:03:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806041638080.10290@shell4.speakeasy.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
	<9e4733910806041228i330e145q439d3ee43494f4c4@mail.gmail.com>
	<20080604233335.13459512@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604233335.13459512-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 4 Jun 2008, Jean Delvare wrote:
> On Wed, 4 Jun 2008 15:28:54 -0400, Jon Smirl wrote:
> > On 6/4/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > >  > Hi all,
> > >  >
> > >  >  This patch set demonstrates a new concept which I would like to add to
> > >  >  the i2c subsystem. It is named "i2c listeners" and is based on the
> > >  >  following structure:
> >
> > Could the existing API be used something like this?
> >

> > scans the registered driver structures looking for class matches. When
> > a match is encountered it repeatedly calls the driver's probe function
> > with the addresses from the range. Driver returns true/false on each
> > probe which triggers creation of the device.
>
> The driver's probe function is, by definition of the device driver
> model, called on an existing device. So the probe function cannot
> decide whether the device should be created or not - it's too late at
> this point.

Couldn't you say the probe function is called on a potential device?  The
probe function can return -ENODEV, in which can other driver's probes get
called, and it's perfectly ok if no driver binds to it.

The way PCI works, is that when a new pci bus is created, each address is
probed and a device is created if anything responds.  The generic bus code
tries to match each device to a driver or drivers and calls those drivers'
probe functions.  The drivers don't have to claim the device in the probe
function.  The bus code handles all the cases of a driver or bus getting
added or removed in various orders.

So why can't I2C do this too?

When a new bus is created, the i2c core scans it and creates a device for
each chip that responds.  Each driver's probe function is called in turn on
the device and it gets to device if it wants to drive it or not, probably
based on i2c address range since there is usually little else to go on.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
