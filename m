From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Sat, 7 Mar 2009 11:54:49 +0100
Message-ID: <20090307115449.32f0ab26@hyperion.delvare>
References: <20090225212119.67402391@hyperion.delvare>
	<1235606248-13004-1-git-send-email-daniel@caiaq.de>
	<20090226094857.50d0710d@hyperion.delvare>
	<20090306160042.GA17800@buzzloop.caiaq.de>
	<20090306182432.338b0244@hyperion.delvare>
	<20090306181409.GA20135@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306181409.GA20135-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 6 Mar 2009 19:14:09 +0100, Daniel Mack wrote:
> On Fri, Mar 06, 2009 at 06:24:32PM +0100, Jean Delvare wrote:
> > I agree that it doesn't make sense to wait for the industrial I/O
> > subsystem to be merged. But I also do not want to put in drivers/hwmon
> > drivers which do not really belong there. So I'd either go the way you
> > proposed already (drivers/sensors for non-hwmon sensor drivers) or
> > simply put your driver in drivers/misc if this is only meant as a
> > temporary home until the industrial I/O subsystem is merged.
> 
> Okay, drviers/misc sounds like a good intermediate solution. Do you want
> me to post another patch for that or will you move it yourself?

Please post new patches, I'll review and apply them.

-- 
Jean Delvare
