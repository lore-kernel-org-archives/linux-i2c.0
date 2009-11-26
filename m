From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ALS: TSL2550 driver move from i2c/chips
Date: Thu, 26 Nov 2009 15:17:16 +0100
Message-ID: <20091126151716.303e4c7e@hyperion.delvare>
References: <4ACF4AC6.7070802@cam.ac.uk>
	<20091010183347.52b043ed@hyperion.delvare>
	<4AD3477D.4020904@cam.ac.uk>
	<20091012173824.0f3ef021@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091012173824.0f3ef021-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 12 Oct 2009 17:38:24 +0200, Jean Delvare wrote:
> On Mon, 12 Oct 2009 16:13:01 +0100, Jonathan Cameron wrote:
> > > The operating mode selects the measurable range. Standard range is from
> > > 0 to 1846 lux, extended range is from 0 to 9230 lux, with a resolution
> > > divided by 5. Extended mode is also 5 times faster.
> > > 
> > > What do we want to do with this? I am open to suggestions. There are
> > > several possibilities. The operating mode could be provided as platform
> > > data and stay internal to the driver. Or we can leave is visible to
> > > user-space, in which case I'd recommend that we do so in terms of
> > > "range" rather than "mode", so that other drivers can use the same
> > > convention, whatever it becomes. For example, one would write the range
> > > of values he/she wants to be able to measure and the driver would put
> > > the device in the most appropriate mode.
> >
> > That sounds like a sensible approach.  For now I guess a sysfs parameter
> > like illuminance_range_max would do the job and we can add a min for any
> > device that features an offset?
> 
> Yes, this sounds sensible.

Following up publicly so that everyone interested knows what's going on.

Jonathan and me tested the above idea on the tsl2550 driver, and it
turns out that it doesn't work well. The TSL2550 computes the lux of
visible light by computing a difference between total light (infra-red +
visible) and infra-red light. When there's a lot of infra-red light, it
is very easy to saturate the light sensors in standard mode, even
though the amount of visible light is low.

The bottom line is that one may need to reduce the integration time
(which is what the "extended mode" is really about) even if the result
fits in the standard mode's range. In the light of this, it seems
wrong to hide the mode behind the name "illuminance_range_max". It
seems better to export the exposure time as is, readable and writable.
Remains to agree on a file name and unit.

-- 
Jean Delvare
