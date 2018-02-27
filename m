From: "Christ, Austin" <austinwc@codeaurora.org>
Subject: Re: [PATCH 02/12] i2c: qup: minor code reorganization for use_dma
Date: Tue, 27 Feb 2018 14:48:14 -0700
Message-ID: <73c94c05-e4a8-cb02-1919-1f872aafd96a@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Tested on Centriq 2400

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

On 2/3/2018 12:58 AM, Abhishek Sahu wrote:
> 1. Assigns use_dma in qup_dev structure itself which will
>     help in subsequent patches to determine the mode in IRQ handler.
> 2. Does minor code reorganization for loops to reduce the
>     unnecessary comparison and assignment.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>   drivers/i2c/busses/i2c-qup.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 9faa26c41a..c68f433 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -190,6 +190,8 @@ struct qup_i2c_dev {
>   
>   	/* dma parameters */
>   	bool			is_dma;
> +	/* To check if the current transfer is using DMA */
> +	bool			use_dma;
>   	struct			dma_pool *dpool;
>   	struct			qup_i2c_tag start_tag;
>   	struct			qup_i2c_bam brx;
> @@ -1297,7 +1299,7 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>   			   int num)
>   {
>   	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> -	int ret, len, idx = 0, use_dma = 0;
> +	int ret, len, idx = 0;
>   
>   	qup->bus_err = 0;
>   	qup->qup_err = 0;
> @@ -1326,13 +1328,12 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>   			len = (msgs[idx].len > qup->out_fifo_sz) ||
>   			      (msgs[idx].len > qup->in_fifo_sz);
>   
> -			if ((!is_vmalloc_addr(msgs[idx].buf)) && len) {
> -				use_dma = 1;
> -			 } else {
> -				use_dma = 0;
> +			if (is_vmalloc_addr(msgs[idx].buf) || !len)
>   				break;
> -			}
>   		}
> +
> +		if (idx == num)
> +			qup->use_dma = true;
>   	}
>   
>   	idx = 0;
> @@ -1356,15 +1357,17 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>   
>   		reinit_completion(&qup->xfer);
>   
> -		if (use_dma) {
> +		if (qup->use_dma) {
>   			ret = qup_i2c_bam_xfer(adap, &msgs[idx], num);
> +			qup->use_dma = false;
> +			break;
>   		} else {
>   			if (msgs[idx].flags & I2C_M_RD)
>   				ret = qup_i2c_read_one_v2(qup, &msgs[idx]);
>   			else
>   				ret = qup_i2c_write_one_v2(qup, &msgs[idx]);
>   		}
> -	} while ((idx++ < (num - 1)) && !use_dma && !ret);
> +	} while ((idx++ < (num - 1)) && !ret);
>   
>   	if (!ret)
>   		ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
