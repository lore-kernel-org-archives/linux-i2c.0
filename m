Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098322;
	b=cGz4HD8b0Q33HW01a6oPLAxUhfvfZuiXdueNR4ccybaFxGky7DCe8nuWNbETKcptjr+E
	 9nRVyrJYlSji2IlLBR2t0V2HCs5dr5tVmSHS2Q0B9nGagiVtmuLcQQkM1A8NsipE+rRAs
	 US87ycJ9yw8xDGacBZxamxMu+5e04GnECjMp/6YzNKnBgMWc0/e9KfFv2MEL9JGzyFpBu
	 mDplreKfp2ZMq9ivOxuLl+DtWws/G86g4d6qBpkoF57RIVyrPGtwyVECSVB34q4gMtdls
	 Tg9NhFzi+qXLozUtE4J/dPMTMgBXjUxSal3qRc9qBP+9lR6lkhwnXdcbmuyyBztcx7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098322;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M5M1bmrFFRdO/+Axqgj5MF4sDBhs8Nh7NXZX+mqK9Xo=;
	b=LMddqHwTl94GQz7Gw8+w2mVau8EQyy3azsCKPKlgj2EcJNcBWj8kjOl8ksFerUNbWrmi
	 A0K6V4YGSW5T1woksEVeF4j5q5g9pX44Mfvzgl7gErml8vREYUyIEDl6POxrJ6jm3CC+p
	 Hs8LP0V92gg5/LZIwp9VCE5jVsYY86YbndCejlMShPHAXqKpqODM+ejnhDFMfS6S9RqLz
	 yHf0wqgp1kcsjJFqTH/nymIoaTCNzRbfGdUOMmJjnX/+t6LUgRAPsFTCiLioInRQF5FAy
	 o7ILquUt18U/jAThjgY9KqjvFVhYEZo6AsZ5y4k0TkFC9GWDwAy3u/04de1RuHRg0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO6CZNNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A3606A31A;
	Tue, 27 Oct 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO6CZNNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54E21F01828;
	Tue, 27 Oct 2026 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098321;
	bh=M5M1bmrFFRdO/+Axqgj5MF4sDBhs8Nh7NXZX+mqK9Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WO6CZNNXU8St/D0KjvJ9ctcDFMx8vzW7vLWqfR8j+fuTbjU4Pf5V7PuFBlvDLY18B
	 bOO8BZgTEFxcOGKeXR/zePXpzqajoDxxsLUnVsdxAlfRMu8dVo2w3bbMgmbSiQVoyz
	 GoW4VLG6PbSjXXiJ46divpjsDWcG2i/hB93XmHGNqBfpXE1XiAlYJmd7GNC9IQcTLa
	 OXdbxVIw/r1nIbZk+mlFsTWFx9KEzj4G7YM5xrc+EvqKrK8hkq/4VAH7kCehg9PZri
	 eH9UNAYKAoJe5ssHNSe5OfCqMn1PtZR1Xk/Og9S0f3SZwThO6nQaCplumPECHys/vk
	 XngLJ059avSaQ==
Date: Tue, 27 Oct 2026 11:51:58 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Bowen Yu <yubowen8@huawei.com>
Cc: linuxarm@huawei.com, liudingyuan@h-partners.com, 
	linux-i2c@vger.kernel.org, acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, lenb@kernel.org, zhanjie9@hisilicon.com, 
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com, ouyiyong1@huawei.com
Subject: Re: [PATCH v5 2/2] i2c: hisi: Add I2C bus recovery support
Message-ID: <auCAeZHhQVMtPVlZ@zenone.zhora.eu>
References: <20260929121348.109556-1-yubowen8@huawei.com>
 <20260929121348.109556-3-yubowen8@huawei.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929121348.109556-3-yubowen8@huawei.com>

Hi Bowen,

the patch looks good and it can be taken without 1/2.

Just few nitpicks,

...

> +static int hisi_i2c_get_bus_recovery_res(struct hisi_i2c_controller *ctlr,
> +					 struct platform_device *pdev)
> +{
> +	struct resource *res0;

/res0/res/

> +
> +	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +
> +	if (!res0 || resource_size(res0) != HISI_I2C_RECOVERY_REG_SIZE)
> +		return -ENODEV;
> +
> +	ctlr->sctrl_addr = devm_ioremap_resource(&pdev->dev, res0);
> +	if (IS_ERR(ctlr->sctrl_addr)) {
> +		ctlr->sctrl_addr = NULL;
> +		return -ENOMEM;

return PTR_ERR(ctlr->sctrl_addr);

> +	}
> +
> +	return 0;
> +}

...

>  static int hisi_i2c_start_xfer(struct hisi_i2c_controller *ctlr)
>  {
>  	struct i2c_msg *msg = ctlr->msgs;
> @@ -496,6 +634,10 @@ static int hisi_i2c_probe(struct platform_device *pdev)
>  
>  	hisi_i2c_configure_bus(ctlr);
>  
> +	ret = hisi_i2c_recovery_init(ctlr);
> +	if (ret)
> +		dev_info(ctlr->dev, "I2C bus recovery not available\n");

I would use here dev_dbg(...);

If it's OK with you, I can change the ones above and apply,
otherwise, please send a v6.

Andi

> +
>  	adapter = &ctlr->adapter;
>  	snprintf(adapter->name, sizeof(adapter->name),
>  		 "HiSilicon I2C Controller %s", dev_name(dev));
> -- 
> 2.33.0
> 
