Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375126;
	b=IZfKb7YiiaokhbgJ34KdP/ELuWbW67O7d7W70g1xvTA2M+lI2446MXcy3AbfMQA/oRhg
	 tV2E2+2/5gdMVZFIzHKvyle/ZPdfcNwuzRefQCcVdGfwFgMvMMeqDZsAObjKWAjewV6bu
	 LCdwd2q2cb/WbQdTPWV5ZvMQArWqxspZLSg/HRMnA07/MEIt8tR9/GYvD+ZHSokxRI0wT
	 nT4NXDgyPIchEE7r0szFTk0bcOfv0qWrdBExHO1mzfNsonG3AYTgsiIbT/PVwWPpJyoC7
	 GoBsoOipw5D9S8zsXvdWB0dJ/4N6vozOzL8Wv865qyfjxnbp+oDyPzgCwijD3JpfEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+Uqhop9ybLEnfZjiktNvan2dFW98Stkgcu+CDpZ9vF0=;
	b=MKWlA4Z7pUJQrMS4YosA2Y19enNBaixZBP6QuUTCO9SYx1XTkvXpNtiqoxAr9lTPBivX
	 nkZ+jy0BsE3jUa1EaiNpSCPYYeHYUKbFIrXuxB4t6rC593V0LIrvQ19NoniOFV0VfA+Kb
	 uHrXNg9zJh8w4EN1ioftnqhJXNEA/Z4XSzSmjZammeUraxtZ1JqTsFJYUi8sM1ItJznxI
	 cEUQB7ZFSBl6hjLhEmwu+Dr9AqgzoKv+CngAhwIyDRku8LRIRiKculguaP8Fyml/0+bEG
	 g7aPcN6k8AW8zPHIZ7caoZbWgXsqRgDlW0/H7NmR9rrPJrthVR6H6CIybKXSYe8dYOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTMlfTU8;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88E606A31E
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 19:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B88E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTMlfTU8
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49412eb1474so1572769f8f.3
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795375124; x=1795979924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Uqhop9ybLEnfZjiktNvan2dFW98Stkgcu+CDpZ9vF0=;
        b=kTMlfTU8geprJcn3SJfoU8Olz/H633H5rA98cCtRissMONe5M8J3YEH/E5oj67UV+I
         fLcqmahmop+FsUy6WJEPQ2fHZm0tckySeUiMtBaEDjJ9lXKNqJ2/b2e/egAn6p4g7L2w
         6N7+IMRqEKxPJaDCAnNHiWEBk2RuIc4THzlLdlbNNTmoX/RynpxEboaweYHUdfkbwC6O
         vSUwArT6PYJsO1NFckFoyECFS/ynxv1H1yyQQ/EN2dgjq3Up43KmiFRnGLBBfzLvZnFU
         kv6mO+lpVd/S1w06eivjWMTLr01IllIOwEKyOJ+hXmrvPJVEqj2Z+AlBzTnK9gTvuB/Y
         Bprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375124; x=1795979924;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Uqhop9ybLEnfZjiktNvan2dFW98Stkgcu+CDpZ9vF0=;
        b=N1oXCY3mrDfD/zBwcst53JoPWJHhxg/MhNy4pG8vYFbsbrZ8tm8qHLlAIkR1xLS+1x
         N4H0xc0N92ee0tS16U68BPun7gVnU8kGHX8VsG0ZeGfOxXHbb8kcf3iaj1ECiQlWw70L
         wmaFUEL5oT8uWQV1/uMm8+Druh3fNmBIG9kvnYdpPRymCuBFTr/T3B9nX7NGyN5/RB8X
         LQEPUTgUVTqaIVthwAP8o4csaTqeUSQM3SgMt2Z/Yk0VW229sHgm/i8EEmKaV7Zx7QO1
         41jVXAYibK52dMeyIt9mXoW6PHtl8ZU/A7BLbuQq2ijU+wMWD0gzo9AW0DJK2GYQZKas
         m9tQ==
X-Forwarded-Encrypted: i=1; AL+hErETdoWGh9k6SXJdNHxF/zeWiHlch4EIpLua6OXh4IgjvpbKFkrQm8pxNeot1uD1FaVTuuRGmKuB0Cc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VLG++k2GjT2f9DkmiKlh1kpkVPCI3QC8pK2/Y6p319sGiLKhU
	msmeTwJS5ZvfD1o635iQywFnGZCROBTnEwSNcP82rr/r+b45YdKKdmnD
X-Gm-Gg: AZFdTZdbaa+5o0bjMezT6yVo1UuuMrMgQ97J+eWZB6+mwkMvtYq1Rn1BOqQzm0FKFNK
	0Eaj6+SdPMJcFvRZTq3pBcTaulZY9LAih1/RMoanPVIQqxT9jFK7Ntv90IpqlWg7KR4W44DrYJk
	7Nz0HNbGiocASxIrikn0rROGPYFCEt4Q94uf5i1PVKcWZ5yNOIMt9qfjQ4kASoVIgXvONtFFl35
	YD4rjPhbkso8xsvqakyzkC5RtF6+ijPx1O4IzaCPIgXC9i50MhyRgO0n98nPI1BTaFrfE1QV29I
	adzte187xSWbtvSe5QwjKsFUWUiKgpVfNVNYt0mwVrw/lTw3JWA7BFeDeZaiuXacv3Xix/dtOqc
	x1wp2Ckf0e7lXb41948Luc6wja4oH5KHa+xjbquYuC6a4VxyKvRj1pMBM6GcZsKYwfhIv7IgiBR
	KAx+1ohDoJ6gCcHg5Gw3EIXMq9j0pMDyvci36PvkHIa+xGPMTHqtuXBspXAN9t/gS3FWXVf8NC0
	YcT1MFy+USNpAqNDV7CsBJ0+X/Jzhf0dEpT1yVGROza4gTGiFU4joQfR4+nMvhxcJch4C7P4uej
	VlUeiyVRr8rUWMLu+tAyYS+yWJ0uj1g3P0AfjaAvAmJ1
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb88922a67mr196302675e9.31.1795375124413;
        Sun, 22 Nov 2026 11:18:44 -0800 (PST)
Received: from cachyos-x8664.aetlocal ([2001:bb6:e78e:9100:cdb3:c7ee:74a4:5189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf62f7sm19437148f8f.13.2026.11.22.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:18:44 -0800 (PST)
From: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v5 0/7] riscv: eswin: eic7700: Add support for clocks, resets, pinctrl, HSP bus, I2C and watchdog
Date: Sun, 22 Nov 2026 19:18:42 +0000
Message-ID: <20261122191842.2183685-1-mervynpretorius.oss@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I tried this series on a DeepComputing DC-ROMA RISC-V Mainboard II
(FML13V03). It uses an EIC7702X, i.e. two EIC7700X dies, with 32 GiB.

Setup: v7.4-rc3 (4843f6873f7c) + this series + a minimal local board dts
that includes eic7700.dtsi and eic7700-pinctrl.dtsi and describes die 0
(4 of the 8 harts, uart0, the firmware reserved-memory regions). Boot
chain: OpenSBI v1.3, U-Boot 2024.01, GRUB (EFI); the kernel takes its
memory from the EFI memory map, so it also uses die 1's RAM. Initramfs
only, no storage.

Config: defconfig + PINCTRL_EIC7700, DW_WATCHDOG and RISCV_SBI_V01 (the
firmware's SBI is v1.0, so earlycon=sbi needs the legacy console call).

With clk_ignore_unused, the non-I2C parts of this series probe cleanly:
eic7700-clock, eic7700-reset, pinctrl-eic7700 (with a fixed 3.3 V vrgmii
supply; no pinmux consumers yet), the four dw_wdt instances and the hsp
simple-pm-bus. The console, interrupts, timer and SBI reboot work. I
left the I2C controllers disabled, so patches 5/7 and 6/7 are only
build-tested here, and for patch 3/7 none of the pinmux states in
eic7700-pinctrl.dtsi were exercised. I'm therefore replying with
Tested-by only to patches 1/7, 2/7, 4/7 and 7/7 rather than to this
cover letter.

Without clk_ignore_unused, the board hangs during/after
clk_disable_unused(). That looks like an issue in the already-merged
drivers/clk/eswin/clk-eic7700.c rather than in this series (I don't
have a single-die EIC7700X to see whether it is EIC7702X-specific), so
I'm reporting it separately to linux-clk and the clock driver
maintainers ("clk: eswin: eic7700: EIC7702X hangs when disabling unused
D2D/PVT gates").

One build note on patch 6/7: eic7700.dtsi now references i2c0_pins ..
i2c11_pins, which are defined in eic7700-pinctrl.dtsi. A board dts must
therefore include eic7700-pinctrl.dtsi too (as the P550 dts does),
otherwise dtc fails with:

  ERROR (phandle_references): /soc/i2c@50950000: Reference to non-existent node or label "i2c0_pins"

Is that intended, or should eic7700.dtsi include eic7700-pinctrl.dtsi
itself (or the pinctrl-0 properties move to the board files) so that
the SoC dtsi stays self-contained?

Thanks,
Mervyn Pretorius
