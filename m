Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D242AFB7;
	Thu, 15 Oct 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085022; cv=none; b=MatghuQUhKHkE1FSQr2l8fGdS6X3gCnBtTgSInJSGsSK5ZjGMR0Ysxzpw3NAn+RwIUeiibWlTEyAm+kh3vRDEY/Bk+ORuu91y2JWH4BwPEYL26D7CLsHB0nRwZ4AXTvy1pizSSXPy9dtcweJ5ukMPhXru2TQNZeIG7Xy8QyVbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085022; c=relaxed/simple;
	bh=62lf82E2z8J3pjBsvFgvbUJl6TfiO+TvR2u3HIX61rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCgViioMQN87iwL5WM4RFQ5eFQSKBI4ohz6zMNxRyv71Z/miBsBydvZgwk3fbtQMDs7Fmlp4sGGSJ554RqijR6A5MktM1I6elPof2ehZ997PZeH2+Ivs1l+Cobny6YP/3CdZwqTz6isxrEZmB1Vj+UiwlCsz1jGaoa93F/k1iRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJcaJb5y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJcaJb5y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC720C62205;
	Thu, 15 Oct 2026 17:24:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B36B6075C;
	Thu, 15 Oct 2026 17:23:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 710F310328C76;
	Thu, 15 Oct 2026 19:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792085002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nY88KXFFykE4mi/205FHcUkNHV0vtTpb8pBqWkJfikE=;
	b=LJcaJb5yw/zxQp4IExNrOWRfsui3ySbEHjlwKnLieX2H15WPn+UqlqFReaQ39eWIM46Yg+
	w2z7696wFUSnK5dFM2GOOSu3JAi7hLQHSPItavn+Ddn1/x0jUnYOHjC6UjqfbYqKCd/TFn
	rhvOzUrplatioW3S8/mWz1taDYOMPCym4ZOf0BNpWFQn+zpSGt8RytqZKnxITKJGMPDZrC
	/81UizjzhcIuw6+UWbo/bj8mVAXW3ZFPoXwpsKHZ2twANOYVgiVygSBEhrgweGy4jhw0RR
	vd2ws4XdPWLgN2DomWm70YUKnnKusKJ5AaiHlB5h9/plija72yLBdrgCIaUQEg==
Message-ID: <8eaed3d4-218b-4abd-853a-108443f3ecd2@bootlin.com>
Date: Thu, 15 Oct 2026 19:23:20 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] mfd: cgbc: Use real I2C bus names
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-5-eb42e0f1df59@bootlin.com>
 <20261015152700.GA2048969@google.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261015152700.GA2048969@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

>> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
>> index 8522df882509..a58d9ffdc277 100644
>> --- a/drivers/mfd/cgbc-core.c
>> +++ b/drivers/mfd/cgbc-core.c
>> @@ -55,13 +55,13 @@
>>  
>>  static struct platform_device *cgbc_pdev;
>>  
>> -static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
>> -	.name = "Congatec General Purpose I2C adapter",
> 
> This is odd.  We only just added these.
> 
> This should be fixed up into the original patch.
> 
Indeed I can fix names earlier in the series, when I2C bus names are
defined in the I2C driver, so no need to rename variables in the MFD.

Best Regards,
Thomas
