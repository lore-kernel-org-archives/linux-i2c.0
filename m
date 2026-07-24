Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB2BD0B;
	Sat, 25 Jul 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784960527; cv=none; b=OJAPoHdBtSbLBhjF1opfeEUylaDIVuSDqjLDWEpWI55HdhyxHRxrI2rsQFDtT9lyfmhWZCAqzNRPtaClUNNzangY8cTCgkGaTUIw4CUsbjeuai7+hSujcTfCfJ84mdcY1WbEibxQPvCwuqrCsVliIQR/FEKbO023bOSha2+28x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784960527; c=relaxed/simple;
	bh=JPk71yfiHUYLxbLBWHm0knlB3mZVH9rfAE0BzqIaCh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrJyeqoejr5V8hiW6LzUK0ES0eWm4zoJDEIZV9wd5t/V0StyUd05DgCwORhGH/R+d8lte8khg1gKr0wZVitt9zvpk5EMuO+3dCdSDSc/qmAje8pMk5xfLILSO2fX052H3USbRJTIVbRrXl9l3aWrPGSOvBX5yfRd03XknqVUjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=IEF3SUvX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="IEF3SUvX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 270F411B380;
	Sat, 25 Jul 2026 08:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784960518;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=peQw6q/IKJb5fV3+RfKeuUXuz1fhWHgejJ64Gkcun9w=;
	b=IEF3SUvXlmj4S3Aurqv5TvhE5hM2t8N5cjlLBSfRzRflSEuJXpS2wT/Q8HZuz5GGiHgL4S
	e5/tEHFvDEr49TC6M3mXIL+PrhYVrsFYHWcZ7Vbg3cThia6iPE5fzplt6Pfnzy9l4VFrLu
	damdvf36iwYnthU0N8AAJhvnzd2DqiAhX0zrkCHnrNadetAqxsJB7dSFLRT6dthAeGnrwm
	Ez0A3iK4SkWfqHrXgAH9YlBzlGdrhKDA1q4wj8LbabGJrFzzZ01lljqkHvuypxdmxgh5de
	2Biv0j2/sJ5GAmhuBQmfzF/dT27eZx+y/OgXw/a54z/iO6zO7en6qN2qnMbMJw==
Message-ID: <8a5838f6-8582-4ce2-b80d-cd05bb984a4f@nabladev.com>
Date: Fri, 24 Jul 2026 14:51:08 +0200
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
 <46051025-8b50-47de-839a-a901615b8227@nabladev.com>
 <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7/24/26 9:30 AM, Bartosz Golaszewski wrote:

Hello Bartosz,

>> I tried to look into the gpio-shared* , but I couldn't figure out how to
>> describe it in DT. Do you have any examples?
>>
>> Take for example this DT snippet:
>>
>> gpio: gpio-controller { ... };
>>
>> i2c {
>>     eeprom@0 {
>>       wp-gpios = <&gpio 0 0>;
>>       ...
>>     };
>>
>>     eeprom@1 {
>>       wp-gpios = <&gpio 0 0>;
>>       ...
>>     };
>> };
>>
>> I assume there has to be some new glue node between the eeproms and the
>> GPIO controller somewhere ?
>>
>> Thank you for your help !
>>
> 
> No, this is literally how you do it. If you enable HAVE_SHARED_GPIOs and
> DEBUG_GPIO, you should see it being picked up in the kernel log.
Ah, HAVE_SHARED_GPIOS is what I did not have enabled. Is there any 
reason why this is not enabled by default ?

Thank you !
