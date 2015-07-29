From: Sifan Naeem <Sifan.Naeem@imgtec.com>
Subject: RE: [PATCH 8/8] i2c: img-scb: verify support for requested bit rate
Date: Wed, 29 Jul 2015 13:34:17 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DC9E@hhmail02.hh.imgtec.org>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
 <1437997641-32575-9-git-send-email-sifan.naeem@imgtec.com>
 <55B8C0B9.1070108@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <55B8C0B9.1070108@imgtec.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: James Hogan <James.Hogan@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

> On 27/07/15 12:47, Sifan Naeem wrote:
> > The requested bit rate can be outside the range supported by the driver.
> > The maximum bit rate this driver supports at the moment is 400Khz.
> >
> > Return -EINVAL if the bit rate is larger than 400khz.
> >
> > Maximum speed supported by the driver can be increased to 1Mhz by
> > adding support for "fast plus mode" in the future.
> >
> > Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB
> > driver")
> > Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> > Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index bbfee33..07a039c 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -1157,6 +1157,12 @@ static int img_i2c_init(struct img_i2c *i2c)
> >  			break;
> >  		}
> >  	}
> > +	if (i2c->bitrate > timing.max_bitrate) {
> > +		dev_err(i2c->adap.dev.parent,
> > +			"requested bitrate (%d) is higher than the max
> bitrate supported (%d)\n",
> > +			 i2c->bitrate, timing.max_bitrate);
> > +		return -EINVAL;
> > +	}
> 
> The timing is only chosen if i2c->bitrate <= timing.max_bitrate, so you'd only
> hit this case if none of the timings were valid, in which case timing ==
> timings[0], so when you print timing.max_bitrate it won't be the max bitrate
> supported, it'll be the max bitrate of the first timing in the array.
> 
> Anyway, I think the original intent of the DT provided clock-frequency was
> more as a maximum bitrate. This was used with TZ1090 as a way to limit the
> bitrate of the bus if some devices on the bus don't support the full speed,
> e.g. we had an HDMI chip that would get confused at 400khz.
> 
> So would it be acceptable to change it to just clamp the bitrate to the
> maximum rate supported, before the bitrate_khz calculation, such that if you
> specified 1MHz in DT, it could safely fall back to 400KHz until the driver
> supports the faster mode?
> 
I'll rework this, when the requested bit rate is larger than the maximum supported, set the bitrate down to the maximum supported before bitrate_khz is calculated. 

Thanks,
Sifan
> Cheers
> James
> 
> >
> >  	/* Find the prescale that would give us that inc (approx delay = 0) */
> >  	prescale = SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
> >
