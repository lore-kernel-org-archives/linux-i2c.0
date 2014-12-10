From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Tue, 9 Dec 2014 19:31:18 -0800
Message-ID: <5487BE86.30900@broadcom.com>
References: <rjui@broadcom.com>	<1418172891-19441-1-git-send-email-rjui@broadcom.com>	<1418172891-19441-3-git-send-email-rjui@broadcom.com>	<5487A2D6.8070901@gmail.com>	<5487A4C9.2000604@broadcom.com>	<CAEUmHyZ+VqjzL4LkQozGJtnictPNXHYWM2qMKvD=LmfQdcT8iQ@mail.gmail.com> <CAEUmHyZ86r=7KzJzfE9_upv45vN7geW9woqMkaGaBPwfp3xbMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEUmHyZ86r=7KzJzfE9_upv45vN7geW9woqMkaGaBPwfp3xbMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 12/9/2014 7:28 PM, Varka Bhadram wrote:
>
>
> On Wed, Dec 10, 2014 at 8:51 AM, Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> <mailto:varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     On Wed, Dec 10, 2014 at 7:11 AM, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>     <mailto:rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>> wrote:
>
>
>
>         On 12/9/2014 5:33 PM, Varka Bhadram wrote:
>
>
>             On Wednesday 10 December 2014 06:24 AM, Ray Jui wrote:
>
>                 Add initial support to the Broadcom iProc I2C controller
>                 found in the
>                 iProc family of SoCs.
>
>                 The iProc I2C controller has separate internal TX and RX
>                 FIFOs, each has
>                 a size of 64 bytes. The iProc I2C controller supports
>                 two bus speeds
>                 including standard mode (100kHz) and fast mode (400kHz)
>
>                 Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>                 <mailto:rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>>
>                 Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>                 <mailto:sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>>
>                 ---
>                    drivers/i2c/busses/Kconfig         |    9 +
>                    drivers/i2c/busses/Makefile        |    1 +
>                    drivers/i2c/busses/i2c-bcm-iproc.c |  503
>                 ++++++++++++++++++++++++++++++++++++
>                    3 files changed, 513 insertions(+)
>                    create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c
>
>     (...)
>
>                 +static int bcm_iproc_i2c_probe(struct platform_device
>                 *pdev)
>                 +{
>                 +    int irq, ret = 0;
>                 +    struct bcm_iproc_i2c_dev *dev;
>                 +    struct i2c_adapter *adap;
>                 +    struct resource *res;
>                 +
>                 +    dev = devm_kzalloc(&pdev->dev, sizeof(*dev),
>                 GFP_KERNEL);
>                 +    if (!dev)
>                 +        return -ENOMEM;
>                 +
>                 +    platform_set_drvdata(pdev, dev);
>                 +    dev->device = &pdev->dev;
>                 +    init_completion(&dev->done);
>                 +
>                 +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>                 +    if (!res)
>                 +        return -ENODEV;
>
>
>             We can remove this resource check. This checking will happen
>             with
>             devm_ioremap_resource()
>
>         Don't you need to obtain a valid resource and pass it into
>         devm_ioremap_resource? Without 'res' being assigned a valid
>         resource, devm_ioremap_resource will reject with "invalid resource".
>
>     platform_get_resource() will return a resource, checking on this
>     resource is happening at
>     http://lxr.free-electrons.com/source/lib/devres.c#L115. So no need
>     to check it explicitly.
>
>     If you check here it will be duplication of check with resource. Two
>     times we are checking on
>     the resource. No point of doing like that.
>
>     Thanks.
Sorry I misunderstood what you meant. Okay I'll get rid of if (!res) 
check there. Thanks.

>
>
> See this: http://lxr.free-electrons.com/source/lib/devres.c#L102
>
> --
> Thanks and Regards,
> Varka Bhadram.
