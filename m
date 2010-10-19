From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-pca-platform: Change i2c adapter name
Date: Tue, 19 Oct 2010 11:14:55 +0900
Message-ID: <4CBCFF1F.4070709@renesas.com>
References: <1287372270-12163-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <20101018102054.0bdec0fc@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20101018102054.0bdec0fc-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Jean .

Thank for your comments.

Jean Delvare wrote:
> Hi Nobuhiro,
> 
> On Mon, 18 Oct 2010 12:24:30 +0900, Nobuhiro Iwamatsu wrote:
>> In kernel which enableded this driver output The following warning,
>> because a slash (/) is in the i2c adapter name by the current driver.
>> This set another adapter name (i2c-pca-platform at 0x) what removed slash.
>>
>> [    2.872000] PCA9564/PCA9665 at 0x06000000: Registering gpio failed!
>> [    2.876000] name 'PCA9564/PCA9665 at 0x06000000'
>> [    2.880000] ------------[ cut here ]------------
>> [    2.880000] WARNING: at fs/proc/generic.c:323
>> [    2.880000] Modules linked in:
>> [    2.880000]
>> [    2.880000] Pid : 1, Comm:           swapper
>> [    2.880000] CPU : 0                  Not tainted  (2.6.36-rc1-00238-g67e5b3a #261)
>> [    2.880000]
>> [    2.880000] PC is at __xlate_proc_name+0x88/0xa4
>> [    2.880000] PR is at __xlate_proc_name+0x88/0xa4
>> [    2.880000] PC  : 800b3bc4 SP  : 9fc41d34 SR  : 40008001 TEA : c0018000
>> [    2.880000] R0  : 00000037 R1  : 9fc40000 R2  : 9fc40000 R3  : 8049db48
>> [    2.880000] R4  : 00000001 R5  : 000000f0 R6  : ffffffff R7  : 8019e450
>> [    2.880000] R8  : 00000000 R9  : 9fc41d9c R10 : 00000007 R11 : 9fc41d9c
>> [    2.880000] R12 : 9fc41d80 R13 : 80167fce R14 : 9fc41d34
>> [    2.880000] MACH: 00000461 MACL: 00000000 GBR : 00000000 PR  : 800b3bc4
>> [    2.880000]
>> [    2.880000] Call trace:
>> [    2.880000]  [<800b4056>] __proc_create+0x46/0x110
>> [    2.880000]  [<80162b00>] strlen+0x0/0x58
>> [    2.880000]  [<800b4824>] proc_mkdir_mode+0x24/0x60
>> [    2.880000]  [<800b486e>] proc_mkdir+0xe/0x1c
>> [    2.880000]  [<8004740a>] register_handler_proc+0x9e/0xd4
>> [    2.880000]  [<80045ab2>] __setup_irq+0x226/0x2c0
>> [    2.880000]  [<80075d50>] kmem_cache_alloc+0x94/0xf0
>> [    2.880000]  [<80045bcc>] request_threaded_irq+0x80/0xdc
>> [    2.880000]  [<802041c0>] i2c_pca_pf_handler+0x0/0x3c
>> [    2.880000]  [<802ecb62>] i2c_pca_pf_probe+0x162/0x294
>> [    2.880000]  [<801a3b38>] platform_drv_probe+0x14/0x1c
>> (...)
> 
> The i2c adapter names are strings which appear as the _contents_ of
> sysfs attributes. They don't appear in procfs. What happens here is
> that the adapter name is used also as the IRQ name:
> 
> 	if (irq) {
> 		ret = request_irq(irq, i2c_pca_pf_handler,
> 			IRQF_TRIGGER_FALLING, i2c->adap.name, i2c);
> 		if (ret)
> 			goto e_reqirq;
> 	}
> 
> This is the problem. i2c->adap.name shouldn't be used here, instead the
> driver name "i2c-pca-platform" should be used.
> 

Oh, I didn't notice. I will fix this.
And hrere was a couse of the warning.

>> (...)
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> CC: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-pca-platform.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
>> index ef5c784..4cc3cdf 100644
>> --- a/drivers/i2c/busses/i2c-pca-platform.c
>> +++ b/drivers/i2c/busses/i2c-pca-platform.c
>> @@ -27,6 +27,8 @@
>>  
>>  #include <asm/irq.h>
>>  
>> +#define DRIVER_NAME "i2c-pca-platform"
>> +
>>  struct i2c_pca_pf_data {
>>  	void __iomem			*reg_base;
>>  	int				irq;	/* if 0, use polling */
>> @@ -171,7 +173,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
>>  	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
>>  	i2c->adap.owner = THIS_MODULE;
>>  	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>> -		 "PCA9564/PCA9665 at 0x%08lx",
>> +		 DRIVER_NAME " at 0x%08lx",
>>  		 (unsigned long) res->start);
> 
> I would like to avoid changing the adapter name when we don't have to.
> People may be using this string as an identifier in i2c tools. Please
> leave the adapter name unchanged and only change the IRQ name.

I see.
But I noticed that it was not necessary to revice it here.
There was the cause of the warning for the name to request_irq.

I revert the revision of here.

> 
>>  	i2c->adap.algo_data = &i2c->algo_data;
>>  	i2c->adap.dev.parent = &pdev->dev;
>> @@ -250,7 +252,7 @@ e_remap:
>>  e_alloc:
>>  	release_mem_region(res->start, resource_size(res));
>>  e_print:
>> -	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
>> +	printk(KERN_ERR "Registering " DRIVER_NAME " FAILED! (%d)\n", ret);
> 
> This is semantically incorrect. We are registering a device here, not a
> driver. The proposed change makes this error message confusing. Please
> revert.
> 
I agree.


Best regards,
   Nobuhiro
