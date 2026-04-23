Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA23537D0;
	Thu, 23 Apr 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945841; cv=none; b=Xbqbvbw3Njd6dHF91umW7ArRb4FPx+u/aXFPdhDUIdOclmK8UqRbVh6XHb8HKgp27rJhv/RHvmhgOTiuqQ4Ux3NsSTKkUQZy+NBMwgHlhNM/LYVXMLm73vxeGleN/CZn91moJn5nQX66SxrE0arFO7Oq84CbuqRAQXubNuKwc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945841; c=relaxed/simple;
	bh=u2W8iYeL9ijnxYkPiCQmiJOQU2rd3YS+TxljZyL/BeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM5DBs9wKFsgMIdKfTaWvla5CJY+nQEnMSZubNNBNDFBIGT7ZugBKpsbYU10PeWbnL2r60m09CEchGxSXVA6KhNzQmoeM3hHrhEHSoXCkGZ6125M7o+agATDQv52B8jVz2Ene1ORTR+iybjc6oEMqlKvJNdyNPkrN/fz0zctH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=cZ2SbGHc; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="cZ2SbGHc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD7C8113ECE;
	Thu, 23 Apr 2026 14:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776945837;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fEYw6FuYgxS/qvu0/UHGRW7vNKtIjVSHDP0XY+qtk/k=;
	b=cZ2SbGHcWN8F0K2DHgP+jxVjDLVykwjtfAHbzNZo4KJV84VwwUxLB8hyYhLi3QmMMjQSeX
	DSsIgrM1rvLoLdEb/t+f+FaomOK1CRzNJiJqSAQfa5m8Ac+m1JhEO78JVic1/f4ocm7DF1
	hvhqX7HVbAHLR7WSiINwTnKgZpm9MH0mt0AiTuNo5GzfmpteGYrq3g1REZtb3CM+jh5xNS
	1nNLSQuiGfpW2F0+V9Q5ONW5QJfMIn3gxrCFN9Z0RzbR+F3XGF7XtYMct+7XqFhaefuhA/
	NwL8mSq4sL87o+zFpH2Y6TyCDCCi/Lb/mM4nnuklS8aobHQNGTFqN0fewq6EpQ==
Message-ID: <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
Date: Thu, 23 Apr 2026 11:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260421140755.54222-1-marex@nabladev.com>
 <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
 <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
 <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/23/26 9:42 AM, Bartosz Golaszewski wrote:
> On Wed, Apr 22, 2026 at 7:01 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 4/22/26 1:33 PM, Marek Vasut wrote:
>>> On 4/22/26 11:07 AM, Bartosz Golaszewski wrote:
>>>> On Tue, Apr 21, 2026 at 4:08 PM Marek Vasut <marex@nabladev.com> wrote:
>>>>>
>>>>> Handle special-case of AT24 EEPROM described in DT, which contains both
>>>>> "read-only" and "wp-gpios" properties. Interpret this configuration as
>>>>> default read-only, but with the possibility of unlock via force_ro sysfs
>>>>> attribute.
>>>>>
>>>>
>>>> Patch looks ok code-wise but does this really make sense? If an EEPROM
>>>> is read-only, we should forbid writes in the kernel. Which board uses
>>>> it? Can we simply remove the read-only flag from DT?
>>>
>>> Currently I am not aware of any upstream users, I plan to introduce one
>>> once this patch or some for of it lands.
>>
>> I have to amend my statement, I would also like to adjust an already
>> upstream DT to make use of this default-read-only functionality now.
>>
>> I would however like to get go/no-go on this patch before I roll out the
>> DT patches.
>>
> 
> Yes, go ahead.
> 
>>> I have is an ID EEPROM which I would like to be able to program under
>>> special circumstances (hence the wp-gpios control) , but it should be by
>>> default read-only .
>>>
>>> If I remove the read-only, then by default the EEPROM is read-write,
>>> which is undesired. If I remote wp-gpios then I loose access to the
>>> force_ro attribute which controls the nWP GPIO from userspace, which is
>>> undesired.
>>>
>>> So I think defining this special-case where wp-gpios and read-only are
>>> used together as default-read-only is sensible.
>>>
>>>> Admittedly: the DT bindings do allow it as read-only and wp-gpios are
>>>> not mutually exclusive but I think it's more of an accidental omission
>>>> than a planned feature.
>>> I think it is currently an undefined behavior, and this patch defines it.
>>
>> Also, this default-read-only behavior is effectively the same behavior
>> like the eMMC HW BOOT partitions have, they are also default read-only,
>> but can be switched and written to by setting their force_ro sysfs
>> attribute.
> 
> I see. Ok, please send a v2.
Does this patch require any changes ?

I will be sending the DT changes separately.
