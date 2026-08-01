Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F42EEE7B
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601274; cv=none; b=urtSP68bWWqfekQLZjESMEQwyP7xrAk1OquQnd/DQebZbv+KyvbCDz9tkp9jo4kkxs1/NtJpVKakzIufAF0ms4aDsh2r/8Yd0mz8ZUnNemiUYzAM5YqDsLbjEOg2S+pPXcS1vqQKfLOxd/qJedx0KCqtdDL4CNF0UI9V8aTWSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601274; c=relaxed/simple;
	bh=SbMYTvaisbbZ5aa4cV5PYaTXtf0Q+AS8HiAZLNaZnzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vc+ryqgRBoonklgs4badabmI6hJtKXo2vn2CVDHuocEzImnvN9AawbRAJwQkCtS/hLS//xctN9w09HaEb07bQ73X8po4ZeDvbbjAgIsg1SYMKuY8QYQ6QodXWle8vH+SVrXfhGGQI2BG1SsuQypPapXmFJIR2nirxXx5olCqqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJaVJ1Uy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJaVJ1Uy"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so4217775e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785601271; x=1786206071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgl+xjmipuLemKWkAmqJnYDHJGgXDc5XvkmVK3O/R7o=;
        b=rJaVJ1Uy5LF/xRiFZoSD5NpaYjSrYDoALq31/4HqZQxDgO1My0epVnsup4uOxP3iIl
         VxwBeD6r0JhGR090WJHMa4Q8ayKcLdbVixJYNWam3Koq/nSuNKPUPgjqsV2MRAwWgav9
         OxnDCZjqb+ui8g8hSNMC8xflZ60o5bNFMwsIgq+2+psL3fyjQNnflTJeAiMy0uWMFNdE
         q1lMVc7lohXRanlndTkH9OeDkklMFWX4tL4pjdx2qbANojIFkcWskjzfNnKxhsuZj1lj
         uU2ziNSX678jQOghrvIvpxYIxeSqBFFBd8+6QGYRR9z++w7EsUUofgq+ZZ5k89+rschL
         ER2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785601271; x=1786206071;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mgl+xjmipuLemKWkAmqJnYDHJGgXDc5XvkmVK3O/R7o=;
        b=Et+ol/Hi5myDAcgkvyff6G+3aWKTzBswqs/WznCtcRPwPcz+3jQT54byAX7Vf/G93K
         320LE0ieoG/OFZhDM0o3RZBml1EwONE1Ze5cI54TuTlQeBnEU7bS+i7ao+IqPyeEOvA3
         JBXDCfEkqrd1d7GhpA95bc1lqk4mdI3FwsuEW28LirrYf5uOC4ToHDKqAO9nQI27bA/D
         5QLgNE5MBcCkmzJ4/gj0b2V1jkhq7mEcMRflQEyldT37dsgzvC2CQV7K+J6X7uqn5ppV
         UWUPC1WqAwNNDH8Olc/Fg1vkdzYqp60+Fvctjfujyf//BYUtLq43OLI3bVV2+j+2obWH
         2eZg==
X-Forwarded-Encrypted: i=1; AHgh+RqUxx9Ua6sRfBaGLknHn3T0NJSwSssvhQ6LszXkfVY5lbfq287ETal/wbKuAmfXmfPkOncCXopPTtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZmmloZZLYiKMcPM3BjNCIVUHy3VeIsV8CrcvSUwqzBje/1Qj
	m4ilzPI+bl7UKP11heh7Bbwaq8G58oeta0AWgZ6TwmZYdVvbV8zxKrXLKSTJTiyg
X-Gm-Gg: AR+sD12JPrwzAyMh8acGnvEoE8cLAadXMlsRpviDT5uaPzj/BOydDpfEVgUFGrsPcMP
	RJJiQ2VWCgoQw8QeVgUychwm4DJ1Beju3KN9ThX60YTFFi6ql/Kn0zXGhaDfz3hvhf9iffjzwt2
	1l3rTDeeLX9hYAOglD0A4pS+i+v6m4np37RPlJ8eyO6WFNBpYbcMSEN3hcKPI8GGYTlac8DCO0Z
	aeIlFNAp6AE4xD69WwrEYxj+7UwhGs9FnjyrF3JYgpEPQYdVzrjywN2lhNzlxOy1ZJB2uwUo8yS
	R4PkSMHh6sLC7FtlcfrCIFhkXyEVEfoCKayke2JaLRJUY8DMoWBFZ+rCh46t0hcOVADXfSCSCcJ
	bLNs2IxwePVjsZDslwpFKbjj9axFrV76iTAhkcxP/PArMB/DLAWJSiH1qvZT8kXty0792+ozR0X
	1n5k8laz4dI2a5DAx+noTFSmCwQRE3FljaoT5KYaTdhh6wQQuwQed1RCFDxFE6NIWN3m731RvhB
	rOvljMIcGKwhhmDlyVTPn7ZkVD8AAREia0tcL4+PyMJTyepHl91XhU=
X-Received: by 2002:a05:600c:3550:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-4980c679513mr61138735e9.17.1785601271059;
        Sat, 01 Aug 2026 09:21:11 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-217-60.nc.de. [195.14.217.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b9441csm62248215e9.4.2026.08.01.09.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:21:10 -0700 (PDT)
Message-ID: <7b71a776-2f8c-48e8-919b-f97a205ca1cb@gmail.com>
Date: Sat, 1 Aug 2026 18:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: core: fix debugfs UAF on adapter removal
To: Andi Shyti <andi.shyti@kernel.org>
Cc: wsa+renesas@sang-engineering.com, johan@kernel.org, hdanton@sina.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
References: <20260730162540.291570-1-vasilisalmpanis@gmail.com>
 <am0Mk1KapCw0SD1s@zenone.zhora.eu>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <am0Mk1KapCw0SD1s@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/31/26 11:35 PM, Andi Shyti wrote:
Hi Andi,
> Hi Vasileios,
>
> ...
>
>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>> index 3ec04787a737..b894563f5a75 100644
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -1826,8 +1826,6 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>>   
>>   	i2c_host_notify_irq_teardown(adap);
>>   
>> -	debugfs_remove_recursive(adap->debugfs);
>> -
>>   	/* wait until all references to the device are gone
>>   	 *
>>   	 * FIXME: This is old code and should ideally be replaced by an
>> @@ -1839,6 +1837,9 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>>   	device_unregister(&adap->dev);
>>   	wait_for_completion(&adap->dev_released);
>>   
>> +	/* clients use this directory as their debugfs parent */
>> +	debugfs_remove_recursive(adap->debugfs);
>> +
> Speaking of sysfs, this can't work if a new device is created
> through the new_device interface. Perhaps you can remove the
> attribute first with device_remove_file(), but we need to check
> whether that could lead to a double removal when the device
> attributes are cleaned up during device removal.
>
> Thanks,
> Andi
Thanks you for reviewing my patch. You're right. A write to new_device
that happens during removing clients leaks a client. It holds a reference
on the adapter device, so wait_for_completion() never returns.
I reproduced this locally by adding mdelay(5000) right after 
unregistering clients
and creating a client. The write succeeds and i2c_del_adapter() hangs.

I already wrote another patch that includes my hunk from v1 but also adds
device_remove_file(&adap->dev, &dev_attr_new_device) before deregistering
clients as you suggested. This no longer reproduces the same bug.
I also tested it with CONFIG_DEBUG_KOBJECT_RELEASE and KASAN as
i2c_del_adapter suggests and no warnings were emitted.

syzbot also tested the result against mainline and the reproducer
doesn't trigger anymore.

Is it okay with you if I keep the hunk of v1? Or you prefer its left as 
originally,
since after removing the new_device attr, we can't have new clients so
leaving there is safe.

Thanks,
Vasilis
>
>>   	/* free bus id */
>>   	mutex_lock(&core_lock);
>>   	idr_remove(&i2c_adapter_idr, adap->nr);
>> -- 
>> 2.47.3
>>
