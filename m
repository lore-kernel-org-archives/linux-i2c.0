Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C081946DA;
	Sun,  1 Mar 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.59.18.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385015; cv=none; b=dCpz0cIE0sfIpcNIUow820Jm2HTDGZPO0/Fu56k9zXxGu6nhuA5c+40dS6Y6dP0OxW+qvHtbIiOYuTdRh9WYIdmEqTOoa89uucHhR055ZuXb64alwMclGUbba52QV7aRKv8dMsKdTvjTdC1GiYysbVihpy1P5ucma+NjB0flKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385015; c=relaxed/simple;
	bh=BwtIxymzcsNe+MXXLfPE1AyI8YH6gFdwPIn52Jm6k/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuWXNl4tDMk9LudEPDsFIfh0Sfe9xlfEeTzPQwNuSN812GdtT5XgapEkrLqF1Qa+rHCUf9x+ObYbQ8daFgE58qIkAx4wDL2PGLjpYQA7jGyWiJ9l8OAOrOw1w2MNwrObVazmQKrv9oIubWn0uEfu3+ZsfSsrDWeDTpBo7TYztjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mattcorallo.com; spf=pass smtp.mailfrom=mattcorallo.com; dkim=pass (2048-bit key) header.d=mattcorallo.com header.i=@mattcorallo.com header.b=g7jkeWPS; dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b=Tzu8WgA7; arc=none smtp.client-ip=69.59.18.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mattcorallo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mattcorallo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mattcorallo.com header.i=@mattcorallo.com header.b="g7jkeWPS";
	dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b="Tzu8WgA7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mattcorallo.com; s=1772383262; h=In-Reply-To:From:References:Cc:To:Subject:
	From:Subject:To:Cc:Reply-To; bh=6yzpMGcLsiDWsRNd9YIrBVPBsDkMvnzQ/31bfqGpYbE=;
	b=g7jkeWPS8yogS7PczBX1HhQClD8v0FVePMxNmYKIt+cgiY/UO2lFKcDvmsd8h3+zCF/KS3+QN3B
	9g+hkqYs8xP7sWeNKxranAzcxbBHnT8fYBpHzJCqjh6pb45WD2YjNvgXfRIHsTLRKZ5RC/rNPiEeW
	evv7sS4cjrSenghUqqWuO/R7bFyC87Nqj35achEfC3PoX43Bp+Ny8fyzr8fLWvHAd8s6XudCqQu84
	nRihEMKZ+X1vGiLd5Nbhu7tgYRIP36S3fAIhC+bJHUb3FBql68Kqsb/pA4w0oQfCV8bR6M23/cojC
	jaW4w6AOF48wvor9hsTXH8ds98TPBd7vtiYA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=clients.mail.as397444.net; s=1772383264; h=In-Reply-To:From:References:Cc:
	To:Subject:From:Subject:To:Cc:Reply-To;
	bh=6yzpMGcLsiDWsRNd9YIrBVPBsDkMvnzQ/31bfqGpYbE=; b=Tzu8WgA7UCKuBrYvfFVcQ6Hyca
	60iT1gWz+YDb92UGg6Mqff/aUHcir1QohRJrPNHqgmeDW1i7LzV9A2x/XREbOyDO8NsXn4anAIjKU
	K29mUktzmiWdV3hY8kFOzxafK85kCVgwzV1A26TUbdh5LqpPqU0yxk8EBY4Y3QW6juw2aODhc8oxN
	5on2z09MpTMmNd3ZchJhvSduGcvX9GFq4/bQlWQDe5kujO2rjkxmGyZ6dEb68Qf5lpuhbYZ/cAF6Z
	gHOfNZxkY9Sjt+poJlsz2sNgOL5ZRc8p8zeiXjaldtDa+qcM4hXnOxzAhylXQOZ1kAYUqtnPVj/Tp
	jFsZmSSg==;
X-DKIM-Note: Keys used to sign are likely public at
X-DKIM-Note: https://as397444.net/dkim/mattcorallo.com and
X-DKIM-Note: https://as397444.net/dkim/clients.mail.as397444.net
X-DKIM-Note: For more info, see https://as397444.net/dkim/
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
	(envelope-from <yalbrymrb@mattcorallo.com>)
	id 1vwkJ0-0000000BL7M-20wC;
	Sun, 01 Mar 2026 17:10:10 +0000
Message-ID: <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>
Date: Sun, 1 Mar 2026 12:10:08 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PMBus memory overflow
To: Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
 security@kernel.org
References: <d5abeb59-8286-425c-9f78-cd60b0e26ada@mattcorallo.com>
 <00baca6f-8046-46ae-a68c-525472562be7@roeck-us.net>
 <aAtEydwUfVcE0XeA@shikoro>
 <3a9ab7bf-6761-4a14-983e-e6bb288ce58a@mattcorallo.com>
 <e0e789b3-24c2-4ea3-9c79-fa815d801d83@roeck-us.net>
 <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com>
 <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net>
 <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com>
 <2025060749-attendant-trout-d2c8@gregkh>
 <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com>
 <2025060848-reset-recovery-f67a@gregkh>
 <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
 <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
 <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
Content-Language: en-US
From: Matt Corallo <yalbrymrb@mattcorallo.com>
In-Reply-To: <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/1/26 11:12 AM, Kees Cook wrote:
> 
> 
> On March 1, 2026 5:46:33 AM PST, Matt Corallo <yalbrymrb@mattcorallo.com> wrote:
>>
>>
>> On 6/9/25 9:57 AM, Matt Corallo wrote:
>>>
>>>
>>> On 6/8/25 3:14 AM, Greg KH wrote:
>>>> Have a pointer to that patch on lore for the maintainers involved to
>>>> review?  Note, we are in the middle of the merge window, so no new
>>>> changes can be added to our trees until -rc1 is out.
>>>
>>> A proposed patch was posted by Guenter, and tested and confirmed that it fixes the issue by myself, at https://lore.kernel.org/linux-hwmon/284466fd-39e8-419e-8af5-41dbabb788af@roeck-us.net/ . Wolfram suggested this patch was acceptable at https://lore.kernel.org/linux-hwmon/aAtEydwUfVcE0XeA@shikoro/ but that's the last he chimed in on this issue.
>>
>> Any update on getting this patch applied Wolfram? Looks like the buffer overflow is still present on at least 6.18.
> 
> Looking at the code, I think probably the best place to check would be in i2c_smbus_read_block_data() when it does a I2C_SMBUS_BLOCK_DATA cmd, since the callers are all already checking the returned status.

I believe that's what the above patch does?

Matt
