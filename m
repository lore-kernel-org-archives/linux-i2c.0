From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 3/4] gpiolib: add irq_not_threaded flag to gpio_chip
Date: Wed, 24 Sep 2014 13:01:42 +0200
Message-ID: <20140924110142.GC17019@localhost>
References: <1411158165-25794-1-git-send-email-octavian.purdila@intel.com>
 <1411158165-25794-4-git-send-email-octavian.purdila@intel.com>
 <CACRpkdbnXo9VhybkZeP7Z4b0pxCHorGJvbRw-dh_X0dWT2iC8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbnXo9VhybkZeP7Z4b0pxCHorGJvbRw-dh_X0dWT2iC8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, johan@kernel.org, Daniel Baluta <daniel.baluta@intel.com>, laurentiu.palcu@intel.com, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 24, 2014 at 10:54:51AM +0200, Linus Walleij wrote:
> On Fri, Sep 19, 2014 at 10:22 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
> 
> > Some GPIO chips (e.g. the DLN2 USB adapter) have blocking get/set
> > operation but do not need a threaded irq handler.
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> 
> Usually I don't apply patches adding interfaces with no users, but
> this seems very useful, so patch applied. I guess your driver will
> appear on v3.19+ so then you can rely on this having been merged
> for v3.18.

Octavian, please include this one in any future revision of you series
so that it is self-contained (at least until v3.18-rc1 is out)
nonetheless.

Thanks,
Johan
