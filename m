From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
Date: Tue, 31 Mar 2020 10:52:07 -0700
Message-ID: <20200331175207.GG199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-3-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1585652976-17481-3-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Akash,

On Tue, Mar 31, 2020 at 04:39:30PM +0530, Akash Asthana wrote:
> Add necessary macros and structure variables to support ICC BW
> voting from individual SE drivers.
> 
> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment dropped enums for ICC paths, given the three
>    paths individual members
> 
> Changes in V3:
>  - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
>  - Add geni_icc_path structure in common header
> 
>  drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    | 36 +++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 7d622ea..9344c14 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
>  }
>  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>  
> +int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
> +		const char *icc_ddr)
> +{
> +	if (icc_core) {
> +		se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
> +		if (IS_ERR(se->to_core.path))
> +			return PTR_ERR(se->to_core.path);
> +	}
> +
> +	if (icc_cpu) {
> +		se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
> +		if (IS_ERR(se->from_cpu.path))
> +			return PTR_ERR(se->from_cpu.path);
> +	}
> +
> +	if (icc_ddr) {
> +		se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
> +		if (IS_ERR(se->to_ddr.path))
> +			return PTR_ERR(se->to_ddr.path);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(geni_icc_get);
> +
> +int geni_icc_vote_on(struct geni_se *se)
> +{
> +	int ret;
> +
> +	if (se->to_core.path) {
> +		ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
> +			se->to_core.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
> +						__func__);
> +			return ret;
> +		}
> +	}
> +
> +	if (se->from_cpu.path) {
> +		ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
> +			se->from_cpu.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
> +						__func__);
> +			return ret;
> +		}
> +	}
> +
> +	if (se->to_ddr.path) {
> +		ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
> +			se->to_ddr.peak_bw);
> +		if (ret) {
> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
> +						__func__);
> +			return ret;
> +		}
> +	}


With an array of 'struct geni_icc_path' pointers the above could be
reduced to:

	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++) {
		if (!se->icc_paths[i])
			continue;

		ret = icc_set_bw(se->icc_paths[i]->path, se->icc_paths[i]->avg_bw,
			se->icc_paths[i]->peak_bw);
		if (ret) {
			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed\n",
						__func__);
			return ret;
		}
	}

similar for geni_icc_vote_off()

It's just a suggestion, looks also good to me as is.

Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
