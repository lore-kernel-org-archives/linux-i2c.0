From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: bfin: turn to Resource-managed API in probe function
Date: Thu, 22 May 2014 17:12:49 +0800
Message-ID: <CAJxxZ0PqQmOp6r9-yrr7OReQZ1Y6aRSBEDzTv0d++P9gvbkd6w@mail.gmail.com>
References: <1394445784-4653-1-git-send-email-sonic.adi@gmail.com>
	<20140521080530.GD2708@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140521080530.GD2708@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, May 21, 2014 at 4:05 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> @@ -646,22 +646,19 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       if (res == NULL) {
>>               dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
>> -             rc = -ENOENT;
>> -             goto out_error_get_res;
>> +             return -ENOENT;
>
> You don't need to check the resource. devm_ioremap_resource will do it.

OK

>
>> -     iface->regs_base = ioremap(res->start, resource_size(res));
>> -     if (iface->regs_base == NULL) {
>> +     iface->regs_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR((void *)iface->regs_base)) {
>>               dev_err(&pdev->dev, "Cannot map IO\n");
>> -             rc = -ENXIO;
>> -             goto out_error_ioremap;
>> +             return PTR_ERR((void *)iface->regs_base);
>
> Do we need the casts?

No. I will remove the cast.

>
>> @@ -740,8 +728,6 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
>>       i2c_del_adapter(&(iface->adap));
>>       free_irq(iface->irq, iface);
>>       peripheral_free_list(dev_get_platdata(&pdev->dev));
>> -     iounmap(iface->regs_base);
>> -     kfree(iface);
>
> You missed to remove the free irq.
>
> Have you actually tried unloading the module?
>

Ok. The free_irq should be removed.

I will send a new patch.

Thank you.

Sonic
