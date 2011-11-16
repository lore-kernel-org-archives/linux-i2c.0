From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: 10-bit address support
Date: Wed, 16 Nov 2011 15:56:10 +0100
Message-ID: <20111116155610.6b02aab6@endymion.delvare>
References: <20111110160739.540cda37@endymion.delvare>
	<20111111104335.GC2493@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111111104335.GC2493-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 11 Nov 2011 11:43:35 +0100, Wolfram Sang wrote:
> > I can think of 2 different ways of addressing the problem.
> > 
> > First way is to use a different device name format for 10-bit address
> > devices, for example %d-10bit-%04x. This has the drawback that some
> > user-space applications and libraries may not recognize these as valid
> > i2c device names. libsensors and sensors-detect would be amongst these.
> 
> Wouldn't the cleanest solution be
> 
> "%d-%02x" for 7 bit
> "%d-%04x" for 10 bit?

I'd rather use %03x for 10-bit then, for consistency.

> Yeah, I know that would really break userspace.

Yes indeed. While it wouldn't break libsensors (which uses sscanf
"%hd-%x" to parse the fields), it would break at least sensors-detect,
which really expects 4 hex digits in the sysfs name. This would
definitely be a change in the user-space interface anyway, who knows
which other tools would be affected.

Your solution was elegant (although it has its own drawbacks, such as
leaving it to every library and application to come up with a creative
way to handle and store 10-bit addresses separately from 7-bit addresses
internally), but unfortunately it would have had to be implemented in
the early days, not 8 years later.

> > I'd rather go with a larger offset such as 0x1000. This translates 0x2d
> > to 0x102d which is more obviously "10-bit address 0x2d". We have 16
> > bits to store the address so it shouldn't be an issue. Another possible
> > offset would be 0xa000 (as 0xa is 10.)
> 
> I like 0xa000 a tad better than 0x1000, but well... Then again, those
> devices are probably rare enough to take a non-intrusive approach.

Yes I agree, we really want to leave 7-bit addresses unaffected by the
change.

0xa000 is not more intrusive than 0x1000, so if the majority - i.e.
you ;) - is in favor of this, that's fine with me. I'll send a patch
later today.

Thanks,
-- 
Jean Delvare
