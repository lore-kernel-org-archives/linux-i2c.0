From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 3 May 2012 14:59:25 +0200
Message-ID: <201205031459.25262.rjw@sisk.pl>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com> <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com> <CACRpkdbj+cF7d_=QmqtXTGS4s3Jrr7vxnrt5VbHMDO=an_cVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbj+cF7d_=QmqtXTGS4s3Jrr7vxnrt5VbHMDO=an_cVow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Rickard ANDERSSON <rickard.andersson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, May 03, 2012, Linus Walleij wrote:
> On Wed, Apr 18, 2012 at 8:39 AM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > I'm a bit hesitant to ack because the runtime suspend/resume callbacks
> > are used differently than we would do on arch/sh and
> > arch/arm/mach-shmobile. This difference may or may not be a good
> > thing. I'm afraid I know too little about the nomadik platform to say
> > anything wise. =)
> >
> > Our drivers assume that the ->runtime_suspend() and ->runtime_resume()
> > callbacks are executed before/after the power is turned off/on for a
> > certain power domain. The way they are used in this patch more seems
> > like they are expected to be called regardless of the state of the
> > rest of the devices sharing the underlying power domain.
> 
> After discussing this internally a bit I think this is the central point here,
> and yes that is indeed how it is written.
> 
> We are not using runtime_[suspend|resume]() like that but want
> this to be handled on each and every driver in isolation.
> 
> So our handler kicks in at the pm_domain level, then calls the
> driver hook from the domain by a simple
> pm_generic_runtime_suspend(dev) *every* time, not just
> if the power domain was switched on/off.
> 
> The reason is mainly that we want register save/restore to be done
> as soon as a driver needs it, not before/after its power domain is cut
> as mentioned here.
> 
> Example: the system is sleeping. We need to wake up and do
> some sporadic task in one driver, then go back to sleep.
> 
> If *all* runtime_resume() hooks for *all* devices in the same power
> domain are called at this time on the way up/down we get a major
> overhead as our primary power domain is pretty big.

FWIW, in the generic PM domains framework used on the sh7372 platform we have
a need_restore flag whose meaning is whether or not to call .runtime_suspend()
(or its domain-specific counterpart) when the domain is about to be powered
off and .runtime_resume() when the device is resumed by the runtime PM
framework.  Those two callbacks are meant to save and restore the device's
state, respectively, and there are two more domain-specific callbacks,
.stop() and .start() that (in the case of sh7372) manipiulate the devices'
clocks.

So, if pm_runtime_suspend() is called for a device, we first check if it's OK
to call .stop() for it (according to PM QoS constraints), but we don't call
.runtime_suspend() for it yet at this point.  Next, we check if it's OK to
power off the domain containing the device (taking PM QoS constraints and
subdomains into consideration) and if we decide to do that, we call
.runtime_suspend() for the devices in the domain, but only those whose
need_restore flags are unset.  Then, if pm_runtime_resume() is called for
one of the devices, we check its need_restore flag and call .runtime_resume()
for the device if the flag set and .start() is called subsequently.

> We prefer to be able to control on a per-driver instance how this
> is handled. That may include e.g. clock handling as part of the
> pm_runtime hooks, but not necessarily, register save/restore is
> the big bulk of work.
> 
> Another thing that sort of mandates this approach is that we
> have drivers that are used on multiple systems beside ux500.
> E.g the UART PL011 is used on a plethora of systems.
> 
> Some of these may use the bus hooks (or type, class...)
> calling into the drivers runtime_pm() hooks, if we start to
> encode semantics into the driver regarding how these hooks
> get called or assume they are always called from a power
> domain we're inviting disaster I'm afraid :-/

The generic PM domains framework allows you to use different callbacks
with domains in general (ie. it is possible to use two different sets of
PM callbacks depending on whether the device is in a domain or not).

There may be a couple of things still missing depending on the use case, but
the general support is there.

> On systems where we know the driver is always used with
> power domains the world is easier, but this is not the case
> here. This piece of code in rumtime PM is the source of the
> confusion:
> 
>         if (dev->pm_domain)
>                 callback = dev->pm_domain->ops.runtime_suspend;
>         else if (dev->type && dev->type->pm)
>                 callback = dev->type->pm->runtime_suspend;
>         else if (dev->class && dev->class->pm)
>                 callback = dev->class->pm->runtime_suspend;
>         else if (dev->bus && dev->bus->pm)
>                 callback = dev->bus->pm->runtime_suspend;
>         else
>                 callback = NULL;
> 
>         if (!callback && dev->driver && dev->driver->pm)
>                 callback = dev->driver->pm->runtime_suspend;
> 
> So for a particular driver we don't know which one it's
> going to be.

This doesn't seem to be particularly difficult to figure out in advance, though.

The diffucult part is to know what the domain/subsystem will do in addition to
executing your callbacks, but the general idea is that drivers shouldn't need
to know that.  I know that that's kind of not in agreement with reality, however.

> But we need to assume they all call down to the runtime_suspend/resume hooks
> with something like pm_generic_runtime_suspend(dev) regardless.
> 
> For example the bus code for AMBA does this:
> 
> static int amba_pm_runtime_suspend(struct device *dev)
> {
>         struct amba_device *pcdev = to_amba_device(dev);
>         int ret = pm_generic_runtime_suspend(dev);
> 
>         if (ret == 0 && dev->driver)
>                 clk_disable(pcdev->pclk);
> 
>         return ret;
> }
> 
> Platform devices does this:
> 
> static const struct dev_pm_ops platform_dev_pm_ops = {
>         .runtime_suspend = pm_generic_runtime_suspend,
>         .runtime_resume = pm_generic_runtime_resume,
>         .runtime_idle = pm_generic_runtime_idle,
>         USE_PLATFORM_PM_SLEEP_OPS
> };
> 
> So ... we assume pm_generic_runtime_suspend() is always
> called one way or another. How else can we have code that
> work with both bus code like this and out power domains?
> 
> I see that shmobile does something totally different, but its
> drivers are not used by others are they?

Yes, they are, by the sh architecture.

There are a few things missing here still, as I said above, but in the end
a driver should be able to learn whether or not it is used along with a PM
domain (as in the generic PM domains framework) and adjust to that.

> > You probably
> > want to control the clocks and the regulators directly - independently
> > of the rest of the devices.You may want to look into struct
> > gpd_dev_ops for various ways to interface to the pm domain code.
> 
> In this specific driver we may want to keep the clock control
> in the main code path, and move the regulator, which is actually
> a power domain switch, to the power domain (genpd) framework.
> 
> But that is not the case with all drivers, so while I can device a
> way forward in this case it doesn't play well in the generic sense.

I think the number of different use cases is limited, though, so it
should be possible to cover them all somehow. :-)

Thanks,
Rafael
