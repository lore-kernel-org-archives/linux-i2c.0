From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Thu, 7 Apr 2011 07:22:44 +0200
Message-ID: <201104070722.44771.rjw@sisk.pl>
References: <20110406095240.410b4e7e@endymion.delvare> <20110406223123.GA5297@opensource.wolfsonmicro.com> <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, April 07, 2011, Sonny Rao wrote:
> On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
> <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> > On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
> >
> >> Neither is the case.  For these subsystems, the PM dependencies _are_
> >> known.
> >
> > ...
> >
> >> Now, I have no idea what the situation is with regard to I2C...
> >
> > You definitely don't know *anything* about the relationships for I2C,
> > especially in embedded systems.
> >
> 
> Would it be okay to enable this on a per-device basis where it is
> known to be safe?

Yes.

> I started out doing it like this,  but I didn't like the way the patch looked
> because it ended up having to call this function twice -- once on the i2c
> master device and once on it's client devices (and actually a third time
> because it had another struct dev for the industrial IO device).  So,
> that seemed pretty ugly.
> 
> Also, it didn't seem to match the usage of device_enable_async_suspend()
> in other parts of the kernel where it was used on whole subsystems.

It is used by subsystems where dependencies between devices are known to
generally follow the structure of the device hierarchy within the kernel
(i.e. they are well-defined buses with well-defined parents and children).

Thanks,
Rafael
