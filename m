From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] mfd: add support for Diolan DLN-2 devices
Date: Wed, 17 Sep 2014 09:38:25 +0200
Message-ID: <20140917073825.GE20727@localhost>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
 <1410290686-6680-2-git-send-email-octavian.purdila@intel.com>
 <20140916232149.GB30918@lee--X1>
 <CAE1zotJWUnduPUd9C8EgSHHSo-OCgdj7c-sKaT5M2Ajj2CmNWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotJWUnduPUd9C8EgSHHSo-OCgdj7c-sKaT5M2Ajj2CmNWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 17, 2014 at 10:25:18AM +0300, Octavian Purdila wrote:
> On Wed, Sep 17, 2014 at 2:21 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >
> > On Tue, 09 Sep 2014, Octavian Purdila wrote:
> >
> > > This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
> > > Master Adapter DLN-2. Details about the device can be found here:
> > >
> > > https://www.diolan.com/i2c/i2c_interface.html.
> > >
> > > Information about the USB protocol can be found in the Programmer's
> > > Reference Manual [1], see section 1.7.
> >
> > This driver really needs a USB Ack before I can accept it.
> >
> 
> Greg, Johan, is the driver acceptable now?

I started looking through v4 yesterday and found a few more things. Will
send you some you comments shortly.

Johan
