From: "Anthony Drake" <agmotorsvc-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: rtc-ds3232 driver
Date: Fri, 2 Mar 2012 17:27:35 +0000 (UTC)
Message-ID: <62_2012_112735_GON@news.gmane.org>
References: <61_2012_11913_GON@news.gmane.org>  <20120301191200.GB2538@pengutronix.de>  <61_2012_13540_GON@news.gmane.org> <20120301213414.501c5189@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 1 Mar 2012 21:34:14 +0100,
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote in 
message
> 
> Odds are that the underlying I2C slave device was not instantiated.
> Please read:
> Documentation/i2c/instantiating-devices
> 
Thank you very much! It works! after using method 4 with the name
("ds3232") from the i2c_device_id array, the kernel autoloads the
module, creates /dev/rtc1. I've modified my userspace app to use the
driver instead of raw i2c read/write, all working well. 
