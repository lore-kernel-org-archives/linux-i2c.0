From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 14:27:46 +0200
Message-ID: <20091007142746.4bc4f0f4@hyperion.delvare>
References: <20091007115017.6941faa7@hyperion.delvare>
	<20091007095610.GF3177@pengutronix.de>
	<20091007120734.31a41f33@hyperion.delvare>
	<20091007102557.GG3177@pengutronix.de>
	<4ACC85B7.2010300@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ACC85B7.2010300-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 07 Oct 2009 13:12:39 +0100, Jonathan Cameron wrote:
> ALS is the right place for this one. I've offered to do the port but haven't had
> a chance as yet.
> 
> These light sensors are two slow to really require most of IIO. When you can get
> all data from a chip by polling at a couple hz life becomes somewhat easy!
> Also moving the tsl2561 out of iio and into ALS asap. 
> 
> Though I'm guessing ALS won't merge until next merge window opens. To my mind
> it's clean enough to merge now as a new 'driver' but I'm guessing as a subsystem
> this might not get past Linus. I'm not bothered about ditching the iio based
> tsl2561 immediately (as far as I know I'm the only user other than on boards
> for which I roll out the images anwyay - please yell if not!),
> but moving the tsl2550 will probably involve a few userspace api changes
> (to conform to what als expects), not to mention a change in location in sysfs.
> 
> I've no idea how heavily used this driver is, so what do people reckon we do about
> about deprecating and removing the old driver? (the usual 2 kernel release or
> can we speed it up to finally get rid of that chips directory!)

I am aware of 3 users for the tsl2550 driver (all Cc'd): Rodolfo
Giometti, who said 3 months ago that his hardware was now out of order,
Michele De Candia, and myself. As far as I am concerned, you can change
pretty much whatever you want as long as there is an easy way to read
the lux value from user-space. I'm using one TSL2550 for my own fun and
that's it. Don't know about Michele.

I think we can simply move the driver and convert it directly, and
document the interface changes. I've always said loudly that the
tsl2550 driver was the first of its kind and as such its interface was
subject to change when other similar drivers would be added. Which is
what's happening right now.

-- 
Jean Delvare
