Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7937FF68;
	Wed, 22 Apr 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875312; cv=none; b=G+rYosixMOqCFZQgkCcUE+9l8yJ2SbIOeYgO9XJYMIUgByHl2Woll/RJzpQFZbUqWuT35f5Qj7uwhR6/BStc1bMBX3pH4E0Pfxtk338MwbzR515fQ9kfHbVjkcxoxLCSb0+42kKNLR5zJSH0R+rI540PMTm+17PH99/0NzVjQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875312; c=relaxed/simple;
	bh=qhlbZbIGVHQy9LrIzp3QdBPC1fyAcxZI52H9IQOGLT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDWt7fe3nRp2v4MKqogybAGklGHh9rLb7TwKrUrvXZQuBMF+CRVgT8Koc2JI0w/qj6CmjrgCnJ418/+DO/EzGSSElYCTVvOiUvhjoXelfY5vtwu6R4hiOWaGjNaOxrVfP+kakGxO/riXUzJ3tBz9AHtj6iEQKb18rYjEmKBf8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aIpE0Krw; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aIpE0Krw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CF29114A75;
	Wed, 22 Apr 2026 18:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776875301;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0nHk+0iP3Aq5bsqejM+w9/UT3yt1JZ6+Jx5bItZNCFo=;
	b=aIpE0Krwozdrzo8akDTgkbSL6tT3B278YiJ6oECuimrh4hGN6cudcc1yUsQol5jqm4yq40
	ZwtSHkcS0KzGOWbZIRyS36Ymofe2uhVL2Ybi8TTDbIL+23SHu8jo9A76PPYiyWybcTMfIH
	mY4zR8Cvl+WZLE4NZpar+eR4ZY29polMi3ZbgDcbn0ekFO8OxcOiwrRqmE6t22m6Iq2HyN
	Knya7cpf69rM+f1xsZS9rBXoHQXJutvwpoMhWiqQDfqQizV8msX05RN1BY60ncRyXpv/0x
	0Z3CwjPzNP5+4WJ9obIuf62hv/gMruJAbBi0w6KEKJdiRKxrhJXbOsAumlibeA==
Message-ID: <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
Date: Wed, 22 Apr 2026 13:33:08 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/22/26 11:07 AM, Bartosz Golaszewski wrote:
> On Tue, Apr 21, 2026 at 4:08 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> Handle special-case of AT24 EEPROM described in DT, which contains both
>> "read-only" and "wp-gpios" properties. Interpret this configuration as
>> default read-only, but with the possibility of unlock via force_ro sysfs
>> attribute.
>>
> 
> Patch looks ok code-wise but does this really make sense? If an EEPROM
> is read-only, we should forbid writes in the kernel. Which board uses
> it? Can we simply remove the read-only flag from DT?

Currently I am not aware of any upstream users, I plan to introduce one 
once this patch or some for of it lands.

I have is an ID EEPROM which I would like to be able to program under 
special circumstances (hence the wp-gpios control) , but it should be by 
default read-only .

If I remove the read-only, then by default the EEPROM is read-write, 
which is undesired. If I remote wp-gpios then I loose access to the 
force_ro attribute which controls the nWP GPIO from userspace, which is 
undesired.

So I think defining this special-case where wp-gpios and read-only are 
used together as default-read-only is sensible.

> Admittedly: the DT bindings do allow it as read-only and wp-gpios are
> not mutually exclusive but I think it's more of an accidental omission
> than a planned feature.
I think it is currently an undefined behavior, and this patch defines it.
