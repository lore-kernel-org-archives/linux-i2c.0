From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 03/12] i2c: qup: remove redundant variables for BAM SG
 count
Date: Fri, 9 Feb 2018 07:46:10 +0530
Message-ID: <a20dc9c0-e012-d1a5-e182-5c7ddbcc8515@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
> be used for total number of SG entries.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c68f433..bb83a2967 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -692,7 +692,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  	struct dma_async_tx_descriptor *txd, *rxd = NULL;
>  	int ret = 0, idx = 0, limit = QUP_READ_LIMIT;
>  	dma_cookie_t cookie_rx, cookie_tx;
> -	u32 rx_nents = 0, tx_nents = 0, len, blocks, rem;
> +	u32 len, blocks, rem;
>  	u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
>  	u8 *tags;
>  

 This is correct. Just a nit, may be rx/tx_buf can be changed to
 rx/tx_count to make it more clear.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
