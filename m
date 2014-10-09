From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Thu, 9 Oct 2014 14:58:44 +0200
Message-ID: <20141009125844.GM1990@localhost>
References: <1412606587-3323-1-git-send-email-muth@cypress.com>
 <20141009074029.GL20647@lee--X1>
 <20141009081520.GJ1990@localhost>
 <20141009105950.GP20647@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141009105950.GP20647@lee--X1>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 09, 2014 at 11:59:50AM +0100, Lee Jones wrote:
> On Thu, 09 Oct 2014, Johan Hovold wrote:
> > On Thu, Oct 09, 2014 at 08:40:29AM +0100, Lee Jones wrote:
> > > On Mon, 06 Oct 2014, Muthu Mani wrote:

> > > > diff --git a/include/linux/mfd/cyusbs23x.h b/include/linux/mfd/cyusbs23x.h
> > 
> > > > +/* Serial interfaces (I2C, SPI, UART) differ in interface subclass */
> > > > +enum cy_scb_modes {
> > > > +	CY_USBS_SCB_DISABLED = 0,
> > > > +	CY_USBS_SCB_UART = 1,
> > > > +	CY_USBS_SCB_SPI = 2,
> > > > +	CY_USBS_SCB_I2C = 3
> > > 
> > > No need to number these.
> > 
> > As it's not an arbitrary enumeration, I think they should be initialised
> > explicitly.
> 
> No need.  You are protected by the C Standard:
> 
> 6.7.2.2 Enumeration specifiers
> 
> "If the first enumerator has no =, the value of its enumeration
> constant is 0. Each subsequent enumerator with no = defines its
> enumeration constant as the value of the constant expression obtained
> by adding 1 to the value of the previous enumeration constant."
> 
> There's nothing arbitrary about that.

I obviously wasn't suggesting that the definition of an enum (and the
values of its constants) in c was arbitrary.

My point was that the values of the USB interface subclasses (defined
through the enum) are not arbitrary. In this case they just happen to be
zero-based and consecutive. You cannot reorder, or remove an unused
item, without breaking the driver. By initialising each constant
explicitly this would become apparent.

Using preprocessor defines could be an alternative if you really do not
like initialised enumeration constants.

> > They could be defined in the mfd driver though, as they only
> > appear to be needed during probe.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
