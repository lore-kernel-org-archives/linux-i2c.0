From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 04/12] i2c: qup: schedule EOT and FLUSH tags at the end of
 transfer
Date: Thu, 15 Feb 2018 20:01:04 +0530
Message-ID: <dcb7b543-3474-e573-cdc0-010cda5c2d67@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> A single BAM transfer can have multiple read and write messages.
> The EOT and FLUSH tags should be scheduled at the end of BAM HW
> descriptors. Since the READ and WRITE can be present in any order
> so for some of the cases, these tags are not being written
> correctly.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 54 ++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index bb83a2967..6357aff 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -560,7 +560,7 @@ static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
>  }
>  
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
> -			    struct i2c_msg *msg,  int is_dma)
> +			    struct i2c_msg *msg)
>  {
>  	u16 addr = i2c_8bit_addr_from_msg(msg);
>  	int len = 0;
> @@ -601,11 +601,6 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>  	else
>  		tags[len++] = data_len;
>  
> -	if ((msg->flags & I2C_M_RD) && last && is_dma) {
> -		tags[len++] = QUP_BAM_INPUT_EOT;
> -		tags[len++] = QUP_BAM_FLUSH_STOP;
> -	}
> -
>  	return len;
>  }
>  
> @@ -614,7 +609,7 @@ static int qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  	int data_len = 0, tag_len, index;
>  	int ret;
>  
> -	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg, 0);
> +	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg);
>  	index = msg->len - qup->blk.data_len;
>  
>  	/* only tags are written for read */
> @@ -710,7 +705,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  			while (qup->blk.pos < blocks) {
>  				tlen = (i == (blocks - 1)) ? rem : limit;
>  				tags = &qup->start_tag.start[off + len];
> -				len += qup_i2c_set_tags(tags, qup, msg, 1);
> +				len += qup_i2c_set_tags(tags, qup, msg);
>  				qup->blk.data_len -= tlen;
>  
>  				/* scratch buf to read the start and len tags */
> @@ -738,17 +733,11 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  				return ret;
>  
>  			off += len;
> -			/* scratch buf to read the BAM EOT and FLUSH tags */
> -			ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
> -					     &qup->brx.tag.start[0],
> -					     2, qup, DMA_FROM_DEVICE);
> -			if (ret)
> -				return ret;
>  		} else {
>  			while (qup->blk.pos < blocks) {
>  				tlen = (i == (blocks - 1)) ? rem : limit;
>  				tags = &qup->start_tag.start[off + tx_len];
> -				len = qup_i2c_set_tags(tags, qup, msg, 1);
> +				len = qup_i2c_set_tags(tags, qup, msg);
>  				qup->blk.data_len -= tlen;
>  
>  				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> @@ -768,26 +757,31 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  			}
>  			off += tx_len;
>  
> -			if (idx == (num - 1)) {
> -				len = 1;
> -				if (rx_buf) {
> -					qup->btx.tag.start[0] =
> -							QUP_BAM_INPUT_EOT;
> -					len++;
> -				}
> -				qup->btx.tag.start[len - 1] =
> -							QUP_BAM_FLUSH_STOP;
> -				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -						     &qup->btx.tag.start[0],
> -						     len, qup, DMA_TO_DEVICE);
> -				if (ret)
> -					return ret;
> -			}
>  		}
>  		idx++;
>  		msg++;
>  	}

 While here, can you please split above the if, else in to two separate functions ?
 and probably one more function for handling the NACK case down below. The function
 size at the moment is too big.

>  
> +	/* schedule the EOT and FLUSH I2C tags */
> +	len = 1;
> +	if (rx_buf) {
> +		qup->btx.tag.start[0] = QUP_BAM_INPUT_EOT;
> +		len++;
> +
> +		/* scratch buf to read the BAM EOT and FLUSH tags */
> +		ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
> +				     &qup->brx.tag.start[0],
> +				     2, qup, DMA_FROM_DEVICE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	qup->btx.tag.start[len - 1] = QUP_BAM_FLUSH_STOP;
> +	ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++], &qup->btx.tag.start[0],
> +			     len, qup, DMA_TO_DEVICE);
> +	if (ret)
> +		return ret;
> +

  May be you can change the commit to make it explicit to say what is being
  fixed, like "current code is broken when there is sequence of wr,rd,wr" like that.
  Agree on this fix otherwise.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
