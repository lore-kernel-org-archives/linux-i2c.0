From: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] add MAX17040 Fuel Gauge driver
Date: Mon, 08 Jun 2009 11:36:01 +0900
Message-ID: <4A2C7911.80407@samsung.com>
References: <4A28BC20.3010307@samsung.com>
 <5d5443650906060959w678a29acn8200239d35869dca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <5d5443650906060959w678a29acn8200239d35869dca-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Trilok Soni,

Thanks for review

> Hi Minkyu Kang,
> 
> On Fri, Jun 5, 2009 at 12:03 PM, Minkyu Kang<mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion batteries
>> This patch adds support the MAX17040 Fuel Gauge
>>
> 
> Thanks for making change. Some more comments.
> 
>>  endif # POWER_SUPPLY
>> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>> index 2fcf41d..9c48995 100644
>> --- a/drivers/power/Makefile
>> +++ b/drivers/power/Makefile
>> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA)    += tosa_battery.o
>>  obj-$(CONFIG_BATTERY_WM97XX)   += wm97xx_battery.o
>>  obj-$(CONFIG_BATTERY_BQ27x00)  += bq27x00_battery.o
>>  obj-$(CONFIG_BATTERY_DA9030)   += da9030_battery.o
>> -obj-$(CONFIG_CHARGER_PCF50633) += pcf50633-charger.o
>> \ No newline at end of file
>> +obj-$(CONFIG_BATTERY_MAX17040))        += max17040_battery.o
> 
> Are we following any alphabetical order in this Makefile?
> 

I'm not sure either. :(
I just grouping with batteries.

>> +static int max17040_suspend(struct i2c_client *client,
>> +               pm_message_t state)
>> +{
>> +       struct max17040_chip *chip = i2c_get_clientdata(client);
>> +
>> +       cancel_delayed_work(&chip->work);
>> +       return 0;
>> +}
>> +
>> +static int max17040_resume(struct i2c_client *client)
>> +{
>> +       struct max17040_chip *chip = i2c_get_clientdata(client);
>> +
>> +       schedule_delayed_work(&chip->work, MAX17040_DELAY);
>> +       return 0;
>> +}
>> +
> 
> Please add #ifdef CONFIG_PM around suspend resume functions.
> 

Ok, I will.
Thanks

---
from, prom.
