From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] i2c/gpio: add DT support
Date: Mon, 20 Feb 2012 15:51:37 +0100
Message-ID: <20120220145137.GG11307@game.jcrosoft.org>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
 <4F3945B1.9070900@samsung.com>
 <20120220095813.GB11307@game.jcrosoft.org>
 <20120220100843.GE22562@n2100.arm.linux.org.uk>
 <20120220102231.GC11307@game.jcrosoft.org>
 <20120220125054.GF22562@n2100.arm.linux.org.uk>
 <20120220143557.02787bad@endymion.delvare>
 <20120220135106.GA26840@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120220135106.GA26840-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 13:51 Mon 20 Feb     , Russell King - ARM Linux wrote:
> On Mon, Feb 20, 2012 at 02:35:57PM +0100, Jean Delvare wrote:
> > On Mon, 20 Feb 2012 12:50:54 +0000, Russell King - ARM Linux wrote:
> > > What is linux specific is specifying the _delay_ rather than specifying
> > > the bus frequency.  So as soon as you're trying to justify not adding
> > > the units because they may be linux specific, you've already lost that
> > > argument by using a delay rather than a bus frequency.  You can't have
> > > it both ways.
> > 
> > While I am not much into DT and did not follow this thread too
> > carefully... I seem to understand that the dispute is mainly on
> > frequency vs. udelay specification for the bus speed, Jean-Christophe
> > arguing that hardware-specific delays are added when changing e.g. a
> > GPIO pin output value and thus the frequency can't be guaranteed. Do I
> > get this right?
> 
> This sub-thread is more about the units of the properties rather
> than the properties themselves.
> 
> What's being proposed is to have two properties, one named 'udelay'
> which takes microseconds, and one named 'timeout' which takes
> milliseconds.
> 
> I'm saying that's a completely absurd proposal, as the proposal is
> for two opaque numeric properties with different units.  At least
> make the units the same, or as Karol said, incorporate the units
> into the property names.
> 
> At least we can then create new properties in the future of we need
> to change the units, rather than thinking up a different name for
> 'timeout'.

please read the binding

we have 2 properties

 - udelay: delay between GPIO operations (may depend on each platform)
 - timeout: timeout to get data (ms)

 please do not mixed them together

udelay is related to bus frequency

timeout is implelentation detail, that allow to parameter the timeout og i2c
bit algo when reading the scl on slow device

Best Regards,
J.
