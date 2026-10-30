Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327983;
	b=fMszhlUC3A40EyJtV2EekJ/q97Wk13bjo5FHETUTnPsy7Y1otlzkbmpd5Y5/z9bqKayG
	 4ratfcaxSKNHrVqN+7hG1LGk8klLgkyfcD7RauhWisqrBfzjpeORm8RwGz2taHuR/zej+
	 eV0pdO3C/E7vNU5QgXkytHH+Ri4QQMEKTN7VOz+pm/NPvb5YbtEwSKgEvrHz6L/Unnuc7
	 DRUT2P5b+S6+/ceWvHA9vj8xhXHgz5aNLIBNXsf4+t0+XLPi4CNvXxCu70CsbsTfMsW7r
	 33/Mbv6dG3NTbpAihfyA9HMwWHqLrvRg7ppQqkcvlXUjRlDbX4pkf+qhtFwmZqLQAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327983;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JfMA4d97tm/QzVwMD8XEulCDmRDIRbrehPwOMhblrRQ=;
	b=BkI71AJ+CMuG/XwwLxngrIvqBtg4Dkf+1aEeXbjWS6J87N0zNc2kqy50FmAqMtNIf0ri
	 8mNNem1knW6TCHKOBTeIAto7k27SX9Iz6fBlNv6yG2t9FfErcJ1HYtemrO2BpSACqL8rf
	 uJry2BfZ0R94/gGdODt42tpZB0MKmL+wjnNeXv6MHTuYbGii2MwDI2bqZS5DPD7VII+9N
	 5i88dimpu4W7CmU1TNDNqkK9nMyXD1WGB/7+JfM9rva9Yn+DDQ3giHGTcycoPvAAnqx3N
	 e2Dacrk0BVpSybAnE+jG9P/lkgWgrQjD4Jzp2P1CFi+B11VhHlIL/fEZfPsNvmkdtrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xt+qrsTS;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8746606A31A;
	Fri, 30 Oct 2026 02:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8746606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xt+qrsTS
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JfMA4d97tm/QzVwMD8XEulCDmRDIRbrehPwOMhblrRQ=;
	b=Xt+qrsTS9bk+HJ0m3UmDEbP13O90uFk3Cz56tR8cSBYZSghmyHfvIn65Imm5iIsUxrtXwqmsM
	We8cjUX4VOtwYtMCVpUgrCkjAYQtvuAOhlEhoseyNJgaih2rpA7EWGHoSwDMwjUjyHzqFbwQaIT
	H6q2AaCiiCCv+/m5aXcwbCw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jG50S2qyFznTVn;
	Fri, 30 Oct 2026 10:39:36 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A71D4057A;
	Fri, 30 Oct 2026 10:39:38 +0800 (CST)
Received: from [10.67.120.228] (10.67.120.228) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 30 Oct 2026 10:39:37 +0800
Message-ID: <810c504e-8950-46d3-846b-bacef5ba92d2@huawei.com>
Date: Fri, 30 Oct 2026 10:39:36 +0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] i2c: hisi: Add I2C bus recovery support
To: Andi Shyti <andi.shyti@kernel.org>
CC: <linuxarm@huawei.com>, <liudingyuan@h-partners.com>,
	<linux-i2c@vger.kernel.org>, <acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <ouyiyong1@huawei.com>
References: <20260929121348.109556-1-yubowen8@huawei.com>
 <20260929121348.109556-3-yubowen8@huawei.com>
 <auCAeZHhQVMtPVlZ@zenone.zhora.eu>
From: "yubowen (H)" <yubowen8@huawei.com>
In-Reply-To: <auCAeZHhQVMtPVlZ@zenone.zhora.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100017.china.huawei.com (7.202.195.215)


在 2026/10/27 18:51, Andi Shyti 写道:
> Hi Bowen,
>
> the patch looks good and it can be taken without 1/2.
>
> Just few nitpicks,
>
> ...
>
>> +static int hisi_i2c_get_bus_recovery_res(struct hisi_i2c_controller *ctlr,
>> +					 struct platform_device *pdev)
>> +{
>> +	struct resource *res0;
> /res0/res/
>
>> +
>> +	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +
>> +	if (!res0 || resource_size(res0) != HISI_I2C_RECOVERY_REG_SIZE)
>> +		return -ENODEV;
>> +
>> +	ctlr->sctrl_addr = devm_ioremap_resource(&pdev->dev, res0);
>> +	if (IS_ERR(ctlr->sctrl_addr)) {
>> +		ctlr->sctrl_addr = NULL;
>> +		return -ENOMEM;
> return PTR_ERR(ctlr->sctrl_addr);
>
>> +	}
>> +
>> +	return 0;
>> +}
> ...
>
>>   static int hisi_i2c_start_xfer(struct hisi_i2c_controller *ctlr)
>>   {
>>   	struct i2c_msg *msg = ctlr->msgs;
>> @@ -496,6 +634,10 @@ static int hisi_i2c_probe(struct platform_device *pdev)
>>   
>>   	hisi_i2c_configure_bus(ctlr);
>>   
>> +	ret = hisi_i2c_recovery_init(ctlr);
>> +	if (ret)
>> +		dev_info(ctlr->dev, "I2C bus recovery not available\n");
> I would use here dev_dbg(...);
>
> If it's OK with you, I can change the ones above and apply,
> otherwise, please send a v6.
>
> Andi
>
>> +
>>   	adapter = &ctlr->adapter;
>>   	snprintf(adapter->name, sizeof(adapter->name),
>>   		 "HiSilicon I2C Controller %s", dev_name(dev));
>> -- 
>> 2.33.0
>>
Thank you for the feedback, I be back with V6.

Best Regards,
Bowen


