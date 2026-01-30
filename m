Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9B309F13;
	Fri, 30 Jan 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770184; cv=none; b=n+Qy/ST3GcTlg1N6d4u2kAUMaR/LNosgX1ru7ttbLOZG+zPqv0s74BPIbz2yVtkYNDEFTqOIUL8XzPqz7KtcfFvEBHIgiyH9cuPi1mivmI7txdVKyk8/WzoDSzCsI/Imv7UpgoUCSgTiCtx+63XGPAbvjz00xPTrgFyDeyI4Tqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770184; c=relaxed/simple;
	bh=ZhVc+HneTnp8JJ6w/geFYmRQF1dGTVPT71V+HOyDjQI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gx+gZR88nfRVCN+BGBk9pYJS93ome/p3gjOMaeuKni+bAd2q0fEG6EgcxnfIDin6wdbKbRstVUSD3XVPA6qc/C8jQJXBQLkPl+LFasBLp+soFc/EX8hRMMR0xnwJ/Y78lTp6w6KBduoZTLJ0y7C9GajQP6gIjy1vfU4ZUooWDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2Xmt4F0pzHnGkW;
	Fri, 30 Jan 2026 18:48:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DED4440569;
	Fri, 30 Jan 2026 18:49:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Jan
 2026 10:49:37 +0000
Date: Fri, 30 Jan 2026 10:49:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Abdurrahman Hussain via B4 Relay
	<devnull+abdurrahman.nexthop.ai@kernel.org>
CC: <abdurrahman@nexthop.ai>, Michal Simek <michal.simek@amd.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 3/6] i2c: xiic: remove duplicate error message
Message-ID: <20260130104936.00005ee1@huawei.com>
In-Reply-To: <20260129-i2c-xiic-v7-3-727e434897ef@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
	<20260129-i2c-xiic-v7-3-727e434897ef@nexthop.ai>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 29 Jan 2026 21:43:15 +0000
Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:

> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> The devm_request_threaded_irq() already prints an error message. Remove
> the duplicate.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index a480cbb86d93..ca5685660e45 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -1493,11 +1493,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  					xiic_process, IRQF_ONESHOT,
>  					pdev->name, i2c);
> -
> -	if (ret < 0) {
> -		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> +	if (ret)
>  		return ret;
Ah ok.  I'd be tempted to drop that before the previous patch then we don't
have the dance that I guess was there to reduce churn.

> -	}
>  
>  	i2c->singlemaster =
>  		of_property_read_bool(pdev->dev.of_node, "single-master");
> 

