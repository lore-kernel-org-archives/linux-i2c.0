Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853245;
	b=okfSDspcN8xDgafwOOSZMTWIAuMXqOr3ojfRJ7YOhu45NGYipn/MWx8VJGCiIv7gNZr9
	 CYirvzKpomv7ne7N2S8ZvyOE0KP/9J2yFMUdUx5R0JnlNLHmJvnU1F/38tHsSnVPQ6uFH
	 KZi8mqMlKqPHErcMU4PU4oUWgy2Vx144PsTwkj6cFYhf+taExeJwZgjTcW1Zu3OdmXy9V
	 orAd84TCWRKetYGSZVaoF2Uv9ONuQkkaj8AtKrNm6vzmi4ZHASLEVqI0mM4SmHXLrx2t4
	 V1mo2aHbdZMIVe6/UHNAVcm4LS3ST/u7Zr5JukHcgXcz7YaZ4i7BPfOh4wpKU2OU+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=focnNfHFlWYzCF1G01fF7j20QFYjF7BQNefzQKj/yZ4=;
	b=FL784SGP2RNNZq1Vh69yp03chFZx2icFbMEjVaq9iqtAziLF2dbB2g49h2Vo7x50zKn9
	 FuczlH7zND/3IlAWdud60LU5/7sOgZLiTU1PAWCYyiZolhAzSFb1TGiA0b8qq3bYZqn3m
	 cwm1U04o3rbnQNTBTASsVTHGA3pFzOlXk0bYH+eqwQnA75Cc6ltYkMO0xwOcc68NmsBKy
	 zKRvAm0ZahBHHJR79rDllevmQHWVmkyP8KEvddd+gOhNzevaXOoek/mXYp/lK64ETykm0
	 GwMxQwYOsRpyqAAsO5YoVFWLMvLHQe9W5TgYcjsav+o5f+LuCm+ffoa+5dm2+UYpJyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbE+QY5R;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F08606A31C
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbE+QY5R
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05b210703so1623247b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853244; x=1795458044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=focnNfHFlWYzCF1G01fF7j20QFYjF7BQNefzQKj/yZ4=;
        b=PbE+QY5R3gAv+sYo3vO4FqrcWA9jOXrUvOcbmg9EYAQynHF4FO7hCLYUhuIvMqadF8
         n2g8wQW9PGrmSRIqRKSlWRCwU9OoiZ1WFo++fTlqbVNUvLJwEwx1K6Ec3T58rSnd6LhS
         TWG9QtNKzuv2Rd9E/lbY/BxvhPvaYEWA9eFYiNTguVtNeSVYuG8I7Rn0ZNYJWGjKvpWN
         ksZEDD+cE+0kEK8U9PIS7UMsN1O/fQUvVA3MfWAUsOwn0eX87opkU3vbGgpOjuo9Gs8b
         DxH8zh84SZrnFgeon4dUM4JOVmi/xnOFfYLml5SK/qrSvStAG6rqhgK+X4bc3rHdK+7A
         jFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853244; x=1795458044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=focnNfHFlWYzCF1G01fF7j20QFYjF7BQNefzQKj/yZ4=;
        b=G0D17n6HRe9d9CmPMrH3Xi9zmTImOdetCXDiaWdOnhxbaK9WFs7BekiPmjAttciE4w
         I0XNRTnKGrxUBCdjXCU31z38BnbGqr3IRFsMAkZP+D/bV+KzxP/OdMT5UfwF6vEbYpKT
         hKLZrCDSCFPYEuBFQ4e2PyMDyp1K28LbZtFMVaYPo0unMxn12yrRPxRRlSOk+RcgT+fr
         phESYZqa2w1w8gtqw+xUOGvZkRjHvUiepkaTJJDUBgoe6sUKkZYE2sGuubyvscohrxO1
         0Z2qWA9AGWOu+wPbNy+HlDXosjCFvTmpngKfCY3skcOyCOLbhY3AE3us0mlYYB93xqyl
         6PIQ==
X-Forwarded-Encrypted: i=1; AL+hErGiQJ4grDOQ516R8jfBfORR3w+NeSIFdzk0qk1c1izkNIdW59juGjhjYSvGSHjQMOErDQ1g8Xp2nIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BzMKY1JQEFAx0Azac8Qn8ilZxe1/p9tu0quhA7jmd0F8xnz44
	3s9CE0PGMeeIbya6mLvSHDS7WwtAIiVR/rzJ3/ladUpHhXLzeMVRc3Ih
X-Gm-Gg: AZFdTZfxC2xlFUtwdQk6biBKT32CSsnp5TqJfLhA83MYU7uPpgKm6SDnT73H7ci67dk
	uYJYvZePGJAygOUOIVEQTUpmmcy5EgLP1h+TLHGNKUtCQTXdgEr9w3Bg4RsNaQEft1dFDWFPphS
	kJk1cVhETPlfqrTCmpHewfJ/ChAyG8Shrvah4h4IJ1c+Evqh+fUqH+rv0U4Mc98x2QADLX2Cj8v
	E/ZGazz306rIACGZQUpRTMSP51LY0AL73qRNIgsWUu25vgDyOx4pRBuCgf5HxKmI0Va09QplWnD
	a7NXYNyHUZu1NqIvUfRJ8NtSjbtD5Bz563T7GB/qJWe4RoqxORdaDADUTpT8nWvf851xjpRT8/z
	jL96cPiDtfHlEkYpWJWALmqlCGyKdJyqU+25QOniA6K4tKMwr0UR3RQ1EJjYpHVV8Jnt7/D7z0f
	055r4embe1r71a6kFZGJ6tzxFNCQXRWMWDUz2m2H7+CMNlgKd/bh58KNb+x53ituOWGJs1QXa+E
	psK2n30LxDQaAFogod/IO1/J+5hO89E4L0uaxDMH06TcqxUGoZl55nd7Oc5ZcL6w/7aQVej55HV
	LANGyprVza/3XCX46oKdsQRbI6kgrN/jdWli8JWXKXDs2Jg9kZs5XSrmycNcimrTXm+IuoBTKVH
	rmqKE6Iz9mTAtb9MY/y7Q2w4GWfjmkS0DAZmW
X-Received: by 2002:a17:903:4b0e:b0:2ed:4c7a:31e4 with SMTP id d9443c01a7336-2ee0d65e7a6mr107391405ad.1.1794853244283;
        Mon, 16 Nov 2026 10:20:44 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76db8acsm3076325ad.11.2026.11.16.10.20.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:20:41 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michal.simek@amd.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Mon, 16 Nov 2026 10:20:38 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-r1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179484681740.3136.17781028072212776292@kernel.org>
References: <20261112163333.12523-3-ahmadexp@gmail.com> <179484681740.3136.17781028072212776292@kernel.org>
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

Agreed. A RAM buffer is not a portable MMIO mapping. The proposed v3
enables the RAM-backed test only on X86_64 with neither UML nor
INDIRECT_IOMEM. The XIIC driver itself gains no architecture restriction.
All four cases passed in an x86-64 QEMU guest. With XIIC and
KUNIT_ALL_TESTS enabled, explicitly requesting the test on arm64, s390,
SPARC64 and 64-bit UML with indirect I/O left it disabled.

pw-bot: cr
