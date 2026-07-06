Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91A2E0925
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313006; cv=none; b=i5Hn24mJsgxfzjmpEx8bTyS4ZfTg+8/JLkB64OIwg4O9FnTra0t2pZ/qHCOSCTddCqH/0vo8z2U8MlV5vyoNX441fndsi8avxO81E8YnDMOISijC8XA1nXeDsXv3wzeB8BxUA5aZ4h4x5tiyEO6a8RmuAtycUezLsyuaP/If/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313006; c=relaxed/simple;
	bh=c+8EKR3Otyj6HpRPZPLDgVtXgi2Sp1PAwFK91ak5sZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dfmmt78BojuYlskvHH+bhdLgOw6moemg65w90x5xVdpYAd5AcHcwWk2guKLLUhoe42tYCfT5o0wFdq3eVEVBwOTLuhUUwGtsY6EOSiOY5z54sj/BEbGAlayJBIGWa7xEW6UljyYTR0LNiE+GDeuvTuNbzabcbUQkHwpAdV+Itvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=H0Wrehoi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="H0Wrehoi"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso2518522a91.2
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 21:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783313004; x=1783917804; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHFPiq3D6uqaQ62rMY/8KRhnoypYDUWFWdRiE5lsj8o=;
        b=H0Wrehoinlhuj/x5t2p7zBCaghnGX3D9rq6GhDWxacgeEXHvuMc3aeYFRNFeU9lGsl
         g7FUfiKocx5f2pJXA8OSRLgxX/UK9kckQc1XfCM7Q4t0Dtcdw3sU6z2gsJG072m9VHUD
         1i8bKxOAHOyGKRYamIgMVsvYh1szJ0plwHkblPCuW8ykj41Cp1qmnbZXnRB9JrdsewJy
         mDVuQyq2WKsujvL98n+7D/BhvvSo48wnl5hbElwsX7Y27YwreoXah3cmfN5ieciwO2lB
         5bOlDktBR+j7I1KXqs2OJlcfxwN2fmv9WqY8Db2a0FsLwEIMgKUd4Dp8XnpY6m66B/+Q
         Lz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783313004; x=1783917804;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHFPiq3D6uqaQ62rMY/8KRhnoypYDUWFWdRiE5lsj8o=;
        b=aYLVCdaw+LOyGiLdxc4UcgPciBbHnW6M5EKXbGqDeYHvlLeqb8zc5v+E+cGC3XgN6Y
         Ip/vT3FBGjtOimy5kJDBSLQr5v04NwENngQA4I6dqr2oa3C/muGLdVyL9tK8piYUqF9d
         cu6RLZiWVrCwlCO7ooPa/jEEVsip9tq2shbgsth/bX6IyqdMUvZIsmfcy6oMAIjB2neQ
         vb/Y4Nw4F3FMR0El1Aby/sBe1lVqH1lT8xxDkBS62c0HZCe6vPwes0Is0Qslo8J3UQl1
         js+eAF7dfDgARVpwj5jpk4B+Z2n8VBw0Iv1Om7fraogRk54wGDjMzujMNQ4YkBkNe1rf
         KD3g==
X-Forwarded-Encrypted: i=1; AHgh+RriUYJtOTifymZidw3i1y3eS2g8JzLZKL7/5UP0fbiPQfaqiy9GBLQnOehdFd7ks9XDRLop6ydvCcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nNusL2zCZom467h3Dd5WAfxZVgAPF6GNHd7FJysUjSC6C4jw
	soyV3CoQ6bxHIJoaTzUryk8ZzNggBBU1Mkof7Nq1hEOqrge16bEKcKOiDUu63DDGyEY=
X-Gm-Gg: AfdE7ckp+pWtp+JJUKct5JPEy/u9dkl7VARL+t79AiJFu/0opoe2fi8i6+5QwJKwQxV
	Xhili6YjyLKgpEjTOiWWd5bp4NVQGqKvORgFdvkCkVjJK0jGKlaFrAg+WJjzySAAbhsm1lJHCSL
	PPVODMmBmhnCvEYLSkukt43BW+WdBqzBWfkDxHfMS4+cpYslVov/rxIxeMYuEDPqD8ex/VTWK3H
	/kGjJaJIXc1rSdIkVmrW9f6WpiuNubXnNDIQw2DOTZhXwdkFJgpDx+SbyGnXHZpM8uy88UBwM/a
	CS2zRut9jlpsG1DdtXvr+WY45FRR1SrEFzGbg+TNIZ/5jzuDnA5ICvMVh1nHN9bYUXQx3ereKEo
	pdfEFpaKkT7vAdgyZZtZ4OnuG+PS2OWbJDNP6ia0M8eb4fV88I9j2TkRjoTXPrVM5SKitDPF7zN
	0zuTAEAYamb0xH9DLbawLGG6x6tSXcqhI2FwG/KhU7+XKU4ikMYTIlQUIV4w==
X-Received: by 2002:a17:90b:4c0d:b0:384:d509:7274 with SMTP id 98e67ed59e1d1-384d5098a0dmr5007171a91.15.1783313004532;
        Sun, 05 Jul 2026 21:43:24 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f376bf710sm28317477eec.6.2026.07.05.21.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 22:45:25 -0600
Message-Id: <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
Cc: "Jean Delvare" <jdelvare@suse.com>, "Stephen Horvath"
 <s.horvath@outlook.com.au>, "Brigham Campbell" <me@brighamcampbell.com>,
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>

On Sun Jul 5, 2026 at 12:10 PM MDT, Wolfram Sang wrote:
> We need help, especially with tests, for the next release. To make this
> visible, document the planned items and explain where and how people can
> participate.

> +[.] make i2c-tools accept bus paths (Brigham Campbell)
> +	[x] patches available: https://lore.kernel.org/r/20260530-accept-device=
-path-v3-0-20c01b8f6726@brighamcampbell.com
> +	[ ] reviews and tests needed, please help

Noticed a minor conflict after rebasing onto master, so I rolled a v4:
https://lore.kernel.org/r/20260705-accept-device-path-v4-0-c62caa708a9e@bri=
ghamcampbell.com

This latest revision includes no functional changes from v3.

> +[.] add DDR5 support to decode-dimms (Stephen Horvath)
> +	[x] patches available: https://lore.kernel.org/r/20260629-ddr5-v3-0-07f=
45075a51a@outlook.com.au
> +	[ ] reviews and tests needed, please help

Stephen, it looks like your series applies cleanly on top of my v4. I'm
not familiar with decode-dimms, but I do have a laptop with DDR5 memory.
If you can provide some instructions for testing, I'd be happy to
exercise this new code and report back.

In case it's relevant, here's the output of `i2cdetect -l` on my system:

```
i2c-0	i2c       	Synopsys DesignWare I2C adapter 	I2C adapter
i2c-1	i2c       	Synopsys DesignWare I2C adapter 	I2C adapter
i2c-2	i2c       	i915 gmbus dpa                  	I2C adapter
i2c-3	i2c       	i915 gmbus dpb                  	I2C adapter
i2c-4	i2c       	i915 gmbus dpc                  	I2C adapter
i2c-5	i2c       	i915 gmbus dpd                  	I2C adapter
i2c-6	i2c       	i915 gmbus dpe                  	I2C adapter
i2c-7	i2c       	i915 gmbus tc1                  	I2C adapter
i2c-8	i2c       	i915 gmbus tc2                  	I2C adapter
i2c-9	i2c       	i915 gmbus tc3                  	I2C adapter
i2c-10	i2c       	i915 gmbus tc4                  	I2C adapter
i2c-11	i2c       	AUX A/DDI A/PHY A               	I2C adapter
i2c-12	i2c       	AUX USBC1/DDI TC1/PHY TC1       	I2C adapter
i2c-13	i2c       	AUX USBC2/DDI TC2/PHY TC2       	I2C adapter
i2c-14	i2c       	AUX USBC3/DDI TC3/PHY TC3       	I2C adapter
i2c-15	smbus     	SMBus I801 adapter at 0000:00:1f.4	SMBus adapter
i2c-16	i2c       	usbio-i2c.0                     	I2C adapter
i2c-17	i2c       	usbio-i2c.1                     	I2C adapter
```

Thanks,
Brigham
