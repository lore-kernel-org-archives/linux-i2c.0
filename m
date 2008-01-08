From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Forcing an adapter onto a bus
Date: Tue, 8 Jan 2008 20:52:06 +0100
Message-ID: <20080108205206.75b74fbb@hyperion.delvare>
References: <9e4733910801030909v70ddc068xfb658bf15c5f8924@mail.gmail.com>
	<20080108175804.2bb2671b@hyperion.delvare>
	<9e4733910801080922p7f302876y34e1a10c27e68c45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910801080922p7f302876y34e1a10c27e68c45-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 8 Jan 2008 12:22:54 -0500, Jon Smirl wrote:
> On 1/8/08, Jean Delvare wrote:
> > On Thu, 3 Jan 2008 12:09:27 -0500, Jon Smirl wrote:
> > > If adapter->dev.parent is NULL the current i2c code forces the adapter
> > > onto the platform bus.  But this may not be what you want on the
> > > powerpc since it mainly uses of_platform_bus.  What about changing
> > > this to an error condition and fixing the drivers that don't set it
> > > right?
> >
> > I've been there and tried to do that, some times ago. See for example:
> > http://lists.lm-sensors.org/pipermail/i2c/2007-February/000781.html
> >
> > I converted a good load of drivers back then but there are still more
> > to do.
> >
> > I don't really get the link between the patch below and the fact that
> > powerpc uses of_platform_bus. With or without your patch, the powerpc
> > drivers will have to properly declare their parent device.
> 
> I turned off platform bus in my PowerPC builds since it is replaced by
> of_platform_bus on powerpc. Turning off platform bus causes compile
> errors is various places in the kernel. I then check them to see what
> was wrong. In the case of the PowerPC this code would do the wrong
> thing by putting the device onto platform bus. The incorrect
> assumption here is that every platform has a platform bus that is
> used.

OK, I see your point now. Indeed I thought that the platform bus was
always available, I didn't know that you could go without it. Not sure
how you did that, BTW, I see no configuration option to select the
platform bus?

> Fixing things in the driver core that the drivers should have set is a
> bad idea.

I agree, but that was done so for historical reasons. All these drivers
predate the 2.5 device driver model, and nobody had the time to convert
them.

> (...) How about upping this to a visible waning message on boot
> that encourages the driver authors to fix their drivers? It only take
> a few seconds to fix the driver once you know which ones need to be
> fixed.  Then change it to an error in 2.6.26 and remove the check in
> 2.6.27.

It takes more than a few seconds if you really update the driver to
cleanly fit in the device driver model, otherwise we would already have
done so. If you just update the driver to set its parent device to
&platform_bus as i2c-core is doing now, then of course it is fast. For
some reason I had never considered this possibility. It probably makes
sense, as long as you add a FIXME comment nearby so that people realize
that it's only a band aid. If you do that for all remaining bus drivers
than I would be fine applying the patch that you submitted earlier
(that turns the debug message into an error.)

Just to make it clear: there is no amount of time after the moment we'll
make i2c-core display a warning where it will become acceptable to just
break the remaining drivers. We can invite driver authors to help but
we can't force them to do so, and we can't break their drivers in
reprisal. If there are unconverted drivers remaining at the time you'd
like to turn the warning into an error, then you have to fix these
drivers yourself, that's the rule. Which is why I suggest that you do
it right now if you want things to happen fast.

-- 
Jean Delvare
