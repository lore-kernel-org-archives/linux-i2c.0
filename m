From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Thu, 9 Oct 2014 10:15:20 +0200
Message-ID: <20141009081520.GJ1990@localhost>
References: <1412606587-3323-1-git-send-email-muth@cypress.com>
 <20141009074029.GL20647@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141009074029.GL20647@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 09, 2014 at 08:40:29AM +0100, Lee Jones wrote:
> On Mon, 06 Oct 2014, Muthu Mani wrote:

> > +static int update_ep_details(struct usb_interface *interface,
> > +				struct cyusbs23x *cyusbs)
> > +{
> > +	struct usb_host_interface *iface_desc;
> > +	struct usb_endpoint_descriptor *ep;
> > +	int i;
> > +
> > +	iface_desc = interface->cur_altsetting;
> > +
> > +	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> > +
> > +		ep = &iface_desc->endpoint[i].desc;
> > +
> > +		if (!cyusbs->bulk_in_ep_num && usb_endpoint_is_bulk_in(ep))
> > +			cyusbs->bulk_in_ep_num = ep->bEndpointAddress;
> > +		if (!cyusbs->bulk_out_ep_num && usb_endpoint_is_bulk_out(ep))
> > +			cyusbs->bulk_out_ep_num = ep->bEndpointAddress;
> > +		if (!cyusbs->intr_in_ep_num && usb_endpoint_is_int_in(ep))
> > +			cyusbs->intr_in_ep_num = ep->bEndpointAddress;
> > +	}
> 
> All of the USB specific code in this driver will require a USB Ack.

I'll review it once the incomplete gpio-driver issue has been resolved.

> > +	dev_dbg(&interface->dev, "%s intr_in=%d, bulk_in=%d, bulk_out=%d\n",
> > +		__func__, cyusbs->intr_in_ep_num ,
> > +		cyusbs->bulk_in_ep_num, cyusbs->bulk_out_ep_num);
> > +
> > +	if (!cyusbs->bulk_in_ep_num || !cyusbs->bulk_out_ep_num ||
> > +		!cyusbs->intr_in_ep_num)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}

[...]

> > diff --git a/include/linux/mfd/cyusbs23x.h b/include/linux/mfd/cyusbs23x.h

> > +/* Serial interfaces (I2C, SPI, UART) differ in interface subclass */
> > +enum cy_scb_modes {
> > +	CY_USBS_SCB_DISABLED = 0,
> > +	CY_USBS_SCB_UART = 1,
> > +	CY_USBS_SCB_SPI = 2,
> > +	CY_USBS_SCB_I2C = 3
> 
> No need to number these.

As it's not an arbitrary enumeration, I think they should be initialised
explicitly. They could be defined in the mfd driver though, as they only
appear to be needed during probe.

Johan
