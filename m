Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D453ECFC
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079177; cv=none; b=kZBS/giVVQ9kOTIefVBvLBwzjqRbkkD49gDUkhwLuBnEyRM3Qa7/bnAHJMfEjWjxV17RI1HVF/a9f0bQV0jYkY2mzrutPPfiGLaXQ8N1cNzi8Q3ko6rEb2J3QCFGKpzP2d6bTqmfbzLn9iCVE/ST3ahq9/eCi/JRuakyHIxt+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079177; c=relaxed/simple;
	bh=rFtM7Y/4hLz4QUzVQrWr8hZpi5xC8pCu87wXIa+Qv9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBL9ubnCC+kbEAVuXZhvYDwvRcOfVvQGXH0spMo6u51TNgxiaInLa72SVmave9VjCqUy6ShFf/Dg8EitHPk9LlMpjEvXeJW3M6WvPWP+5U8rcHVih535gjK9gMtyYAsntuXLmYZNQobRJ6PQ4q9LzW8y5POJHCIe0o+V+xIeus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKwgBvV/; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKwgBvV/"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ab17a156so161867a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079175; x=1790683975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFtM7Y/4hLz4QUzVQrWr8hZpi5xC8pCu87wXIa+Qv9U=;
        b=PKwgBvV/eCibDTYKGd/9k780slqUN1qZ2/60FDez3ZAiiv94EFoR11P/kv1y7w7wCb
         vwNwkwYgXj3noI1MWXCDFcM+NdOgBRbJsgDaSyMbr/vVtNZ8Nsy76MBucpYi8vwG5AGW
         6vhkgfOw6/5o7C+LHSwD4AdKHgIZPtGzay1rP6OIYs8UK4as1bzKqFnr8t5wP6+8Br58
         Wd5hQoyj4ME+6fiWS4qMr5K03zzbtEgzKQg05EN402BH05BQ70HIWu96Tmv+JJxsw/fW
         Ov6uny3LeWmy/w2N63icdRQEagL8In46hV636msMDV/CqCS79MQuGYhar/woQZj3fliq
         0Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079175; x=1790683975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFtM7Y/4hLz4QUzVQrWr8hZpi5xC8pCu87wXIa+Qv9U=;
        b=KGlQJGNokOLNZej39ma58dvLHVGT/orzUx0CIa4xPrDVo41wR3F9DLBzth6dFyhhMf
         VS5bMDWtcNFwDJsMLXyxap1G6mATVVbr2jgdEWiDCcgMZr5m+jveikqU5kDCeApLmbCT
         aDZzzmU//7rJSJR2c5g3LPkuNqAslJl4lVMQUX+2XKbcl0hOR54fWzyombWJ21Ti+rbK
         pCFHO/wPIvBeZ29A3KFXBr9W04FzCdaqkrEDG+H6VD5EUx6acSuaJ6Tp3wKaXpt3PTdZ
         A9V5gzsgI8kYwaDmeosKPxW13idgg5EVS76e9Xgd87EPiOCeIheLNd6l9hCV4uGa/nBl
         62zg==
X-Forwarded-Encrypted: i=1; AKwUvBzwCEi0nQML6J7Q4z9ehDLk3bSwvORhsWoJN+S3qeAUSTLwDUwe80j8AUACRkVWnJWGsFyMcqZ8FdA=@vger.kernel.org
X-Gm-Message-State: AFuF++kalVfUy8VHMo5TZ1BU5DTrHhhyDHphplQu+E39O6ND9so64XJu
	23R49I2VEKMTJceL4MhYxD/P1dVOh9R6sKgFn5SdUXBE0p7mGMxVqPUs
X-Gm-Gg: AYBFou3+tQ7gObSXEQS9Jh/4aqW/IMsI5B9OrVx6Lyu4ni/P1uEGJ8amF4A7SzKdn0p
	ndyxEXr2KoQNE2gEFQ+6QFC1TdkQ0CauEgfVIU/aLKg8cvbwAeOu0A/I75kHXK1vi1s/OcK5iNS
	IsRvYemxN9EvTEMF6BnKsyWRxR4NE1VW/5D9lwqXvNPGyV2EZ3iY2EtLVxu7tokJlwevsWrso/h
	emiJw6rAju7g3XDVNYGImJW5uDlU7WRjMh1lGmtKfwP+GR3ooMuqeiyT7KlinA9nZP6VK5ik1gb
	CTgUTsUkehzSIeEqpio00205Xl3/6VYOs8UMmXIjmmQzpmYawNRZ4PL06s3sMMdqxmeW9QdaNe9
	GTZlmvOPifdytGcLdH9VnrrFuNJ4OGeCFEWBIdaT1oQMGK+VBkWbFhPjDcTOEqriEBcvxDsxPaQ
	rc0u5HANQzDR0sJvfHkW8WEXdiSkMpvZIEONJGPQQ8NQm925cJeDlDDH5Ragosy9kBdjaluckxO
	pQJs+cqb8nQr3nBWLuo8kUFFdBrjpbqnZl6ofP83F8iGy+zdJJG2Ys7AxKBe2UZxmSB8Docy8vS
	PA6lq6wV47l+Kqrp1edvCZQcACDugA==
X-Received: by 2002:a17:90b:4e8e:b0:39e:3728:3b11 with SMTP id 98e67ed59e1d1-3a0732ba084mr1605467a91.3.1790079175243;
        Tue, 22 Sep 2026 05:12:55 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129a33esm5771625eec.14.2026.09.22.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:12:54 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Tue, 22 Sep 2026 17:42:49 +0530
Message-ID: <20260922121249.46057-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arJRC4Ou1LSAMGTs@ashevche-desk.local>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com> <arJRC4Ou1LSAMGTs@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 22, 2026 at 12:57:31PM +0300, Andy Shevchenko wrote:
> Nobody will go with 0 in cpu_dma_latency. It basically kills the idea of CPU
> power states.

Agreed, and the patch does not ask anyone to. Holding it at 0 was how I
measured where the added latency comes from. Mika raised the same point and
there is more detail in that subthread:

https://lore.kernel.org/all/20260921170456.53354-1-navonjohnlukose@gmail.com/

> If you need a dynamic run-time PM QoS, patch the HID subsystem to
> make those when they want to heavily communicate with the HW.

A QoS request would bound the latency, AFAIK. It would not change that the
controller raises RX_FULL once per received byte, which is what this patch
is about, so I do not think one blocks the other.

> There is also the issue of the interrupt locality.

I am not sure what the i2c driver can do about that. What did you have in
mind?

Worth noting i2c_dw_configure_mode() sets TX_TL to half the FIFO and
RX_TL to 0 on adjacent lines, so a transmit interrupt moves up to half a
FIFO and a receive interrupt moves one byte, which is what this patch
changes.
