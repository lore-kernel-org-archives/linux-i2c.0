From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] ACPI: support for NXP i2c controller
Date: Tue, 3 Sep 2019 07:41:45 +0200
Message-ID: <896b88d4-9d1b-922b-1784-55ef9a1a1830@pengutronix.de>
References: <20190711102601.20582-1-chuanhua.han@nxp.com>
 <CAJZ5v0hY2sL+XfN_4v07_hjvoxgCAt+Q89+wNg5Pky6XKP-mqA@mail.gmail.com>
 <CAHp75VfFtMMQhetRFHrx=Ft7OWwyMqLrwP3sPjT6YVtr8xCHoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfFtMMQhetRFHrx=Ft7OWwyMqLrwP3sPjT6YVtr8xCHoQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chuanhua Han <chuanhua.han@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 02.09.19 23:16, Andy Shevchenko wrote:
> On Mon, Sep 2, 2019 at 11:58 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Jul 11, 2019 at 12:35 PM Chuanhua Han <chuanhua.han@nxp.com> wrote:
>>>
>>> Enable NXP i2c controller to boot with ACPI
>>>
>>> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>>> Signed-off-by: Udit Kumar <udit.kumar@nxp.com>
>>> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
>>
>> Wolfram, any objections to this from the i2c side?
> 
> May I propose amendment(s)?
> 
>>> @@ -44,6 +44,7 @@
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/sched.h>
>>>   #include <linux/slab.h>
> 
>>> +#include <linux/acpi.h>
> 
> If it's kept in order, better to go with it. (Yes, it is as I have checked)
> However, property.h should be included instead, see below.
> 
>>>          const struct of_device_id *of_id = of_match_device(i2c_imx_dt_ids,
>>>                                                             &pdev->dev);
>>> +       const struct acpi_device_id *acpi_id =
>>> +                       acpi_match_device(i2c_imx_acpi_ids,
>>> +                                         &pdev->dev);
> 
> 
>>>          if (of_id)
>>>                  i2c_imx->hwdata = of_id->data;
>>> +       else if (acpi_id)
>>> +               i2c_imx->hwdata = (struct imx_i2c_hwdata *)
>>> +                               acpi_id->driver_data;
> 
> 
> The above altogher may be replaced with
> 
> const struct imx_i2c_hwdata *match;
> ...
> match = device_get_match_data(&pdev->dev);
> if (match)
>   i2c_imx->hwdata = match;
> else
> ...

Instead of "may be replaced", I would say: it should be replaced :)

>>> +               .acpi_match_table = ACPI_PTR(i2c_imx_acpi_ids),
> 
> Since there is no #ifdef guard no need to use ACPI_PTR().
> 

What iMX/(other NXP?) SoCs are with ACPI support?  Where I can get one? I would like to 
know more about it.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
