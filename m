From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.13
Date: Tue, 19 Nov 2013 01:11:25 +0100
Message-ID: <3690707.5664qBQcL8@vostro.rjw.lan>
References: <20131118193802.GA14925@katana> <CA+55aFxZaC=beR+dN36Sv==6fjY7SdOdwXaSHU+wnk+-oDJp4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+55aFxZaC=beR+dN36Sv==6fjY7SdOdwXaSHU+wnk+-oDJp4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, November 18, 2013 03:46:34 PM Linus Torvalds wrote:
> On Mon, Nov 18, 2013 at 11:38 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> > here is the pull request from the i2c subsystem for 3.13:
> 
> So while resolving some fairly trivial conflicts here, I noticed that
> commit a76e9bd89ae7 ("i2c: attach/detach I2C client device to the ACPI
> power domain") that I got earlier through the ACPI/PM tree calls
> acpi_dev_pm_detach() even when the device "->remove()" function fails.
> But it only sets clientdata to NULL if it succeeds.
> 
> That looks a bit odd.
> 
> I didn't try to fix it, though. I just thought I'd point out the oddity.

Well, given that the driver core doesn't even check the return value of
dev->bus->remove(dev), I think doing the unconditional acpi_dev_pm_detach()
is actually correct and clientdata should be cleared unconditionally too.

Rafael
