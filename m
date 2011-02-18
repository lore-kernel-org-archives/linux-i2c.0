From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 18 Feb 2011 19:28:05 +0100
Message-ID: <201102181928.05911.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <AANLkTikRUZRh0YnP8nYTKFnFeUiJbK5xKvHHjn_S+gZE@mail.gmail.com> <AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, khilman-l0cyMroinI0@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday, February 18, 2011, Rabin Vincent wrote:
> On Thu, Feb 17, 2011 at 20:55, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org> wrote:
> > This will solve the platform vs AMBA bus, but shouldn't we really be
> > aiming for consistent behaviour between these and the other busses such
> > as I2C and SPI, which are also usually commonly used on the same
> > platforms and are using GENERIC_PM_OPS?
> >
> > Should we be auditing all platform drivers and then switch platform to
> > the GENERIC_PM_OPS?
> >
> > Or should the two points (1) and (2) be not handled in the bus at all
> > and be left to individual drivers (in which case we should audit i2c and
> > spi and change GENERIC_PM_OPS)?
> 
> How about something like the below?  If we have something like this, we
> can just switch platform to GENERIC_PM_OPS and add the
> pm_runtime_want_interaction() (or something better named) call to the
> i2c and spi drivers using runtime PM.

Why don't we make platform_bus_type behave along the lines of generic ops
instead?

Rafael
