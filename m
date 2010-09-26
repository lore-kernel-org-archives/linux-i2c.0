From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Mon, 27 Sep 2010 00:04:01 +0100
Message-ID: <4C9FD161.2000606@fluff.org>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org> <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sundar <sunder.svit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Daniel Walker <dwalker-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, sdharia-sgV2jX0FEOLY0TyS/+Ba5Q@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09/09/10 20:01, Sundar wrote:
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

I think both are inappropriate here, -ENXIO is an IO failure
and -ENODEV is 'device is not here'. However, some people don't
like the use of things like -ENOENT (filesystem errors) for this
sort of situation. ENOTSUP might be something you could use.

As a note, both ENXIO and ENODEV will be taken by the device
framework as a device is not there at-all and not display any
error to the user (which is annoying if you then forget to
do anything about it)

As a note, you may want to have a look at devres to offload the
tracking of the requested and mapped resources.
