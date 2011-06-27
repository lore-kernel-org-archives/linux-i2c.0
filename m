From: "Zhang, Shijie" <shijie.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Question about i2c_xxx function on CONFIG_I2C
Date: Mon, 27 Jun 2011 22:04:01 +0800
Message-ID: <6D7A567890E70E4BA49B8A9B365980FA12D97F9A0E@shsmsx501.ccr.corp.intel.com>
References: <87aad3bvyf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87aad3bvyf.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi, I think you can config the kernel using make menuconfig command, go to Device Driver--->I2C Suppport

Check what you want to disselect. 


-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Sent: Monday, June 27, 2011 3:00 PM
To: Linux-I2C
Subject: Question about i2c_xxx function on CONFIG_I2C


Dear all

I'm using i2c_xxx function on some board.
And sometimes I need very small kernel which doesn't need CONFIG_I2C.

But then (.config doesn't have CONFIG_I2C), the compile will fail.
like this

error: implicit declaration of function 'i2c_get_adapter'
error: implicit declaration of function 'i2c_transfer'

In this case, should I use #ifdef CONFIG_I2C in my code to solve this compile issue ?
Or is below #else in i2c.h good idea ?

--- i2c.h ---------
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
...
extern struct i2c_adapter *i2c_get_adapter(int nr);
...
#else
...
#define i2c_get_adapter(nr) NULL
...
#endif


Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
