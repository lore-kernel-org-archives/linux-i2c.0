From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Thu, 09 Sep 2010 14:52:19 -0600
Message-ID: <4C894903.1050909@codeaurora.org>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org> <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sundar <sunder.svit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sdharia-sgV2jX0FEOLY0TyS/+Ba5Q@public.gmane.org, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Walker <dwalker-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sundar wrote:
> Hi Kenneth,
> 
> just some error codes and leaks if I am right :)
> 
> On Wed, Sep 8, 2010 at 6:29 AM, Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> +
>> +static int __devinit
>> +qup_i2c_probe(struct platform_device *pdev)
>> +{
>> +
>> +       qup_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                                               "qup_phys_addr");
>> +       if (!qup_mem) {
>> +               dev_err(&pdev->dev, "no qup mem resource?\n");
>> +               return -ENODEV;
> 
> I think this should be -ENXIO instead of -ENODEV?
> 
>> +       gsbi_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                                               "gsbi_qup_i2c_addr");
>> +       if (!gsbi_mem) {
>> +               dev_err(&pdev->dev, "no gsbi mem resource?\n");
>> +               return -ENODEV;
> 
> Ditto here.
> 
>> +       in_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> +                                               "qup_in_intr");
>> +
>> +       out_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> +                                               "qup_out_intr");
>> +
>> +       err_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> +                                               "qup_err_intr");
>> +       if (!err_irq) {
>> +               dev_err(&pdev->dev, "no error irq resource?\n");
>> +               return -ENODEV;
>> +       }
> 
> All the same here too?
> 
>> +
>> +       qup_io = devm_request_mem_region(&pdev->dev, qup_mem->start,
>> +                       resource_size(qup_mem), pdev->name);
>> +       if (!qup_io) {
>> +               dev_err(&pdev->dev, "QUP region already claimed\n");
>> +               return -EBUSY;
>> +       }
>> +
>> +       gsbi_io = devm_request_mem_region(&pdev->dev, gsbi_mem->start,
>> +                       resource_size(gsbi_mem), pdev->name);
>> +       if (!gsbi_io) {
>> +               dev_err(&pdev->dev, "GSBI region already claimed\n");
>> +               return -EBUSY;
>> +       }
>> +
>> +       dev = devm_kzalloc(&pdev->dev, sizeof(struct qup_i2c_dev), GFP_KERNEL);
> 
> [..]
> 
>> +       if (!dev->base)
>> +               return -ENOMEM;
> 
> Missing *_kzfree whilst returning?
> 
>> +       dev->gsbi = devm_ioremap(&pdev->dev,
>> +                       gsbi_mem->start, resource_size(gsbi_mem));
>> +       if (!dev->gsbi)
>> +               return -ENOMEM;
>> +
>> +       clk = clk_get(&pdev->dev, "qup_clk");
>> +       if (IS_ERR(clk)) {
>> +               dev_err(&pdev->dev, "Could not get clock\n");
>> +               ret = PTR_ERR(clk);
>> +               goto err_clk_get_failed;
> 
> Will not the devm_iounmap be needed here?
> 
> Thanx!
> Sundar
> 

Hopefully no leaks since I am using the devm_ calls.  The resources 
should be freed up automatically on device release and if the probe 
function fails.  Please let me know if this assumption is not correct.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
