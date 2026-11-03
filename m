Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722429;
	b=uald8pHwthMTozbPXF5V5X/E2Mrw057b4vA+0JpVUN+RRBHLSsgtAFFJxfOk5Z1IToSy
	 V7GzS8Autp0ZYCEHaCQJIDh7lWxtEymFYI7SMlbdyEHvto0IHN90eTZ9lZGOsMCAMye8Y
	 csA82R37S9sivOLd68Ey8LSNXgGzOBlsvMqhZg3v7q96yTFvS9o+LopvFCHdlF0AczaeO
	 ifNCQrdm/e848RXTz+NxCLAHVUHMkCpPTOiwaJ4jrXaCv41pLlu3ap9/Vq2Wr0Bo/ZU9N
	 EFamhCzaVSo1U6fpld1s0OpAbJ5jWdCYN0ca/IxIwe9t8QNL+g4GvLPds2wIY/hU2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
	b=hwr72Jfsi+WzUYKDxC1iPnNq/7IBMfWspd8bzE+doxcWyrEtAsz7WjQSeWHnMKATIJia
	 bi0s/0c0+MkiMR+SyjDzYe3DrxFmnqzSIrRVEQcigv9F93yEsDJPSMSPAJ5pQ5tYUnOPP
	 D7YdhOgVsnmKWu93IB++wL7sTTahSeFgoHoi/tGzXR5M6fFSAf2yAu9hseckCxWmxLCsO
	 hTwyyVpsN6PnqxYrH1zk3UF8rpNvyvFELoIZc0DueDHlAGewUKr6zadGagv3lY6d68lbQ
	 52ol0bf5I/LRziN/mKCRjBTNBrsDI1Cs38QQ70T2Ltd3hMsD3X4sZIcq6g87Vv4Uwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9d4b7Ef;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8C606EEBA
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC8C606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9d4b7Ef
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso48844065e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722428; x=1794327228; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
        b=F9d4b7EfncJF5ES2462x+Zjbhb4TYd33M/P+3Y0mSFXz0xngNNtM0a9BCDpY6aPyFn
         EccfZpdj51j50gsAn5T7iZGoF2czsnhL/CgXIRFFxaUQJ8AIy8hcQrohqa7xZ4IiyqZS
         4NOjesdM1xKIaKZRE1G5Cns2zp+BR0b0zP6LwIF7DN0YiH5hclwDOhZw1f7cUwtj1DvR
         d7GpzilbGp54raXH9QSRZdvcbKUMIbHdXFLMJKGuUnVlJj4pW78JqPgHT7fWZtj6D4e2
         +qENEHrrgxujIH3GBfoqRlRVbsXxPpJBnVFJ9CMZRaPj6XSd+FYZJhscJXOpj2oYJg8x
         0GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722428; x=1794327228;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
        b=tw3SEat/Hoyeyss9ypsE8Yh9AxzZ+W31iBNTc/pVXLHm1IKIcCUbQo+nkU5NQzwR+W
         sDDsU5P4LRrv+DrBW3IhZgKS76hhT73Huw8uVvd+NEk7uTrfXN131+4GyV3m6SChCWxA
         Hm3cxjojgTYW4tViutTYvvpgRY/E7HRAOf3AKbQkqT3erb8Kk7GC6aPlGI66brE4v/ky
         O9BC5wU+QSQOaP0pwPyum+7YOZE4KhIyzNkXryShc0WcF38JS3sAhZWqzBi/LR6ZSQl/
         PXk01EwlX0eZGDliujzVJpbiJc9AfJZfYPCFLUYTbFV9ofG54We8fu90p4e5l0g6Gaxc
         vbLQ==
X-Forwarded-Encrypted: i=1; AKwUvByvRrhHSCzB7lNlFTf3jH8eGz/SgczANrNHWqT4QRy+YXJlVmfU/GxLbhPMS9fugHSwZV5rL+upDhM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Z/Im/td+uaNE+JfuMMSDqISf5mVbdamgrPi6mvNJ4RvhP1tt+
	OWlOGt5kquimOWq6iB4+Nt+UOoLvZIFgiIa5QyDxtufbBS3Afgdkhkc7
X-Gm-Gg: AYBFou19ldvZ1AhXfHZq7DAEggY7HOMo1VntPUUoYF10pItUXHmE9NTUXt84SJLiG1S
	ZjO051RhjxQUtD7sNF4zm5mPtSOSZUV5WG8/gCCobNrw0lkir3xk95CiG/rzlmJyg5dUFe8ZpB3
	vTrQExkmBrqCMfrcWbKo6uRGukJHgnRCdcbIm2wvgNRVZW998CHthU2FoEGrY5Ooo0g0UduxYrB
	MejaDkuA2U1KJGj3zoYEkde0OgCeHUhncH9oeWYY8HhnXOc2Dn4wJjdKA1v+8quFRHvcV8TNmTy
	LI6mCwgYW68SMnKIjAXstVLJECH8LWtkFNsqfklUNhsOS2MUhuDXo6HYGaH/U6GZFv7BL02y6xV
	rkEHvQI39MK94T0K0WkX2GobAAXze0EN4FxjjaMqm+Q/1o6PoKA0wYiRs4W8ze42cDQmqpF68SY
	HT4CNlChQOZgf3EfXkzghiO0L2glaWa+jZNWUn/ZS18X9Ll+NpbvwplfRJicwvoH4tsNo0YcMNR
	3xvOwmpeATkcHBsOWVCWn/MXnjKdPvuo7IaFlBPWlsaJYTQEfuSRYWk3mnZCV82rr4SdT8Ogdeq
	prfnic/YoNMovjNtswU3U+kBHaKh7RPbcx4Q3GFKdNh4L1ianyds42pDaQxINmZmzqNcSG6rw1m
	NFGVLWzSjJpdzjw==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr306531505e9.13.1793722427449;
        Tue, 03 Nov 2026 08:13:47 -0800 (PST)
Received: from [127.0.1.1] (ppp91-78-241-225.pppoe.mtu-net.ru. [91.78.241.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm24419506f8f.15.2026.11.03.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:13:46 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject:
 Re: [PATCH v3 07/11] watchdog: Add ARM TWD (MPCore private) watchdog driver
In-Reply-To: <004d4007-d049-4257-97e7-bf7f197ae3a8@roeck-us.net>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-7-181bb0d23f4c@gmail.com>
 <004d4007-d049-4257-97e7-bf7f197ae3a8@roeck-us.net>
Date: Wed, 04 Nov 2026 02:13:37 +1000
Message-ID: <179372241749.1222507.6207957568716226558@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

Hi Guenter,

On Mon, Oct 19, 2026 at 06:46:41PM -0700, Guenter Roeck wrote:
> The issues raised by Sashiko will need to be addressed, or you'll need
> to explain why they are non-issues.

Thanks for having a look. All three are real and are fixed in the next
version:

1. cpus_read_lock() in the clock notifier (lock inversion with CPU
   hotplug through cpufreq): the driver no longer takes cpus_read_lock()
   anywhere. The armed state and the rate are published with
   WRITE_ONCE() and applied with on_each_cpu(); a CPU coming online
   meanwhile either sees the new values in its hotplug callback or is
   reached by on_each_cpu().

2. armed set after on_each_cpu() in start, racing with a rate change:
   the flag is now set first, and the start path and the clock notifier
   each have a full barrier between their store and their load, so
   either the watchdog is started with the new rate or the notifier sees
   it armed and reloads it.

3. Watchdog state lost in a deep idle state: a CPU PM notifier sets the
   watchdog of the CPU up again on CPU_PM_EXIT/CPU_PM_ENTER_FAILED when
   the device is active and the watchdog mode bit is gone. It does not
   reload a watchdog that kept running, so idle exits do not count as
   pings.

The earlier Sashiko points (prescaler of a watchdog left running by the
boot loader, rate changes, resume) were handled in v2 and v3.

As the driver is not specific to the Cortina SoC, the next version will
be a standalone patch to you and Wim instead of part of the CS75xx
series. It will be sent after v7.4-rc1.

Fil

