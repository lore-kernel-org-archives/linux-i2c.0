Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D711A6820;
	Fri, 24 Jul 2026 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784866892; cv=none; b=D4+Xng5yxuK3solY/LcdWZGXMwIffjcHcVt20wGDT+xgkK0J/CAEiIxoS3KjBtZ2w0WDkUGFpjVSgM/QA++YiEEApmj5RU0ULsbF64RbJoq7ALS+213+Xd9flVG29hpkocUHv3ef8wC54H3QvOstkDcAD5i4WpGlu41BYqUfo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784866892; c=relaxed/simple;
	bh=lssLY0ZrPtp8i3g3vXjHkOCOVRKFxmAanxTiVoAHlHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTWG+8YgTs/pImac1uaE938gYSxXCMI3I20WkE9NZ6C8lwjDR9lOYyJ7OOBVWGzDfqxNXGrb3I5F89aJVfQUgUbsa181bRS3wehdERw0Stser3EhZPCbxXz5/JgzYqHrj9yFVcA7Gtgi46AVsXBwpr36MLUcUdPTlhcY5KDi8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=JQLW3xyg; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="JQLW3xyg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6177711B19B;
	Fri, 24 Jul 2026 06:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784866882;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FkqNlD44tdFCByTrriUMkm25MemcrjMkPA4JyMRZw6k=;
	b=JQLW3xyg4QZ9hnQr/c93+akqIckHN/F8LFZ3Ayyh4lN+pqMO9cO/Iu7JxOQvSASQE3vMuN
	oYt1Sqae1QlX3umGk10GofhVw4k66WTl0s9iAFcKa2TOwOo4cBXZxFowZFk6DA1IzTs38+
	TOGTSr0Pec222dZRndrxcpnhaXQdJDb3QLwJ/Q6hpn7x5TTCWA5JPXBsgZKGMvpDDNYCXn
	zrzqn/pn9V8/ubpFMu97Ej0z+WJNgMRTc8TMkoN+UajRZfjeBzO/afMX+RqdCYHEt1VD6y
	IyuR8LDQIRmMLnIc4xIz5Si9XeJ2xfV9lLXZubelLVAqEwsQ3szTSyUaiIMZ1A==
Message-ID: <46051025-8b50-47de-839a-a901615b8227@nabladev.com>
Date: Thu, 23 Jul 2026 21:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260511163518.51104-1-marex@nabladev.com>
 <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 5/12/26 12:04 PM, Bartosz Golaszewski wrote:
> On Mon, May 11, 2026 at 6:35 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> Mark the nWP GPIO as non-exclusive, because there is hardware in the
>> field which has multiple AT24 EEPROMs with nWP GPIO line tied to a
>> single GPIO. This allows such hardware to be described in DT and the
>> nWP GPIO operated via NVMEM force_ro sysfs attribute.
>>
>> Note that GPIOD_FLAGS_BIT_NONEXCLUSIVE is a deprecated flag and should
>> not be used, but thus far there seems to be no replacement.
>>
> 
> There is a replacement now. It lives under
> drivers/gpio/gpiolib-shared.c and drivers/gpio/gpio-shared-proxy.c.
> Though the voting mechanism I implemented is hard-coded to drive the
> line high if there's at least one consumer sharing the line that votes
> high. I'm now thinking that this may be too rigid as yesterday, within
> two hours I had two submissions wanting to do it the other way around
> - drive the line low if there's at least one consumer that wants it
> low.
> 
> I'll try to modify the gpio-shared-proxy driver to take into account
> the value set when the line is first requested and treat it as the
> "default" in the voting mechanism. IOW: when the first user requests
> it out-high, we'll drive it low on the first user that votes for low
> and drive it high again when the last user drivers it high. This
> should work for both the Qualcomm shared GPIOs for audio use-cases and
> the WP pin here as well as the SCL recovery shared GPIO we have in
> I2C.
> 
> With that said: I'd prefer you not set the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE and see if you can make gpio-shared-proxy
> work for you instead. I'll submit something soon for you to test.

I'm sorry for my late reply, I was completely overwhelmed by emails.

I tried to look into the gpio-shared* , but I couldn't figure out how to 
describe it in DT. Do you have any examples?

Take for example this DT snippet:

gpio: gpio-controller { ... };

i2c {
   eeprom@0 {
     wp-gpios = <&gpio 0 0>;
     ...
   };

   eeprom@1 {
     wp-gpios = <&gpio 0 0>;
     ...
   };
};

I assume there has to be some new glue node between the eeproms and the 
GPIO controller somewhere ?

Thank you for your help !

-- 
Best regards,
Marek Vasut
