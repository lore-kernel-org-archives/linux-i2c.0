From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH] I2C bus driver for SH7760 SoC, #2
Date: Wed, 27 Feb 2008 23:55:06 +0100
Message-ID: <20080227235506.3e79c27c@hyperion.delvare>
References: <20071105172313.GB17951@roarinelk.homelinux.net>
	<20080223171513.678f04d0@hyperion.delvare>
	<20080226072330.GB14289@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080226072330.GB14289-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: linuxsh-dev-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Tue, 26 Feb 2008 08:23:30 +0100, Manuel Lauss wrote:
> > > +	for (cdf = 3; cdf >= 0; cdf--) {
> > > +		iclk = mck / (1 + cdf);
> > > +		/* iclk must not be > 20MHz */
> > > +		if (iclk >= 20000000)
> > 
> > > or >=?
> > 
> > > +			continue;
> > > +		for (scgd = 0; scgd < 63; scgd++) {
> > > +			m1 = iclk / (20 + (scgd << 3));
> > > +			dff = abs(scl_hz - m1);
> > > +			if (dff < odff) {
> > > +				odff = dff;
> > > +				cdfm = cdf;
> > > +				scgdm = scgd;
> > > +			}
> > > +		}
> > > +	}
> > 
> > These imbricated loops don't look exactly optimal. Is there no way to
> > compute the right value right away?
> 
> I'm open to suggestions. I just wanted to support (almost) every conceivable
> scl clock and module clock.

Let me think about it...

In the inner loop, scgd is monotonic (increasing), so m1 is also
monotonic (decreasing). Assuming for simplicity that the first value of
m1 is greater than scl_hz, dff will start big, then shrink until m1 is
almost equal to scl_hz, then grow again. Basically you want scgd such
that

	scl_hz == iclk / (20 + (scgd << 3))

i.e.

	scgd == ((iclk / scl_hz) - 20) >> 3

with the obvious problem that this is integer arithmetic, so the
resolution is limited. The value above is the integer value immediately
below the "correct" value, and scgd + 1 is the integer value
immediately above the correct value. This means that, for each
iteration of the outer loop, there are really only two candidates to
check: ((iclk / scl_hz) - 20) >> 3 and (((iclk / scl_hz) - 20) >> 3) + 1.

This results in the following code:

	/* pclock/CDF = i2c_module clock (iclk)/SCGD = SCL */
	odff = scl_hz;
	scgdm = cdfm = m1 = 0;
	for (cdf = 3; cdf >= 0; cdf--) {
		iclk = mck / (1 + cdf);
		/* iclk must not be > 20MHz */
		if (iclk >= 20000000)
			continue;
		scgd_low = ((iclk / scl_hz) - 20) >> 3;					/* ADDED */
		for (scgd = scgd_low; scgd < 63 && scgd <= scgd_low + 1; scgd++) {	/* CHANGED */
			m1 = iclk / (20 + (scgd << 3));
			dff = abs(scl_hz - m1);
			if (dff < odff) {
				odff = dff;
				cdfm = cdf;
				scgdm = scgd;
			}
		}
	}

This gets you the best combination of settings in a maximum of 8
iterations, instead of 252 with the original code. As an additional
speedup, you could exit the loop as soon as dff == 0, however it's
arguable whether it's worth the additional code now that the number of
iterations is so small.

> I'll resend once I've managed to get zero-byte transfers working without
> ugly hacks.

As I wrote before, you should be able to get everything to work even
without implementing zero-byte transfers, as long as you only use
new-style i2c drivers. With legacy i2c drivers you can use the "force"
module parameters to work around the problem, too.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
