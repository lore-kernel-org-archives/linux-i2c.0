From: "Maxin B. John" <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-ocores: Fix PM-related warning
Date: Mon, 4 Mar 2013 10:18:20 +0100
Message-ID: <CAMhs6Yy+CFB-dC7PKCEn=19JbiKz=DqWW1G=QeLUzTvwakE_rg@mail.gmail.com>
References: <1361915625-24294-1-git-send-email-maxin.john@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361915625-24294-1-git-send-email-maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Maxin B. John" <maxin.john-AM1FMPraTHU@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2013 at 10:53 PM,  <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: "Maxin B. John" <maxin.john-AM1FMPraTHU@public.gmane.org>
>
> Fixes this warning:
>   CC      drivers/i2c/busses/i2c-ocores.o
> drivers/i2c/busses/i2c-ocores.c:460:12: warning: 'ocores_i2c_suspend'
>  defined but not used [-Wunused-function]
> drivers/i2c/busses/i2c-ocores.c:471:12: warning: 'ocores_i2c_resume'
> defined but not used [-Wunused-function]
>
> Signed-off-by: Maxin B. John <maxin.john-AM1FMPraTHU@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ocores.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 0e1f824..1ecea5e 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -456,7 +456,7 @@ static int ocores_i2c_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int ocores_i2c_suspend(struct device *dev)
>  {
>         struct ocores_i2c *i2c = dev_get_drvdata(dev);
> @@ -476,12 +476,9 @@ static int ocores_i2c_resume(struct device *dev)
>
>         return 0;
>  }
> +#endif
>
>  static SIMPLE_DEV_PM_OPS(ocores_i2c_pm, ocores_i2c_suspend, ocores_i2c_resume);
> -#define OCORES_I2C_PM  (&ocores_i2c_pm)
> -#else
> -#define OCORES_I2C_PM  NULL
> -#endif
>
>  static struct platform_driver ocores_i2c_driver = {
>         .probe   = ocores_i2c_probe,
> @@ -490,7 +487,7 @@ static struct platform_driver ocores_i2c_driver = {
>                 .owner = THIS_MODULE,
>                 .name = "ocores-i2c",
>                 .of_match_table = ocores_i2c_match,
> -               .pm = OCORES_I2C_PM,
> +               .pm = &ocores_i2c_pm,
>         },
>  };
>
> --
> 1.7.7
>

ping..
