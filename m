From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 21:22:37 +0200
Message-ID: <20140409212237.377629a2@endymion.delvare>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	<1397061392.5276.11.camel@x230>
	<53457D0D.7020805@redhat.com>
	<1397063381.5276.17.camel@x230>
	<5345849F.6070909@redhat.com>
	<1397065034.5276.19.camel@x230>
	<53458992.4060003@redhat.com>
	<1397066342.5276.21.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397066342.5276.21.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Apr 2014 17:59:03 +0000, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 13:55 -0400, Prarit Bhargava wrote:
> > 
> > On 04/09/2014 01:37 PM, Matthew Garrett wrote:
> > > Right. It's dangerous, which is why we forbid it by default. How do we
> > > benefit from having a driver that's no safer?
> > 
> > We have yet to see where the existing case exhibits the behaviour of a race.  In
> > fact, AFAICT, all we've seen is stability.  So it's no safer?  Yep.  It's as
> > equally not racy as the existing workaround.
> 
> So... why add the driver at all? Refusing to permit the kernel to touch
> these resources is a deliberate design choice, because of the potential
> for these races. (...)

So it is a deliberate design choice to prevent the user from accessing
his/her own hardware? I want to be able to read the SPD EEPROMs and the
temperature sensors on my memory modules, and this requires SMBus
access.

The ACPI interface to hardware monitoring chips is horribly limited.
Until the ACPI people come up with something which really exposes most
of the features of the hardware monitoring chips currently provide,
native access it required. At the moment, when a full-featured hardware
monitoring chip monitors 5 to 10 voltage inputs, 5 fans and 3
temperature sensors, ACPI will show 2 thermal zones at best, not always
updated in real-time, with limited resolution, and the fans are shown
without their speed. That simply sucks.

So we need either proper ACPI interfaces to all the useful features, or
low-level, safe access to the registers through ACPI. Until we have
that, we are condemned to live dangerously in an hostile world :(

-- 
Jean Delvare
SUSE L3 Support
