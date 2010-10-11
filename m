From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [PATCHv2 1/5] misc: Driver for bh1770glc / sfh7770 ALS and
 proximity sensor
Date: Mon, 11 Oct 2010 09:16:03 +0300
Message-ID: <1286777763.28027.3.camel@4fid08082>
References: <1286545324-18506-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1286545324-18506-2-git-send-email-samu.p.onkalo@nokia.com>
	 <4CAF2C1D.9040304@cam.ac.uk>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CAF2C1D.9040304@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
List-Id: linux-i2c@vger.kernel.org


I have a question about one of your comment

On Fri, 2010-10-08 at 16:35 +0200, ext Jonathan Cameron wrote:
> On 10/08/10 14:42, Samu Onkalo wrote:
> > This is a driver for ROHM BH1770GLC and OSRAM SFH7770 combined
> > ALS and proximity sensor.
> >
> > Interface is sysfs based. The driver uses interrupts to provide new data.
> > The driver supports pm_runtime and regulator frameworks.
> >
> > See Documentation/misc-devices/bhsfh.txt for details
> 
> Couple of nitpicks / formatting suggestions inline.
> 
> >
> > +/* chip->mutex is kept when this is called */
> > +static int bhsfh_lux_update_thresholds(struct bhsfh_chip *chip,
> > +                                     u16 threshold_hi, u16 threshold_lo)
> > +{
> > +     u8 data[4];
> 
> u8 data[4] = { threshold_hi,
>    threshold_hi >> 8,
>    threshold_lo,
>    threshold_low >> 8};
> and loose the below will give same result.

What do you mean by that? Threshold_lo / threshold_hi parameters can be
modified before they are stored to HW.

> > +     int ret;
> > +
> > +     /* sysfs may call this when the chip is powered off */
> > +     if (pm_runtime_suspended(&chip->client->dev))
> > +             return 0;
> > +
> > +     /*
> > +      * Compensate threshold values with the correction factors if not
> > +      * set to minimum or maximum.
> > +      * Min & max values disables interrupts.
> > +      */
> > +     if (threshold_hi != BHSFH_LUX_RANGE && threshold_hi != 0)
> > +             threshold_hi = bhsfh_lux_adjusted_to_raw(chip, threshold_hi);
> > +
> > +     if (threshold_lo != BHSFH_LUX_RANGE && threshold_lo != 0)
> > +             threshold_lo = bhsfh_lux_adjusted_to_raw(chip, threshold_lo);

Code above can modify values.

> > +
> > +     if (chip->lux_thres_hi_onchip == threshold_hi &&
> > +         chip->lux_thres_lo_onchip == threshold_lo)
> > +             return 0;
> > +
> > +     chip->lux_thres_hi_onchip = threshold_hi;
> > +     chip->lux_thres_lo_onchip = threshold_lo;
> > +
> > +     data[0] = threshold_hi;
> > +     data[1] = threshold_hi >> 8;
> > +     data[2] = threshold_lo;
> > +     data[3] = threshold_lo >> 8;
> > +
> > +     ret = i2c_smbus_write_i2c_block_data(chip->client,
> > +                                     BHSFH_ALS_TH_UP_0,
> > +                                     ARRAY_SIZE(data),
> > +                                     data);
> > +     return ret;
> > +}
> > +
