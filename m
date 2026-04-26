Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E31F03DE;
	Sun, 26 Apr 2026 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777171804; cv=none; b=MALgRzzqP+h+bnIgT782Ai50K0RVT0lhkf4wasB82VMJO9buYlIvzdGoGGTze/kX8tHmjEXL34Ntrd/l6Ak2hGCscXBZvjSNFSRRI5wrbFVPAzG9KvXZp3nZoPc2lFkDNEpqDzuSZXo5FLK7T4PuGrhe6Z5U5fiKR3YRizrQ6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777171804; c=relaxed/simple;
	bh=KOlDetN67fE1P/icqohLIDDSELdOiEYLA1EypHGAYlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEKHZ9xVvrrD67ivijugNK10n3TFqmEn5gKAXmakqQCcwFJkpn0GBq271nrjbsU1MjHPsm9OsKNCWGiJHpnfa3qyr/jG+DRaht1tIVA0yN9v+jEO7P7MJrM5NHM7vop7S8qO5FlWdV7z7OTNw8d1+ThNskUaN0/nPIRNK0Az0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ZbhhDWwp; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ZbhhDWwp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72B6F11418A;
	Sun, 26 Apr 2026 04:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777171800;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7EfP2fq85L8iweLuPtTU+TueaSdT3KR7c8RZEy+E7TI=;
	b=ZbhhDWwpJz1WChEyQErQKq8mbiZdtrytxAwDYkRDAH720CuQ4FLE0Ln/7VeJSJXRPerMou
	clwieQCkRMruItstK6oTxeIxUYt8YNr+JDyFLlHe5aZwHkR9WcvPNUHc3BOC7162N2UiL3
	I7Xsexzjx8WoKLGxSutDj/j8wwBi1MPfU/+tIrBnu2pTmOh5nz0JDFbnwCCFfudNgFt02A
	EforbbXfo46VETDbAkZ7Y+AgmgMukYMVJdNWS6AOBxYHaG9C5xgF1NyRpeGiwYEai9f9bT
	LOeU3lVj6SqV0Lt/bIajBmozgq00AQz+XntFEenHToYl3NtIPPdnwIr2tJcybQ==
Message-ID: <a6b29aa2-8a92-440d-9026-5682af828a78@nabladev.com>
Date: Sun, 26 Apr 2026 04:49:58 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260421140755.54222-1-marex@nabladev.com>
 <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
 <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
 <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
 <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
 <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
 <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com>
 <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
 <4a6c6822-28e1-4838-9262-f7b758f92736@nabladev.com>
 <CAMRc=McSHzmOZ2DgyiZNVVaeQm7QVG1GGnwGAPXUGdh7hPOS1Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=McSHzmOZ2DgyiZNVVaeQm7QVG1GGnwGAPXUGdh7hPOS1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/24/26 10:12 AM, Bartosz Golaszewski wrote:
> On Thu, Apr 23, 2026 at 9:15 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 4/23/26 4:19 PM, Bartosz Golaszewski wrote:
>>> On Thu, Apr 23, 2026 at 4:06 PM Marek Vasut <marex@nabladev.com> wrote:
>>>>
>>>> On 4/23/26 2:17 PM, Bartosz Golaszewski wrote:
>>>>> On Thu, Apr 23, 2026 at 2:04 PM Marek Vasut <marex@nabladev.com> wrote:
>>>>>>
>>>>>>>
>>>>>>> I see. Ok, please send a v2.
>>>>>> Does this patch require any changes ?
>>>>>>
>>>>>> I will be sending the DT changes separately.
>>>>>
>>>>> Sashiko is saying this:
>>>>> https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nabladev.com
>>>>
>>>> What does this mean ?
>>>>
>>>>> Shouldn't we report the device as read-only in sysfs unless it was
>>>>> "unlocked" with force_ro?
>>>> This would be ideal, but I did not find a way to toggle the "nvmem" bin
>>>> attr permissions at runtime. Is that even possible ?
>>>
>>> Right, it seems like it's set once and can't be changed (Greg: correct
>>> me if I'm wrong).
>>>
>>> Ok, nevermind the comment then. Maybe just split the changes into
>>> nvmem and at24 changes and I can take both with an Ack from Srini.
>> I have two more ideas I would like to run past you ... how about either:
>>
>> - If wp-gpios is present, set the device as default RO after boot, and
> 
> Isn't this already what happens though? nvmem core requests the GPIO
> as output-high and drives it low only when it's doing the writing.

It isn't, the default is read-write . But I now submitted a V2:

nvmem: core: Default to read-only if wp-gpios present

>>     let force_ro sysfs attribute toggle the protection of the device back
>>     and forth afterward. This would however change the userspace facing
>>     behavior slightly, because right now, with wp-gpios present in DT, the
>>     device is default RW.
>>
> 
> Or do you mean just the file permissions?
> 
> If the latter, then that does sound logically sound but yeah, it's
> asking for a regression report. :)

Please see "nvmem: core: Default to read-only if wp-gpios present" that 
I just submitted.

>> - Introduce new DT property, wp-gpios-default-read-only or
>>     default-read-only or some such, to indicate the device should be in
>>     read-only mode by default. That would mitigate the downside of the
>>     aforementioned point, but would require a new DT property.
>>
>> Thoughts ?
> 
> I like "default-read-only" and it both allows to introduce this
> behavior and not break existing users. Let's loop in DT maintainers
> and see. I'd just like to clarify if we're talking about sysfs
> permissions or GPIO behavior here.
I think we might not need this, please see above.
