Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B62BDC16;
	Wed,  4 Feb 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199269; cv=none; b=azKyFNCXQsyc5mWfEyt2a0PF8CciJkFm3199ipLU1tnOiCcSnXwEa9hyKXPO/PtNHillCxfjeP1Oh0fpO8TgGjDw1u8L2T7XjJ6TX//Go22/A+Gdx15tjIjSQswBHUs8vhFFAoIZcnK9JJKgdvNGxQcj7gFAPWCk64iW/m5NmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199269; c=relaxed/simple;
	bh=EyB6nIiTH7nUDLPMhvFl7nlT2MZbd09dRv46ibZTjWI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdO9VYS4AfS/G/umPNc899kv+ItHOYOqdPOZBm/yx8ktsWxmS1OsFL4kN4WuTIaCPlUgarEpCMuC9SoSJYgLm9lS6y5F+tMAC7M8G4AhYwfSjsSOVMzFdlCf7KoAmNOXLKdiEY8KXShi9ls3xZm3nyXfGnN0UO4EiYqMJqT0KOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5bSd2lRLzJ46hC;
	Wed,  4 Feb 2026 18:00:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 39DB940573;
	Wed,  4 Feb 2026 18:01:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 10:01:05 +0000
Date: Wed, 4 Feb 2026 10:01:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Abdurrahman Hussain via B4 Relay
	<devnull+abdurrahman.nexthop.ai@kernel.org>
CC: <abdurrahman@nexthop.ai>, Michal Simek <michal.simek@amd.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v10 2/7] i2c: xiic: remove duplicate error message
Message-ID: <20260204100104.00001a85@huawei.com>
In-Reply-To: <20260204-i2c-xiic-v10-2-c2b996425235@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
	<20260204-i2c-xiic-v10-2-c2b996425235@nexthop.ai>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 04 Feb 2026 07:01:59 +0000
Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:

> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> The devm_request_threaded_irq() already prints an error message. Remove
> the duplicate.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/i2c/busses/i2c-xiic.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 16ff83fe280b..4cb7c40fb565 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -1491,11 +1491,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  					xiic_process, IRQF_ONESHOT,
>  					pdev->name, i2c);
> -
> -	if (ret < 0) {
> -		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	i2c->singlemaster =
>  		of_property_read_bool(pdev->dev.of_node, "single-master");
> 

