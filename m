From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V3, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Fri, 15 May 2015 10:59:35 -0700
Message-ID: <55563407.9070409@gmail.com>
References: <1431536390-9761-1-git-send-email-kdasu.kdev@gmail.com> <555630DE.2090100@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <555630DE.2090100-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15/05/15 10:46, Ray Jui wrote:
[snip]

>> +            ret = -ETIMEDOUT;
>> +    } else {
>> +        /* we are in polling mode */
>> +        u32 bsc_intrp;
>> +        unsigned long time_left = jiffies + timeout;
>> +
>> +        do {
>> +            bsc_intrp = bsc_readl(dev, iic_enable) &
>> +                BSC_IIC_EN_INTRP_MASK;
>> +            if (time_after(jiffies, time_left)) {
>> +                ret = -ETIMEDOUT;
>> +                break;
>> +            }
>> +            cpu_relax();
>> +        } while (!bsc_intrp);
>> +        brcmstb_i2c_enable_disable_irq(dev, INT_DISABLE);
> 
> I had a question on this during the previous review. You said you will
> investigate but never really answer my question or add a comment in the
> code to explain it. My question was, why do you need to disable
> interrupt in the end of the polling loop? Do you use interrupt at all in
> polling mode? If so, why?

I suspect this may have to do with the special Level 2 interrupt
controller (drivers/irqchip/irq-bcm7120-l2.c) used between the Level 1
interrupt signaled to the CPU (<irq-bcm7038-l1.c or ARM GIC) and the
interrupt generation on the BSC controller side.

The L2 interrupt controller only signals interrupts, but the actual
acknowledgement of the interrupt needs to happen at the BSC controller
level, if we do not do that, I suspect the controller keep ssignaling a
pending interrupt, so we would need to clear it to move forward with
next events.
-- 
Florian
