Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29D332918;
	Mon, 27 Apr 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303326; cv=none; b=H7gmD17RpAgyW+4laAUU8+i2vWwkibe2RmnslVy4E5pEguEb8E30PnDJl9M0UTWtDzI8bdx+JQw/KX7WjSk3NKPdOTS0VnmIvbwmj0YzKCNo/2vYmCpqHrzkMexoS1fcX2QYv+8TqEbE0zSaw1GCYAyQu8AAE4L1bwUkIFK/mNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303326; c=relaxed/simple;
	bh=RsZftrUU5QUKZFFFSGAVqNm+jWCQRbZALhDoqqQP2k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T66QASwfSLjKFKv3fbEjG0q1FCdvU0jgx/kW7e3s27GCK8cSDHFRGCSwQfy3+7sBnwbJO8HRlP45sI49o0/WQdwPNSmVMwp7E5TKSUkl6+qIFDoSgyR9Vp41aaK9UZhqaN4C0uyzLL/lajp//vWcUgBLG0dNvrcaJjapyl6w9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aDaUruTL; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aDaUruTL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B2741127B7;
	Mon, 27 Apr 2026 17:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777303320;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0RcsjARXi/WylSvaqq+PoSLhuLdhmBes5fAdA/dIqvQ=;
	b=aDaUruTLxko2wLJD0GaGMRn5HASwvo4yEgbWQYxm4A6iLqDPdylpyYhBIY0evVu6JviIUg
	vZ84g7/HVeujMu/cP5k0HVKYzkCClLgecHsonhk8NrF6U1ZAndrOGasFq8W1JSkDUAhf5u
	RdHUsZROpHIZOmzwmZt9zz/1aaCWbvE8lwCETCfozc9R/6tD6Qb/5/JXDXQXYRFcDDdFf5
	6lD5fKZIG2rgnxAc32KuRVxP+WaKbj1X3KTnHpNJyDpHpuznvPaZFoL2/kFwwCYU+1v3Lg
	ZmVBQTYcIbtDcNpjUV7/1VEkyycAd8jeGKPoGvBVMITMwRC/49Tg8vY9TaBLmQ==
Message-ID: <eed5c6d0-166a-4b2c-bfeb-13c0f6168f2e@nabladev.com>
Date: Mon, 27 Apr 2026 17:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: core: Default to read-only if wp-gpios present
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org
References: <20260426024507.597480-1-marex@nabladev.com>
 <CAMRc=Me0UunWyG8s5B1vBRjwvCj3Ps8fEu=6h26irqBPBOXDHw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Me0UunWyG8s5B1vBRjwvCj3Ps8fEu=6h26irqBPBOXDHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/27/26 11:44 AM, Bartosz Golaszewski wrote:
> On Sun, 26 Apr 2026 04:44:32 +0200, Marek Vasut <marex@nabladev.com> said:
>> In case the nvmem DT node contains "wp-gpios" DT property, the device
>> currently defaults to read-write and the force_ro sysfs attribute reads
>> 0. Switch to the default read-only, which is both safer, and aligned
>> with eMMC HW BOOT partition force_ro sysfs attribute behavior, which
>> also defaults to read-only.
>>
>> The adjustment of nvmem->read_only value to read-only in case wp-gpios
>> DT property is present must be done only after the device_add() got
>> called because device_add() does internally call nvmem_bin_attr_get_umode(),
>> which configures the permissions of 'nvmem' bin attr based on the value
>> of nvmem->read_only that is only parsed from DT property 'read-only',
>> without any adjustment. This way, if DT property 'read-only' is present,
>> the 'nvmem' attribute is always read-only. Otherwise, if the device is
>> writeable, then 'nvmem' attribute is writeable, and nvmem->read_only
>> defaults to read-only, but can be switched to read-write at runtime via
>> the 'force_ro' attribute.
>>
>> The updated behavior can be tested as follows:
>>
>> Current content:
>> "
>> $ cat /sys/bus/nvmem/devices/logging7/force_ro
>> 1
>>
>> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
>> 00000000  66 6f 6f 0a ff ff ff ff
>> "
>>
>> Write into default-read-only device:
>> "
>> $ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
>> bash: echo: write error: Operation not permitted
>> $ cat /sys/bus/nvmem/devices/logging7/force_ro
>> 1
>> "
>>
>> Unlock and write into device:
>> "
>> $ echo 0 > /sys/bus/nvmem/devices/logging7/force_ro
>> $ cat /sys/bus/nvmem/devices/logging7/force_ro
>> 0
>>
>> $ echo bar > /sys/bus/nvmem/devices/logging7/nvmem
>> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
>> 00000000  62 61 72 0a ff ff ff ff
>> "
>>
>> Relock and write into device, fails because device is read-only again:
>> "
>> $ echo 1 > /sys/bus/nvmem/devices/logging7/force_ro
>> $ echo baz > /sys/bus/nvmem/devices/logging7/nvmem
>> bash: echo: write error: Operation not permitted
>>
>> $ hexdump -C /sys/bus/nvmem/devices/logging7/nvmem
>> 00000000  62 61 72 0a ff ff ff ff
>> "
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Bartosz Golaszewski <brgl@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Cc: linux-i2c@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> V2: Simplify the implementation, make devices with wp-gpios default
>>      to read-only and let users unlock those devices via force_ro
>>      sysfs attribute, just like eMMC HW BOOT partitions
>> ---
>>   drivers/nvmem/core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 311cb2e5a5c02..0b1942e389113 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -1019,6 +1019,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   	if (rval)
>>   		goto err_remove_dev;
>>
>> +	/* If the device has WP GPIO, default to read-only */
>> +	if (nvmem->wp_gpio) {
>> +		nvmem->read_only = true;
>> +		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> 
> Why is this needed if we already did:
> 
> 	nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp", GPIOD_OUT_HIGH);
It is not. I double-checked with a scope and dropped it in V3.

Thanks !
