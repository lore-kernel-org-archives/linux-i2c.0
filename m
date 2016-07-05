From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 0/6] Implement I2C restart handler
Date: Tue, 5 Jul 2016 08:41:04 -0700
Message-ID: <577BD510.1070506@roeck-us.net>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <20160705145839.GA3641@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160705145839.GA3641@tetsubishi>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stefan Christ <s.christ-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/05/2016 07:58 AM, Wolfram Sang wrote:
> Hi,
>
>> this is a request for feedback about a lockdep-warning-free I2C
>> restart_handler.  I would like to know whether someone had the problem already
>> and how the best and mainline friendliest solution looks like.
>> I have an embedded board with the PMIC chip DA9063 that is also used as a
>> voltage regulator for DVFS. For a clean reboot/reset of the system I have to
>> set the bit nSHUTDOWN in the PMIC via I2C. The restart_handler call chain
>> is of type
>>
>>      static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
>>
>> So any code running as a restart_handler cannot (should not) wait, for other
>> locks. When you use i2c_transfer/regmap you get lockdep warnings like [1].
>
> Yes, this problem has come up occasionally. And it is not only about
> sleeping. IRQs are disabled, too.
>
> My idea was to introduce master_xfer_irqless or similar to struct
> i2c_algorithm. I even discussed this shortly with Mark Brown how to
> interact with regmap; but this was too long ago, so I forgot what we
> agreed on :(
>
>> Any comments?
>
> I just skimmed very lightly over the patchset. Yet, seeing an I2C client
> messing directly with 'struct adapter' breaks so many abstractions, it
> hits my instant-NACK nerve ;)
>

My NACK would be for two other reasons: First, for bypassing the watchdog core
for handling the minimum time between heartbeats, second for bypassing
the watchdog core to implement a reboot handler. Both are inadequately
or not at all explained.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
