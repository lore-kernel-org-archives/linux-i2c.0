From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
Date: Tue, 26 Jun 2018 09:41:26 +0200
Message-ID: <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-06-26 8:22 GMT+02:00  <alanx.chiang@intel.com>:
> From: "alanx.chiang" <alanx.chiang@intel.com>
>
> In at24.c, it uses 8-bit addressing by default. In this patch,
> add a property address-width that provides a flexible method to
> pass the information to the driver.
>
> alanx.chiang (2):
>   dt-bindings: at24: Add address-width property
>   eeprom: at24: Add support for address-width property
>
>  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
>  drivers/misc/eeprom/at24.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> --
> 2.7.4
>

What is your use case exactly? Do you have an EEPROM model that's not
yet supported explicitly in the driver? Why would you need this
option?

Best regards,
Bartosz Golaszewski
