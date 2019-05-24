From: Yang Li <pku.leo@gmail.com>
Subject: Re: [PATCH] i2c: layerscape: use PIO when fail to request dma channel
Date: Fri, 24 May 2019 15:01:26 -0500
Message-ID: <CADRPPNQjgDRPDzA31c6qQ=ZynYQjHTHNOJQ+_bFGr37SPuYApw@mail.gmail.com>
References: <20190524030514.14082-1-qiang.zhao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524030514.14082-1-qiang.zhao@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 23, 2019 at 10:08 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> When fail to request DMA TX/RX channel, use PIO instead for layerscape.

I know that there is a problem that the i2c will fail to probe when
edma driver is not configured.  But this shouldn't be a Layerscape
specific issue.  We don't have proper fix yet, but we have a
workaround which is enable the EDMA driver in the defconfig.
Disabling deferred probe just for Layerscape is not a proper fix
either as this is not specific to Layerscape.

>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 98b278613cf2..39a5ab4cf332 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -347,9 +347,13 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>
>         dma->chan_tx = dma_request_chan(dev, "tx");
>         if (IS_ERR(dma->chan_tx)) {
> +#ifdef CONFIG_ARCH_LAYERSCAPE
> +               dev_dbg(dev, "can't request DMA tx channel\n");
> +#else
>                 ret = PTR_ERR(dma->chan_tx);
>                 if (ret != -ENODEV && ret != -EPROBE_DEFER)
>                         dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
> +#endif
>                 goto fail_al;
>         }
>
> @@ -366,9 +370,13 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>
>         dma->chan_rx = dma_request_chan(dev, "rx");
>         if (IS_ERR(dma->chan_rx)) {
> +#ifdef CONFIG_ARCH_LAYERSCAPE
> +               dev_dbg(dev, "can't request DMA rx channel\n");
> +#else
>                 ret = PTR_ERR(dma->chan_rx);
>                 if (ret != -ENODEV && ret != -EPROBE_DEFER)
>                         dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
> +#endif
>                 goto fail_tx;
>         }
>
> @@ -396,6 +404,9 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>         dma_release_channel(dma->chan_tx);
>  fail_al:
>         devm_kfree(dev, dma);
> +#ifdef CONFIG_ARCH_LAYERSCAPE
> +       dev_info(dev, "can't use DMA, using PIO instead.\n");
> +#endif
>         /* return successfully if there is no dma support */
>         return ret == -ENODEV ? 0 : ret;
>  }
> --
> 2.17.1
>


-- 
- Leo
