From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Mon, 20 Dec 2010 15:00:52 +0000
Message-ID: <20101220150051.GI26706@rakim.wolfsonmicro.main>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
 <201012181354.58077.rjw@sisk.pl>
 <20101218132029.GA22273@opensource.wolfsonmicro.com>
 <201012181559.50347.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012181559.50347.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 18, 2010 at 03:59:50PM +0100, Rafael J. Wysocki wrote:

> Second, the situation at hand is that the bus type implements dev_pm_ops,
> but the driver doesn't.  Now, pm_generic_suspend() is called with a struct
> device pointer, so it would have to go back to dev->bus, find the
> ->legacy_suspend() callback (as opposed to ->suspend(), which also is legacy,
> but is called by the PM core instead).  May I call that confusing?

Well, the trouble is that the whole situation is already pretty
confusing for what should be very simple buses, each one needs to write
a bunch of not really bus specific code in order to get basic behaviour
which allows the drivers to make use of runtime PM, requiring more
thought and care per bus than I'd expect given that they've nothing
really to contribute.  This leads to the sort of random variations
between buses that Rabin is reporting, and means that updates keep
having to get done in multiple different places.

The overall effect is that from the point of view of trying to use
runtime PM in drivers which work with these simple buses everything
feels like it's much harder work than it should be.  Moving all the
decision making out of the buses and into the PM core seems like a win
here.
