From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
Date: Thu, 10 Sep 2009 03:55:36 -0400
Message-ID: <8bd0f97a0909100055n3192deeka93dc853f0139bfc@mail.gmail.com>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
	<20090910062609.GA26454@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090910062609.GA26454-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 10, 2009 at 02:26, Wolfram Sang wrote:
>> the Blackfin defconfigs refer to an input driver for the PCF8574, not
>> the I2C client driver
>
> Yup, I am aware of that. With the exception of:
>
> blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=m

thanks for double checking.  i'm not sure this board even has this
device.  i'll review the hardware.
-mike
