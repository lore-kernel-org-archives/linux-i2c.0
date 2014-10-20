From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v8 3/4] gpiolib: add irq_not_threaded flag to gpio_chip
Date: Mon, 20 Oct 2014 14:08:38 +0900
Message-ID: <CAAVeFuJ4B37YgvTBctXqmtWJtg3b19PDt1EEZF5Rc6KVXZzUtw@mail.gmail.com>
References: <1413384491-23703-1-git-send-email-octavian.purdila@intel.com> <1413384491-23703-4-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1413384491-23703-4-git-send-email-octavian.purdila@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>, daniel.baluta@intel.com, laurentiu.palcu@intel.com, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 15, 2014 at 11:48 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> Some GPIO chips (e.g. the DLN2 USB adapter) have blocking get/set
> operation but do not need a threaded irq handler.

Sorry if you already explained this (I have been a little bit late
with the GPIO reviews recently), but does this optimization bring a
significant benefit that justifies adding another field in struct
gpio_chip? If so it would be nice to have it in the commit message. If
not, do we need this at all?
