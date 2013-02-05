From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Feb 2013 17:41:03 +0100
Message-ID: <20130205174103.0190f7e4@endymion.delvare>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<1360007650-26272-1-git-send-email-nhorman@tuxdriver.com>
	<DEC3922D1904474A8862C7BFF516EA9A59B4A8B8@ORSMSX101.amr.corp.intel.com>
	<20130205081642.5349bd1a@endymion.delvare>
	<20130205145230.GA4511@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130205145230.GA4511-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 5 Feb 2013 09:52:30 -0500, Neil Horman wrote:
> On Tue, Feb 05, 2013 at 08:16:42AM +0100, Jean Delvare wrote:
> > On Tue, 5 Feb 2013 01:13:56 +0000, Heasley, Seth wrote:
> > > Hi Neil,
> > > 
> > > >General note - Seth had mentioned to me that he was unable to get writes to
> > > >work on his system.  I'm not sure of the details, but I've done some
> > > >rudimentary read/write testing here on my system, and it seems to work well
> > > >(for the limited testing I can do).  Seth if you could please provide details of
> > > >your testing, or give this patch a try, I would appreciate it.
> > > 
> > > Whatever issues I was having with the previous patch, they appear to be resolved.  I was able to do testing similar to yours, albeit using an external slave device.  I'm not seeing the device at 0x54 on my system.  But reads and writes both worked.
> > 
> > Great news, thanks for testing and reporting!
> > 
> Yes, thank you Seth.  I think that puts version 7 at tested by all three of us,
> and working.  Jean, any other fixups you feel are needed?

No, it looks good now. Wolfram, please queue this new driver for kernel
3.9.

I have also made the driver available as a standalone source file at:
  http://khali.linux-fr.org/devel/misc/i2c-ismt/
Testers can be pointed to this location. This version of the driver has
some compatibility code to build at least down to kernel version 3.0.

-- 
Jean Delvare
