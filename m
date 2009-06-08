From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address
 lists on the fly
Date: Mon, 8 Jun 2009 14:39:32 +0200
Message-ID: <20090608143932.36cd1b4f@hyperion.delvare>
References: <200906061500.49338.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200906061500.49338.hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Hans,

On Sat, 6 Jun 2009 15:00:48 +0200, Hans Verkuil wrote:
> For video4linux we sometimes need to probe for a single i2c address. 
> Normally you would do it like this:
> 
> static const unsigned short addrs[] = {
> 	addr, I2C_CLIENT_END
> };
> 
> client = i2c_new_probed_device(adapter, &info, addrs);
> 
> This is a bit awkward and I came up with this macro:
> 
> #define V4L2_I2C_ADDRS(addr, addrs...) \
>         ((const unsigned short []){ addr, ## addrs, I2C_CLIENT_END })
> 
> This can construct a list of one or more i2c addresses on the fly. But this 
> is something that really belongs in i2c.h, renamed to I2C_ADDRS.
> 
> With this macro we can just do:
> 
> client = i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr));
> 
> Comments?

I'm not a big fan of macros which hide how things work, but if this
makes your life easier, why not. Just send a patch and I'll queue it up
for 2.6.31.

-- 
Jean Delvare
