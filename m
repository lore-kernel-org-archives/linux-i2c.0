From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Mon, 14 Oct 2013 11:16:22 +0300
Message-ID: <20131014081622.GD3521@intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <2393462.4JRAMNeigd@vostro.rjw.lan>
 <20131012050413.GY3521@intel.com>
 <2878883.SYGmCkS5Bt@vostro.rjw.lan>
 <20131012161805.GB3521@intel.com>
 <525B9321.5000906@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <525B9321.5000906-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 14, 2013 at 09:45:53AM +0300, Jarkko Nikula wrote:
> On 10/12/2013 07:18 PM, Mika Westerberg wrote:
> >If we have two ACPI enumerated devices, they have following modalias:
> >
> >   i2c-device0:	i2c:INTABCD:00
> >		acpi:INTABCD
> >
> >   i2c-device1:	i2c:INTABCD:01
> >   		acpi:INTABCD
> >
> >Likelihood that some random I2C driver has INTABCD:00 or INTABCD:01 ids in
> >their list is minimal. However, when you turn it to this:
> >
> >
> >   i2c-device0:	i2c:INTABCD
> >		acpi:INTABCD
> >
> >   i2c-device1:	i2c:INTABCD
> >   		acpi:INTABCD
> >
> >It might be possible that we get a match that isn't supposed to happen.
> >Well, OK it is pretty remote but anyway :-)
> Well, name conflicts could occur of course but still I don't think
> we should generate illegal or wrong modaliases. I'm not an udev
> expert but I suppose trying to load nonexisting drivers
> (i2c_INTABCD:xy) could slow booting a little and perhaps pollute
> needlessly error log compared to if it can see that driver is
> already loaded or tries to load the same driver again.
> 
> I don't think name conflicts can pose too big risk as they are
> trivial to fix in sources and can be queued to stable too.

OK, you got me convinced :-)

No further objections from me.
