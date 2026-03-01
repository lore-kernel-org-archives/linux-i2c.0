Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE53A8F7;
	Sun,  1 Mar 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381575; cv=none; b=lbnD7i2gWijzJa/T5Pgq3pg2RMao+KUD0/Loy/IBzqF0M/qW3F6C0Er8bYgiSkWE/dqNLmwjmAuMIdYLxoBN3jTy391l+b6NlStU0GcX2xgJ4/vqEAJiknDTImFF8BAGX0CZ1rlqqAtnpnlpgBS214+mhcERo6nkJu8dpfspFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381575; c=relaxed/simple;
	bh=DgyESKIjRaPC+E4yh9+FWtF4iKJJn4Q9Ct57JDTKb+g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ertoG7SndnKT/HJdU9OfOVu8TKj5NdQvmdNw/9HoE3EyXt6FgiCmm4MQVlXW6Vxl3PZKGgRY3iAJ93SV/BqJ4cW75/NVSyVEL0Rv+WqB4NhhUUANU7zIfuTuYuKjPWHSG0hsIqH0wklemHbufKZpJ+BKn6uORJZxXVkU46YKGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSmm0pgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSmm0pgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E24FC116C6;
	Sun,  1 Mar 2026 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772381574;
	bh=DgyESKIjRaPC+E4yh9+FWtF4iKJJn4Q9Ct57JDTKb+g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hSmm0pgJ5ZfSfDeO+WYDT02nvh+geId6av1HAPJjpTzT6IJzhuCtOp/gT+6ZNORFa
	 agAjlTvWqLDQXLo1mLT643bKbKWzTW60c8caz2dR6ptRyTvrhYv8iM/HVf7jLqLgHz
	 CeaRfcbbVBRwwwboDJ2vV1bpnxmgppbvT28x+MgitmhSKbB/22tPHHvWnkD+ZV5tS6
	 s3sNJVVxf0oWAdzZu/o8j++JxvWGIf0yl/bsDOynlo3C4LKoz72kj7rRgGnIfosbZT
	 xCFf+ubOQ8vdvS2sy4edd/6WYCiTXBPRkEnfwdaF4XAtfmq9xX9wgYg2yR5adoNT4w
	 7Np5iMMRQpYBw==
Date: Sun, 01 Mar 2026 08:12:53 -0800
From: Kees Cook <kees@kernel.org>
To: Matt Corallo <yalbrymrb@mattcorallo.com>,
 Greg KH <gregkh@linuxfoundation.org>
CC: Guenter Roeck <linux@roeck-us.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-hwmon@vger.kernel.org,
 Linux I2C <linux-i2c@vger.kernel.org>, security@kernel.org
Subject: Re: PMBus memory overflow
User-Agent: K-9 Mail for Android
In-Reply-To: <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
References: <d5abeb59-8286-425c-9f78-cd60b0e26ada@mattcorallo.com> <00baca6f-8046-46ae-a68c-525472562be7@roeck-us.net> <aAtEydwUfVcE0XeA@shikoro> <3a9ab7bf-6761-4a14-983e-e6bb288ce58a@mattcorallo.com> <e0e789b3-24c2-4ea3-9c79-fa815d801d83@roeck-us.net> <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com> <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net> <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com> <2025060749-attendant-trout-d2c8@gregkh> <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com> <2025060848-reset-recovery-f67a@gregkh> <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com> <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
Message-ID: <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 1, 2026 5:46:33 AM PST, Matt Corallo <yalbrymrb@mattcorallo=2Ecom=
> wrote:
>
>
>On 6/9/25 9:57 AM, Matt Corallo wrote:
>>=20
>>=20
>> On 6/8/25 3:14 AM, Greg KH wrote:
>>> On Sat, Jun 07, 2025 at 09:25:44AM -0400, Matt Corallo wrote:
>>>>=20
>>>>=20
>>>> On 6/7/25 4:19 AM, Greg KH wrote:
>>>>> On Fri, Jun 06, 2025 at 04:57:37PM -0400, Matt Corallo wrote:
>>>>>> Adding security@kernel=2Eorg cause probably they should make sure t=
his gets fixed=2E
>>>>>=20
>>>>> That's not how security@k=2Eo works, sorry=2E=C2=A0 As this is alrea=
dy public, no
>>>>> need for security@k=2Eo to get involved at all, the normal developme=
nt
>>>>> process happens here now=2E
>>>>>=20
>>>>> So, submit a patch and people will be glad to review it!
>>>>=20
>>>> Thanks, figured I'd ask=2E Sadly there is a patch that folks seem to =
be okay
>>>> with to fix a buffer overflow but its just sitting=2E
>>>=20
>>> Have a pointer to that patch on lore for the maintainers involved to
>>> review?=C2=A0 Note, we are in the middle of the merge window, so no ne=
w
>>> changes can be added to our trees until -rc1 is out=2E
>>=20
>> A proposed patch was posted by Guenter, and tested and confirmed that i=
t fixes the issue by myself, at https://lore=2Ekernel=2Eorg/linux-hwmon/284=
466fd-39e8-419e-8af5-41dbabb788af@roeck-us=2Enet/ =2E Wolfram suggested thi=
s patch was acceptable at https://lore=2Ekernel=2Eorg/linux-hwmon/aAtEydwUf=
VcE0XeA@shikoro/ but that's the last he chimed in on this issue=2E
>
>Any update on getting this patch applied Wolfram? Looks like the buffer o=
verflow is still present on at least 6=2E18=2E

Looking at the code, I think probably the best place to check would be in =
i2c_smbus_read_block_data() when it does a I2C_SMBUS_BLOCK_DATA cmd, since =
the callers are all already checking the returned status=2E

--=20
Kees Cook
