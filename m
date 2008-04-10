From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc8] i2c: fix platform driver
	hotplug/coldplug
Date: Thu, 10 Apr 2008 11:07:17 -0700
Message-ID: <200804101107.18130.david-b@pacbell.net>
References: <200804091354.07807.david-b@pacbell.net>
	<200804100949.10255.david-b@pacbell.net>
	<20080410103009.0d3f39ec.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080410103009.0d3f39ec.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 April 2008, Andrew Morton wrote:
> On Thu, 10 Apr 2008 09:49:09 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > It was a regresssion as of 2.6.24, for 200+ drivers;
> > every platform_bus driver used have hotplug/coldplug
> > support, but that patch stopped that from working.
> > 
> > The thing is, that had only been working for a few
> > releases at that time, so not many folk were relying
> > on it yet.  They would just have been able to start
> > doing so when that mechanism stopped working.
> > 
> > So I can't see a rush to get this into 2.6.25 now.
> > I think the 200+ drivers will hotplug/coldplug again
> > in 2.6.26 ... I've pushed almost a hundred such driver
> > updates by now (sigh).
> > 
> 
> Oh.  I was thinking we should slam all these fixes into 2.6.25.

I would not object to that.  I can't see the patches I
signed off on could break anything, and I dislike the
notion of regression fixes getting deferred even longer.

(That includes I2C, RTC, SPI, USB, and Watchdog patches
I posted yesterday, and the earlier EHCI one ... fixing
about 90 drivers, and those entire subsystems.)

It's just that one kind of gets the feeling 2.6.25-final
was just around the corner... and there's still the 122
drivers from Kay's patch to review, plus the ones missing
from those patches.  (Another 15-20 percent if numbers
from the subsystems I looked at continue to hold.)


> If a couple fo them cause problems then we can patch things up in
> 2.6.25.x, but that's beter than having hundreds of broken drivers.
> 
> Or does your "as of" above mean that 2.6.24 is also busted?

Yes, that "platform:" change broke hotplug/coldplug for
most platform_bus drivers on 2.6.24 kernels too.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
