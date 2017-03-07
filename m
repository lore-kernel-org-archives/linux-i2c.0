From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Linux irq subsys i2c interaction question
Date: Tue, 7 Mar 2017 11:57:15 +0100
Message-ID: <d2e66f4d-c868-c9d3-4c4e-d2ca3e93394e@redhat.com>
References: <ff19dd32-2e6a-d4a2-a4f0-f11e1316b7c1@redhat.com>
 <alpine.DEB.2.20.1703070942430.3584@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755458AbdCGLFt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Mar 2017 06:05:49 -0500
In-Reply-To: <alpine.DEB.2.20.1703070942430.3584@nanos>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

Hi,

On 07-03-17 10:18, Thomas Gleixner wrote:
> Hans,
>
> On Tue, 7 Mar 2017, Hans de Goede wrote:
>
>> I've an "interesting" irq problem. I've an i2c pmic (Intel Cherry Trail
>> Whiskey Cove) which itself contains an i2c controller (adapter in Linux
>> terms) and has a pin dedicated for raising irqs by the external battery
>> charger ic attached to its i2c-adapter.
>>
>> To be able to use the irq for the external-charger, the driver for the
>> PMIC needs to implement an irqchip and here things get interesting. This
>> irqchip can NOT use handle_nested_irq, because the i2c-client driver's
>> irq-handler will want to read/write to the external-charger which uses
>> the i2c-controller embedded in the PMIC which requires handling of new
>> (not arrived when started) PMIC irqs, which cannot be done if the client
>> irq-handler is running in handle_nested_irq, because then the PMIC's irq
>> handler is already / still running and blocked in the i2c-client's
>> irq-handler which is waiting for the new interrupt(s) to get processed to
>> signal completion of the i2c-transaction(s) it is doing.
>
> Cute circular dependency.
>
>> I've solved this the following way, which works but
>> I wonder if it is the right way to solve this ?
>>
>> Note this sits inside the threaded interrupt handler
>> for the PMIC irq (after reading and acking the irqs):
>>
>>         /*
>>          * Do NOT use handle_nested_irq here, the client irq handler will
>>          * likely want to do i2c transfers and the i2c controller uses this
>>          * interrupt handler as well, so running the client irq handler from
>>          * this thread will cause things to lock up.
>>          */
>>         if (reg & CHT_WC_EXTCHGRIRQ_CLIENT_IRQ) {
>>                 /*
>>                  * generic_handle_irq expects local irqs to be disabled
>>                  * as normally it is called from interrupt context.
>>                  */
>>                 local_irq_disable();
>>                 generic_handle_irq(adap->client_irq);
>>                 local_irq_enable();
>>         }
>>
>> Not really pretty, but it works well enough. I can
>> live with this if you can live with it too :)
>
> I'm a bit worried about this being hardcoded for that particular use
> case. That also means that you cannot use the generic regmap irq handling
> stuff and need to have your own irq magic there.

Yeah, although the amount of irqchip code needed is pretty minimal
for this (otherwise) simple device.

> Wouldn't it be smarter to
> mark that interrupt in some way and have that as a generic option?

Such a generic option is what I was looking for before going this
route, so yeah +1 for that. I'm not familiar enough with the
irq code to feel comfortable adding that, but if you can provide
a patch, I can test it.

> Can you point me at the relevant drivers/patches?

Here is my current wip stuff (I've pushed this to a for-irq-discussion
branch so that the commits won't go away when I rebase my wip
branch).

mfd patches:
https://github.com/jwrdegoede/linux-sunxi/commit/a0b9ee4ba7b8206880415351a53d5fbbd5969ba6
https://github.com/jwrdegoede/linux-sunxi/commit/a2bff50785c31239ec699a8b43e827c40089ee1f
https://github.com/jwrdegoede/linux-sunxi/commit/708985e8f33471976359c9ff52e2db9964e3ddf4

i2c-adapter patch:
https://github.com/jwrdegoede/linux-sunxi/commit/88a671b3543ffd1f5f4251f4028e4a5d67d88fda

Note the mfd driver has its own irqchip using the regmap-irq.c stuff (second commit)
and the trouble some irqchip driver is nested from that in the i2c-adapter driver
(the last commit).

Regards,

Hans
