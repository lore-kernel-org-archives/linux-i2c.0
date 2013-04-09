From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 3/4] gpio: Kontron PLD gpio driver
Date: Tue, 9 Apr 2013 09:41:01 -0700
Message-ID: <20130409164101.GA20001@roeck-us.net>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <1365441321-21952-3-git-send-email-kevin.strasser@linux.intel.com>
 <CACRpkdYrGK_SPbiRssFUrg2vMvWbYO_iXsy+aZr99tyFtk88Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYrGK_SPbiRssFUrg2vMvWbYO_iXsy+aZr99tyFtk88Uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 09, 2013 at 10:46:15AM +0200, Linus Walleij wrote:
> On Mon, Apr 8, 2013 at 7:15 PM, Kevin Strasser
> <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> 
> > From: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>
> >
> > Add gpio support for the on-board PLD found on some Kontron embedded
> > modules.
> >
> > Signed-off-by: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> This looks very generic, setting and clearing bits in bytesized
> registers.
> 
> Can you please attempt to use generic GPIO for this?
> 
Linus,

I looked into it, but for my part I seem to be missing how the generic GPIO code
permits locking access to the hardware (PLD) and setting the PLD's page register.
In other words, I don't immediately see how to call kempld_get_mutex_set_index()
from the generic GPIO code. The other drivers using generic GPIO code don't
seem to have that requirement.

Thanks,
Guenter

> drivers/gpio/gpio-generic.c
> <linux/basic_mmio_gpio.h>
> 
> See for example:
> gpio-ep93xx.c, gpio-sodaville.c ...
> 
> Since you don't even have IRQ support in this it will be even simpler.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
