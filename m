From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add support for device-tree based chip
 initialization
Date: Mon, 26 Nov 2012 19:40:05 -0800
Message-ID: <20121127034005.GB28656@roeck-us.net>
References: <1353905636-6697-1-git-send-email-linux@roeck-us.net>
 <50B39C3A.5080600@gmail.com>
 <20121126201954.GA14617@roeck-us.net>
 <50B3EF21.9020201@gmail.com>
 <50B3F41E.3020805@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50B3F41E.3020805-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2012 at 12:58:38PM -1000, Mitch Bradley wrote:
> On 11/26/2012 12:37 PM, Rob Herring wrote:
> > On 11/26/2012 02:19 PM, Guenter Roeck wrote:
> >> On Mon, Nov 26, 2012 at 10:43:38AM -0600, Rob Herring wrote:
> >>> On 11/25/2012 10:53 PM, Guenter Roeck wrote:
> >>>> Some I2C devices are not or not correctly initialized by the firmware.
> >>>> Configuration would be possible via platform data, but that would require
> >>>> per-driver platform data and a lot of code, and changing it would not be
> >>>> possible without re-compiling the kernel. It is more elegant to do it
> >>>> generically via devicetree properties.
> >>>>
> >>>> Add a generic I2C devicetree property named "reg-init". This property provides
> >>>> a sequence of device initialization commands to be executed prior to calling
> >>>> the probe function for a given device.
> >>>>
> >>>> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> >>>> ---
> >>>> Any comments / feedback ?
> >>>
> >>> This has been discussed before in terms of memory mapped registers. I
> >>> think this is of questionable use of DT and could easily be abused. Not
> >>
> >> Isn't that true for pretty much everything ?
> >>
> >> Really, I don't think that "it can be abused" should be considered a valid
> >> argument. It is almost as good (or bad) as "we have always done it that way"
> >> or "this doesn't scale".
> > 
> > DT is a description of the h/w. It is not a h/w configuration mechanism.
> 
> And yet, the document that defined the device tree is entitled "IEEE
> Standard for Boot (Initialization, Configuration) Firmware".
> Initialization and configuration was part of the problem set, and part
> of the solution set, from the outset.
> 
Many of the dt properties could be removed if it were only a HW description,
and it would be quite worthless. One of the arguments for dt was that it can be
used to replace platform data, which is widely used to provide configuration
data.


> > Although, you do lots of h/w configuration based on the h/w description.
> > That being said, you can find examples in bindings that are just
> > configuration data so it's not a clear line.
> > 
> > If we do want to support this, then there is no reason for it to be
> > specific to i2c devices or ethernet phys. It was on the pinmux/pinctrl
> > binding discussions the last time this came up IIRC. The first issue
> > will be the need to specify register sizes. Then you get into needing
> > masked writes. Then you need delays and polling reads of register
> > values. Then the discussion dies when it starts to look like a scripting
> > language and Forth is mentioned (happened just last week with runtime
> > interpreted power sequences thread).
> 
> It would be nice if hardware were simple enough not to need the power of
> a programming language to initialize it, or if hardware variants did not
> proliferate to the point where building new kernels became unattractive.
>  The world doesn't appear to be going in that "nice" direction...
> 
I didn't plan to solve all problems in the world - for i2c I'd be happy with 90%
or even 80%. That would help me to avoid having to write explicit code for those 80%.

> The longer that one resists doing the right thing, the more likely that
> one ends up saddled with a bad half-solution that has to be extended
> into a truly awful hodgepodge.
> 
At least, as David has pointed out, there is already a precedence for reg-init.

Personally I prefer a working solution for existing problems now over a
solution which is supposed to solve all problems in the world ... until the next
problem comes up and it turns out that the solution doesn't work for it. Which,
in my experience, happens all the time if one tries to come up with solutions
for future problems.

Guenter
