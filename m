Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82153CC7CE;
	Thu, 17 Sep 2026 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633716; cv=none; b=XyFmVg4n6sQ7hXcqoEyXOnOwGcjM+wkzSHzPaQ5uej2iO4k8T/F9/F+GomwPQTX48LnFH8FnU2W40MJLK7pfPUJ5ZYG87hqfs1UXthZJzpuGQwJMVCdo0tQOQezIdM9p3maon8vwi98Hr6WrBMnOpWO/WAk8w3o3tZQCfp7/AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633716; c=relaxed/simple;
	bh=jYPuoRoudLtcquC0QCNNKs75zfnF9Cw5cd2UWh3WgF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IjOYHOLmWI+GF+q53hKnGj7dX72XhxFYwlmui3tSMH2rfbkLJk7PDKSCUSMpJ4cTkgorpsmyEOhB2qGd3AGpvAQbUlQo6FlKnjWVlZtBrnXpox7mNlfiFoTmTEJ5cxacHRY9wFMCSxfnSe12NychQLfBc3H1bb8trU7lZDX8qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hlpWb3bs8zcb46;
	Thu, 17 Sep 2026 16:16:59 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id A98F92017D;
	Thu, 17 Sep 2026 16:28:12 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 17 Sep
 2026 16:28:11 +0800
Message-ID: <5e00c73f-fdb2-42f9-92cd-652fd8be4489@hisilicon.com>
Date: Thu, 17 Sep 2026 16:28:11 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: hisi: Add I2C bus recovery support
To: "yubowen (H)" <yubowen8@huawei.com>, <linuxarm@huawei.com>,
	<liudingyuan@h-partners.com>, <andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<xuwei5@huawei.com>, <zhangpengjie2@huawei.com>
References: <20260909023958.4190890-1-yubowen8@huawei.com>
 <db15e184-244d-4415-b590-8a7d44783830@hisilicon.com>
 <ffcc17b2-7d4e-4ade-b8c4-2a64567a20e3@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ffcc17b2-7d4e-4ade-b8c4-2a64567a20e3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/17/2026 10:39 AM, yubowen (H) wrote:
[ ... ]
>>> +static int hisi_i2c_recovery_init(struct hisi_i2c_controller *ctlr)
>>> +{
>>> +	struct platform_device *pdev = to_platform_device(ctlr->dev);
>>> +	struct i2c_adapter *adapter = &ctlr->adapter;
>>> +	int ret;
>>> +
>>> +	if (acpi_disabled)
>>> +		return -ENODEV;
>> Is #ifdef CONFIG_ACPI still useful if 'acpi_disabled' is checked?
> Thanks for the review, Jie.
> 
> Both guards are needed; they operate at different layers and cannot replace each other.
> 
> - #ifdef CONFIG_ACPI is a compile-time guard to prevent errors caused by functions
> 
>     like acpi_has_method
> 
> - acpi_disabled() is a runtime check, it is 1 by default and set to 0 when the platform
> 
>     boots via acpi.
if not CONFIG_ACPI, acpi_disabled would be 1.
> 
> Other comments will be fixed in v4.
> 
> 
> Thanks
> 
> Bowen
> 
>>> +
>>> +	ret = hisi_i2c_get_bus_recovery_res(ctlr, pdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ctlr->rinfo = (struct i2c_bus_recovery_info){
>> Neat: (struct i2c_bus_recovery_info) {
>> Good to add a space.
>>> +		.get_scl = hisi_i2c_recovery_get_scl,
>>> +		.get_sda = hisi_i2c_recovery_get_sda,
>>> +		.set_scl = hisi_i2c_recovery_set_scl,
>>> +		.prepare_recovery = hisi_i2c_prepare_recovery,
>>> +		.unprepare_recovery = hisi_i2c_unprepare_recovery,
>>> +		.recover_bus = i2c_generic_scl_recovery,
>>> +	};
>>> +	adapter->bus_recovery_info = &ctlr->rinfo;
>>> +	ctlr->acpi_handle = ACPI_HANDLE(ctlr->dev);
>> Neat: a blank line before return 0.
>>> +	return 0;
>>> +}
>>> +#else
>>> +static int hisi_i2c_recovery_init(struct hisi_i2c_controller *ctlr) { return -ENODEV; }
>>> +#endif /* CONFIG_ACPI */
>>> +
>>>  static int hisi_i2c_start_xfer(struct hisi_i2c_controller *ctlr)
>>>  {
>>>  	struct i2c_msg *msg = ctlr->msgs;
>>> @@ -504,6 +645,10 @@ static int hisi_i2c_probe(struct platform_device *pdev)
>>>  	adapter->dev.parent = dev;
>>>  	i2c_set_adapdata(adapter, ctlr);
>>>  
>>> +	ret = hisi_i2c_recovery_init(ctlr);
>>> +	if (ret)
>>> +		dev_info(ctlr->dev, "I2C bus recovery not available\n");
>>> +
>> Move this before setting 'adapter' and i2c_set_adapdata()?
>>
>> Recovery init should be done before the final preparation of 'adapter'.
>>>  	ret = devm_i2c_add_adapter(dev, adapter);
>>>  	if (ret)
>>>  		return ret;
