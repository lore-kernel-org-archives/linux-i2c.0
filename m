From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] TSL2550 driver bugfix
Date: Sun, 12 Jul 2009 10:52:37 +0200
Message-ID: <20090712105237.01e11954@hyperion.delvare>
References: <4A4A2FBC.1060804@valueteam.com>
	<4A4A4036.3000408@cam.ac.uk>
	<4A4B1A71.20101@valueteam.com>
	<20090711202030.52ffbddb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090711202030.52ffbddb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 11 Jul 2009 20:20:30 +0200, Jean Delvare wrote:
> For another, I do hit the case c1 > c0 from times to times, in
> particular when I move the sensor in dark areas. Do you hit this as
> well? This might be specific to the serial evaluation module I'm using,
> it is very slow and this might cause c0 and c1 to be sampled at
> significantly different times (say 200 ms apart.) If the light
> conditions change meanwhile, this can explain why c1 > c0.

Scratch this theory. Reading the TSL2550 datasheet again, I understand
that sampling happens continuously and is unrelated to I2C reads.
Sampling of each channel takes 400 ms in standard mode, so c0 and c1
samplings are _always_ 400 ms apart, regardless of how fast the I2C
interface is. So you should be able do see the problem too.

This also means that the code in tsl2550_get_adc_value() is more
complex than it needs to be. The only case where it makes sense to wait
400 ms to get a reading is right after power-up. 400 ms after power-up,
c0 will always have a valid value, and after 800 ms c1 will always have
a valid value as well. So I propose to simplify tsl2550_get_adc_value()
and just return -EAGAIN if there is no valid reading. In practice I
doubt we'll ever hit it.

> I am not
> sure what to do in this case. We can return -EAGAIN and let user-space
> retry. But we could also restart the computation automatically in this
> case. Of course if the problem only affects the evaluation module then
> we don't really care.

Thinking some more about this: if we want to retry then we will have to
wait at least 400 ms to read c0 again, and if it's not enough 400 more
ms to read c1 again. And even then, there's no guarantee the new
readings will be OK if the light conditions are still changing. This is
an intrinsic weakness of the TSL2550 that both channels are sampled
sequentially. I doubt we want to let the user wait for the lux value
for several seconds, so returning -EAGAIN seems OK to me.

But I am not using the light sensor a lot myself, so my practical
experience is rather limited, thus I would welcome comments and
opinions on this.

-- 
Jean Delvare
