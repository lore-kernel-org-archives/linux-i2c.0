From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: rtc-ds3232 driver
Date: Thu, 1 Mar 2012 21:34:14 +0100
Message-ID: <20120301213414.501c5189@endymion.delvare>
References: <61_2012_11913_GON@news.gmane.org>
	<20120301191200.GB2538@pengutronix.de>
	<61_2012_13540_GON@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61_2012_13540_GON-2AO0Uh8ossnZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Drake <agmotorsvc-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 1 Mar 2012 19:54:00 +0000 (UTC), Anthony Drake wrote:
> On Thu, 1 Mar 2012 20:12:00 +0100,
> Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote 
> 
> > 
> > Documentation/rtc.txt
> > 
> > --=20
> Thank you.  I am familiar with the /dev/rtc0 character device special 
> file interface, and can access it well.  My problem is that there is no
> device special file created for rtc-ds3232 module.

Odds are that the underlying I2C slave device was not instantiated.
Please read:
Documentation/i2c/instantiating-devices

Note that the rtc-ds3232 driver doesn't support method 3 (presumably
the device lacks identification and thus can't be autodetected.

-- 
Jean Delvare
