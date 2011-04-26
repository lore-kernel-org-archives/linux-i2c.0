From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] misc: Driver for Silicon Labs Si570 and compatibles
Date: Tue, 26 Apr 2011 16:00:23 +0200
Message-ID: <201104261600.23675.arnd@arndb.de>
References: <1303248968-5069-1-git-send-email-guenter.roeck@ericsson.com> <20110421233415.GC2786@local> <1303501213.31666.27.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303501213.31666.27.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: "Hans J. Koch" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 22 April 2011, Guenter Roeck wrote:
> On Thu, 2011-04-21 at 19:34 -0400, Hans J. Koch wrote:
> > I don't think the UIO framework is the right place for such a thing. If it's
> > just this one driver that needs modification of a clock from userspace, then
> > a sysfs attribute could be added to that driver. If there are several drivers
> > that need this, then the clock framework should be extended.
> 
> Agreed. Also, the desire to control the clock frequency through such a
> driver (user mode or not) seems odd. Such an approach would be
> inherently non-scalable (for my part I would have to support two drivers
> already). Voltage regulators are not controlled through the drivers of
> the chips they are providing power to either, but have an independent
> existence.

I think you are talking about different things here. What I think
Hans was saying is that it should be in the specific UIO driver, not
in the framework, which I can agree with. If we get a bunch of these,
we can still make it generic at a later point, but that is not your
problem.

I think exporting the clock to kernel drivers as a struct clk is
the most useful approach to allow reuse, and then you just have to
interface to that from your existing UIO driver.

	Arnd
