From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH] i2c:i2c-core-of:remove redundant dev_err message
Date: Wed, 26 Feb 2020 11:58:41 +0100
Message-ID: <0757d83b-203c-fe40-a8ac-665953d7d336@gmail.com>
References: <20200226103901.21520-1-tangbin@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55032 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgBZK6o (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Feb 2020 05:58:44 -0500
In-Reply-To: <20200226103901.21520-1-tangbin@cmss.chinamobile.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tangbin <tangbin@cmss.chinamobile.com>, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/26/20 11:39 AM, tangbin wrote:
> of_i2c_register_device already contains error message, so remove
> the redundant dev_err message
> 
> Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
> ---
>   drivers/i2c/i2c-core-of.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> index 6787c1f71..7b0a786d3 100644
> --- a/drivers/i2c/i2c-core-of.c
> +++ b/drivers/i2c/i2c-core-of.c
> @@ -103,9 +103,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
>   
>   		client = of_i2c_register_device(adap, node);
>   		if (IS_ERR(client)) {
> -			dev_err(&adap->dev,
> -				 "Failed to create I2C device for %pOF\n",
> -				 node);
> +			return PTR_ERR(client);

This looks like an unrelated (and wrong) change. Why would you alter the 
semantics of of_i2c_register_devices()? Besides, this function doesn't 
have a return value.
