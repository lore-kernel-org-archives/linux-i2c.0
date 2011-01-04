From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c_intel_mid: Fix slash in sysfs name
Date: Tue, 04 Jan 2011 00:55:33 +0000
Message-ID: <4D227005.3010000@fluff.org>
References: <20101214152849.7265.93628.stgit@bob.linux.org.uk> <20101215100815.44fb8b83@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101215100815.44fb8b83-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15/12/10 09:08, Jean Delvare wrote:
> Hi Alan,
> 
> On Tue, 14 Dec 2010 15:29:08 +0000, Alan Cox wrote:
>> From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> This gets caught by the new sanity check code.
> 
> New sanity check of what? Where's the code?
> 
>> Instead of the slash use a
>> different symbol. This was originally found by Major Lee who proposed a
>> rather more complex patch which changed the name according to the chip
>> type.
>>
>> On the basis that we are in a late -rc and making Linus grumpy isn't always
>> a good idea (however fun) this is a simple alternative.
>>
>> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>
>>  drivers/i2c/busses/i2c-intel-mid.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>
>> diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
>> index 657f314..da4bbdd 100644
>> --- a/drivers/i2c/busses/i2c-intel-mid.c
>> +++ b/drivers/i2c/busses/i2c-intel-mid.c
>> @@ -1035,7 +1035,7 @@ static int __devinit intel_mid_i2c_probe(struct pci_dev *dev,
>>  
>>  	/* Initialize struct members */
>>  	snprintf(mrst->adap.name, sizeof(mrst->adap.name),
>> -		"MRST/Medfield I2C at %lx", start);
>> +		"Intel MID I2C at %lx", start);
>>  	mrst->adap.owner = THIS_MODULE;
>>  	mrst->adap.algo = &intel_mid_i2c_algorithm;
>>  	mrst->adap.dev.parent = &dev->dev;
> 
> Having a slash in an I2C adapter name shouldn't be a problem. The real
> problem is below:
> 
> 	err = request_irq(dev->irq, intel_mid_i2c_isr, IRQF_SHARED,
> 					mrst->adap.name, mrst);
> 
> Using the adapter name to request the IRQ is silly. The very same issue
> was fixed in i2c-pca-platform recently:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=323584436db0cb05286425d4dfd9516fce88487f

I agree, something like dev_name(dev) is much better for readability
of /proc/interruopts


> You want to use a short name for the interrupt. Either the driver name,
> or if you really want something device-specific, the bus device name.
> 
