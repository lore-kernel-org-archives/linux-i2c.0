From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH] i2c: core: Add missing of_node_put()
Date: Fri, 15 Apr 2016 17:58:38 +0300
Message-ID: <5711019E.9020304@mentor.com>
References: <1460724191-12167-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:37919 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcDOO6m (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Apr 2016 10:58:42 -0400
In-Reply-To: <1460724191-12167-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 15.04.2016 15:43, Jon Hunter wrote:
> for_each_available_child_of_node performs an of_node_get on each
> iteration, so of_node_put() must be called on each iteration once
> we are finished with the node pointer.

This is wrong, embedded of_get_next_available_child() correctly decrements
ref counter of an examined node.

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/i2c/i2c-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 4979728f7fb2..38f4dae681a9 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1428,9 +1428,9 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
>  	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
>  
>  	for_each_available_child_of_node(adap->dev.of_node, node) {
> -		if (of_node_test_and_set_flag(node, OF_POPULATED))
> -			continue;
> -		of_i2c_register_device(adap, node);
> +		if (!of_node_test_and_set_flag(node, OF_POPULATED))
> +			of_i2c_register_device(adap, node);
> +		of_node_put(node);
>  	}
>  }
>  
> 

--
With best wishes,
Vladimir
