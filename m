Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903049C4C0
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178127; cv=none; b=sDWGAcn9kqV8vASWuFz6iYNxmXuzKgglpF8sBWR9aHwJCYXbTJc8/u57saQmsKuooMXuBaiy9HxbDll8n/OrDqS5seT6WVLLADjnXIcLaW5brFBOcO5UgP5vvkGbOnYbSwS73t5SYlQLKzzmNt6G404BXqfCblkdO5NJ/85RmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178127; c=relaxed/simple;
	bh=Bf2WDs6ju2xnoaqyYTaniTAmubFZHV7uVUwkSsLckOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI7Hiy7EBcsTRzVc5dPFkOQUCKM9qA/STPepnsuPlu4zShPVfSyQABCeyDBqNt/mfjI2Lq/WM2JUqqgYR9fliwgwqaYeVK7DFjwKQ1f0V+SCX7Zv2QKVLTLmdN2g5J5VQ0z81ST4cDq+YRPdW/taijUh9ZmJYhEKvQFqhQTqHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hM1TSjdn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hM1TSjdn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B6E31A0FE4
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 15:42:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E19A260580;
	Wed, 23 Sep 2026 15:42:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED708103290E1;
	Wed, 23 Sep 2026 17:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790178122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=THlp2NCefvx0BAiojze+1baYVFoUxGf/jKi6XVt79f8=;
	b=hM1TSjdnDiakjzd2nHhWm+SlveuzgCxbXN8CPuSxoGc4ZE8yZEh4Lq5rEgc/OYpBXwLsXY
	HMKomkFKIFTHEfWZlr8cCfGu8iTyZzaRdYUs1qldghEE0TeK7tyKuWsV3rpKdA2hQTKF28
	2qE+3tM9Fu/CuN1pAbAHJm7uItXrb/OJwDnu1PEhZdSdU4qIKu+qb0eb/kCtLXMBTH+uyU
	3vrYFkK4cqIstxrDPhbQPumVtxVNACpq4lco9UNGZZ4laFdOIAmzv4iv5mUe60H1eYlzrx
	ONXe2PZidkCo4A/l7BfbqwmMFQMRubOJOI+bu9YFBcMLBQHBqYEvMLbOE+o/FQ==
Message-ID: <6f8bdbc3-6184-4165-8e5b-83e98e67e70c@bootlin.com>
Date: Wed, 23 Sep 2026 17:42:00 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] mfd: cgbc: Add I2C platform data
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
 <20260911-cgbc-i2c-storage-devices-support-v3-2-594b53fbc5ea@bootlin.com>
 <20260923150254.GH3864833@google.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260923150254.GH3864833@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/23/26 5:02 PM, Lee Jones wrote:
> On Fri, 11 Sep 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> Define I2C platform data for each I2C bus in the cgbc MFD driver. Platform
>> data passes per-bus parameters to the I2C driver, rather than being defined
>> inside the i2c-cgbc driver itself. This makes the i2c-cgbc driver more
>> generic.
>>
>> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
>> ---
>>  MAINTAINERS                            |  1 +
>>  drivers/mfd/cgbc-core.c                | 39 ++++++++++++++++++++++++++--------
>>  include/linux/platform_data/i2c-cgbc.h | 22 +++++++++++++++++++
>>  3 files changed, 53 insertions(+), 9 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6215fcb07770..561f102c2541 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6621,6 +6621,7 @@ F:	drivers/mfd/cgbc-core.c
>>  F:	drivers/video/backlight/cgbc_bl.c
>>  F:	drivers/watchdog/cgbc_wdt.c
>>  F:	include/linux/mfd/cgbc.h
>> +F:	include/linux/platform_data/i2c-cgbc.h
>>  
>>  CONSOLE SUBSYSTEM
>>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
>> index 4a409234e66c..321fa3fff2ac 100644
>> --- a/drivers/mfd/cgbc-core.c
>> +++ b/drivers/mfd/cgbc-core.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/mfd/cgbc.h>
>>  #include <linux/mfd/core.h>
>>  #include <linux/module.h>
>> +#include <linux/platform_data/i2c-cgbc.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/sysfs.h>
>>  
>> @@ -55,6 +56,35 @@
>>  
>>  static struct platform_device *cgbc_pdev;
>>  
>> +static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
>> +	.name = "Congatec General Purpose I2C adapter",
>> +	.cgbc_bus_id = 0,
>> +};
>> +
>> +static const struct cgbc_i2c_platform_data cgbc_i2c_pm_pdata = {
>> +	.name  = "Congatec Power Management I2C adapter",
>> +	.cgbc_bus_id = 4,
>> +};
>> +
>> +static const struct mfd_cell cgbc_devs[] = {
>> +	{ .name = "cgbc-backlight" },
> 
> MFD_CELL_*
> 
>> +	{ .name = "cgbc-gpio" },
>> +	{ .name = "cgbc-hwmon" },
>> +	{
>> +		.name = "cgbc-i2c",
>> +		.id = 1,
> 
> Why does PLATFORM_DEVID_AUTO not work for you?

Path 2, 3 and 4 do the transition to PLATFORM_DEVID_AUTO.
But at this point I2C driver uses cell id to identify the bus.

Patch 2: adds cgbc_bus_id (in cgbc_i2c_platform_data) to identify the bus.
Patch 3: modifies I2C driver to use cgbc_i2c_platform_data.
Patch 4: now I2C driver doesn't rely on cell id, so switch to
PLATFORM_DEVID_AUTO

> 
>> +		.platform_data = &cgbc_i2c_gp_pdata,
>> +		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
>> +	},
>> +	{
>> +		.name = "cgbc-i2c",
>> +		.id = 2,
>> +		.platform_data = &cgbc_i2c_pm_pdata,
>> +		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
>> +	},
>> +	{ .name = "cgbc-wdt" },
>> +};
>> +
>>  /* Wait the Board Controller is ready to receive some session commands */
>>  static int cgbc_wait_device(struct cgbc_device_data *cgbc)
>>  {
>> @@ -235,15 +265,6 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
>>  }
>>  EXPORT_SYMBOL_GPL(cgbc_command);
>>  
>> -static struct mfd_cell cgbc_devs[] = {
>> -	{ .name = "cgbc-wdt"	},
>> -	{ .name = "cgbc-gpio"	},
>> -	{ .name = "cgbc-i2c", .id = 1 },
>> -	{ .name = "cgbc-i2c", .id = 2 },
>> -	{ .name = "cgbc-hwmon"	},
>> -	{ .name = "cgbc-backlight" },
>> -};
>> -
>>  static int cgbc_map(struct cgbc_device_data *cgbc)
>>  {
>>  	struct device *dev = cgbc->dev;
>> diff --git a/include/linux/platform_data/i2c-cgbc.h b/include/linux/platform_data/i2c-cgbc.h
>> new file mode 100644
>> index 000000000000..4465e8a7b40e
>> --- /dev/null
>> +++ b/include/linux/platform_data/i2c-cgbc.h
> 
> I think this area is mainly used to share data with OF.
> 
> Did you consider include/linux/mfd?
I thought it was the right place. But I can move the struct to
include/linux/mfd/cgbc.h if you prefer.

Best Regards,
Thomas

