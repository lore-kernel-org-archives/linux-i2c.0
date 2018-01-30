From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH 1/4] i2c: xlp9xx: return ENXIO on slave address NACK
Date: Tue, 30 Jan 2018 19:58:20 +0530
Message-ID: <1043d995-1448-3c0c-8052-8c31d18343d1@caviumnetworks.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:63288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752165AbeA3O2l (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 Jan 2018 09:28:41 -0500
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>

Gentle Ping on this series.

On 01/18/2018 11:09 AM, George Cherian wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> 
> Fix the driver violation of the common practice to return
> ENXIO error on a slave address NACK.
> 
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>   drivers/i2c/busses/i2c-xlp9xx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index b970bf8..6d78cdc 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -324,7 +324,8 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
>   		dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
>   		if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
>   			xlp9xx_i2c_init(priv);
> -		return -EIO;
> +		return (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) ?
> +			-ENXIO : -EIO;
>   	}
>   
>   	if (timeleft == 0) {
> 

Regards
-George
