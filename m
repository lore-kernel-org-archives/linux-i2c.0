From: Sundar <sunder.svit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Fri, 10 Sep 2010 00:31:52 +0530
Message-ID: <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP@mail.gmail.com>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283907557-1874-1-git-send-email-kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sdharia-sgV2jX0FEOLY0TyS/+Ba5Q@public.gmane.org, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Walker <dwalker-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kenneth,

just some error codes and leaks if I am right :)

On Wed, Sep 8, 2010 at 6:29 AM, Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>=
 wrote:
> +
> +static int __devinit
> +qup_i2c_probe(struct platform_device *pdev)
> +{
> +
> + =A0 =A0 =A0 qup_mem =3D platform_get_resource_byname(pdev, IORESOUR=
CE_MEM,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "qup_phys_addr");
> + =A0 =A0 =A0 if (!qup_mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no qup mem resourc=
e?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

I think this should be -ENXIO instead of -ENODEV?

> + =A0 =A0 =A0 gsbi_mem =3D platform_get_resource_byname(pdev, IORESOU=
RCE_MEM,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "gsbi_qup_i2c_addr");
> + =A0 =A0 =A0 if (!gsbi_mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no gsbi mem resour=
ce?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

Ditto here.

> + =A0 =A0 =A0 in_irq =3D platform_get_resource_byname(pdev, IORESOURC=
E_IRQ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "qup_in_intr");
> +
> + =A0 =A0 =A0 out_irq =3D platform_get_resource_byname(pdev, IORESOUR=
CE_IRQ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "qup_out_intr");
> +
> + =A0 =A0 =A0 err_irq =3D platform_get_resource_byname(pdev, IORESOUR=
CE_IRQ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "qup_err_intr");
> + =A0 =A0 =A0 if (!err_irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no error irq resou=
rce?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }

All the same here too?

> +
> + =A0 =A0 =A0 qup_io =3D devm_request_mem_region(&pdev->dev, qup_mem-=
>start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(qup_mem),=
 pdev->name);
> + =A0 =A0 =A0 if (!qup_io) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "QUP region already=
 claimed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gsbi_io =3D devm_request_mem_region(&pdev->dev, gsbi_me=
m->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(gsbi_mem)=
, pdev->name);
> + =A0 =A0 =A0 if (!gsbi_io) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "GSBI region alread=
y claimed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev =3D devm_kzalloc(&pdev->dev, sizeof(struct qup_i2c_=
dev), GFP_KERNEL);

[..]

> + =A0 =A0 =A0 if (!dev->base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;

Missing *_kzfree whilst returning?

> + =A0 =A0 =A0 dev->gsbi =3D devm_ioremap(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gsbi_mem->start, resour=
ce_size(gsbi_mem));
> + =A0 =A0 =A0 if (!dev->gsbi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "qup_clk");
> + =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Could not get cloc=
k\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_get_failed;

Will not the devm_iounmap be needed here?

Thanx!
Sundar
