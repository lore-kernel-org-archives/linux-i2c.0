From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address
 lists on the fly
Date: Tue, 9 Jun 2009 16:54:18 +0200
Message-ID: <20090609165418.70768103@hyperion.delvare>
References: <200906061500.49338.hverkuil@xs4all.nl>
	<20090608143932.36cd1b4f@hyperion.delvare>
	<200906091504.37330.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200906091504.37330.hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Jun 2009 15:04:36 +0200, Hans Verkuil wrote:
> Here it is:
> 
> --- linux-git/include/linux/i2c.h.orig	2009-06-09 14:53:32.000000000 +0200
> +++ linux-git/include/linux/i2c.h	2009-06-09 15:03:24.000000000 +0200
> @@ -412,6 +412,10 @@
>  /* The numbers to use to set I2C bus address */
>  #define ANY_I2C_BUS		0xffff
>  
> +/* Construct an I2C_CLIENT_END-terminated array of i2c addresses */
> +#define I2C_ADDRS(addr, addrs...) \
> +	((const unsigned short []){ addr, ## addrs, I2C_CLIENT_END })
> +
>  
>  /* ----- functions exported by i2c.o */
>  
> 
> Signed-off-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> 
> Note that this can also be used to initialize an array:
> 
> static const unsigned short addrs[] = I2C_ADDRS(0x2a, 0x2c);
> 
> Whether you want to is another matter, but it works. This functionality is 
> also available in the oldest supported gcc (3.2).

Applied, thanks.

-- 
Jean Delvare
