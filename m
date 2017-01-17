From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iio: distance: srf08: add IIO driver for us ranger
Date: Tue, 17 Jan 2017 11:28:01 +0100
Message-ID: <20170117102801.GB7823@andreas>
References: <20170110184815.GA15532@andreas>
 <4099feac-959c-2b5b-a21a-3b111098af39@kernel.org>
 <20170114174856.GA2351@andreas>
 <d05cce62-4362-b249-f49f-58eed2316ddb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d05cce62-4362-b249-f49f-58eed2316ddb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,

[...]

> >> For the range, it's an interesting one.  Again the term range could
> >> mean too many things within the wider ABI. We need to make it more
> >> specific.
> >>
> >> Actually reading the datasheet, I think this is fundamentally about the
> >> maximum sampling frequency rather than directly about the range.
> >> The only reason you'd reduce the range is to speed that up. It doesn't
> >> improve the resolution, the device simply answers quicker.
> >>
> >> So I'd support this as sampling_frequency.  You could then use
> >> the the iio_info_mask_*_available and relevant callback to provide
> >> info on what it then restricts the possible output values to
> >> (rather than controlling it directly).
> >>
> > 
> > By changing the range one cannot influence the sampling frequency directly. I
> > have seen on the oszilloscope that the telegrams arrive almost at the same time
> > with different settings of range and the same gain.
> > 
> > Only if the gain is also adjusted the sensor works faster and a higher frequency
> > can be used. But the gain is also used to adjust the sensitivity of the sensor. 
> That's rather weird and not what the datasheet suggests. Ah well.
> > 
> > What about calling it "sensor_domain" or "sensor_max_range"?
> hmm. Not sure - propose that with appropriate Docs and we can think more on it.
> > 
> > 

I made a mistake in the earlier mentioned measurement which i have to correct:

The telegrams arrive faster with a smaller range and the same gain. 

But we cannot use the sensor at a higher frequency if we are not adjusting the
gain of the sensor as well. This is because of echos of the former cycle which
are still around. And this setting of the gain depends on the surrounding where
the sensor is used. So in the driver we cannot estimate it.

Therefore i'll send out the next version with the attribute name
"sensor_max_range" together with documentation as proposal.

Andreas

-- 
