From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c/pxa2xx: Add PCI support for PXA I2C controller
Date: Fri, 26 Nov 2010 15:16:05 +0100
Message-ID: <4CEFC125.8010905@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de> <1290633617-15311-4-git-send-email-bigeasy@linutronix.de> <20101125235933.GD15948@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101125235933.GD15948-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
>> +#define IBMR            (0x14)
>> +#define IDBR            (0x0c)
>> +#define ICR             (0x00)
>> +#define ISR             (0x04)
>> +
>> +#define _IBMR(i2c)	((i2c)->reg_base + IBMR)
>> +#define _IDBR(i2c)	((i2c)->reg_base + IDBR)
>> +#define _ICR(i2c)	((i2c)->reg_base + ICR)
>> +#define _ISR(i2c)	((i2c)->reg_base + ISR)
> 
> couldn't these be in common code?

Yes. I'm going to move these back into the driver and ifdef x86 & arm
specific.

>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
>> +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
>> +{
>> +	struct ce4100_devices *sds;
>> +	unsigned int i;
>> +
>> +	sds = pci_get_drvdata(dev);
>> +	pci_set_drvdata(dev, NULL);
>> +
>> +	for (i = 0; i < CE4100_PCI_I2C_DEVS; i++)
> how about using ARRAY_SIZE of sds->sd[i] ?

I'm still thinking whether to use this or pci_select_bars() as Florian
suggested.

Sebastian
