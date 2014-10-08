From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] gpio: add support for Cypress CYUSBS234 USB-GPIO adapter
Date: Wed, 8 Oct 2014 16:18:36 +0900
Message-ID: <CAAVeFu+X0Lk=5sNm9kOwGX=2-DYN_-5v-7M9bAWXraffKsTkMg@mail.gmail.com>
References: <1412606822-3406-1-git-send-email-muth@cypress.com>
 <CAAVeFu+vBZ49ciZT+-dnKXks201_psy_NtYsTjw0ptOkx2es7Q@mail.gmail.com> <405b439b16ea40078718da326343f673@BN1PR06MB069.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <405b439b16ea40078718da326343f673-W5EIp8XyyIo12s5EQIJpXb9PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 8, 2014 at 4:09 PM, Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org> wrote:
>> -----Original Message-----
>> From: Alexandre Courbot [mailto:gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Tuesday, October 07, 2014 3:34 PM
>> To: Muthu Mani
>> Cc: Samuel Ortiz; Lee Jones; Wolfram Sang; Linus Walleij; Greg Kroah-
>> Hartman; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linux Kernel Mailing List; Rajaram Regupathy; Johan
>> Hovold
>> Subject: Re: [PATCH v3 3/3] gpio: add support for Cypress CYUSBS234 USB-
>> GPIO adapter
>>
>> On Mon, Oct 6, 2014 at 11:47 PM, Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org> wrote:
>> > +
>> > +static int cy_gpio_direction_input(struct gpio_chip *chip,
>> > +                                       unsigned offset) {
>> > +       return 0;
>> > +}
>> > +
>> > +static int cy_gpio_direction_output(struct gpio_chip *chip,
>> > +                                       unsigned offset, int value) {
>> > +       return 0;
>> > +}
>>
>> If that chip is capable of both output and input, shouldn't these functions be
>> implemented? I think this has already been pointed out in a previous version
>> but you did not reply.
>
> Thanks for your inputs.
>
> Only the GPIOs which are configured to be output GPIO can be set.

In that case cy_gpio_set() should return an error for GPIOs which are
not configured as outputs. Is that guaranteed by the current
implementation?

> The set operation would fail trying to set the input or unconfigured GPIOs.
> In this version of driver, this support is not added, it can be introduced in future versions.
> I will add a TODO note in the code.

Argh, no TODO please. Actual code that will turn this code into a
solid driver that can be merged.

Can all GPIOs be set as input or output? If so, please implement
cy_gpio_direction_*() and make sure that cy_gpio_set() behaves
properly if a GPIO is not an output. If the input/output GPIOs are
fixed, please make cy_gpio_direction_*() return an error if the GPIO
capabilities does not correspond to what is asked, and again ensure
that cy_gpio_set() works as expected.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
