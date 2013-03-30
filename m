From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/6]  Make return type of i2c_del_adapter() (and
 i2c_del_mux_adapter()) void
Date: Sat, 30 Mar 2013 21:13:52 +0100
Message-ID: <20130330211352.07530db7@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars,

On Sat,  9 Mar 2013 19:16:43 +0100, Lars-Peter Clausen wrote:
> Currently i2c_del_adapter() returns 0 on success and potentially an error code
> on failure. Unfortunately this doesn't mix too well with the Linux device driver
> model. (...)

I see:

struct device_driver {
	(...)
	int (*probe) (struct device *dev);
	int (*remove) (struct device *dev);

So the driver core does allow remove functions to return an error. Are
you going to fix all subsystems as you are doing for i2c now, and then
change device_driver.remove to return void? If not, I don't see the
point of changing it in i2c.

-- 
Jean Delvare
