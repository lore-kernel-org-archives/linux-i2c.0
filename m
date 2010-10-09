From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Newbie Question About Dev-Interface Method
Date: Sat, 9 Oct 2010 09:33:19 +0200
Message-ID: <20101009093319.696d5164@endymion.delvare>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
	<8F90F944E50427428C60E12A34A309D2308DA559B4@carmd-exchmb01.sierrawireless.local>
	<20101008085758.2f06dbad@endymion.delvare>
	<8F90F944E50427428C60E12A34A309D2308DAD1B7F@carmd-exchmb01.sierrawireless.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8F90F944E50427428C60E12A34A309D2308DAD1B7F-3qf8vkpM5jTbmvMHnzRVpW3Pdy6AhKVLXbPIYa3/oNjDOqzlkpFKJg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rory Filer <rfiler-usJ8hg9QsBLWpu6QEFMNjNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 8 Oct 2010 19:03:27 -0700, Rory Filer wrote:
> > > I'm assuming that a kernel space chip driver like our gpio expander
> > (pca953x.c) also uses the same adapter driver as my user-space
> > application since that expander chip is on the same bus.
> > 
> > Let's clarify right away: i2c-dev (which handles /dev/i2c-* nodes) is
> > NOT an adapter driver. It is a bridge driver between user-space and
> > your adapter driver. Your adapter driver is most likely one living in
> > drivers/i2c/busses, and depends on the actual hardware you run on.
> 
> OK, thanks that's clear. I was confused by the terminology in the 
> dev-interface document. When it said to open an adapter, I thought
> that meant I was using the associated adapter driver.

Well, you end up using the underlying adapter driver. i2c-dev is only a
glue driver between user-space and the actual in-kernel i2c adapter
driver. See
  https://i2c.wiki.kernel.org/index.php/Driver_Architecture
for a diagram of the architecture.

> > Incorrect. The address isn't written to the adapter, it is a setting
> > local to i2c-dev and even specific to the file handle you got when
> > opening a /dev/i2c-* node. Each subsequent read, write or smbus call in
> > your user-space driver automatically includes the slave address, which
> > is only valid for the read, write or smbus call in question.

I realize my wording may be a little misleading. When you set a slave
address using the I2C_SLAVE ioctl, the address is valid for _all_
subsequent read, write or smbus calls on the filehandle, until either
the file is closed or ioctl(I2C_SLAVE) is called again, not only the
following one.

> Excellent! - in the words of a famous Swiss restaurant's wine menu, this
> leaves me nothing to hope for!
> 
> Jean, thank you for your help, it saved me a ton pouring over source 
> code and allowed me to get on with the job at hand. Much appreciated.

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
