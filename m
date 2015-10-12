From: Kieran Bingham <kieranbingham@gmail.com>
Subject: Re: [PATCH v2] i2c: return probe deferred status on dev_pm_domain_attach
Date: Mon, 12 Oct 2015 21:50:09 +0100
Message-ID: <CAB3z_RpmeXepxp8w1Wvt_ux=G-31EpvGOVegPo6qtMXJeN-mEQ@mail.gmail.com>
References: <1444679344-27284-1-git-send-email-kieranbingham@gmail.com>
	<CAKdAkRSvhX97NbG2=0qq5RPsUwOVHyz4jcxUxfttWfw1wERyNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33154 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbJLUuK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 16:50:10 -0400
In-Reply-To: <CAKdAkRSvhX97NbG2=0qq5RPsUwOVHyz4jcxUxfttWfw1wERyNw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On 12 October 2015 at 21:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Mon, Oct 12, 2015 at 12:49 PM, Kieran Bingham
> <kieranbingham@gmail.com> wrote:
>> A change of return status was introduced in commit 3fffd1283927
>> ("i2c: allow specifying separate wakeup interrupt in device tree")
>>
>> The commit prevents the defer status being passed up the call stack
>> appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.
>
> Ah, indeed, sorry about that.
>
>>
>> Catch the PROBE_DEFER and clear up the IRQ wakeup status
>>
>> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
>> Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup
>> interrupt in device tree")
>>
>> ---
>> V2:
>>  Fall through the error path before returning -EPROBE_DEFER
>>
>>  drivers/i2c/i2c-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 5f89f1e3c2f2..51f20cce1732 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -699,6 +699,8 @@ static int i2c_device_probe(struct device *dev)
>>                                         client));
>>                 if (status)
>>                         goto err_detach_pm_domain;
>> +       } else {
>> +               goto err_clear_wakeup_irq;
>>         }
>
> How about we do:
>
>         status = dev_pm_domain_attach(&client->dev, true);
>         if (status == -EPROBE_DEFER)
>                 goto err_clear_wakeup_irq;
>
>         status = driver->probe(client, i2c_match_id(driver->id_table, client));
>         ....
>
> instead of doing "else"?

Well in fact - this is actually what I do in the next set of patches
I'm working on which led me to find this fault.
 (i2c: Provide a temporary .probe2() call-back type)

And so ... v3 ... so much for my quick one word bugfix patch :)

I'll send v3 with the if/else removed

--
Kieran


>
> Thanks.
>
> --
> Dmitry
