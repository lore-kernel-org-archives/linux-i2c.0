From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Bus drivers don't have to support
 I2C_M_REV_DIR_ADDR
Date: Wed, 14 Oct 2009 10:35:59 +0200
Message-ID: <20091014103559.17efa264@hyperion.delvare>
References: <20090930222244.43b8d17d@hyperion.delvare>
	<20091013225010.GA15469@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091013225010.GA15469-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, 13 Oct 2009 23:50:10 +0100, Ben Dooks wrote:
> On Wed, Sep 30, 2009 at 10:22:44PM +0200, Jean Delvare wrote:
> > I2C bus drivers don't have to support I2C_M_REV_DIR_ADDR. It is a
> > deviation from the I2C specification, which only makes sense to
> > implement when really needed.
> 
> Probably the right thing to do, does anything actually use this
> support?

As far as I know, the only chip which uses this is the "Maven" which is
found on some Matrox G450 graphics cards to handle the second head.

As the i2c-matroxfb driver builds on top of i2c-algo-bit, i2c-algo-bit
is the only driver which needs to implement I2C_M_REV_DIR_ADDR.

I've left it in i2c-algo-pcf and i2c-s3c2410 for now because at least
they properly declare the I2C_FUNC_PROTOCOL_MANGLING functionality, but
this could be reconsidered.

The other protocol mangling flags are in a similar situation. For
example I2C_M_NOSTART is only used by the Intel i915 and Matrox Maven
chips. Both use i2c-algo-but, but no less than 9 other I2C adapter
drivers implement it! Most of these implementations have most probably
never been tested, and I wouldn't be surprised if some don't work.

I2C_M_IGNORE_NAK is only used by the msp3400 audio processing driver.
But it is implemented by embedded I2C adapter drivers which probably
will never see this chip: i2c-davinci, i2c-omap, i2c-s3c2410 and
i2c-stu300.

I2C_M_NO_RD_ACK is only used by the ks0127 video driver, and only
i2c-algo-bit implements it. That one is correct.


> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-iop3xx.c   |    6 ------
> >  drivers/i2c/busses/i2c-mv64xxx.c  |    3 ---
> >  drivers/i2c/busses/i2c-powermac.c |    2 --
> 
> I assume that I should merge this in my -next tree?

Probably, yes. For now I have this patch in my own -next tree, but as
all drivers affected are embedded ones, it would fit better in yours.

I leave it up to you to decide what to do with the i2c-s3c2410 driver.
As I understand it, it doesn't need to implement I2C_M_REV_DIR_ADDR nor
I2C_M_IGNORE_NAK nor I2C_M_NOSTART, so you could simplify the code a
bit and stop defining I2C_FUNC_PROTOCOL_MANGLING.

BTW, is your -next tree visible somewhere? It might be convenient for
me to be able to check what it includes.

-- 
Jean Delvare
