From: Grygorii Strashko <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Thu, 12 Mar 2015 14:37:25 +0200
Message-ID: <CAO5CWPJWhpGCb4NvXnJJ00-9kOvvqtxQsSQbTMxODNC4tjtWzQ@mail.gmail.com>
References: <55003E6B.40008@nokia.com>
	<55008AD7.4070905@linaro.org>
	<55015351.7040508@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55015351.7040508-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12 March 2015 at 10:50, Alexander Sverdlin
<alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> On 11/03/15 19:35, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>> +    if (i2c_davinci_wait_status_change(dev, DAVINCI_I2C_STR_BB, 0)) {
>>> +        dev_warn(dev->dev, "timeout waiting for bus ready\n");
>>> +        davinci_i2c_recover_bus(dev);
>>> +        i2c_davinci_init(dev);
>>> +        /*
>>> +         * the bus should not be busy after init, otherwise something
>>> +         * is badly broken
>>> +         */
>>
>> I think you should recheck BB and return error if it's still detected.
>
> But after re-reading the datasheet, I must conclude, this is almost not possible.
> It will be a dead code. Reset will clear BB anyway and the only possibility to see
> BB set to 1 here is when another master transmits right after our reset. We cannot
> guarantee that we will always catch this here, so this must be any way handled over
> AL interrupt.

The question here what is worse:
- silently continue execution with undefined behavior
- or recheck and return error (That's how it was before).

I like option 2 :) - don't believe HW.

-- 
Best regards,
-grygorii
