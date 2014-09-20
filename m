From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 4/4] gpio: add support for the Diolan DLN-2 USB GPIO driver
Date: Sat, 20 Sep 2014 09:32:24 +0300
Message-ID: <CAE1zot+ENng7QE42UK9jahCcgNq6eLjKH4BMPX7OtAwHQLQnCg@mail.gmail.com>
References: <1411158165-25794-1-git-send-email-octavian.purdila@intel.com>
	<1411158165-25794-5-git-send-email-octavian.purdila@intel.com>
	<201409200448.48180.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201409200448.48180.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 20, 2014 at 5:48 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Friday 19 September 2014, Octavian Purdila wrote:
>> +struct dln2_gpio_pin {
>> +     __le16 pin;
>> +} __packed;
>
> This does not need to be marked packed, since it is never embedded in another
> structure.
>

Will do.

>> +struct dln2_gpio_pin_val {
>> +     __le16 pin;
>> +     u8 value;
>> +} __packed;
>
> It's enough here to mark just the 'pin' member as packed.
>

OK.

>> +static int dln2_gpio_get_pin_count(struct platform_device *pdev)
>> +{
>> +     int ret;
>> +     __le16 count;
>> +     int len = sizeof(count);
>> +
>> +     ret = dln2_transfer(pdev, DLN2_GPIO_GET_PIN_COUNT, NULL, 0, &count,
>> +                         &len);
>
> You must not do a USB transaction on stack memory.
>

dln2_transfer allocate a new buffer (in dln2_prep_buf(), with
kmalloc()) and does the USB transfer with that buffer.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
