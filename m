Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853249;
	b=fbcgVpzqE/oGtIsvMtnDhrPOFNz/7aR49JjFdN1Ys6LF1900NW3xSwrUTEtkHCMOeQ+j
	 vk8gvqx28XZdCFhbJ4NoSFr29E9vuzdRgKYz1GYN2ZExY4nUGWNfOKTrtRACekqkEe9V8
	 texydH8dWca/gCs3iobNnTeeOT1H6ZwczLKQErqMhzCd92XbumEdQsdcWwDfz9m7wqUso
	 oycA4BztW6jwl+cKlVPYPUp0rvdjD6dHFOvaz8rqO+4AXJFSPoDkYAjFcFrcfiWyhI4RK
	 OMHL3UIEj48zbXAS94NUwRIlnMWaLUPbuf2THgbAOoqu0uqrmpvCeZZTFblriEAlMww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gmcXc8PpLN8Y0P2f1bs8epH6lji2dvrS3zcd2mdMtMA=;
	b=c030uY0Y6YhJ2iLkoMZYGTsmrTRyCzwA87Car2j1h4of3fuRcAwW7aKjptpJr/tMMF/9
	 ziNKoF+4Y61689plky+ltMsXmmAGovtgFu3SwOHnlJKi/jyOXsHAhG+KRNXtzMR70mlHR
	 d5heMaKFhErm8dgquEAToSo0jqgl7j7i9ovbnQFxDWEnoWN1WNsMqlSNvSSHj6YcALK1S
	 8bNJA2LzDbePyPnnI2B7KVHOzr/o8Z+jQkzhnws9pkE8UmrLFCGmaM8TSrbx1uZ5mjWb0
	 9hBxZOYlcGCwvk7JT8xwripfGIwqsJMvE238pbFPRVoKWm7OyiUUZkwzZQeXJ/8PMPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eqpuz/BN";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B063606A329
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B063606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqpuz/BN
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so2875671b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853248; x=1795458048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmcXc8PpLN8Y0P2f1bs8epH6lji2dvrS3zcd2mdMtMA=;
        b=eqpuz/BNRewwnqPR7Lwmmdgpfh+V3P3GN1xkaOj9TGIfVxlvvUaeb+b61A4lFcZakD
         HKNV7dYJ5vMNhJg2Jtbs+B/yB+qpMSvukXDC7F3N2y0KoPs7/Y2DMUDHjToOQFC0fBAL
         1F3WSIjqXrRakyePJsE5t1QMuZKR/a/3H2nsMYW3k+MBDY+ry39LkA5DOakoRD0blMH+
         UWilVCKHWpXJjoyXUTyAaA94q1v22loBGudWyAzccXQGLvpgst0Jk3lXv2X7lCgf5XTq
         fQG8FEsdOvc+d50IF/heXA51aqJrZ3ReT2LM4/3aaH00qUJSwsxvMTXEuVGJP6gKVyvS
         e8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853248; x=1795458048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmcXc8PpLN8Y0P2f1bs8epH6lji2dvrS3zcd2mdMtMA=;
        b=CFqYvaqaxr0FfaeE2jXYNLvpxYbuk7I9xn7CJhPHJlryKzzmUlfe/Q5ZmaWRnh4R2Z
         B/YxHpEBx1jZH7xN9Q4GsbL1HuU05pyg/Ngp5WIIGhK93CK2ri4sbEaMUodOp3gODk1d
         QcW0jzTnicCz+5jiMysLjdjbFgfTXUldYOAml3hZm4ab1jyu2HFYoEhtFLbzO09D7kM8
         HE9mrR+QQ+9wD9zQwA29HZbAhyQtArEt3itYUJEKNo9Q0VhaPtHQPlYVabOXOmAYL8xw
         tQ9S4rw6cdY/tKZr8TMAwGLyeNcfEHoUSGl8bjPXyQgnWMvgqZO/GXwKEJdkwFw5O5fy
         Xgpg==
X-Forwarded-Encrypted: i=1; AL+hErHXg6an3TeSTWgTKmelLFSVR+aghKjTawVela/4WnFyabWPaxWViwqLbA8mlLHXHjGAOuPsrvbXfgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vApRr4uM2L0U+KMWe5DTLHNbeu5OVxOfdABn0PoM7+VFrI898
	OkPR4vZmq2QxfD+kWt8/9mNcHy3BJiCpfODSsnw+lVF1Mv76r6jz/NTb
X-Gm-Gg: AYBFou1Pc+Z+wXlRXfyDB9W6XP3Bp/yVhh3BovjYS3+dT8KaJ0rlj7oClJds82V1TOD
	vd2DuYrALPYAPoFtDS4JFvdvGL5mor/HokcuwcJWwOUhhq/xUQwYS2f8tTilyKewaT2XtZR4V0c
	6OIV0fLL5+nud7pxKWtQ+fYd4fOZHpu+br9g6RWZX+RN1CVScJ7B93Y4iVpcmEhUvv5B+IEgmfV
	z7cCUtBSW78d7aWGJlJvxzYyY7Mc4c9z8tn6RcwCK/1EF7p6MfxLvkP99tFDY+RjKCT37C5h4Ne
	5p7yhv4/9r1mQOHSpae7dU7Z+r4BG00gpm6SaPKINF5KKP2qBulDTvBG/y78GPFhOw+j1wROroF
	NH/AK/L0knrm1x7nyuA9CxNbyjLWbl1nFsU8FkOkDobVQ9IYKTKsvpu1KnkkaaArKtRUSP4lNJ4
	yJC0hA6whz7gGC2XQfxn2c4h5jPrLF7qTEXmvXVR3uiB18cpf1m5gres7zCKBTnSsyk5jPvd7vN
	ucckw7DfEtNEY9ZEkXwP6cghVO8W7dif2ZQU/5AkJS8f4klZhzIkoTCeqM2xMU457VHMdd/KNe+
	RZucoozXYqap7mxOTL2UdEZ/4009Ik7FtRO8705IEwwbXFlF1u95pJ3i+yp1h4n6YzJlzIml5ep
	WcjZv5fqtg4DbhprnfokdiQKr3do64DVFQEhtjnwNT+iBzKSegLM5BcgYgQ==
X-Received: by 2002:a05:6a20:9e4e:b0:3e2:827b:2b7e with SMTP id adf61e73a8af0-3f7a6ea143cmr11038256637.28.1794853247994;
        Mon, 16 Nov 2026 10:20:47 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececce013sm4235466b3a.6.2026.11.16.10.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:20:47 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michal.simek@amd.com,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v3 0/3] ptp: ocp: support the WiWi production Time Card
Date: Mon, 16 Nov 2026 10:20:44 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The WiWi Time Card (2163:1008, subsystem 10ee:0007) presents its timing
peripherals behind a LitePCIe interface that requires aligned word MMIO.
Add an opt-in access mode for XIIC, test both access modes, and support
the revision 02 PCI interface in ptp_ocp. Patch 3 consumes patch 1.
Could the I2C maintainers review patches 1 and 2 for an Ack to take
them through net-next?

Changes since v2:
 - 1/3: Identify patch 3's WiWi XIIC child as the first user.
 - 2/3: Restrict the RAM-backed test to direct x86-64 MMIO. Exclude
   UML and indirect I/O; do not restrict the driver.
 - 3/3: Match the board by its PCI IDs, validate revision and geometry
   separately, and select typed XIIC data from the static board match.
   Do not expose the SPI flash through MTD or devlink. Omit unsupported
   GNSS2 interfaces, preserve external PPS2, and clarify firmware build
   reporting. Refuse timing enables until the interrupt gate is open.
   Distinguish WiWi's PCI interface from legacy Celestica.

The driver objects build for x86-64 allmodconfig with W=1. All four
XIIC KUnit cases passed on x86-64 QEMU with the same two I2C patches.
An earlier revision of the driver on a revision 02 card confirmed
64 MSI-X vectors and an advancing PHC. The new board policy and timing
guard have not been run on that card. No claim of PPS lock, UTC accuracy
or masked-event replay is made.

Codex assisted with implementation, tests and changelogs using the
board evidence, vendor revision rule and mailing-list feedback.

v2: https://lore.kernel.org/netdev/20261112163333.12523-1-ahmadexp@gmail.com/
v1: https://lore.kernel.org/netdev/20261111041904.48916-1-ahmadexp@gmail.com/

Ahmad Byagowi (3):
  i2c: xiic: allow platforms to require 32-bit register accesses
  i2c: xiic: add KUnit coverage for register access modes
  ptp: ocp: support the WiWi revision 02 Time Card

 Documentation/networking/devlink/ptp_ocp.rst |  47 +++-
 MAINTAINERS                                  |   1 +
 drivers/i2c/busses/Kconfig                   |  15 ++
 drivers/i2c/busses/i2c-xiic.c                |  60 +++--
 drivers/i2c/busses/tests/i2c_xiic_kunit.c    |  91 +++++++
 drivers/ptp/ptp_ocp.c                        | 242 +++++++++++++++++--
 include/linux/platform_data/i2c-xiic.h       |   3 +
 7 files changed, 422 insertions(+), 37 deletions(-)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c


base-commit: 6964ff21c5d8b75649211a52dbfd92753e605649
