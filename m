Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853276;
	b=4mLFe/8uiATRQKuD7aZHWAbLL0yb9p1cTxkR1ylC1K/sh2hswpcL45v81VbgGrYpWlv0
	 N/JM9qZy5aLHH2CmpVwIfq4kh3nNqGYiq8JDQ6Ke5I94qbJl3o2E8zPJdE8dUr0mzeZgs
	 cHz+azEMkIj+2lVKV4o/cXiB26i4AMuZxO9xOuL1TvWf9RECAVPNDD6Hga8vdeUsrrX9G
	 9z7NWe2JdbremFI6CSY4T4V0aW+vYrduZK2mVMPVyKp1oViYF3BOA1pAHDkYQnWCj/cSu
	 2IBQS1FZAbdg8wIkji4Zxdq6QzH7iYqu5FjjJSeFD6qGmpT+KCpuA+QzrQVOEtmQckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FuJbvNF0FrPMLXejiqbdViekL7UXyCU2votoGhiD3Qk=;
	b=NFHKg3QHK2H6EaR7T4XQnUIYTZ4SsW4T2z/1btGpGjDHOXnxQjtchwrT+TOdrWF/63Cz
	 dlxbPGtWhQssb4wo6FwY1sBtQabgeNhfF5wx9RXZ/M5FcJbaTwyUre5sNIeFLfDWzo7q/
	 8bi3vl3xrC2CQIJsWUdfluTBk4cQDf27AQwrtlVNspbOJv9IdPFgYf2T5b2QwIUoJsTex
	 zRvYAV9CBHeGXTUW0TAjdF1cjvHXL7wtrkCc7fhiVn+h4BntWwYgwLznUj4ENKB/fNr5P
	 bm3rmo59BSiSRRwKbZAOGVxP9dkhBUUKawHlU34dtD4kT2g8g611u1tFJrIzmjE9DKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3JkZ1RQ;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD9606A88E
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBD9606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v3JkZ1RQ
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1814270b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853275; x=1795458075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuJbvNF0FrPMLXejiqbdViekL7UXyCU2votoGhiD3Qk=;
        b=v3JkZ1RQEG58gy+eqpxPbxT4r2sOGl+3RM02Ofi2whSprgoglF1t5NJzEdx8sfFa6V
         Y/CwvO/WJHi2dcQl7L143L1IovUE6y9/goX7nZbdD6HmXrv71AVVxOLcPGHccKnPvbpw
         g9BsGkaBia1RGG1iffaOjrKO7wzfmlrR0pUWwnQiBAnk7bOtcngrh7hZW4orFLM+GXyh
         oFR7OnXSA1Kyk1Jk8SaztfuO/ien8ulpHEGVKgVjc9S1Eh3vycBMe/pE7M9U6X9TQUTI
         HJ+l5hcSm27NIv9Pf778NMmhtrIdiGGD9nqKGM3QEisGswQ2XaP2JWerPGeh5agfIAlL
         A89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853275; x=1795458075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FuJbvNF0FrPMLXejiqbdViekL7UXyCU2votoGhiD3Qk=;
        b=l39OU08YAD6zhWnyMkjkijMVSljcCkWoopdbOpFPGQXhV8t4n/aehVSHfxWLUYKTb4
         viF7v/IXyLR5zzeG+ltyizonrjxQBG+lA33W/X0fJ8OYveqpEUZe5St83yEFC8wLOe9T
         VleHuSRjNDNJckUXnCJv8+H7CZlnhgK/IpxOzUSZFWGqH6S32/LcLlej2xM2FWajaqeH
         YMTRgBQJs0CwoVaw8uZNE8QFTwtmZIN/de6NvKAlGBV9G/kDk7e1uA1NfYrrbEmeMwwi
         f5U7Yfh+n7u+WPncRHvmz/UYsVwJpChSHVrKd4rJuWuLIPD35V9FeKdsN/eDL4qc7KqN
         qU9A==
X-Forwarded-Encrypted: i=1; AL+hErHuZuCnWLa5ius4ZmQhzghiaEDWGrDkmPyFvcPEpWTRUwkdxa7Ca6u+FCSn0M5ed/oPw3aseDk09vw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XqkDqAjjBJ9+2KeLoFnWCeYSmAgweBWRBcFM0k0geKuWkcFsw
	U8TWn7YF8wUEB4sANZ+nIufpSYYyWx+UOE01pZu+gmN/3HsMI0ybe1sX
X-Gm-Gg: AYBFou258MuUK/leoMiM1rzZwogBHUj2vlmfznDaYr8ZyvxlxxfdU5WrIN2+BjKUAgS
	0UlhJMu8qmysj8MkUnJzmOwY+t8LnhHMBDyNfgUpbQmzeoT1ncu8g6somnuBsJkLaiX47n4+lHG
	vDvEUPdU9F8+w8PEx35mPuCQIY9aik8Jzwqk0oPqBmDhgDC7R7hLPIf6wiOAPvzcsrV7tvb0NAY
	p/sSss7YR5b5MD3865G1z7qWPO6KN6DHsb5AC4Jpknvf92uc3fTw6lVyZvk/PIYe8Yi1wgdB0Qq
	D2tXasa4M31LKhsk0DHHl353bSn7QH72yykHRDr77Bu6y4g4Wf38fcmTM3M6mxz4J2r4l2PRnIo
	o+ejUTCH96KvbqTgYDq1hdfpszjNKShNu92mUO7qAQ9DrmLB41K/fZR93aAeSDusGUhqp23ZFGs
	crdKUinjTwIjczuGUZ81fsBYXtIxpHX+lqThrDWtx5SRRf9iVpdmG3VkBS8cxrjEe1b0ofKgiuL
	s7AzdSf7wps+VAkAZ1WvaQimEltbqPsGc/5MUwu7GTxVB8W7XmuJp5fhAP3n4+ba2Lpev/pQ/ch
	8nQLHRrcBnHpnZkVaaN7JGqyahjmi11aqLWub1vGU9Dhe/JK50sIwZmAxl65oujnfjN5cs7wffc
	MnXDO7gFOKYjrPp3I4flskcLo9VS/Wev4X5B2
X-Received: by 2002:a05:6a21:8cc3:b0:3e2:ad2b:8f69 with SMTP id adf61e73a8af0-3f7a7ec1f78mr9948935637.67.1794853275248;
        Mon, 16 Nov 2026 10:21:15 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde0f3f4c7bsm236378a12.22.2026.11.16.10.21.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:21:13 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Mon, 16 Nov 2026 10:21:10 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-r4-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179456531820.2199510.7014507677375597007@kernel.org>
References: <20261111041904.48916-2-ahmadexp@gmail.com> <179456531820.2199510.7014507677375597007@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 3 is the first consumer of patch 1's flag. It sets
force_32bit_access in the typed platform data for WiWi's XIIC child. Patch
1's proposed commit message now identifies that dependency. Other boards
retain their existing access mode.

v3:
https://lore.kernel.org/r/20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com
