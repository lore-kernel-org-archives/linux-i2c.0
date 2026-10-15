Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDC41D4FE;
	Thu, 15 Oct 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086513; cv=none; b=bgvNIZpz/pFd9uw44I9IDA8Ga1CJ/nSKIbFdybssrHudAA/xGN+RHYairikmFbSTky7CVELnvxUzKjlUp8mF5qubJbf7uIdGIfIleji62tVNQdGONHKldkHmgZuhHX92RM9Ck2XHn4RPCGULtitWSWEtf0oOqO58r4zpFTkcgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086513; c=relaxed/simple;
	bh=8kdyArpqUwUZB8FOauNgFWztVvHrMoC7Jx2U5/AdZus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwVoKLYCKC2FokFX9PGz/4q+eOQl+30d6xD9EedA0GFb//hO8qIbhd/oD3BIe8DuQEazWKNytEaa+Ou0gB/q2bcJu9hDB4izpr1lSVAl4d/zqcm0ZgkUPst0HedUFCeAB47wNLsqBseR69IBVYoWgVth6ksHdw4JYnKM62VNqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pGMe7QrO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pGMe7QrO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A189C1A11FF;
	Thu, 15 Oct 2026 17:48:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1D756075C;
	Thu, 15 Oct 2026 17:48:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B84F410328B42;
	Thu, 15 Oct 2026 19:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792086494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tZutKb/ew38IvaeximPU5uu/kbLveuBsTybraI0yJ+k=;
	b=pGMe7QrOcJj8GQ5g9TTKAlY7KRimPjuqUJOSwv722Yq4LQDoZ4MEW9rktseT99Jx0Kcc0Z
	g6UCdJGK+QbjBy1d6yHM41yjNQgVf/l2piRlR/LGvGrQCheleEvdDVvS39apjGzndlSA+S
	yO+Z2rsF3JwS2CKUOOGfoCEwzo0dyMujYOsgdXy2h89SqI8APAl3gOf8WzDdS0AY5fYiFS
	h0RYlUdPav2Jnb4Qarjs0vswGqWU1eaSSnO0LHJvcBBTJ1xhEzCLfy+4yvskjbuKinRvZ3
	j/tPtJObesrHOWywTQlfAAWMGJSQBEwhP+bXyxwqk8o834jhVKJ0ojia1l/wZw==
Message-ID: <a873afcf-ba8b-479d-bb0d-d022895d18d4@bootlin.com>
Date: Thu, 15 Oct 2026 19:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child
 device registration
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-4-eb42e0f1df59@bootlin.com>
 <20261015152741.GB2048969@google.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261015152741.GB2048969@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/15/26 5:27 PM, Lee Jones wrote:
> On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> Since parameters are now passed to the i2c-cgbc driver via platform
>> data, the I2C driver no longer depends on the platform device ID to probe
>> the correct I2C buses. Drop the hardcoded cell ID in favor of
>> PLATFORM_DEVID_AUTO.
>>
>> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
>> ---
>>  drivers/mfd/cgbc-core.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
>> index 0cd9e6f888cb..8522df882509 100644
>> --- a/drivers/mfd/cgbc-core.c
>> +++ b/drivers/mfd/cgbc-core.c
>> @@ -71,13 +71,11 @@ static const struct mfd_cell cgbc_devs[] = {
>>  	MFD_CELL_NAME("cgbc-hwmon"),
>>  	{
>>  		.name = "cgbc-i2c",
>> -		.id = 1,
> 
> If you shuffled the patches around a bit, you shouldn't have to hack
> your own new additions in and out, no?
For I2C bus names I got it, but not for id.
I need i2c_platform_data to be able to drop cell id and use
PLATFORM_DEVID_AUTO, so I don't see how I could reorder the patches.
And cell ids are there from the beginning, not really a new addition.
Maybe I misunderstood your comment, or I miss something.

Best Regards,
Thomas
