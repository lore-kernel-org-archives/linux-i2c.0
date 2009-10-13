From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Bus drivers don't have to support
 I2C_M_REV_DIR_ADDR
Date: Tue, 13 Oct 2009 23:50:10 +0100
Message-ID: <20091013225010.GA15469@fluff.org.uk>
References: <20090930222244.43b8d17d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090930222244.43b8d17d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 30, 2009 at 10:22:44PM +0200, Jean Delvare wrote:
> I2C bus drivers don't have to support I2C_M_REV_DIR_ADDR. It is a
> deviation from the I2C specification, which only makes sense to
> implement when really needed.

Probably the right thing to do, does anything actually use this
support?
 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-iop3xx.c   |    6 ------
>  drivers/i2c/busses/i2c-mv64xxx.c  |    3 ---
>  drivers/i2c/busses/i2c-powermac.c |    2 --

I assume that I should merge this in my -next tree?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
