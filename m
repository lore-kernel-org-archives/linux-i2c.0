Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996735;
	b=pKB1/EU7EMdOO8XDMo8niVK2/kogQNKP58RrsW1YQtGf8oDIj9ig+iohZY5CXLz+/NpP
	 tDIyMkrr5crTjMWaZmbD57yQ0h462fBrNra+L9NMoJkoF4V2HOtekmi1EZ7CxqeKEnZPz
	 jhYO0gOEcnbw5cOzbixDB2r48hebW2CBpp4wg2RQzRcLHS91jSggcn5UWmiJH1+PMoWJZ
	 vaOH5T3slPPKoh+LEZZONLcPD43R710oAn5cNr5A03ctHm1Bj+RSkK/kUMnYzS2cD8cyX
	 RwQI3gEMxSJEwjIk2JAem8XXrg4TBMyg3Wk81RpMkyQbTn8iLN2T5ST97oqoFFckJ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g0wg2R4D4ws9g0qj9z8FjxgFwkWHzS73xmd1tBLqVOI=;
	b=DWHvOa0xOB33XSW+sT2GVexid1Y+TzgZs7NOt0hlKP6VmmbcF7OGLXGQ77ue0rctmshh
	 lAtA4qYoqFJMbAeLyK9ThI1zXY3qgmVuTDgHb78r7JqNoNP+9aAP6E26gGpADyuV1yMXQ
	 SBooY5JTJ5ceEIpDoFHAyxs9VceeXhBYB0giMyCk+9s+qNoZRfOtbjz/lL86CnTvXMuSO
	 zCehUXJDWT6DMDOLxdsMaZkaK5ROhewBWPovi/hdBQUzdAl40Wq7XisN65VardrLk0WGR
	 vRM+ZeR8rt19Q3e6+IvtVmPbu962vbORMXy+R/0AnTSk7edRPzxB6G54+5SzHRZ3xcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M137R3Jq;
	arc=none smtp.remote-ip=74.125.228.134
Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F75606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M137R3Jq
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c410cdcab7dso19228666b.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996733; x=1795601533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0wg2R4D4ws9g0qj9z8FjxgFwkWHzS73xmd1tBLqVOI=;
        b=M137R3JqnrXHrCuaq4bpoBaKRlmo7e2gnV3a2TPKEvhnjgrDlE+JNyHI0PyfuvSE3X
         P8y8WMtV1+L5fdMIbWSguYL+5p0ki837DIG+zF16hhEhLKs8eDnrh/Tr5Um+s6ELD4Of
         pekQa6zwnbRv/AXECK4EVb5PO5rl7tMXPYpWMPWJwrGF6lofWVR9yXn4uJIAwSjXea9Q
         xBcfsOjs2kkWA6pDJZo2TNq7L9xwomaf9CfxnoQmkSnjNmdbGr7kYbV7gzdk+MJvzWzm
         nSrZD324xdWlOSNIjsarhfXYzUBwMUs2Vqd0tXnysSR+vWKYKdKUWEMn+uQRmji/8I7u
         FwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996733; x=1795601533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0wg2R4D4ws9g0qj9z8FjxgFwkWHzS73xmd1tBLqVOI=;
        b=ok28a1M8P1ixZn3RAD5haUEwDu2Acc07KROgk2J7S+z5tIEOxxPo/xQOV/aul8sd0/
         nGgZ71gO6Mi2WkPrQR593oMbu/P+l6wSTJA2RJ+sQVuzqU2v2pccFcOLsSm1+G8Q1hV2
         zsOfRsWXQJJtztgc5zR+GhvBzdQB5nhhqoFVsW5aXWp+OnrVlWZ8Z7Pm4F3vfcGHCS3K
         1B84ttyweLbw8f5nR3USuZ08xPAA2cVc5WojFiAOpeiqN5zAX3ct0BbaD6Q1lyVZPQCu
         zPMSQHoDoPMnU6MI8jTz130Bc/tsRk/cR7ODXT9cBEv42ve8I0waNyX01565qo9NQbb8
         39Zw==
X-Forwarded-Encrypted: i=1; AL+hErELvgbk4udx5DlruYG6QI70SnuX8hsrKxxlN/4LyD7viFtS16Lm1UJUUglsH0TKTIhmh+zCgEPlHg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4BxPGbLz5lQ4M7Ls1Avxr9DBoTcBZcoX6Eh1T9KMfdZxBefMj
	vE6eu/8tp8C5E6azri1D688K17sqhUtHahJXGTaADnMWjuL+4AtD0hAq
X-Gm-Gg: AYBFou1C0KkaMrlkwvs1/T5zBGjuPd7fk0vf1/YcNbBkzS6lnfF7PnRwArsT7OfeBmt
	5dzqhSx6OnNVNVBN5DiQshyAVi3VEoR6oXav5gEvCyFCfbpWYBcfyJBnTRsP/In800iUWkP4F05
	gJa8NJciuDYY4o5EfiLCCWKW2PurUfEj/651AWZWQ2z+9Otw5pHtgjpKLfJnkFjp+/IFN/Tva8z
	2CIC677zB5WL3BbTt4whGa1G/ARpBKT6AGwtwhAeTrdKKfmt/fE6vEoWGYlEG21N98DrFfauGVR
	vNlor6Cjx9roKZBauNey5jKULQUOOnd7pmDdKJEZOdBHS/bZ2OWA6A66BQd6CXZpX8Y7TFnoncX
	YQLG2Dg4vqH0lraxksmz4C8xMc6Ll389+gJj+M4ILp680q0k0Qy4cOTaeu0FsXWdsWZRgUf2P1q
	fuM+SiPTRnhXdVm2yx8EMJgo5hgFa3HpaCVN3EfVjK+M1Lz500MlWSTN9GsZ1/qcMX3SoZe4I/D
	Z69fRs0rV08wGuuFrqdkv7zviztFScrmwRLflgMVmWwMSqF0kodIdnDJstEfgpkVVPJ4En4Nzn4
	LUAndEhJohkp7U6Q8FoIkXUdcMmrGnqTXbhCpQFiPkuC/fpd+L5c6vTm9dyOih+DJ2b4G9IaKYI
	zZOdKkKJUuzP07jlSuQxtt1gdulgH5to8pBDLxLwhjTCnU7LTXCT2RHHPPAKN8d8yeqwN33OXVG
	Dbxw==
X-Received: by 2002:a17:907:9805:b0:c50:93b6:52ed with SMTP id a640c23a62f3a-c510e34dd9dmr172220566b.40.1794996733005;
        Wed, 18 Nov 2026 02:12:13 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f332sm78436366b.7.2026.11.18.02.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:12:12 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [RESEND PATCH v4 0/2] i2c: i2c-xiic: fix clearing of bnb irq and waiting/ clearing while atomic
Date: Wed, 18 Nov 2026 11:11:45 +0100
Message-ID: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Resend due to inactivity since Nov 09.
I think PATCH v4 2/2 misses a review.
Anything I can do to move this further ?

Dear all,

This patch-series fixes the clearing routine for the bus not busy (bnb) irq
plus the waiting and clearing routines while in atomic context.

The bnb is used to indicate that the current transfer is done.
A high level view of the software flow for tx:

* init i2c controller
* prepare all registers ( fill fifo, enable irqs, ... )
* start i2c txfer
* clear and enable bnb
* wait for completion
* ( serve interrupts )
* ( bnb interrupt ): complete completion

The datasheet ( pg090-axi-iic, Interrupt-Status-Register ISR)
states that the bnb bit can only be cleared if
the bus busy bit in the status register is set.
So the iic controller must have recognized that their is some activity
on the bus. ( Start condition )

Currently the bnb bit is cleared without checking or waiting for this
condition. This can lead to spurious bnb interrupts.

Andi suggested to use an atomic-save function to wait for bnb.
This was applied for other waiting/ clearing functions, too.

Kind regards,

Thilo Zirnstein
---

RESEND v4
- Add Reviewed-by Tag

Changes in v4
- Fix timeout argument of polling in atomic context

Changes in v3
- Use atomic-save functions for waiting and clearing.
- Fix intendation
- Unintentional changes removed

Changes in v2:
- Unintentional changes removed.
---

Thilo Zirnstein (2):
  i2c: i2c-xiic: fix clearing of bnb irq
  i2c: i2c-xiic: fix waiting/clearing while atomic

 drivers/i2c/busses/i2c-xiic.c | 70 ++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 13 deletions(-)

--
2.43.0

