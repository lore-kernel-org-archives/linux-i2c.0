From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Wed, 3 Dec 2008 13:56:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812031355120.4717@axis700.grange>
References: <gh3f1h$fto$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <gh3f1h$fto$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

One more thing: you also want to do something like this

	i2c_imx->adapter.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;

in i2c_imx_probe().

If you want, I can send you my current version of your driver, so you can 
compare.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
