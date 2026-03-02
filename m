Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618438F625
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444401; cv=none; b=JyVhaBQKu0Mj6qTDudtemi4xRMBmxfPd+EzDcbAbsY0UiRBravkWdNB6IMOoUr2tz/HNK5vu+V313NTLIuFk2VbR9C4QfWYI9xk0UtI2D3Zl0MaMJqab5avHNwisv7iuFm/P2vMpE1+polaqyCGhBtrEuG2dnn/tZNEvB4t6FxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444401; c=relaxed/simple;
	bh=NvpPswBntIduciU9ML/fmmpOmy17gd0JhmiIgAokKSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSPzwQMEtrQ96BjftA7/8K7UBZprk+ed2vtDDah9CixdaijmiNCesA7iGOjbB074Hsh9bsz3F+ahgy2mYkqrH/QwGfhNU0P9UVePEt0vQ9/WQmNmwu/YUSAVU+VzboYd4c6e/AY10TH9YMFXAN+qdsx0ss+BFsgO5KW5Q8sGlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHGKVgWb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHGKVgWb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2addb31945aso31777885ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Mar 2026 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772444398; x=1773049198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wX0OGsPu0Cxlv0PiFeBEE73XuyzU5Okzie1/FOEP9ag=;
        b=PHGKVgWbxdYSfhVGzMFuVHmfE+JD/lOM/h0cpaKrvHyJTDbehiVzrZZm6Mk2aiY6xA
         JfeAw5warDloDxeQMATcskbLyj76TSHAGzHdJQZ9UlFh4XvVuiHzxGXrmcqYbEki5f/l
         BznZKzwx3rMH88CcNdzZlju3XC1JAKbQhXb5FBR+5XNfQNX0meBTEiAHS3a/jBMyFN1o
         30biFoD75gPzU5rGXnx7bzkXGC5Plrpag4E2o01ZT8aCc71MpkMIX5n4yjZ/oO7eWhCS
         dkBUrrGHwfdmn6FCyzxbirtovqmY7xhJxtCnIxuMvYh7PH26N7Fh4ia85GKTE8CO/bJL
         tnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444398; x=1773049198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX0OGsPu0Cxlv0PiFeBEE73XuyzU5Okzie1/FOEP9ag=;
        b=WRx85QzZpum1Rq00ilzE5mTYFP0JFBNINIEuc+3nMtwiRN168JVosUf1aWjz758Rz0
         Xz5DFYHY3Pul33NQsDcaBcjA9YqhzDbHraPGfClA7/IPlSwjYzC+Fyg6BaI/nRMQizzp
         I22TBogcMLk7/4Wsc+NnTyMFH5Cjn1URg7YmZ/1+JK/UC9FKYu3PcaiPplWyY74tTsWW
         47qd7CKPIAJZC0jx3oD4zPguzAs9sHGnknByAmR+kx1VyqC8S6TabTHcplVHLSoTE+6O
         t0aoxi+davZ2VU1RVRY2ikqQJqqJBMSwO7k1cZW3QZj0H4UOrinf9H2i6kOkw9UIHOlb
         QZaw==
X-Forwarded-Encrypted: i=1; AJvYcCXgSfdZVsJwJDGM7rgU0rk/bXCd1m67qxm5DjGRdM3Np1UchWUcsS8LK7ert4Gg0RV7ZL5UkJrzsS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGQciSLIPjJQ9aCyDTfUA3xOKhUosXb6+wie/mKLt/5lCwTUj
	oGr1IiaSBtg5BvAh3R+96PyMGfBhtrgXGOYU326UmAFGrmSDdM3cIqhE
X-Gm-Gg: ATEYQzy0dLtURFB3si9d4vpU4REl8skwJJFigpX0BTZieXNPAZSJloMRSR6s5neLXxK
	f6I7BDVt7WN0vCOew5+7phoJsBrQbqsFuuyMnlm4eTq3WUjlTvVkFpn8IkvshSp28z8PlJs/1xY
	vLN/8bO5H2hf5x8Y/gCASLf1sliC7ZxG+nUURFwhoZuvzw/zJ/uiklAUZVgWfBKJbljq73yDEPR
	Y3yzsnGm67wlH2ojuhEjdA23h5y4DcINMy3is4TKDQo5ZV+4BiNleiWagdVEWXjecxwIRfa29IT
	aIQ5nY6nVmgaYi260OKoJM6Ctl/rTrpnrM/7/NAn5LjKENiAI6QFGCo3z76eIboK0ufaVhzAiAp
	GQWLLRQbkJcQ/noJDusz4ibqDgAT0GPTMKo3HkmpEcqu75/Ef8L1odJ1EnAirPEELJP5NicwUMj
	KhZGfGM+tkIl6UP/4NSqUq0AMvNhbnwwBe2PL45ZLsCNe8F9FtMIWVVTXavcC3p62T2ATV5y4=
X-Received: by 2002:a17:902:e852:b0:2ad:ad0f:bbd2 with SMTP id d9443c01a7336-2ae2e4b54d3mr114451445ad.39.1772444398205;
        Mon, 02 Mar 2026 01:39:58 -0800 (PST)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae399acba4sm70151475ad.67.2026.03.02.01.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:39:57 -0800 (PST)
Message-ID: <eb013eda-7e3c-492a-9d69-915f1564f522@gmail.com>
Date: Mon, 2 Mar 2026 17:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andi.shyti@kernel.org, ychuang3@nuvoton.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260302020822.13936-1-zychennvt@gmail.com>
 <20260302020822.13936-3-zychennvt@gmail.com>
 <20260302-spiffy-capuchin-of-completion-e8c5b2@quoll>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260302-spiffy-capuchin-of-completion-e8c5b2@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krzysztof,
	Thank you for the review.

Krzysztof Kozlowski 於 2026/3/2 下午 03:24 寫道:
> On Mon, Mar 02, 2026 at 02:08:21AM +0000, Zi-Yu Chen wrote:
>> Add I2C support for Nuvoton MA35D1 SoC.
>> The controller supports standard, fast and fast-plus modes,
>> and provides master/slave functionality.
>>
>> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
>> ---
>>  drivers/i2c/busses/Kconfig      |  13 +
>>  drivers/i2c/busses/Makefile     |   1 +
>>  drivers/i2c/busses/i2c-ma35d1.c | 819 ++++++++++++++++++++++++++++++++
>>  3 files changed, 833 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-ma35d1.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index e11d50750e63..6bf8be1d2575 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -1589,4 +1589,17 @@ config I2C_VIRTIO
>>            This driver can also be built as a module. If so, the module
>>            will be called i2c-virtio.
>>  
>> +config I2C_MA35D1
>> +	tristate "Nuvoton MA35D1 I2C driver"
>> +	depends on ARCH_MA35
> 
> 
> Missing COMPILE_TEST
Will add || COMPILE_TEST to the dependency in v2.
> 
> ...
> 
>> +	/* Setup info block for the I2C core */
>> +	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
>> +	i2c->adap.owner = THIS_MODULE;
>> +	i2c->adap.algo = &ma35d1_i2c_algorithm;
>> +	i2c->adap.retries = 2;
>> +	i2c->adap.algo_data = i2c;
>> +	i2c->adap.dev.parent = &pdev->dev;
>> +	i2c->adap.dev.of_node = pdev->dev.of_node;
>> +	i2c_set_adapdata(&i2c->adap, i2c);
>> +
>> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +				   &busfreq);
>> +	if (ret) {
>> +		dev_err(i2c->dev, "clock-frequency not specified in DT\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Calculate divider based on the current peripheral clock rate */
>> +	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
>> +	if (clkdiv < 0 || clkdiv > 0xffff) {
>> +		dev_err(dev, "invalid clkdiv value: %d\n", clkdiv);
>> +		return -EINVAL;
>> +	}
>> +
>> +	i2c->irq = platform_get_irq(pdev, 0);
>> +	if (i2c->irq < 0)
>> +		return i2c->irq;
>> +
>> +	platform_set_drvdata(pdev, i2c);
>> +
>> +	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT);
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0)
>> +		goto rpm_disable;
>> +
>> +	writel(clkdiv & 0xffff, i2c->regs + MA35_CLKDIV);
>> +
>> +	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, IRQF_SHARED,
>> +			       dev_name(dev), i2c);
>> +
> 
> No blank line ever between call and if()
Acknowledged. Will fix in v2.
> 
>> +	if (ret != 0) {
> 
> Write simple and obvious code.
> 
> if (ret)
> 
Acknowledged. I will simplify the error check to if (ret) in v2.
>> +		dev_err(dev, "cannot claim IRQ %d\n", i2c->irq);
>> +		goto rpm_disable;
>> +	}
>> +
>> +	/* Give it another chance if pinctrl used is not ready yet */
>> +	if (ret == -EPROBE_DEFER)
> 
> Pointless and dead code.
Acknowledged. I will remove the redundant -EPROBE_DEFER check and its associated comment in v2
> 
>> +		goto rpm_disable;
>> +
>> +	ret = i2c_add_adapter(&i2c->adap);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add bus to i2c core: %d\n", ret);
>> +		goto rpm_disable;
>> +	}
>> +
>> +	pm_runtime_put_autosuspend(dev);
>> +
>> +	return 0;
>> +
>> +rpm_disable:
>> +	pm_runtime_put_noidle(dev);
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_dont_use_autosuspend(dev);
>> +	return ret;
>> +}
>> +
>> +static void ma35d1_i2c_remove(struct platform_device *pdev)
>> +{
>> +	struct ma35d1_i2c *i2c = platform_get_drvdata(pdev);
>> +
>> +	i2c_del_adapter(&i2c->adap);
>> +	pm_runtime_disable(&pdev->dev);
>> +}
>> +
>> +static int ma35d1_i2c_suspend(struct device *dev)
>> +{
>> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
>> +	unsigned int val;
>> +
>> +	spin_lock_irq(&i2c->lock);
>> +
>> +	/* Prepare for wake-up from I2C events if slave mode is active */
>> +	if (i2c->slave) {
>> +		val = readl(i2c->regs + MA35_CTL0);
>> +		val |= (MA35_CTL_SI | MA35_CTL_AA);
>> +		writel(val, i2c->regs + MA35_CTL0);
>> +		ma35d1_i2c_enable_irq(i2c);
>> +	}
>> +
>> +	spin_unlock_irq(&i2c->lock);
>> +
>> +	/* Setup wake-up control */
>> +	writel(0x1, i2c->regs + MA35_WKCTL);
>> +
>> +	/* Clear pending wake-up flags */
>> +	val = readl(i2c->regs + MA35_WKSTS);
>> +	writel(val, i2c->regs + MA35_WKSTS);
>> +
>> +	enable_irq_wake(i2c->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_i2c_resume(struct device *dev)
>> +{
>> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
>> +	unsigned int val;
>> +
>> +	/* Disable wake-up */
>> +	writel(0x0, i2c->regs + MA35_WKCTL);
>> +
>> +	/* Clear pending wake-up flags */
>> +	val = readl(i2c->regs + MA35_WKSTS);
>> +	writel(val, i2c->regs + MA35_WKSTS);
>> +
>> +	disable_irq_wake(i2c->irq);
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_i2c_runtime_suspend(struct device *dev)
>> +{
>> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
>> +	unsigned int val;
>> +
>> +	/* Disable I2C controller */
>> +	val = readl(i2c->regs + MA35_CTL0);
>> +	val &= ~MA35_CTL_I2CEN;
>> +	writel(val, i2c->regs + MA35_CTL0);
>> +
>> +	clk_disable_unprepare(i2c->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_i2c_runtime_resume(struct device *dev)
>> +{
>> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(i2c->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock in resume\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Enable I2C controller */
>> +	val = readl(i2c->regs + MA35_CTL0);
>> +	val |= MA35_CTL_I2CEN;
>> +	writel(val, i2c->regs + MA35_CTL0);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops ma35d1_i2c_pmops = {
>> +	SYSTEM_SLEEP_PM_OPS(ma35d1_i2c_suspend, ma35d1_i2c_resume)
>> +		RUNTIME_PM_OPS(ma35d1_i2c_runtime_suspend,
>> +			       ma35d1_i2c_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id ma35d1_i2c_of_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-i2c" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ma35d1_i2c_of_match);
>> +
>> +static struct platform_driver ma35d1_i2c_driver = {
>> +	.probe      = ma35d1_i2c_probe,
>> +	.remove     = ma35d1_i2c_remove,
>> +	.driver     = {
>> +		.name   = "ma35d1-i2c",
>> +		.owner  = THIS_MODULE,
> 
> Do not upstream 12-year-old code. We fixed all these issues long time.
> Please write your driver from scratch, so you will not
> repeat/reintroduce all the issues which we already fixed.
> 
I will address these issues in V2 by:

Removing the redundant .owner = THIS_MODULE.

Reviewing the entire driver to ensure all APIs and patterns align with current upstream standards.

I am performing a "from-scratch" review to eliminate legacy patterns.
>> +		.of_match_table = ma35d1_i2c_of_match,
>> +		.pm = pm_ptr(&ma35d1_i2c_pmops),
>> +	},
> 
> Best regards,
> Krzysztof
> 

