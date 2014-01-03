From: Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Subject: Re: [PATCH v3 REPOST 2/4] i2c: i2c-ibm-iic: perform the transfer in
 the interrupt handler
Date: Fri, 3 Jan 2014 16:57:17 +0100
Message-ID: <CACh+v5OJoGSZZjbDfeKSnPQ7BHHx6zhdp06=YcMWWfu03FVS+Q@mail.gmail.com>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
	<1387552376-12986-3-git-send-email-jjhiblot@traphandler.com>
	<20140103150416.GA7132@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140103150416.GA7132@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: jean-jacques hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2014/1/3 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>
> Hi,
>
> thanks for the submission!
You're welcome :) Thanks for reviewing this.

>
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -58,6 +58,8 @@ static bool iic_force_fast;
>>  module_param(iic_force_fast, bool, 0);
>>  MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
>>
>> +#define FIFO_FLUSH_TIMEOUT 100
>
> 100 what? The unit is missing.

The actual value of this timeout isn't very important. This is used
only to avoid a never ending loop in case the hardware goes into a
really bad state.

>
>> @@ -167,8 +170,8 @@ static void iic_dev_init(struct ibm_iic_private* dev)
>>       /* Clear control register */
>>       out_8(&iic->cntl, 0);
>>
>> -     /* Enable interrupts if possible */
>> -     iic_interrupt_mode(dev, dev->irq >= 0);
>> +     /* Start with each individual interrupt masked*/
>
> Space at the end of comment missing
ok
>
>>  static irqreturn_t iic_handler(int irq, void *dev_id)
>>  {
>> -     struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
>> -     struct iic_regs __iomem *iic = dev->vaddr;
>> -
>> -     DBG2(dev, "irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
>> -          in_8(&iic->sts), in_8(&iic->extsts));
>> -
>> -     /* Acknowledge IRQ and wakeup iic_wait_for_tc */
>> -     out_8(&iic->sts, STS_IRQA | STS_SCMP);
>> -     wake_up_interruptible(&dev->wq);
>> -
>> +     struct ibm_iic_private *dev = (struct ibm_iic_private *) dev_id;
>> +     iic_xfer_bytes(dev);
>
> Is iic_xfer_bytes later used when polling, too? Otherwise it could be
> simply inserted here.
Yes it'll be used for polling (implemented in a later patch)
>
>
>> +     if ((status & STS_ERR) ||
>> +         (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
>> +             DBG(dev, "status 0x%x\n", status);
>> +             DBG(dev, "extended status 0x%x\n", ext_status);
>> +             if (status & STS_ERR)
>> +                     ERR(dev, "Error detected\n");
>> +             if (ext_status & EXTSTS_LA)
>> +                     DBG(dev, "Lost arbitration\n");
>> +             if (ext_status & EXTSTS_ICT)
>> +                     ERR(dev, "Incomplete transfer\n");
>> +             if (ext_status & EXTSTS_XFRA)
>> +                     ERR(dev, "Transfer aborted\n");
>> +
>> +             dev->status = -EIO;
>
> You could consider returning different fault codes for the different
> states. See Documentation/i2c/fault-codes for a guide.
I'll have a look at it.

>
>> +     if (dev->msgs == NULL) {
>> +             DBG(dev, "spurious !!!!!\n");
>> +             dev->status = -EINVAL;
>> +             return dev->status;
>> +     }
>
> Does that really happen?
Not in my test cases (going through i2c dev). But it could if the data
passed to i2c_transfer is malformed.
Should I remove this ?

>
> And it introduces a build warning:
>
> drivers/i2c/busses/i2c-ibm_iic.c:410:12: warning: 'iic_wait_for_tc' defined but not used [-Wunused-function]
>
I posted this some time ago, but I believe I kept this in to help git
produce a diff readable by a human.
It's removed in a later patch

Jean-Jacques
