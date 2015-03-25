From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 25 Mar 2015 09:37:03 -0700
Message-ID: <20150325163703.GA8389@roeck-us.net>
References: <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
 <20150319213937.GA899@katana>
 <5512C213.7030705@roeck-us.net>
 <20150325161504.GA29838@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150325161504.GA29838@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 25, 2015 at 05:15:04PM +0100, Wolfram Sang wrote:
> Guenter,
> 
> thanks for the update
> 
> > Ultimately, the real problem is how i2c-dev accesses a client, not how
> > i2c client drivers (who assume they have exclusive access to a chip)
> > handle multi-command sequences. Forcing extensive locking on all drivers
> > because of i2c-dev just doesn't seem to be the right thing to do.
> 
> I agree. i2c-dev is too much of a special case.
> 
> And since at24 has its own lock (I missed that), your patch might as
> well be good enough to be applied, I'd think.
> 

Ah, sorry, I blindly assumed that you are aware of that. Yes, at24
itself is not the problem, it is parallel access to the chip by i2c-dev.

The same is actually true for all the other drivers I looked at;
usually they have their own lock(s), but such locks do not protect
against interference by i2c-dev.

The bad part is that i2c-dev is heavily used by user space at my
workplace, and that code happily messes with chips which are also
handled by kernel drivers. But as I said, I have no real good idea
how to fix that - neither the user-space code nor how i2c-dev
interfers with (or completely messes up) device access by drivers.

Thanks,
Guenter
