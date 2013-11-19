From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.13
Date: Tue, 19 Nov 2013 17:00:01 +0200
Message-ID: <20131119150001.GM2281@intel.com>
References: <20131118193802.GA14925@katana>
 <CA+55aFxZaC=beR+dN36Sv==6fjY7SdOdwXaSHU+wnk+-oDJp4g@mail.gmail.com>
 <3690707.5664qBQcL8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3690707.5664qBQcL8-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 19, 2013 at 01:11:25AM +0100, Rafael J. Wysocki wrote:
> On Monday, November 18, 2013 03:46:34 PM Linus Torvalds wrote:
> > On Mon, Nov 18, 2013 at 11:38 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > >
> > > here is the pull request from the i2c subsystem for 3.13:
> > 
> > So while resolving some fairly trivial conflicts here, I noticed that
> > commit a76e9bd89ae7 ("i2c: attach/detach I2C client device to the ACPI
> > power domain") that I got earlier through the ACPI/PM tree calls
> > acpi_dev_pm_detach() even when the device "->remove()" function fails.
> > But it only sets clientdata to NULL if it succeeds.
> > 
> > That looks a bit odd.
> > 
> > I didn't try to fix it, though. I just thought I'd point out the oddity.
> 
> Well, given that the driver core doesn't even check the return value of
> dev->bus->remove(dev), I think doing the unconditional acpi_dev_pm_detach()
> is actually correct and clientdata should be cleared unconditionally too.

Actually, can we remove the whole clientdata setting there?

Commit 0998d0631001 (device-core: Ensure drvdata = NULL when no driver is
bound) modified the driver core to always clear out that field. Same seems
to apply if driver probe fails.
