From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: print correct device invalid address
Date: Sat, 7 Jan 2017 23:43:28 +0200
Message-ID: <e82abf2e-9a47-e66c-a86b-e022096ab424@mleia.com>
References: <1483700577-60130-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50970 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdAGVnd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 7 Jan 2017 16:43:33 -0500
In-Reply-To: <1483700577-60130-1-git-send-email-john.garry@huawei.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: John Garry <john.garry@huawei.com>, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com

On 01/06/2017 01:02 PM, John Garry wrote:
> In of_i2c_register_device(), when the check for
> device address validity fails we print the info.addr,
> which has not been assigned properly.
> 
> Fix this by printing the actual invalid address.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index cf9e396..03cfcdd 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1708,7 +1708,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
>  
>  	if (i2c_check_addr_validity(addr, info.flags)) {
>  		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
> -			info.addr, node->full_name);
> +			addr, node->full_name);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> 

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Fixes: b4e2f6ac1281 ("i2c: apply DT flags when probing")

Thank you for the fix.

--
With best wishes,
Vladimir
