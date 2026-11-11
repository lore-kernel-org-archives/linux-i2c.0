Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394130;
	b=mMCpF87O3b4UHjsUh8JPZFYl8/+YS+vXz3mAUfj8IeQO80o8eNKn4nmRsEEKnT5EJuEe
	 BF5DVrsPjBdWqzrGF41RfbjLcVdSZetP1tk3w1Ps/3e1ZUuzvn3GpOigOBGjwXkNKxL5L
	 LkNi8p3lDoWdJ4Z81BYyiIY28GMMbyBIM/xq49Ip+4GiEgyhg55ODJYanZJYf6cfL313O
	 7KUPtdmjT/02yBy7gvLoKrJm/kc/lhnwChk+RcHjv7KN6c+/qBoS5UcFl9dKLIrAQfMLF
	 aorFrRjKYTyeRYQVFDmxdDaJ2U/cDU4grpyFyf2eywpYKeAqrNJbtPua6ldW3Yn88eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
	b=vFCOZ4xKqPkTjIES1oGe6fgI78hBI7T9rMP2vT5xdyGlLAywL/VghlWaKJ4ux8nOi8ma
	 sVcc41507K074pHy2IES6IW0LIQwbQiMxpjW41QKAMrf/gurLceEkv6c9Xvyx656KfC+r
	 IJVcJx34XoHHPcKpruI+is9aLtmTkHGK+JVI3Vwqes6uABoUM4DA23yQWcEHwXUFQZXkf
	 PMLbonrOVOsVMTgj9jIV9JLFfUEJwYUPQySc+2hIOwizQLxepKHCfqci2OsMiBHFzQAUI
	 DI1jH8j1fnroZkULdWcR3WLsHORhyFMx/zyRWMOg0e8SZNfy+LeScmn4vgKQL6b0sLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GBKkvpuR;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7804606A32D
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 10:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7804606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GBKkvpuR
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so17556515e9.1
        for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794394128; x=1794998928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
        b=GBKkvpuR5r+JH+yFSCx2MRbxX6k1mn+PDhE0+d7qG4hyFMh2NoIazPozMTmQIzj+JD
         9V8o/DugtUDYfrwFdXFHHxGzNFBYTu7e76oRigVpHZa80NBx+zbfSyUnBxDqxg3KoAOA
         I2K6lq0c9BVy7Cbjw4IwNKTP+XHg7DTaHTxQbG5Nh6/cbrNOti3bTUOFGssN6RfM71le
         ijhIsPf9Un9wqeCXlb5W6zgWPLYabiBOKuih/2tp/XV9plgnBLPIiy+2ydMVk2wWH3eO
         jqtcIRFucEU87Lf0iApwLllYGg7Jt9b4puTC3EpxpXWCSs10ncEoku0H26XlqImr5k37
         xJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394128; x=1794998928;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
        b=TCFew8/KvxC8kqB2BZ124Yp8fnDC/tKvrjxj8aaFi8tMdG5FQXt3nnN6/tCUWf0Ya3
         hdKtldXzlcHX8Mu5J4UeNjP08b2sih51V6cJp02+PTcJCKO0Q/sssYn2PTekC7FiQhjx
         oiUBFVJJDhrFgCtQSS3TJq9+pbw1q21va+d+YPME5UdyNlSkXQ/umXHW+hQsWM+NCua5
         8dbGYD3jgeg9CslhV8oRsXw+ECL2wMjGH9Ff5WU5FLGc5c2RgqkEwdJec3KKuYyXB4p7
         LOXDsQL7xfuePL8G4QMhNaFhVcrarBuRDS0BlHRh0Ckdv42auWAgRv/McJ81XPrrfVof
         egMg==
X-Forwarded-Encrypted: i=1; AL+hErEawn9ARCjsJDkz9frcv59M6dJuc7qKpazzBgo+Sn9aC1LmFW+ICRDTSfLH9eYn01F5fu7/YzX8FZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xO/yTRP/M0AFVNEOeoElr+jtdpeTNPYUqhg6SNfkIqkX5krQ3
	HNpHVzt/NOfPeZeYeNK6xxM7HGcCDju+6VzhPZ1477GeoyqtnGeY7lFWbu8gHfBAejY=
X-Gm-Gg: AYBFou2EiV93wixY/2o1ISGwwULXrQ6+t1zbGhXDkyi6xySLjwjIq0YOj6IlcQJXMuZ
	OnD6WcvVNSDK3SxgdTg5vBWs+uxWYF4GB3NVFC5QbHkga4z0rce6umNFN3SzLVJv+e1Gte2um5G
	U/7eNps7E0e4bsCaIXp298/T5eM1GQEoNouKCK9kWCTJQIDKoQab1BPabkDjvthme4EUV6/Jspt
	TvL9FNel2d1amiWlLsNvpyfQ2CXUoKTZXPayYYvdEXlsCodm7ir8J1CPfHDOniMljBUtxt0Dwv4
	8MQ2Z6MTxdvoVlaBNz0DmU7lenHFp9re7F/Seto7ftW8qycS5uOJDaLmaVVoDkvb+ZXIsuIiave
	FoLPP6WQJOeNo8HvbFHCe7X+f1L2iMHMyxInMs9n9tgW4c/v6kN0n3bcm3MD2f7rezcdydFmRgt
	lPgBk/+942h4pghimhyNj6mcKJmrjoEmv+WOAo648Sbk52vR6a664SZVkwiAqL2urSAIVA/d+Yn
	sWl4CE7SMuw3LcttUvuAj611tTee1LtBgn3r1Z2oaWfq36Deyb6tKpZrsW54H1rJB9Jadqhakf6
	Pk3tC/S676BQQAi3hxZOoo1RBM4sUtWRqIVBuWkNYCCy4Wj/6Krr04gHfrodZ14JFg==
X-Received: by 2002:a05:600c:1f93:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4ba0938124fmr41926975e9.16.1794394127955;
        Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm54693255e9.3.2026.11.11.02.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Message-ID: <2e392c2b-3fde-42fd-82e0-8130d2de48d2@suse.com>
Date: Wed, 11 Nov 2026 11:48:45 +0100
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
To: Jani Nikula <jani.nikula@linux.intel.com>
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
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
 <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 7:07 PM, Jani Nikula wrote:
> On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>>> moved it to the graveyard section at the end of linux/module.h
>>>>
>>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>>> remove the macro.
>>>>
>>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>>
>>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>>>
>>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>>> and reviews.
>>>
>>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>>> should go through the hwmon tree. Once these changes are in mainline,
>>> I plan to pick up the final patch ("module: Remove obsolete
>>> __MODULE_STRING()").
>>
>> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
>> the final removal in patch 3 on modules-next for 7.5-rc1.
> 
> Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
> from cropping up between now and v7.5-rc1?
If I need to send an earlier pull request for the module loader, I'll
include this patch as well.

-- Petr
