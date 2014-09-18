From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 3/3] gpio: add support for the Diolan DLN-2 USB GPIO
 driver
Date: Thu, 18 Sep 2014 14:46:11 +0200
Message-ID: <20140918124611.GA26817@localhost>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
 <1410290686-6680-4-git-send-email-octavian.purdila@intel.com>
 <20140918105458.GA2337@localhost>
 <CAE1zot+_hX6TVkW-B6H9NzgyLhF54oQJZt+x_xXGjEB6A5dAZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1zot+_hX6TVkW-B6H9NzgyLhF54oQJZt+x_xXGjEB6A5dAZA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 18, 2014 at 03:43:07PM +0300, Octavian Purdila wrote:
> On Thu, Sep 18, 2014 at 1:54 PM, Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Sep 09, 2014 at 10:24:46PM +0300, Octavian Purdila wrote:

> > Either way, it looks like this could race with get_direction() if you
> > get a set_direction() while get_direction() is retrieving the direction
> > from the device.
> >
> > This would break gpio_get().
> >
> I don't think gpio_set_direction() and gpio_get() are allowed to race.

I wrote that set_direction() and get_direction() could race, which in
turn would break gpio_get() as you would be caching the wrong
direction setting.

But perhaps gpiolib prevents this from happening.

Johan
