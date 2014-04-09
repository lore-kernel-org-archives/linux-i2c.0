From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 20:56:14 +0200
Message-ID: <20140409205614.2ee3c25c@endymion.delvare>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	<1397061392.5276.11.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397061392.5276.11.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthew,

On Wed, 9 Apr 2014 16:36:32 +0000, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 12:22 -0400, Prarit Bhargava wrote:
> > RFC and a work in progress ... I need to go through and do a bunch of error
> > condition checking, more testing, etc.  I'm just throwing this out there to see
> > if anyone has any major concerns about doing something like this.
> 
> This isn't really a good approach. These aren't standardised ACPI
> methods, so you have no guarantee that they exist. The fact that a
> method with one of these names exists is no guarantee that it has the
> same behaviour as the ones on your board. There's no guarantee that
> you're not racing against the firmware.
> 
> These systems simply don't safely support OS-level i2c access.

But people need that. And they have been for almost a decade. It's
about time that hardware vendors realize that. Yes, I mean Intel,
amongst others.

Prarit's approach may not be perfect but it has the merit of bringing
the topic for discussion, at last. And using his driver would still be
much safer than using i2c-i801 with acpi_enforce_resources=lax. If we
can come up with a detection method that is reliable enough, it looks
completely acceptable to me.

Of course it would be much better if vendors could just implement the
standard SMBus CMI interface, but having a way to deal with existing
hardware and BIOSes is still good.

-- 
Jean Delvare
SUSE L3 Support
