From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH v2] eeprom/at24: use device_property_*() functions instead
 of of_get_property()
Date: Thu, 9 Feb 2017 11:03:01 -0600
Message-ID: <CAE7DoPa1taAOWOO+g=A=QJ5wTy+GicjyL6GgdiTYQ94QWaX1Ug@mail.gmail.com>
References: <1486583636-8940-1-git-send-email-gardner.ben@gmail.com>
 <1486654433-20148-1-git-send-email-gardner.ben@gmail.com> <CAHp75VfM6orvq-_XOkPfzGjGZZyOERhAjhXbx5m9Fm1Rh=Biig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfM6orvq-_XOkPfzGjGZZyOERhAjhXbx5m9Fm1Rh=Biig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> Still couple of comments.
>
>> @@ -19,7 +19,6 @@
>>  #include <linux/log2.h>
>>  #include <linux/bitops.h>
>>  #include <linux/jiffies.h>
>
>> -#include <linux/of.h>
>
> I suppose
> + #include <linux/property.h>
> ?

It looks like <linux/property.h> is included via <linux/acpi.h>
outside of any "#ifdef CONFIG_ACPI" check.
But Documentation/process/submit-checklist.rst indicates:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.

So, I'll add it.
As an aside, a quick scan of the drivers/ folder shows that fewer than
half of the files that use functions from that header actually include
it.

>> +static void at24_get_pdata(struct device *dev,
>> +                          struct at24_platform_data *chip)
>
> Now it fits one line.
Sure does. Exactly 80 columns.

>> +       u32 val;
>> +
>> +       if (device_property_present(dev, "read-only"))
>> +               chip->flags |= AT24_FLAG_READONLY;
>> +
>> +       if (device_property_read_u32(dev, "pagesize", &val) == 0) {
>
> ' == 0' looks awkward.
>
> And I think
>
> ret = x();
> if (ret)
> ...
> else
> ...
>
> pattern would look slightly better.

There are 51 C files that use a temporary variable as you suggest with
"device_property_read" functions.
There are 7 C files that use the "if (!device_property_read" style.
It looks like at25.c was the only one that uses the '== 0' construct.
Guess I picked the wrong one to copy.
So, sure, I'll change that.

>> +               chip->page_size = val;
>> +       } else {
>> +               /*
>> +                * This is slow, but we can't know all eeproms, so we better
>> +                * play safe. Specifying custom eeprom-types via platform_data
>> +                * is recommended anyhow.
>> +                */
>> +               chip.page_size = 1;
>
> --
> With Best Regards,
> Andy Shevchenko
