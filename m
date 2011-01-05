From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
Date: Wed, 05 Jan 2011 18:26:21 +0100
Message-ID: <4D24A9BD.6010200@linutronix.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de> <1291320589-31570-4-git-send-email-bigeasy@linutronix.de> <201012141535.30589.ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012141535.30589.ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Florian Fainelli wrote:
>> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c
>> b/drivers/i2c/busses/i2c-pxa-pci.c new file mode 100644
>> index 0000000..f7b74b9
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
>> +
>> +/*
>> + * the number of bars is hardcoded because pci_select_bars() reports the
>> + * wrong thing.
>> + */
>> +#define CE4100_PCI_I2C_DEVS	3
> 
> I am surprised of your comment about pci_select_bars, it works fine here on a 
> CE4100 device, beware that it will report a bitmask of valid resources (7).
> 
> Changing it later would be quite simple anyway.

yep, my bad. I removed the comment and we can make it fully dynamic once
it is required.

Sebastian
