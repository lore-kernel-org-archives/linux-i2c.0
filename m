From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: i2ctools: Need capability to write SMBus block command
Date: Tue, 25 Jan 2011 09:14:11 -0800
Message-ID: <20110125171411.GA8511@ericsson.com>
References: <20110125162106.GA8024@ericsson.com>
 <20110125174922.4c802f49@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110125174922.4c802f49-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 25, 2011 at 11:49:22AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 25 Jan 2011 08:21:06 -0800, Guenter Roeck wrote:
> > I need the capability to write a SMBus block command with i2ctools.
> > 
> > Not an issue writing it myself. Question is if to expand i2cset to include
> > that capability, or to write a new command (i2csetblock ?) to do it.
> > 
> > Thoughts ?
> 
> This would probably be best discussed on the linux-i2c list than
> lm-sensors. Redirecting there...
> 
Yes, I noticed that after I sent my e-mail. Sorry for that.

> I would add it to i2cset. The only problem is that the command line
> convention of i2cset is a little tricky and thus hard to extend. But I
> see no reason why allowing multiple VALUEs followed by MODE s (for
> SMBus block) or i (for I2C block) wouldn't work. I suggest i and s
> because this is what i2cdump is using.
> 
Ok, that is pretty much along the line of what I was thinking. 
I'll implement that and submit it for review.

Thanks,
Guenter
