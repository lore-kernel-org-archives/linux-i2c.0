From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 2/9] i2c: xiic: move the xiic_process to thread context
Date: Fri, 10 Jul 2015 10:38:11 +0530
Message-ID: <CAKfKVtGOxWU-66fQSd8D6Ue0Si0koQF-CrR0pVZ8RupMNQ=-GQ@mail.gmail.com>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
	<1434554299-23443-3-git-send-email-shubhraj@xilinx.com>
	<20150709173158.GD4744@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150709173158.GD4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 9, 2015 at 11:01 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>>  static int xiic_bus_busy(struct xiic_i2c *i2c)
>> @@ -602,16 +601,21 @@ static void xiic_start_send(struct xiic_i2c *i2c)
>>  static irqreturn_t xiic_isr(int irq, void *dev_id)
>>  {
>>       struct xiic_i2c *i2c = dev_id;
>> -
>> -     spin_lock(&i2c->lock);
>> +     u32 pend, isr, ier;
>> +     irqreturn_t ret = IRQ_HANDLED;
>> +     /* Do not processes a devices interrupts if the device has no
>> +      * interrupts pending
>> +      */
>
> Shouldn't you init 'ret' to IRQ_NONE then?
>

Indeed I missed it.
