From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] i2c: qcom-geni: Grow a dev pointer to simplify code
Date: Tue, 4 Feb 2020 13:18:40 -0800
Message-ID: <CAD=FV=W-2jrpSbHoTLJ7MzVAhR=4hKnVyjdtgUQCs=Qr4ptOfg@mail.gmail.com>
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-3-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200204193152.124980-3-swboyd@chromium.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Girish Mahadevan <girishm@codeaurora.org>, Dilip Kota <dkota@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some lines are long here. Use a struct dev pointer to shorten lines and
> simplify code. The clk_get() call can fail because of EPROBE_DEFER
> problems too, so just remove the error print message because it isn't
> useful.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 51 ++++++++++++++----------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 3e13b54ce3f8..192a8f622f3d 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -502,45 +502,42 @@ static int geni_i2c_probe(struct platform_device *pdev)
>         struct resource *res;
>         u32 proto, tx_depth;
>         int ret;
> +       struct device *dev = &pdev->dev;
>
> -       gi2c = devm_kzalloc(&pdev->dev, sizeof(*gi2c), GFP_KERNEL);
> +       gi2c = devm_kzalloc(dev, sizeof(*gi2c), GFP_KERNEL);
>         if (!gi2c)
>                 return -ENOMEM;
>
> -       gi2c->se.dev = &pdev->dev;
> -       gi2c->se.wrapper = dev_get_drvdata(pdev->dev.parent);
> +       gi2c->se.dev = dev;
> +       gi2c->se.wrapper = dev_get_drvdata(dev->parent);
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       gi2c->se.base = devm_ioremap_resource(&pdev->dev, res);
> +       gi2c->se.base = devm_ioremap_resource(dev, res);
>         if (IS_ERR(gi2c->se.base))
>                 return PTR_ERR(gi2c->se.base);
>
> -       gi2c->se.clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(&pdev->dev)) {
> +       gi2c->se.clk = devm_clk_get(dev, "se");
> +       if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(dev)) {
>                 ret = PTR_ERR(gi2c->se.clk);
> -               dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
>                 return ret;
>         }

As with my response to your similar SPI change [1], there are cases
where this print could have informed us about other errors besides
EPROBE_DEFER, but it does seem rather unlikely so I'm OK w/ your
change.

I'm wondering why you didn't further clean this up, though.  You could
have fully gotten rid of the braces by just doing:

return PTR_ERR(gi2c->se.clk);


> -       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> -                                                       &gi2c->clk_freq_out);
> +       ret = device_property_read_u32(dev, "clock-frequency",
> +                                      &gi2c->clk_freq_out);
>         if (ret) {
> -               dev_info(&pdev->dev,
> -                       "Bus frequency not specified, default to 100kHz.\n");
> +               dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
>                 gi2c->clk_freq_out = KHZ(100);
>         }
>
> -       if (has_acpi_companion(&pdev->dev))
> -               ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
> +       if (has_acpi_companion(dev))
> +               ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>
>         gi2c->irq = platform_get_irq(pdev, 0);
> -       if (gi2c->irq < 0) {
> -               dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
> +       if (gi2c->irq < 0)

Commit message doesn't mention removing this print, though checking
platform_get_irq() it looks like it already spams in the case where a
non-EPROBE_DEFER error is returned so I think you're good.

[1] https://lore.kernel.org/r/CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com


In any case above things aren't terribly important, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
