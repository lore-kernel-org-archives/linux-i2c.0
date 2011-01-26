From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c/busses: Diolan U2C-12 USB/I2C adapter driver
Date: Wed, 26 Jan 2011 23:49:53 +0000
Message-ID: <20110126234953.GF15795@trinity.fluff.org>
References: <1295472398-705-1-git-send-email-guenter.roeck@ericsson.com> <1295472398-705-2-git-send-email-guenter.roeck@ericsson.com> <20110119211403.GM5432@trinity.fluff.org> <1295475373.9786.422.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1295475373.9786.422.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 19, 2011 at 02:16:13PM -0800, Guenter Roeck wrote:
> On Wed, 2011-01-19 at 16:14 -0500, Ben Dooks wrote:
> > On Wed, Jan 19, 2011 at 01:26:37PM -0800, Guenter Roeck wrote:
> > > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
>  [ ... ]
> 
> > > +/* Structure to hold all of our device specific stuff */
> > > +struct i2c_diolan_u2c {
> > > +	struct usb_device *usb_dev;	/* the usb device for this device */
> > > +	struct usb_interface *interface;/* the interface for this device */
> > > +	struct i2c_adapter adapter;	/* i2c related things */
> > > +	int olen;			/* Output buffer length */
> > > +	int ocount;			/* Number of enqueued messages */
> > > +	u8 obuffer[DIOLAN_OUTBUF_LEN];	/* output buffer */
> > > +	u8 ibuffer[DIOLAN_INBUF_LEN];	/* input buffer */
> > 
> > you should cache-line align the buffers to avoid any problems with
> > dma-vs-cache, etc.
> > 
> There are several other drivers which don't cache-align the buffers used
> with usb_bulk_msg(). Do those all have potential problems, or is this
> only relevant for optimization ?
> 
> If it is just for optimization, I'd argue that the speed here is so slow
> that it won't make much of a difference, if any, if the buffers were
> aligned.

It is more to do with the way some architectures/cpus deal with cache
coherency with resepect to DMA... in some cases it is possible for hardware
to be dealing with a buffer that the cpu may still be using if they are
not appropriately aligned. I forget the exact case, but losing a few bytes
in a buffer is preferable to the other case.

I also believe that X86 style architectures do not have this problem.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
