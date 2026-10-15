Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFF53B60A;
	Thu, 15 Oct 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086804; cv=none; b=spcRenzvBe5b5Pi2jaMKxh6iCXZ0X4WTk8ZayfSKuLQ8VhqbP5WQ7d8pLHrgHxVsuSyxE3mql4YU1fUFW5cbvKKnt3wHdr0TgCVzQUqHtt2CwkU/fzN4nvrTGVRa2atWBAxOw2tatk0jK52FU2UqOmSKm8TvK3eL1zfw/MGN7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086804; c=relaxed/simple;
	bh=ospWKfGIZaYyc/HAgCk1i0jOqNZa9xQv2NUsih8t3GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxNci5KCMa3AKnUa6BtPos0fk9tqGcr8M2LGeT55aog9vuD3aGu4zcWLBxqwWYxSsy4qOJ7X2W6udCXmj382q9uc56JwMU2QdTbPyShXMTUf7P3R7zf/RdHEr395y8Nx1MQRAUgmGqeJ0HayazySZmGc5URwb7Nq25ayY+KJxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sRf9NSyY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sRf9NSyY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4BCFEC62206;
	Thu, 15 Oct 2026 17:54:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C1676075C;
	Thu, 15 Oct 2026 17:53:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEDC510328BE6;
	Thu, 15 Oct 2026 19:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792086792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zkmAwxmH4lTMQTG3LVsKADQ7KqH8CvX55F0Y0BSykdg=;
	b=sRf9NSyYXuQKHFBtcAH5t/M6CGp3gOD6BmQAK6CjZYPLOe5Y3uTyHJNL1klr8ilEx4mYCA
	VInze+VK/75vdGCW6kk15SMdCwsJn9OwHiRp//1J924/8dZ+QnxLxTUO4N+Ltx5UZVu2jN
	x2vgsCUw3FrN2o0JHHjkaJjjDEOicvkFZIc1UiMHX+MwEv8c5Pj6UWLkwe8nhPcrkHeaQW
	70VKy82OwjUcoJs7Hjidn4NCXiz4YKYQYkJGcLh2uRrtrV4FQYszUdiq1sbDckyH5IItxI
	j55cK/VA2OFDdwBCkSfP4t0QgUILyLdYgKOHaqEMw9Og3W7iYodnpLzh9NIApA==
Message-ID: <c1a7f1fa-de46-4c77-b3f7-05faea626f39@bootlin.com>
Date: Thu, 15 Oct 2026 19:53:10 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] mfd: cgbc: Fix use of negative error code as valid
 session handle
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-1-eb42e0f1df59@bootlin.com>
 <179198454582.839288.18173091548459871170@kernel.org>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <179198454582.839288.18173091548459871170@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/15/26 5:19 PM, Lee Jones wrote:
> On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> The cgbc_session_command() return value was directly cast to u8 and used
>> as session handle without error checking. Casting a negative error to u8
>> produces a valid-looking session handle. So check if return value is
>> positive before to cast and use it.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a%40bootlin.com?part=1
>> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
>> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
>> ---
>>  drivers/mfd/cgbc-core.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
>> index 2becaf797646..4a409234e66c 100644
>> --- a/drivers/mfd/cgbc-core.c
>> +++ b/drivers/mfd/cgbc-core.c
>> @@ -103,7 +103,11 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
>>  	if (ret)
>>  		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
>>
>> -	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
>> +	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
>> +	if (ret < 0)
>> +		return dev_err_probe(cgbc->dev, ret, "session handle request timed out\n");
> 
> As previously requested, can we make this a bit more user friendly?
> 
> "Failed to start XYZ session"
Oh yes, I totally forgot it. Sorry about that.

Best Regards,
Thomas
