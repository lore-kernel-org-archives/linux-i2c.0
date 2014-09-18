From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v4 3/3] gpio: add support for the Diolan DLN-2 USB GPIO driver
Date: Thu, 18 Sep 2014 15:43:07 +0300
Message-ID: <CAE1zot+_hX6TVkW-B6H9NzgyLhF54oQJZt+x_xXGjEB6A5dAZA@mail.gmail.com>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
	<1410290686-6680-4-git-send-email-octavian.purdila@intel.com>
	<20140918105458.GA2337@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140918105458.GA2337@localhost>
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 18, 2014 at 1:54 PM, Johan Hovold <johan@kernel.org> wrote:
> On Tue, Sep 09, 2014 at 10:24:46PM +0300, Octavian Purdila wrote:
>
> <snip>
>
>> +#define DLN2_GPIO_DIRECTION_IN               0
>> +#define DLN2_GPIO_DIRECTION_OUT              1
>> +
>> +static int dln2_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>> +{
>> +     int ret;
>> +     struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
>> +     struct dln2_gpio_pin req = {
>> +             .pin = cpu_to_le16(offset),
>> +     };
>> +     struct dln2_gpio_pin_val rsp;
>> +     int len = sizeof(rsp);
>> +
>> +     if (test_bit(offset, dln2->pin_dir_set)) {
>> +             rsp.value = !!test_bit(offset, dln2->pin_dir);
>> +             goto report;
>> +     }
>> +
>> +     ret = dln2_transfer(dln2->pdev, DLN2_GPIO_PIN_GET_DIRECTION,
>> +                         &req, sizeof(req), &rsp, &len);
>> +     if (ret < 0)
>> +             return ret;
>> +     if (len < sizeof(rsp) || req.pin != rsp.pin)
>> +             return -EPROTO;
>> +     set_bit(offset, dln2->pin_dir_set);
>
> You shouldn't set this flag until you've stored the direction.
>
>> +
>> +report:
>> +     switch (rsp.value) {
>> +     case DLN2_GPIO_DIRECTION_IN:
>> +             clear_bit(offset, dln2->pin_dir);
>> +             return 1;
>> +     case DLN2_GPIO_DIRECTION_OUT:
>> +             set_bit(offset, dln2->pin_dir);
>> +             return 0;
>> +     default:
>> +             return -EPROTO;
>> +     }
>> +}
>> +
>> +static int dln2_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +     struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
>> +     int dir;
>> +
>> +     dir = dln2_gpio_get_direction(chip, offset);
>> +     if (dir < 0)
>> +             return dir;
>> +
>> +     if (dir)
>> +             return dln2_gpio_pin_get_in_val(dln2, offset);
>> +
>> +     return dln2_gpio_pin_get_out_val(dln2, offset);
>> +}
>> +
>> +static void dln2_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>> +{
>> +     struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
>> +
>> +     dln2_gpio_pin_set_out_val(dln2, offset, value);
>> +}
>> +
>> +static int dln2_gpio_set_direction(struct gpio_chip *chip, unsigned offset,
>> +                                unsigned dir)
>> +{
>> +     struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
>> +     struct dln2_gpio_pin_val req = {
>> +             .pin = cpu_to_le16(offset),
>> +             .value = cpu_to_le16(dir),
>> +     };
>> +
>> +     set_bit(offset, dln2->pin_dir_set);
>
> Set flag after you store the direction below.
>
>> +     if (dir == DLN2_GPIO_DIRECTION_OUT)
>> +             set_bit(offset, dln2->pin_dir);
>> +     else
>> +             clear_bit(offset, dln2->pin_dir);
>
> Either way, it looks like this could race with get_direction() if you
> get a set_direction() while get_direction() is retrieving the direction
> from the device.
>
> This would break gpio_get().
>

I don't think gpio_set_direction() and gpio_get() are allowed to race.
I think the user must make sure the right direction is set before
issuing gpio_get(), otherwise it can read invalid values even if
gpio_get() would not depend on get_direction().

I will fix the calls to pin_dir_set to be made after the pin_dir calls.
