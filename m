From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 20:21:17 +0530
Message-ID: <CAKohponsCUuw8v0EUWB8+Ng1PS6cEMvYywgqdcr2fFTbGXOhWg@mail.gmail.com>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
	<50B20670.5070509@pcserviceselectronics.co.uk>
	<CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
	<50B35642.7030104@pcserviceselectronics.co.uk>
	<CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
	<50B36E76.6010008@pcserviceselectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B36E76.6010008-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 26 November 2012 18:58, Paul Carpenter
<paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
>>> +    ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
>>> +            GPIOF_OUT_INIT_HIGH, "i2c-scl");
>>
>>I always get wary of people driving I2C with non-open-drain, especially
>>with stuck busses
>
> I would want to know what "GPIOF_OUT_INIT_HIGH" did as that is
> suspiciously driving output high at startup.

I didn't get the question correctly. You mean you want me to explain what
GPIOF_OPEN_DRAIN and GPIOF_OUT_INIT_HIGH will do?

If no, exit();

GPIOF_OPEN_DRAIN: With this flag, all will work normally, leaving
gpio_set_val(1);
This will put the GPIO in input mode instead of writing one to it in
output mode.

GPIOF_OUT_INIT_HIGH: This will set the direction to output first, and then will
do gpio_set_val(1), which will do what is mentioned in GPIOF_OPEN_DRAIN and
so this action should be safe enough.

--
viresh
