From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Fri, 23 Jan 2009 20:23:32 -0600
Message-ID: <497A7BA4.2080908@freescale.com>
References: <497A3097.1030808@freescale.com> <20090124012817.GA31775@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090124012817.GA31775-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Mark Brown wrote:

> Really what
> you're having to do here is fairly nasty and there's no good reason for
> it to be supported - if something is being registered dynamically and
> passing instantiation specific data around it really should be the
> device and not the driver.

What we need is a way for the codec driver to do its stuff without needing a 
socdev.

I think I see your point, though.  I'm calling i2c_add_driver, which 
technically could result in my i2c_probe function being called multiple times, 
if there are multiple matches in the device tree.  I'll have to check that out 
on Monday.

 > The fact that attempting to do this looks
> bad is a win on the part of the I2C core.
>
> For now an idiomatic solution for ASoC drivers is to have a single
> static variable that you use to get the socdev through.

Well, that's what I do today.  I was hoping to avoid that, but if I'm right 
about i2c_add_driver, then this trick doesn't really work either.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
