From: "Anthony Drake" <agmotorsvc-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: rtc-ds3232 driver
Date: Thu, 1 Mar 2012 17:09:13 +0000 (UTC)
Message-ID: <61_2012_11913_GON@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Group,

I've built and insmod'd rtc-ds3232.ko, but I do not know how to access 
the functionality of the driver.  I think there should be a device
special file such as /dev/rtc1 or something like it, but I don't know
what it is. I suspect that since this is a type of i2c driver there
must be a way to access the driver at a higher level but I do not know
how.  Is there any information to help?

I can access the ds3232 from user space application, using i2c-dev
model.  I would also like to be able to read the status register from a
lkm.  Thank you in advance.

Thanks, Drake.
