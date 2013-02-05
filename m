From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Feb 2013 09:52:30 -0500
Message-ID: <20130205145230.GA4511@hmsreliant.think-freely.org>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
 <1360007650-26272-1-git-send-email-nhorman@tuxdriver.com>
 <DEC3922D1904474A8862C7BFF516EA9A59B4A8B8@ORSMSX101.amr.corp.intel.com>
 <20130205081642.5349bd1a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130205081642.5349bd1a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 05, 2013 at 08:16:42AM +0100, Jean Delvare wrote:
> On Tue, 5 Feb 2013 01:13:56 +0000, Heasley, Seth wrote:
> > Hi Neil,
> > 
> > >General note - Seth had mentioned to me that he was unable to get writes to
> > >work on his system.  I'm not sure of the details, but I've done some
> > >rudimentary read/write testing here on my system, and it seems to work well
> > >(for the limited testing I can do).  Seth if you could please provide details of
> > >your testing, or give this patch a try, I would appreciate it.
> > 
> > Whatever issues I was having with the previous patch, they appear to be resolved.  I was able to do testing similar to yours, albeit using an external slave device.  I'm not seeing the device at 0x54 on my system.  But reads and writes both worked.
> 
> Great news, thanks for testing and reporting!
> 
Yes, thank you Seth.  I think that puts version 7 at tested by all three of us,
and working.  Jean, any other fixups you feel are needed?

Neil
