Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032338;
	b=M/YWbDyyJ7ueJLfzNRH1yNglzgaswWF8sY6o75ubN74vbhXJxQrbVorPitqr77FXuOdX
	 ERNM098UNdkbHfXCt/MtkfRCAkoUsNPKkViawd6B5M4+DJcfYVylY8h9VU976HsociIFI
	 NNdU4fVMZim0EcOGodvUf7W4TkUvCiypk/J1MCJj5RbvclVrSItUVSTHz5t/SIMJQ1dPy
	 IkTQdVW/vTe8wcXpGpn9SFqYNFRrxT59t8i3eU7HEbGAmE0xQn1unSZI8Tc/62unlyq3f
	 8kPZ3MxSRhi54LrK4CD2e0xvi+nSUgEQlNTpOQRnDyF3cVx/GK9+gI/spXRcX1hrfRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sT8BXmWr3ZtRZWaM79NQqvkyqTyjCTuzoolorXg8m8g=;
	b=BhZp/nvJOav8rE2U7xwm0oBCGxRclrwgQlA15LJ3IbxAywGBe/LPrkvQpuFPR6WCiTf0
	 yHsPil10ud00xHRJfZK2v7M2addhXhAw2e2yv00sJQd7AVe30Pzs03anRXp3EB+N1fQDI
	 QHeApXcJywaAQygQFh9FQN1Q6CpxDPaaCDzSY8gyAYmCDPgKBhlWSLyyo2yirjdbYCK3y
	 gOtgFw0ahCgndHn7jayyaJ+8GROWdEsUU42xJg8HsTRFkwrjidFxJOk/2Vi0dK+o5bYCc
	 R/sIkWp6ysrcomYbdT44TLu6hPsabMvB5woyMAH9PxJ1nb+N8AreWbJYig0X+CQaGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XlcqI/WD";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350660A380F
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E350660A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlcqI/WD
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-382c3c9671fso1728843eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032337; x=1795637137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sT8BXmWr3ZtRZWaM79NQqvkyqTyjCTuzoolorXg8m8g=;
        b=XlcqI/WDSL40sFhRfuRWgVgFbUDcqd4dc89nkRX5hq+S6M8QdNcniDdhvF5vb59JR9
         +24b2dBI34OdoIn/aYyBvSwB9tz2lynON+qJxamsUAXHpVmYD/3ZKBFhNp3ecyO+jlfH
         yLH7pY8+TH7FTvuT5+ik8N0FN9+di52g35SX1/oNpSBHggxVrH/KYVnpZPxnnGG7tPAK
         ijRQX/dWp/4oznE3o52u/IE1GSe+QjU5+euXF7w4YEyxGh1/eE5NSDL7B9b1dtmhE3RB
         XHUDBQWdTuTfQpILYYqp1x29wahndXSFG4yJo9XWSRArReOv4M9bjUoseDYx8yWpnopP
         7jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032337; x=1795637137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sT8BXmWr3ZtRZWaM79NQqvkyqTyjCTuzoolorXg8m8g=;
        b=BEP0dkaIiVxBBgxBq8rp42RE1Z3chRiITEhUZkM0RyGU2F1RmgkYVDQ/+R/UTy9Kha
         yj/wImWz7beKGpzIa66aRHv+BjGUdv1vEe6upB/ZYb7SPM3pKozj6fDM0u/hxCM0Q/iD
         U09Uub6uwkRZf9128HbfT3gCI5rtaEtQpddeNqSIurQrc9x91cCogw66bFTjI+W8MLoN
         oyzR2HbgizY74VG33TQALYPsv4JRlDzHoP/sT5q7MbKvvdqVYbZ+D48N85Durd3Xzbj5
         /2xHAFzHomRjW5mwq3nHdM679d+Wo2iE72EuRjJMadPlWTKtMd3C+5EIF53Q5ZwpYuBQ
         6aUw==
X-Forwarded-Encrypted: i=1; AL+hErG8E/YynawVDh1kjxXsFyrG5WcR9B0OmL5CmjOHBd2gRKEV6WdmnTFJ3BSJxQo5nJbMZHGJpmDY9Hw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UgbjduRFnYHYmmhs2jNrQjpfCTtIFbJETDLSFwApvgDihYS/2
	ysxsIpOM6/lnd46U9FYHrdiNPk7kl2npY+ByVjzRplam3zCFZGymtACT
X-Gm-Gg: AZFdTZd0/kgAtNrczbWlzumNUxZT9k8KvwBg9r6pKEXE2JQ0kUct+OcHrPBIWh/X+cz
	ycHbZd+p0QzwyYr7m7IpyqERcywBfMEUnKXra1mBZ6h1zidNxRWdDvtVoYoAqDSTS7zCHO74lqC
	6ToUvMr36ScWggT2fcCtA3mH1WuChEOOSPRDJBuQdY9V9DbdtCs3uGte20gtZCYLVxejL1RkqHw
	UwpxCoZ35MSwYKk7lqvHR0PEFMQdusBkYm6KFzpApKvl2DHpZ34C7xmToJSD1z/7ZnUVZ7DlmJx
	btSV7+/DlNC7CtdfKuKQJvmKfN06mqaDi77PtF0qGr3UhOFGqI6FdgpJ31ot3z0266blSVkdTDh
	eGOc5d9FTTQyqyTz1oENCPP36JNgXqSV2MDvVP/TecNVBGRJ9rvmHXM6HdSVcPn/biXXctsHFE8
	bws0k2Qa6ZxXaIaBm5ZSkgBzkj7olJBhhtACxDEj2++sNhA2jWn/zko/lZoRMKjZi4j6xBIvMIF
	Cvdvcv6QpB2/eootrITRbqCjg9OVFfTorsKrVEtfpiPpPRpmf8Dvo78HlUsBSexlEQPffd61tWc
	UuI1ryto08v9q082f6AhO5jFrkGAIY/MtZMG0qIomCNe+PZ8EveZW8msnDjLPC2vgWBgHQOR4LS
	vbCKTozeq+OhmlWMQioSRvEDaldsN
X-Received: by 2002:a05:693c:83d4:10b0:36a:5126:a8aa with SMTP id 5a478bee46e88-38281025978mr3395503eec.27.1795032336889;
        Wed, 18 Nov 2026 12:05:36 -0800 (PST)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm11752204eec.18.2026.11.18.12.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 12:05:36 -0800 (PST)
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
Subject: Re: [PATCH net-next v3 3/3] ptp: ocp: support the WiWi revision 02 Time Card
Date: Wed, 18 Nov 2026 12:05:34 -0800
Message-ID: <20261118-timecard-common-301f823ddd-r3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179502617840.3136.12704245716223038161@kernel.org>
References: <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com> <179502617840.3136.12704245716223038161@kernel.org>
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

Thanks. I have prepared separate common-driver fixes and a WiWi v4 draft.

The common fixes use tbl[i].value for all boards, mask SMA_ENABLE on
frequency readback, report disabled inputs through the None/0 Hz entry,
and correct the common DCF output frequency to 77500 Hz. The selector,
disabled-input and frequency fixes carry Fixes: 09eeb3aecc6c.

The WiWi table also uses 77500 Hz. Its new init replaces unsupported
output selections, including GNSS2, with the connector's default output.
It leaves valid outputs, inputs, directions and neighboring mux fields
alone. The normal sysfs read therefore names a supported signal. If an
unsupported output value appears later outside the driver, the read
returns -EIO; the ABI document describes this instead of adding the
unwritable "unavailable" token.

The removal concern is real at the source level. An EXTTS request can
rearm a channel after detach disables it but before the POSIX clock is
revoked, without assigning a PTP_PF_EXTTS pin. Clearing readiness alone
does not serialize an enable that has already passed the check.

The separate teardown fix uses a mutex shared by timestamp enable and
disable. Detach sets a permanent stopping flag under that mutex, then
disables and synchronizes all timestamp IRQs before unregistering the
clock. New enables return -ENODEV; an enable already in progress must
finish before stopping is published. Disables remain available to the
PTP core. The IRQ handler does not acquire the mutex. This is a common
fix with Fixes: 627366c51145, not a WiWi-only gate change.

A source-derived pthread/MMIO harness reproduces the rearm window with
the old code. The revised code passes late-enable, in-flight-enable and
active-IRQ-drain cases for timestamps and combined PPS/EXTTS requests.
The tests run under ASan/UBSan; DPLL and routing tests also pass, including
negative controls. Both driver objects compile with W=1 and -Werror.
These are software tests with stubbed I/O, not an in-kernel UAF or a
physical removal test. The card is currently reserved for Windows HLK.

I have sent the four common fixes to net as a separate series:
https://lore.kernel.org/r/20261118-timecard-common-301f823ddd-0-ahmadexp@gmail.com

WiWi v4 remains unsent. I will rebase it after the fixes reach
net-next, so the feature series will not duplicate them.

pw-bot: changes-requested
