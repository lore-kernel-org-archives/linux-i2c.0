From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Wed, 03 Dec 2008 15:07:08 +0200
Message-ID: <gh609o$gs0$1@ger.gmane.org>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812031355120.4717@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0812031355120.4717-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guennadi Liakhovetski wrote:
> One more thing: you also want to do something like this
> 
> 	i2c_imx->adapter.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;

some time ago, it was I2C_CLASS_ALL, but Jean told, that it will be removed at all :)

> 
> in i2c_imx_probe().
> 
> If you want, I can send you my current version of your driver, so you can 
> compare.

yes, please send it.

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
