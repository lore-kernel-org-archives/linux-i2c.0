From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] eeprom/at24: use device_property_*() functions instead
 of of_get_property()
Date: Thu, 9 Feb 2017 18:20:31 +0200
Message-ID: <CAHp75VfM6orvq-_XOkPfzGjGZZyOERhAjhXbx5m9Fm1Rh=Biig@mail.gmail.com>
References: <1486583636-8940-1-git-send-email-gardner.ben@gmail.com> <1486654433-20148-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486654433-20148-1-git-send-email-gardner.ben@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 9, 2017 at 5:33 PM, Ben Gardner <gardner.ben@gmail.com> wrote:
> Allow the at24 driver to get configuration information from both OF and
> ACPI by using the more generic device_property functions.
> This change was inspired by the at25.c driver.
>
> I have a custom board with a ST M24C02 EEPROM attached to an I2C bus.
> With the following ACPI construct, this patch instantiates a working
> instance of the driver.
>
> Device (EEP0) {
>  Name (_HID, "PRP0001")
>  Name (_DSD, Package () {
>   ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>   Package () {
>    Package () {"compatible", Package () {"st,24c02"}},
>    Package () {"size", 256},
>    Package () {"pagesize", 16},
>   },
>  })
>  Name (_CRS, ResourceTemplate () {
>   I2cSerialBus (
>    0x0057, ControllerInitiated, 400000,
>    AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
>    ResourceConsumer,,)
>  })
> }
>
> Note: Matching the driver to the I2C device requires another patch.
>  http://www.spinics.net/lists/linux-acpi/msg71914.html
>

Still couple of comments.

> @@ -19,7 +19,6 @@
>  #include <linux/log2.h>
>  #include <linux/bitops.h>
>  #include <linux/jiffies.h>

> -#include <linux/of.h>

I suppose
+ #include <linux/property.h>
?

> +static void at24_get_pdata(struct device *dev,
> +                          struct at24_platform_data *chip)

Now it fits one line.

> +       u32 val;
> +
> +       if (device_property_present(dev, "read-only"))
> +               chip->flags |= AT24_FLAG_READONLY;
> +
> +       if (device_property_read_u32(dev, "pagesize", &val) == 0) {

' == 0' looks awkward.

And I think

ret = x();
if (ret)
...
else
...

pattern would look slightly better.

> +               chip->page_size = val;
> +       } else {
> +               /*
> +                * This is slow, but we can't know all eeproms, so we better
> +                * play safe. Specifying custom eeprom-types via platform_data
> +                * is recommended anyhow.
> +                */
> +               chip.page_size = 1;

-- 
With Best Regards,
Andy Shevchenko
