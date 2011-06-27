From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Question about i2c_xxx function on CONFIG_I2C
Date: Mon, 27 Jun 2011 13:30:56 +0200
Message-ID: <20110627133056.1379854a@endymion.delvare>
References: <87aad3bvyf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87aad3bvyf.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Morimoto,

On Mon, 27 Jun 2011 16:00:08 +0900, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org wrote:
> I'm using i2c_xxx function on some board.
> And sometimes I need very small kernel which doesn't need CONFIG_I2C.
> 
> But then (.config doesn't have CONFIG_I2C), the compile will fail.
> like this
> 
> error: implicit declaration of function 'i2c_get_adapter'
> error: implicit declaration of function 'i2c_transfer'
> 
> In this case, should I use #ifdef CONFIG_I2C in my code to solve this compile issue ?

Yes.

> Or is below #else in i2c.h good idea ?
> 
> --- i2c.h ---------
> #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> ...
> extern struct i2c_adapter *i2c_get_adapter(int nr);
> ...
> #else
> ...
> #define i2c_get_adapter(nr) NULL
> ...
> #endif

I don't think this is a good idea in general. If the kernel lacks I2C
support, and your code uses it, then this is dead code, and you're much
better excluding that code completely from your build. Most likely
you'll be able to drop whole functions. I wouldn't count on the
compiler to optimize it all properly, and you said you want a very
small kernel.

Of course we could make better comments if we could see your actual
code. Maybe some ifdef magic in i2c.h would make sense for a few items,
as we already do for i2c_register_board_info for example.

-- 
Jean Delvare
