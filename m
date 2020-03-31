From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 7/8] spi: spi-qcom-qspi: Add interconnect support
Date: Tue, 31 Mar 2020 12:45:35 -0700
Message-ID: <20200331194535.GL199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-8-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1585652976-17481-8-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 31, 2020 at 04:39:35PM +0530, Akash Asthana wrote:
> Get the interconnect paths for QSPI device and vote according to the
> current bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
> Changes in V3:
>  - No Change.
> 
>  drivers/spi/spi-qcom-qspi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..ad48f43 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -139,7 +140,10 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> -	/* Lock to protect xfer and IRQ accessed registers */
> +	struct icc_path *icc_path_cpu_to_qspi;
> +	unsigned int avg_bw_cpu;
> +	unsigned int peak_bw_cpu;
> +	/* Lock to protect data accessed by IRQs */
>  	spinlock_t lock;
>  };
>  
> @@ -241,6 +245,20 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>  		return ret;
>  	}
>  
> +	/*
> +	 * Set BW quota for CPU as driver supports FIFO mode only.
> +	 * Assume peak bw as twice of avg bw.
> +	 */
> +	ctrl->avg_bw_cpu = Bps_to_icc(speed_hz);
> +	ctrl->peak_bw_cpu = Bps_to_icc(2 * speed_hz);
> +	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, ctrl->avg_bw_cpu,
> +		ctrl->peak_bw_cpu);
> +	if (ret) {
> +		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	spin_lock_irqsave(&ctrl->lock, flags);
>  
>  	/* We are half duplex, so either rx or tx will be set */
> @@ -458,6 +476,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_probe_master_put;
>  
> +	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
> +	if (IS_ERR(ctrl->icc_path_cpu_to_qspi)) {
> +		ret = PTR_ERR(ctrl->icc_path_cpu_to_qspi);
> +		goto exit_probe_master_put;
> +	}
> +	/* Put BW vote on CPU path for register access */
> +	ctrl->avg_bw_cpu = Bps_to_icc(1000);
> +	ctrl->peak_bw_cpu = Bps_to_icc(1000);
> +
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0)
>  		goto exit_probe_master_put;
> @@ -511,9 +538,17 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +	int ret;
>  
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>  
> +	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, 0, 0);
> +	if (ret) {
> +		dev_err_ratelimited(ctrl->dev, "%s: ICC BW remove failed for cpu\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -521,6 +556,15 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, ctrl->avg_bw_cpu,
> +		ctrl->peak_bw_cpu);
> +	if (ret) {
> +		dev_err_ratelimited(ctrl->dev, "%s: ICC BW voting failed for cpu\n",
> +			__func__);
> +		return ret;
> +	}
>  
>  	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
>  }

Looks good to me besides Mark's concern about the bandwith calculation logic.

Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
