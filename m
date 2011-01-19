From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c/busses: Diolan U2C-12 USB/I2C adapter driver
Date: Wed, 19 Jan 2011 14:16:13 -0800
Message-ID: <1295475373.9786.422.camel@groeck-laptop>
References: <1295472398-705-1-git-send-email-guenter.roeck@ericsson.com>
	 <1295472398-705-2-git-send-email-guenter.roeck@ericsson.com>
	 <20110119211403.GM5432@trinity.fluff.org>
Reply-To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110119211403.GM5432-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2011-01-19 at 16:14 -0500, Ben Dooks wrote:
> On Wed, Jan 19, 2011 at 01:26:37PM -0800, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
 [ ... ]

> > +/* Structure to hold all of our device specific stuff */
> > +struct i2c_diolan_u2c {
> > +	struct usb_device *usb_dev;	/* the usb device for this device */
> > +	struct usb_interface *interface;/* the interface for this device */
> > +	struct i2c_adapter adapter;	/* i2c related things */
> > +	int olen;			/* Output buffer length */
> > +	int ocount;			/* Number of enqueued messages */
> > +	u8 obuffer[DIOLAN_OUTBUF_LEN];	/* output buffer */
> > +	u8 ibuffer[DIOLAN_INBUF_LEN];	/* input buffer */
> 
> you should cache-line align the buffers to avoid any problems with
> dma-vs-cache, etc.
> 
There are several other drivers which don't cache-align the buffers used
with usb_bulk_msg(). Do those all have potential problems, or is this
only relevant for optimization ?

If it is just for optimization, I'd argue that the speed here is so slow
that it won't make much of a difference, if any, if the buffers were
aligned.

Thanks,
Guenter
