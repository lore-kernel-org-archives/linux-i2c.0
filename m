From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH 2/2] i2c: qup: Fixed the DMA segments length
Date: Wed, 11 May 2016 21:48:20 +0530
Message-ID: <000b01d1aba0$c2fea380$48fbea80$@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org> <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Abhishek Sahu' <absahu@codeaurora.org>, agross@codeaurora.org
Cc: architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

Hi,

> 1. The current QCOM I2C driver code is failing for transfer length greater
> than 255. This is happening due to improper segments length as the I2C DMA
> segments can be maximum of 256 bytes.
> 
> 2. The transfer length tlen was being initialized with 0 for 256 bytes,
which is
> being passed for DMA mappings resulting in improper DMA mapping length.
> 
> This patch fixes the above said problems by initializing the block count
with
> the values calculated in qup_i2c_set_blk_data and calculating the
remaining
> length for last DMA segment. Also, the block data length need to be
> decremented after each transfer. Additionally, this patch corrects the
tlen
> assignment for DMA mapping.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index
> 8c2f1bc..6d6b7dc 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -651,23 +651,24 @@ static int qup_i2c_bam_do_xfer(struct
> qup_i2c_dev *qup, struct i2c_msg *msg,
>  	u8 *tags;
> 
>  	while (idx < num) {
> -		blocks = (msg->len + limit) / limit;
> -		rem = msg->len % limit;
>  		tx_len = 0, len = 0, i = 0;
> 
>  		qup->is_last = (idx == (num - 1));
> 
>  		qup_i2c_set_blk_data(qup, msg);
> 
> +		blocks = qup->blk.count;
> +		rem = msg->len - (blocks - 1) * limit;
> +
      Same if we had blocks = (msg->len + limit - 1) / limit instead of the
above ?
     Otherwise, 
     Reviewed-by: Sricharan@codeaurora.org

Regards,
 Sricharan
