Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413628AAEB;
	Thu, 23 Apr 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971749; cv=none; b=ghFVVjs8MnhblLb8eASrJo9NcxSCt4pB+ND0chNCzWmVy79oSqnNfb+/P/X1LTO6sD8vzlvlvLDF5v846Rf0HSgBfmFoN48ffU/fbsvwkRIDaVgToBbG6hU1NXyJpvRtN5cFcJulq629YOJzE/uS0VtjfJ6dZjhO7duj4VJQEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971749; c=relaxed/simple;
	bh=qiwwxf9yhhHO8ZYoPylORcn7HC3ao+V5tI/uFOshm3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edQ7OSS33/graSiaEEm/13sK2UznRM8iG3+/UgO1bq/OHpfaMl5Z9n9fRNt7NSpfsXmNnbO8/gyF6jbscgMxnqE9rjiXMDQYNX7hAzU16FDjNGbGeKNyPogudvnjcXgJyXOsv67CYpStkVT1TJie7RyDQK+WYn4hD3c5t40SVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=QRcokavF; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="QRcokavF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 530021133AA;
	Thu, 23 Apr 2026 21:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776971739;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TJ2rCpjIbZOghBXli83/mp337qVhjpWNhUQPZsMkTLE=;
	b=QRcokavFUoi8C+quE6NbPZSe6Kutf4xWvZrBq2/o21IQbk0ogjcPUb5eR+7sGRiAkt0iDb
	r5Cpr/npGQYGhOaU7Aief2dwSQhmbJJE3Xhwm9rT77T/JeTrd5XhRJWBShUguCnQbo+g0P
	8lhfYIXVWtWxld0OzFbZgqvNxNDFQzhmBZd6akHhA0ElxVZu2x2DPCz62ymET+GLQl1sxp
	KYaowsnAQ0lNFs0mu5n796R90iMoY5wpGu5tEe4NqsN/XKGJ9kBXkNkXkVRINprYoLdug3
	ZqyP4D6QCjP2BW5aqghuLeBuJ/NgzfxMXNiSP4dsS56Uht9cH4gGz0dYNd1Lgg==
Message-ID: <4a6c6822-28e1-4838-9262-f7b758f92736@nabladev.com>
Date: Thu, 23 Apr 2026 21:15:37 +0200
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
 <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
 <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
 <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com>
 <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/23/26 4:19 PM, Bartosz Golaszewski wrote:
> On Thu, Apr 23, 2026 at 4:06 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> On 4/23/26 2:17 PM, Bartosz Golaszewski wrote:
>>> On Thu, Apr 23, 2026 at 2:04 PM Marek Vasut <marex@nabladev.com> wrote:
>>>>
>>>>>
>>>>> I see. Ok, please send a v2.
>>>> Does this patch require any changes ?
>>>>
>>>> I will be sending the DT changes separately.
>>>
>>> Sashiko is saying this:
>>> https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nabladev.com
>>
>> What does this mean ?
>>
>>> Shouldn't we report the device as read-only in sysfs unless it was
>>> "unlocked" with force_ro?
>> This would be ideal, but I did not find a way to toggle the "nvmem" bin
>> attr permissions at runtime. Is that even possible ?
> 
> Right, it seems like it's set once and can't be changed (Greg: correct
> me if I'm wrong).
> 
> Ok, nevermind the comment then. Maybe just split the changes into
> nvmem and at24 changes and I can take both with an Ack from Srini.
I have two more ideas I would like to run past you ... how about either:

- If wp-gpios is present, set the device as default RO after boot, and
   let force_ro sysfs attribute toggle the protection of the device back
   and forth afterward. This would however change the userspace facing
   behavior slightly, because right now, with wp-gpios present in DT, the
   device is default RW.

- Introduce new DT property, wp-gpios-default-read-only or
   default-read-only or some such, to indicate the device should be in
   read-only mode by default. That would mitigate the downside of the
   aforementioned point, but would require a new DT property.

Thoughts ?
