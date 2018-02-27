From: "Christ, Austin" <austinwc@codeaurora.org>
Subject: Re: [PATCH 10/12] i2c: qup: send NACK for last read sub transfers
Date: Tue, 27 Feb 2018 15:07:29 -0700
Message-ID: <e34399ec-3668-585c-a931-3b0bc04f0e35@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Tested on Centriq 2400

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

On 2/3/2018 12:58 AM, Abhishek Sahu wrote:
> According to I2c specification, “If a master-receiver sends a
> repeated START condition, it sends a not-acknowledge (A) just
> before the repeated START condition”. QUP v2 supports sending
> of NACK without stop with QUP_TAG_V2_DATARD_NACK so added the
> same.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>   drivers/i2c/busses/i2c-qup.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index ba717bb..edea3b9 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -113,6 +113,7 @@
>   #define QUP_TAG_V2_DATAWR              0x82
>   #define QUP_TAG_V2_DATAWR_STOP         0x83
>   #define QUP_TAG_V2_DATARD              0x85
> +#define QUP_TAG_V2_DATARD_NACK         0x86
>   #define QUP_TAG_V2_DATARD_STOP         0x87
>   
>   /* Status, Error flags */
> @@ -609,7 +610,9 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>   			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
>   	} else {
>   		if (msg->flags & I2C_M_RD)
> -			tags[len++] = QUP_TAG_V2_DATARD;
> +			tags[len++] = qup->blk.pos == (qup->blk.count - 1) ?
> +				      QUP_TAG_V2_DATARD_NACK :
> +				      QUP_TAG_V2_DATARD;
>   		else
>   			tags[len++] = QUP_TAG_V2_DATAWR;
>   	}
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
