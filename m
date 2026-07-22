Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661A23ABB9;
	Wed, 22 Jul 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688165; cv=none; b=MSikzJTGidZ+8EYdgbcHVxxDXjQFTDf2n21WcsFUOArl31YYFesncSABHQ1GOkOYt/ukM87lTZdVXaAGm9S9dhAHW2v4oA6U7k9AO48WOUWDI19CUsUYge7RpPOhPHPeRkpUMcUPQxvPG+4DOdTxIs/uuC7p0H27G3mZehs9zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688165; c=relaxed/simple;
	bh=pF4bbwZw5CQs/uHKLJTwQ8ja8UKjup4BMtwDvq1e5gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miPzXv93nODp5cYDsBzRd1SRtitWTaIzc3CcYpaynmcnOefirKOHw6J0l+7+75Li9GHmHliZBq7P7ykFThLthctPQYWE8MpjrOwsrbhX4veTpBfg6evx499/1qWUKbrW/NtczvIAmR4Be89DithfT87X1MO6mvljP3AvZUfTF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=F58ornxK; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="F58ornxK"
X-UUID: 01d9270e857711f1b694ffd7d3467620-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=kvJ4qWNx9V/i3P3OjvqnjCFpsA6MRDx046BLikBTqz0=;
	b=F58ornxKSRFsaZ0lKWQgQ2YHZoQ8icdAVuQ1mjbLci11+Oupd8Y38FhIX/f7hrSuuaMenlNBHxhWpLyHTiGPCC3Wi9j+rsFphaNcKi52tOjzmH1ux5RG2f8UEBHbAQIvIj/xxfJNjUndUQTblLvAvkfYXval+uNI/VI0NAlkeHo=;
X-UUID: 01d9270e857711f1b694ffd7d3467620-20260722
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1202881359; Wed, 22 Jul 2026 10:42:40 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 64E101A1E1C;
	Wed, 22 Jul 2026 10:42:40 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 1B0C1C600CC; Wed, 22 Jul 2026 10:42:39 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: krzk@kernel.org
Cc: andi.shyti@kernel.org,
	ben_huang@novatek.com.tw,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v3 3/3] i2c: Add i2c-nt726xx.c I2C driver for Novatek NT726xx SoCs
Date: Wed, 22 Jul 2026 10:41:41 +0800
Message-Id: <20260722024140.527353-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260721-qualified-mustang-of-pride-a6fc53@quoll>
References: <20260721-qualified-mustang-of-pride-a6fc53@quoll>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Tuesday, July 21, 2026 at 3:14 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Jul 15, 2026 at 03:35:34PM +0800, Nina_Kuo@novatek.com.tw wrote:
>> +#define I2C_INFO_LOG(fmt, ...)\
>> +pr_info("[I/SOC_I2C] " fmt, ##__VA_ARGS__)
>> +
>> +#define I2C_ERR_LOG(fmt, ...)\
>> +pr_err("[E/SOC_I2C] " fmt, ##__VA_ARGS__)
>
> No, you do not get own printing stuff.
>
> This is not Linux coding style. Learn how Linux treats your own new
> abstraction layers.
>
> ...
>
>> +static int nvt_i2c_probe(struct platform_device *pdev)
>> +{
>> +struct nvt_i2c_bus *i2c;
>> +struct resource *res;
>> +int ret, irq;
>> +
>> +i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
>> +if (!i2c)
>> +return -ENOMEM;
>> +
>> +res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +i2c->base = devm_ioremap_resource(&pdev->dev, res);
>
> Look at other drivers
>
>> +if (IS_ERR(i2c->base)) {
>> +I2C_ERR_LOG("failed to map controller\n");
>> +return PTR_ERR(i2c->base);
>
> Look at other drivers how they do it
>
>> +}
>> +
>> +init_completion(&i2c->msg_complete);
>> +i2c->dev = &pdev->dev;
>> +
>> +ret = nvt_i2c_parse_dts(i2c);
>> +if (ret)
>> +return ret;
>> +
>> +nvt_i2c_init(i2c);
>> +
>> +irq = platform_get_irq(pdev, 0);
>> +if (irq < 0) {
>> +I2C_ERR_LOG("No IRQ resource\n");
>
> Look at other drivers how they do it
>
>> +return irq;
>> +}
>> +
>> +ret = devm_request_irq(&pdev->dev, irq, nvt_i2c_isr,
>> +       IRQF_SHARED | IRQF_TRIGGER_HIGH, I2C_NAME, i2c);
>> +if (ret) {
>> +I2C_ERR_LOG("devm_request_irq fail\n");
>
> Look at other drivers how they do it
>

Log functions will be changed to dev_err() for error and dev_info()
for info use.

>> +static struct platform_driver nvt_i2c_driver = {
>> +.probe = nvt_i2c_probe,
>> +.remove = nvt_i2c_remove,
>> +.driver = {
>> +.name = "nvt_nt726xx_i2c",
>> +.owner = THIS_MODULE,
>
> NAK, you just sent us 13 year old downstream junk code. This is not
> acceptable, because by doing that you ignore all the bugs or issues we
> fixed over last 13 years.

owner will be removed.

>> +.pm = &nvt_i2c_pm_ops,
>> +.of_match_table = of_match_ptr(nvt_i2c_of_match),
>> +},
>> +};
>> +
>> +static int __init nvt_i2c_platform_init(void)
>> +{
>> +return platform_driver_register(&nvt_i2c_driver);
>> +}
>> +postcore_initcall(nvt_i2c_platform_init);
>
> NAK, this is not postcore!
>
> You have standard module. Full stop.

This will be replaced by module_init().

Sincerely,
Ben Huang
