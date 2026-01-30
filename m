Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD836AB5E;
	Fri, 30 Jan 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770126; cv=none; b=gRrrST1VoRdq0KnbYxlDJAjiMkmHtKgBTJLwzR2C0BmWk2tc6lmG7tZm0Z5yqCo2CHE4hWBdr4uWpxEc3J5YDBFc9CpMLJ86f8ZxQ2u26lHWcLJHDLxSkWZZrW0DOxW1RH9iHUNyKie0kyz+7k0T1sg6LGTkPRLFFdI7LW2bSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770126; c=relaxed/simple;
	bh=6DcwzTunhCgwiGbeX0q+cGZDWQXGZkQDTMzQct/LC9k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAAX1xO+kyQQVOPUzawdzP9z8RNTTr3+G4ihBjSXKain0bKNyf+XFYLHcUIHG6r8olxe2gT3Ijd6eE1TL+OVxu49hZuqqHdNBkA0qgg9pP/e2/6FEoQflILg0IC/kBRB+PeIjAPWJLJF8HqvfBGqjCMAfNt16HvQHbnMIJAumh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2Xlg1LDtzHnHNF;
	Fri, 30 Jan 2026 18:47:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B67A40570;
	Fri, 30 Jan 2026 18:48:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Jan
 2026 10:48:33 +0000
Date: Fri, 30 Jan 2026 10:48:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Abdurrahman Hussain via B4 Relay
	<devnull+abdurrahman.nexthop.ai@kernel.org>
CC: <abdurrahman@nexthop.ai>, Michal Simek <michal.simek@amd.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/6] i2c: xiic: switch to devres managed APIs
Message-ID: <20260130104832.00005890@huawei.com>
In-Reply-To: <20260129-i2c-xiic-v7-2-727e434897ef@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
	<20260129-i2c-xiic-v7-2-727e434897ef@nexthop.ai>
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

On Thu, 29 Jan 2026 21:43:14 +0000
Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:

> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> Simplify the error code paths by switching to devres managed helper
> functions.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 912a94d4d080..a480cbb86d93 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -1462,7 +1462,10 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>  		 DRIVER_NAME " %s", pdev->name);
>  
> -	mutex_init(&i2c->lock);
> +	ret = devm_mutex_init(dev, &i2c->lock);
> +	if (ret)
> +		return ret;
> +
>  	spin_lock_init(&i2c->atomic_lock);
>  
>  	if (is_of_node(dev->fwnode)) {
> @@ -1475,8 +1478,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	i2c->dev = &pdev->dev;
>  	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(i2c->dev);
> -	pm_runtime_set_active(i2c->dev);
> -	pm_runtime_enable(i2c->dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
>  
>  	/* SCL frequency configuration */
>  	i2c->input_clk = clk_get_rate(i2c->clk);
> @@ -1492,7 +1496,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> -		goto err_pm_disable;
> +		return ret;

		return dev_err_probe();

>  	}
>  
>  	i2c->singlemaster =
> @@ -1511,16 +1515,14 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  		i2c->endianness = BIG;
>  
>  	ret = xiic_reinit(i2c);
> -	if (ret < 0) {
> -		dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");
> -		goto err_pm_disable;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
>  
>  	/* add i2c adapter to i2c tree */
>  	ret = i2c_add_adapter(&i2c->adap);
>  	if (ret) {
>  		xiic_deinit(i2c);
> -		goto err_pm_disable;
> +		return ret;
>  	}
>  
>  	if (pdata) {
> @@ -1532,12 +1534,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
>  		(unsigned long)res->start, irq, i2c->i2c_clk);
>  
> -	return 0;
> -
> -err_pm_disable:
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> -
>  	return ret;
>  }
>  
> @@ -1558,8 +1554,6 @@ static void xiic_i2c_remove(struct platform_device *pdev)
>  		xiic_deinit(i2c);
>  
>  	pm_runtime_put_sync(i2c->dev);
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  }
>  
> 

