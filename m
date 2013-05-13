From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V10 2/2] i2c/designware: Provide i2c bus recovery support
Date: Mon, 13 May 2013 14:48:42 +0530
Message-ID: <CAKohpokAPohg2aAjawLN2t_Jh29CZAuiWqKz2ah-bJP9Dw4YvA@mail.gmail.com>
References: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar@linaro.org>
	<f7d8d29a338704deaa7a542f9a213fc7696625c9.1359106966.git.viresh.kumar@linaro.org>
	<CAKohpom=DQDv6v7xwnCRvtWBxC+a5mGZeOv=ad8AjKwV2yGBow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpom=DQDv6v7xwnCRvtWBxC+a5mGZeOv=ad8AjKwV2yGBow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5 April 2013 12:12, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi Wolfram,
>
> On 25 January 2013 15:17, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Add bus recovery support for designware_i2c controller. It uses generic gpio
>> based i2c_gpio_recover_bus() routine. Platforms need to pass struct
>> i2c_bus_recovery_info as platform data to designware I2C controller.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
>> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> V9->V10: None
>>
>>  drivers/i2c/busses/i2c-designware-core.c    | 5 ++++-
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> Can you apply this one too?

Ping!!
