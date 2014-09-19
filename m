From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/3] gpio: add support for the Diolan DLN-2 USB GPIO
 driver
Date: Fri, 19 Sep 2014 09:11:39 +0200
Message-ID: <20140919071139.GE26817@localhost>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
 <1410290686-6680-4-git-send-email-octavian.purdila@intel.com>
 <20140918105458.GA2337@localhost>
 <CAE1zot+_hX6TVkW-B6H9NzgyLhF54oQJZt+x_xXGjEB6A5dAZA@mail.gmail.com>
 <20140918124611.GA26817@localhost>
 <CAE1zotK7nb6VVp5a3n2_fnWZQHfizg4hFFy-ZVW5fzyFwmBMcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotK7nb6VVp5a3n2_fnWZQHfizg4hFFy-ZVW5fzyFwmBMcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 18, 2014 at 06:54:34PM +0300, Octavian Purdila wrote:
> On Thu, Sep 18, 2014 at 3:46 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, Sep 18, 2014 at 03:43:07PM +0300, Octavian Purdila wrote:
> >> On Thu, Sep 18, 2014 at 1:54 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> > On Tue, Sep 09, 2014 at 10:24:46PM +0300, Octavian Purdila wrote:
> >
> >> > Either way, it looks like this could race with get_direction() if you
> >> > get a set_direction() while get_direction() is retrieving the direction
> >> > from the device.
> >> >
> >> > This would break gpio_get().
> >> >
> >> I don't think gpio_set_direction() and gpio_get() are allowed to race.
> >
> > I wrote that set_direction() and get_direction() could race, which in
> > turn would break gpio_get() as you would be caching the wrong
> > direction setting.
> >
> 
> OK, I now see the problem. I think doing this in get_direction() will
> fix the issue:
> 
>                 if (!test_and_set_bit(offset, dln2->pin_dir_set))
>                         set/clear_bit(offset, dln2->pin_dir);
> 
> because gpiolib calls get_direction() while requesting a pin and
> request cannot race with itself. Which means that get_direction() can
> not race with itself the first time it is called, when the set/clear
> operation will be run.
> 
> And because we know that get_direction() is called first, we can even
> remove the set/clear operation from set_direction().

Why not simply fetch the direction in request() and get rid of the
pin_dir_set bitmask?

Johan
