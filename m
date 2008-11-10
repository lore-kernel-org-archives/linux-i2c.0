From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: add i2c adapter driver for i.MX3x SoCs
Date: Mon, 10 Nov 2008 17:06:31 +0200
Message-ID: <gf9iln$n8b$1@ger.gmane.org>
References: <Pine.LNX.4.64.0811071857460.4513@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0811071857460.4513-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guennadi Liakhovetski wrote:
> This is an updated and cleaned up i2c driver for i.MX3x from Freescale.
> 
> Signed-off-by: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
> 
> ---
> 
> Please comment, I'll also have to obtain ARM Acks for the arch/arm part, 
> or, maybe, split it into two parts.
> 

Hi, I have ready driver for MX1. Is it reason to make two separate drivers for MX2/MX3 and MX1?
btw, pending patches for MX1 is main reason why I2C for imx driver is not in kernel.
