Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239513;
	b=R5Q1GOX63J3cjL3zyGSXMWusOrw2RO73WB6rmIVLTfdYQdByBsKsXiGvBzillBEblNns
	 D8RyDYF9TJtf67Dwq1BzmXVRUcGh90AfKUII3R+L1V1A2SXp7w3guYysAA4uSnNsvUx0D
	 tKp2v+cLMryxuAADgqWdxSJ+0g0kGfXqNac1S9+9BjAJtpUtmu1kCz7L4Zakmq1zEmb4r
	 x6y/c7aFmv6e8y6sbgcDabHJ3QREslzmoj8GEK5VXBehEdt1S7Apx43TkkCTxfOzdY9TL
	 OGmFIUsv3Z7fvMurIxekiCPlfGt49+II02QD6+U6U4cq3Y37BDB8tPHl/V/m6C9Yo0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Cc:References:
	 Content-Language:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=1NQGZnmFn94gYbVdzg7q294E5UOJ6vT9dW2mEWVVv8Tm1s9kRwkHKYUPtBKWc+zOfs+B
	 QfrxpePjmQ7n28NBQQnDgke9ZsXYTdR2+LAL03bhIDu5f2eXNVwLpkpU5xAZ7c0/oW2Mh
	 83eO/z2+qCVgaJ/Q8+ky+j4oj4gPobpT5ONOFt/BjcnToolJhYvCXXAgtR9zHH9yO+muX
	 jBPQlm/IDrncG1a1mQVLQX9rM2RhDCEPcTP2ZBsi4oEQAemU59BJxbOomqOnPS1wU74hE
	 oxJchIGXmIA8Oihc1ffV9FgS+joFVDygGAGdujLY4uc1haoEjVkdUr97tDK+2a0MDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABE606A331
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5ABE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so674589f8f.3
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794239511; x=1794844311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=I6Gf+TJ+xx28C6M6wGa7IriJIxP64CATq5xKa5KY4/dVEF70L68u8oNbC3qDhkhEI7
         7ia14iP5TbkPq0pUWtgTMNnR57unFzAtVelBZ6VlJdQ4CrgVYgxw4RobiXpnUn7hkB+D
         nzTyACD0+MFjBaqWPAWXlFUgKFrj/LJmZ6fQQvFA0wYX9Z+YdDx7xP/wSzXM8J7jhI3Y
         cnv1opUi8bNDC5CGiUC5RyhE5sufSwg94ps4g0+w/MIT3GHEM+nHtCTD6yBD+zcjVMzC
         KM6SnUFC/LBhWAJoh5/3RAr1pEMN+dTTDdPPEWzL92kIaF0QNP3pX9QYFDhi6xIlcLq5
         xWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239511; x=1794844311;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=a1z75xHzg+KgqMUv2dl4pJYJ5nLPr4GLlMkb3iYj1owcofNt0/7YphadI6JQmKcBTr
         OeuFm9CyW+1OyNUl90Vgw8Fwexm9ali7NyS+dUY1V9K2PvohC4YQpu6Y/agMqamFV8ws
         ys1gZ2EvHvF5eC4hR9bE2PgGPXqUAejZVyokb5eSY4Uus13riNqZeTdryOYJneodhyhi
         ICke99XUyxMEmBbyQ0/0BJ+T/pyjJvemjNqH+JQeO1xadoe8OtJmjOwvdctELSbxq4f5
         sw9v23+0M6umr2CKThcrOzqCn0QHqaTKbmNDwHcQNuHro0sglKjehjF84qkmGRqdaFiz
         MhKQ==
X-Forwarded-Encrypted: i=1; AL+hErH81h88wGp1yt140Okw3JXPMjyt49LGNr0qno8cQExVN2Crsjt/VdGzMr5c9WofeTbwOTW5Jo9ACo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ohBNxz4etMD5KfDO9rb1nvw+h3U8AZPPIS5bKYukHrxQfTv25
	GTdayGtmBneZqgCn/mEaNvKSAIZplWrXWqmCWYYQf+0W7hzos4XPPyCJpLDk5tYyWNU=
X-Gm-Gg: AYBFou2N9/fmniKmmsjTAfAe7OwL56Zs8SMmT5fRmPNlBu+fLkNdxNQFiOZ1vaaxPZ6
	oRUn1ipg8VdzTaBJFXoLq3jg9Nrm2e5je33YZO4Hy4Y9mXwnrEhMzV/gzEGnVQeug9gzZuUE8Pj
	obEHJ8UxMqp5Q4mo1BFkO4cYi714EEI+meVdxYqiemL7//UIQinbYEkDFl4rIJVEtCZ9ImnVSEC
	/ArbukldXpbQTVVocOfHkmL5SZnZnN3UPyl/4m9BfTl0dvCruLsnqaKIoREPNHJAeoVreixjGtC
	T1ftyYWydkg7KH17lcB/ohqppwGKteoi4G0AF0dQEHj97LyqSW4YTWuESaO/HRacHB6Sh2PZwDx
	K7iaElo/T2VJjD5WD4RJJiNquGAWzfia5Yi28HX6S0lsuelQLFRUt3qbaQ5mq1vB27TSE+Ux6Zu
	7F302pTSPjikXRX0VX5WE84IsVrKP7efzrC0SiCAp8RyUlU+zG5dxN70TU/1up/EnSltCAw8iY+
	7j3PpbisA8tUfH8rRfHt5pJFGd3IoUSuLA9NWbRUBNew00Ai0dupn5aS7qphUuF3j796BGqvsoG
	QwFtukxyK4bpV44CVMz4+SGjKU8UKb8BHkMznv5NCjs5v81r7+3ef0JPN2AzjkRo
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204;
        Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
