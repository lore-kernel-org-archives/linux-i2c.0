From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v4 0/2] Add a property in at24.c
Date: Mon, 2 Jul 2018 13:59:02 +0200
Message-ID: <CAMRc=MfFH7EnyAXyBK+sssjyYoz9LhNDTkzWRsHBsPcDV7Ecig@mail.gmail.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, andriy.shevchenko@intel.com, Rajmohan Mani <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, tfiga@chromium.org, jcliang@chromium.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-07-02 11:12 GMT+02:00  <alanx.chiang@intel.com>:
> From: Alan Chiang <alanx.chiang@intel.com>
>
> This RESEND PATCH only adds the Acked-by and Reviewed-by,
> no other patch for the codes.
>

Please don't do this. We're waiting for Rob's Acked-by and I will
collect all the tags anyway. Don't resend unless there are changes to
patches.

Best regards,
Bartosz Golaszewski

> In at24.c, it uses 8-bit addressing by default. In this patch,
> add a property address-width that provides a flexible method to
> pass the information to the driver.
>
> Alan Chiang (2):
>   dt-bindings: at24: Add address-width property
>   eeprom: at24: Add support for address-width property
>
>  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
>  drivers/misc/eeprom/at24.c                        | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> --
> 2.7.4
>
