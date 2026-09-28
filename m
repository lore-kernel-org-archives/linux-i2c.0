Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587A37A836
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582850; cv=none; b=A7gQ3NWtQ0AkldVYiSzSGNzjs0jtjcfva3fUKSMsQxOw4z1diQPqSu2IHkxIymM/RQZ/lmbLntzfgTPg9/WN1ZFmw/qlNpwOml36tRmMw7wbnsWJ3zelchjE53Qsc45VpLbIdQ1iU5inRUhmf4JLCvH0Q4eaot5Xohr8hZZ6wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582850; c=relaxed/simple;
	bh=6SS3wLDII9CL3+VdtvdWu53KDF8XqkM0dQUfcoqeyic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ffvcvp0/CfCvpkm5jgzj889xoWLy9q/lw/5vubNTVELiAix022O0Ew1U1OV3h/a4kNOzvOconSYffIqSCDj4BmixnkUieBNqEou3rDDZJeZcYCQu7OIIyhwpWYwGjVvGVN1VjeHa1V+MYD8K6+xG2IGITfzNLsDnnadEf8gAR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC9QzJw2; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC9QzJw2"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1441266f8f.0
        for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790582847; x=1791187647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HaLnAgJpNoIc6NIMaxMVAG6mZELl0cDWbrDLreEJlyQ=;
        b=PC9QzJw2gF6CQsoKIdAB9ID7qv8wKFdvSIa/yaFMJhR63m69Vl1Mk0dy/Nxe5AeezX
         ByNYeWLfJWS/YgHD7Z9u6ge1fPCLXYJx/6yQeACgXPrktAX/gNJCc9ObbMdh0wAdsAGS
         Y/tGA3BI30ePuI/aZOg8n1p23vn0fp5gCS8zP0n/ePHhxh88cXW5WdkwTrb2/NT36zJ/
         HwdfG1dlD3QvLjLkrWuFy0yyExW+i1MA9YF9oZLAMf7Cxy5DBgbyTxMHJ0sP5/cIrvX2
         2LSdBO7usSAMT92J7BhPFgR7VkkIlV9pgyTw1nroMe8JP8L9yO3HXTxUCveTMYN+MhKg
         C4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790582847; x=1791187647;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HaLnAgJpNoIc6NIMaxMVAG6mZELl0cDWbrDLreEJlyQ=;
        b=Tiw95V9Lu3pKU3vzfDp8viXETbex8I7JNPaqsaNxnSzd8orfCrgzWQwJcSaTAZ5uyS
         5npKwaKcyl/nKwkoEvLCbf4L5VpvxU3sdWQs638uv+HLxOqBKX2YdX4ZR8cj+8JTsTUe
         5IpdW2VIyUE9XTK/lzxIWMQUIgrTN+FbKE9bQ0UrHJZ32h071P2dLJUOvP2JjmG4OquI
         BA/UCRcnK8nO9PXnuOpGb991aRxVP40g+v/i0GlLlBPQhH8pXUDWkFZxJ36z+ICFvYzx
         GugUvCKdEhhYLDafv9UBbuyY6mhpeqA+cWHHFd1T6ZOTaA7MKBH8HB3NNtgPm8PRXjWk
         NTKw==
X-Forwarded-Encrypted: i=1; AKwUvBwxUmmWlOmJBidhs9lA7aXanPUkgXojfwdUrjnOOGwFfShvXFCxhHSAkhiIZaPt95gyIRqZDnYpV4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMW9wAYl+nrI4z7iY8Ep/0km2o8k05r4p6Oar5C9z/Eb8mA8e0
	gD3l8pMFdHFSMyfn705IOGFIrqiFdzXj4/VeqGkIszhNP9G0f6RH2qsS
X-Gm-Gg: AYBFou3NLQdHgWEg/+rY2V/A1nDApPIf/7iP2cGe3EV+tuYbV+XEgA/d3eaW2xClLnA
	RkP9lmap9TcRCVeSIvqnTrMbcgW3rZC6+Yc9aZUQCMD6wq+FUCYo62iUZLVwTD009HZ8RcAXPl/
	LwjchwEtktWooMo3d50xrB7ZV13iXuNNUACTn6/M54GBRiAQTQ9JoSKSlMwaR8aKEcz2+LJSJ1n
	KnBgcjv4ZQg2PzT1cclqehg1000cdc87GlUQLpUGZgh7yG9Nh2TGZoVIA5mVywdPPkOn0Z5b3Vh
	62g2fW0KoVT+cZUGCNDXnPMKqfZ8lrraFEZvzCIaWqApzSb1K/PFDX2LQp9zacZokScOq1Rgb2n
	UrMPYHuFiL1Pi0QfvUju/cSu/4ZuJDo2Wsy4Lbrz1QMCUQNaSEMb5W9BL+KZNdLG4ggt/GX82Yo
	P6L8OL1flb1UDj3kEUZO5UQBAczZBDAHhRoTh4CJlkBrrkH0cg2D4GMNiONWBZ/E+152CkwgkmJ
	rB0QgpTk7eF532PNxEykr99qT2FR/toLoAnvqX5joYfDXl5kNYlQ0pTfCGiQuj3FNCvKokjdBXm
	K00okKyKQ2E05lVRHHJGDfY=
X-Received: by 2002:a05:6000:41d8:b0:488:7b80:f2d0 with SMTP id ffacd0b85a97d-4887b80f651mr16491093f8f.52.1790582846655;
        Mon, 28 Sep 2026 01:07:26 -0700 (PDT)
Received: from Asus-P170-Pro-Gaming.. (54007D83.dsl.pool.telekom.hu. [84.0.125.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm26035338f8f.12.2026.09.28.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:07:26 -0700 (PDT)
From: Adamyno <padamyno@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Adamyno <padamyno@gmail.com>,
	Simone Chifari <simone.chifari@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Stefan Schaeckeler <schaecsn@gmx.net>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
Date: Mon, 28 Sep 2026 10:06:26 +0200
Message-ID: <20260928080640.550879-1-padamyno@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728122423.358416-2-simone.chifari@gmail.com>
References: <20260728122423.358416-2-simone.chifari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Simone, Andi,

I tested this driver end-to-end on real hardware. Code as published at
https://github.com/systempal/i2c-imc-skylake (matching the v3/v4 series;
the v4 rework did not change anything relevant to this test).

Hardware: ASUS ROG STRIX X299-XE GAMING, Intel Core i9-7980XE (Skylake-X,
PCU function 8086:2085 at 0000:16:1e.5), 8x G.Skill F4-3600C18-16GTZR
(all slots populated), Linux Mint 22, kernel 7.0.0-30-generic.

Results:

- Both adapters register: "iMC SMBus Skylake-X channel 0/1" as
  /dev/i2c-1 and /dev/i2c-2.
- All eight ee1004 SPD EEPROM clients instantiate at 0x36/0x37 and
  0x50-0x53 on both channels; the sysfs eeprom dumps are correct
  (byte 0 = 0x23, JEDEC manufacturer G.Skill).
- SMBCNTL at the 16:00.0 iMC channel function reads 0x00000000
  (TSOD_POLL_EN clear), so the TSOD-polling check passes. On this BIOS
  allow_unsafe_access=1 is required ("firmware/SMM arbitration is
  unknown").
- Through the driver's adapters, OpenRGB's ENE SMBus DRAM detector finds
  all eight RGB controllers at SMBus addresses 0x70-0x73 (four per
  channel), and every mode (Static, Direct per-LED, Breathing, Flashing,
  Spectrum Cycle, Rainbow, Chase, Random Flicker) works end-to-end.
  This is the first working Linux RAM-RGB path on this platform.

One observation that may be worth adding to the driver documentation:
the RGB controller ICs on G.Skill Trident Z RGB DIMMs answer at SMBus
addresses 0x70-0x73 on this bus (4 per channel), not the 0x39-0x3D
range that older OpenRGB-era documentation assumed.

Tested-by: Adamyno <padamyno@gmail.com>

Thanks,
Adamyno
