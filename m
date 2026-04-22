Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679D17DE36;
	Wed, 22 Apr 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877306; cv=none; b=ONkmLoUNwqb1XkdWkEV1u70wzk4zpM5VfF7DsIucHqNlODj3sCPPJMxgDCZlHzbna9BVsBVrJ38Oarz2JIXDt0BQHkqg04Ug+9ukXmsTw2gZ7gZh6HdzcAgAw6UzgM3G9v52JRGgHeYWh3PDA1w3IFOQLPHg583bsIYcvXKaIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877306; c=relaxed/simple;
	bh=zCAQyDnoDjTRLs97PQNQuco7Ndshntfn+BBJPKrSWtk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qj+Cmd+YWquTHjVMQevZvVRIK56jSsnA5Bu3YQxwoM4DAuLBMsQmr3BvlwKxIX4nNe/LNZn5iEkIHxh3j1VOSCfxiACiREk3QBwG625MZLPXgtfh3OlCT7xUUGHPK2UuD8E2u0vn1893li0OqQBtgFV4F6k0DVcLBFtheqRoQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ZKANe1kF; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ZKANe1kF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4982D114A8F;
	Wed, 22 Apr 2026 19:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776877302;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WIWMHVN1WP9qGUnpYBdTuFjk9vviDRD+CjgNIh5iSDc=;
	b=ZKANe1kFmtR8oJSL3SCaR2e/vYrqiitEF9+IwhwQSD+2Neql2PZ0uj9eEPA8nPdfkGfUYX
	V4AORktfsfMzFCtVDxEUoS/2OI9ZgjNXytbeUarzeCTEx1IZWvjlBX0Qn6hLPO1JVR/83x
	PG5q8hFRO0ZY9zIUiPmwORYTdRJUWIPKQ2IfQpzYAHDWBnbuGipoFZDC4W4YsEGuASUvrZ
	N4OlF+yxssJzub4mRDON0kB9HtEJ0Ln+G8oTB2kVb/p3K7uIcdah2IHBXWDLX9PjQIIoN3
	jB9OBALHRER60/XHzwvjqvE7jqGY4lrTYKEKrPOs5ncLIzJoUwTuACiNjMBFeQ==
Message-ID: <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
Date: Wed, 22 Apr 2026 19:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
From: Marek Vasut <marex@nabladev.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260421140755.54222-1-marex@nabladev.com>
 <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
Content-Language: en-US
In-Reply-To: <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/22/26 1:33 PM, Marek Vasut wrote:
> On 4/22/26 11:07 AM, Bartosz Golaszewski wrote:
>> On Tue, Apr 21, 2026 at 4:08 PM Marek Vasut <marex@nabladev.com> wrote:
>>>
>>> Handle special-case of AT24 EEPROM described in DT, which contains both
>>> "read-only" and "wp-gpios" properties. Interpret this configuration as
>>> default read-only, but with the possibility of unlock via force_ro sysfs
>>> attribute.
>>>
>>
>> Patch looks ok code-wise but does this really make sense? If an EEPROM
>> is read-only, we should forbid writes in the kernel. Which board uses
>> it? Can we simply remove the read-only flag from DT?
> 
> Currently I am not aware of any upstream users, I plan to introduce one 
> once this patch or some for of it lands.

I have to amend my statement, I would also like to adjust an already 
upstream DT to make use of this default-read-only functionality now.

I would however like to get go/no-go on this patch before I roll out the 
DT patches.

> I have is an ID EEPROM which I would like to be able to program under 
> special circumstances (hence the wp-gpios control) , but it should be by 
> default read-only .
> 
> If I remove the read-only, then by default the EEPROM is read-write, 
> which is undesired. If I remote wp-gpios then I loose access to the 
> force_ro attribute which controls the nWP GPIO from userspace, which is 
> undesired.
> 
> So I think defining this special-case where wp-gpios and read-only are 
> used together as default-read-only is sensible.
> 
>> Admittedly: the DT bindings do allow it as read-only and wp-gpios are
>> not mutually exclusive but I think it's more of an accidental omission
>> than a planned feature.
> I think it is currently an undefined behavior, and this patch defines it.

Also, this default-read-only behavior is effectively the same behavior 
like the eMMC HW BOOT partitions have, they are also default read-only, 
but can be switched and written to by setting their force_ro sysfs 
attribute.
