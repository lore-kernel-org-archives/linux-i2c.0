From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 21:01:05 +0200
Message-ID: <20140409210105.330211c9@endymion.delvare>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	<1397061392.5276.11.camel@x230>
	<53457D0D.7020805@redhat.com>
	<1397063381.5276.17.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397063381.5276.17.camel@x230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Apr 2014 17:09:41 +0000, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 13:02 -0400, Prarit Bhargava wrote:
> > On 04/09/2014 12:36 PM, Matthew Garrett wrote:
> > > method with one of these names exists is no guarantee that it has the
> > > same behaviour as the ones on your board. There's no guarantee that
> > > you're not racing against the firmware.
> > 
> > I think there is -- AFAICT the operations are serialized; if they aren't that is
> > an associated risk.  Hopefully someone from Intel will lend a hand here and let
> > me know if I'm doing something horrible ;)
> 
> Imagine an i2c chip with indexed register access. What stops:
> 
> CPU0 (i2c):		CPU1 (ACPI):
> SBWB register address
> 			SBWB register address
> SBRB register value
> 			SBRB register value
> 
> and CPU0 getting back the wrong value?

Certainly there is some ACPI lock to prevent ACPI from racing with
itself. Can't we just use it too?

-- 
Jean Delvare
SUSE L3 Support
