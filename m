From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 01/12] i2c: qup: fixed releasing dma without flush
 operation completion
Date: Thu, 8 Feb 2018 19:33:14 +0530
Message-ID: <0ff28076-b105-9280-a7e0-767f923768fa@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> The QUP BSLP BAM generates the following error sometimes if the
> current I2C DMA transfer fails and the flush operation has been
> scheduled
> 
>     “bam-dma-engine 7884000.dma: Cannot free busy channel”
> 
> If any I2C error comes during BAM DMA transfer, then the QUP I2C
> interrupt will be generated and the flush operation will be
> carried out to make i2c consume all scheduled DMA transfer.
> Currently, the same completion structure is being used for BAM
> transfer which has already completed without reinit. It will make
> flush operation wait_for_completion_timeout completed immediately
> and will proceed for freeing the DMA resources where the
> descriptors are still in process.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 08f8e01..9faa26c41a 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All rights reserved.

Not sure, if this was an intended change. But given that you are fixing this,
you can change the header to the new SPDX one.

>   * Copyright (c) 2014, Sony Mobile Communications AB.
>   *
>   *
> @@ -844,6 +844,8 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  	}
>  
>  	if (ret || qup->bus_err || qup->qup_err) {
> +		reinit_completion(&qup->xfer);
> +
>  		if (qup_i2c_change_state(qup, QUP_RUN_STATE)) {
>  			dev_err(qup->dev, "change to run state timed out");
>  			goto desc_err;
> 

Except for the above nit,
  Acked-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
