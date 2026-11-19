Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095750;
	b=y15vbSCK/Ppq01JR80LcDPc5Yg1JrtU4GqpYws4Ybw1FuOaj2LnvOoMkxGYPJgKEdqXe
	 Q4YV9pkBteKVFOdANA30CkT/FZCC0u79wuCBmybzV7/Ws7WknO5Ckv6WKztnj8XxjCtcM
	 ciyOomUzwpqP/Aj4OoYhrLIfqxOCN3n0CNMnz25ylwQ8w9dnTwLCy7NY42LyTRfNWuSoc
	 2wD9hWF0H7s/W9xssr/NAkEaNh9nIqNxGQWTPdcSSYHS5txQOHnI8agdnXP0VtSeHhnMe
	 oqh04Wp9zRHi4bjNxhYZEn4o6JsQV4ytfI+uyx7xZGq23uRK0yTJJha1aeW3QeyF1lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0YIwd+6fF1gaH/fRdW2fKrVKfd8aWdILvAcZvt6cEU=;
	b=BqYaIn2S20wFtEurL5wZo1n8nlwvcUIeVCn6aJ5jYzlW4B4PToXhr/f2foLAatS0axu3
	 2KZOrQcFsglAUTuIDuvYxzFUs6O9oXsQKEEiJcV6l2vK/3h3maxvWabRrl5xim2P1Ov90
	 fLmrGmL+gPjebZu+hCW9mGU3sTFqd/TudQrwiGVKWRyTBL+m/ncI2pKLbx1y3VKW+VH12
	 NM9uCLtWm8JJtZbmWFwQLrSG6l9OB/TdssYfaVkVwO4AQKFtJRYXsYXYHMmO5+grVXSFo
	 MbhVBmu20pKDc3L9WdEJxS97ZqaiSb2dbRdBDtjJL4q2MN5xKA2KhRHS1/FPkA6swJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGFuavV1;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93424606A335
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 13:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93424606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGFuavV1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491d1f66968so191735f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095748; x=1795700548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0YIwd+6fF1gaH/fRdW2fKrVKfd8aWdILvAcZvt6cEU=;
        b=mGFuavV1YavdLmwEQz7yj2t2DHPle+zKKdjMAbnH+VAB8YloU+Br8gnCXQ9zbjzjOy
         V5P+U8leGisyHf5mIPv58EZwTIKYJItg95W8CTG8adyeqoA1CAj/WhlrwFfsHTYzE9fe
         5Ui2udnUSDUQbpKrxdWHQm1VOyuUA2QGez2eR+VEc8Yu6OiYYOB7aMdj/pKpcwgzVAu6
         OAGanTSm4ovd2QxlBMF5BnVgRHAmORZbsxSd02vVG3CLAAQEjA0yc6hgsciztdFIYM67
         NrsgsZq8yqlMv6snABhRUgVqtKF/Y29eWkZLuPmXT8ftvpNxUoNHuCkvKnFitDxr0ufS
         pFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095748; x=1795700548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0YIwd+6fF1gaH/fRdW2fKrVKfd8aWdILvAcZvt6cEU=;
        b=S9eZ8l7LXa53AjNg6KnMu6nVNVnisojv3CqIUd4Jo2x/GlS1dKIJPosWSknJDhWTH6
         4gMSrw5L3aBIimlCZZ8tPPK2DMdGR9BICBhV5jFNSLXAIsXGm3FvbK7aDF6bfH8VH+zu
         FEJxdlIAZNsgVh03GX+fTyS9RQnc/1ofzQL7nH2OshjiEntfiC+1CopgGIcRDIM8j744
         7cGQpF/FbcH9lgjplxuKc82D5aMkoi5eTqxMdPTt+/ETZNm72X44XaJtAN3EQ+DCzVkr
         3zM9sI1qm07tOcQ3tSclEivakui9FkxAgJFU+29f8Km4j78OuPo9Guped+eZrWyzxHHi
         uqEQ==
X-Forwarded-Encrypted: i=1; AL+hErEpXMYJiLpUAQ85C/1XjUSw8Ddh+OME8yNd/w5jWFj+pLX35v7LrAKZehN4ldbdd2EarMhmy7FFtl4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PAds44G8vokUU2OP+EaYkrmIpVlnYIbOfCRdLHx28ojQwqnvj
	b6xRjjYpWULIcsUOl92tiYXGcthnkMI6KfBY1Elspr8P6rNfvMCZxTtS
X-Gm-Gg: AZFdTZcx85G7LzAZv5yhLIS12vBQx5nE6OPz455OFXxf01GZumeHrLueU9LFeKE9EsC
	Q7oM98ZyTrPnoAzTTmiedT/bOhSBHIc1GXaOjktyL19d7zLsmWU6oaZAl8J3j3ZyHg9hTbAYH/4
	3WDeSRxg35vppcbR1+r2TQC2bJLuLToWF8r4lxfM5B0jAEzIZN/2+ZiZklFJ4uvJNtX/wUzaO4z
	plrBy5Y4Bbftu87cPTywqlzIslgz5AHrq4RNPIUST/DAmK+UW/p6urRZvgjL/Y95q3i8yEx+wCT
	Haohdan+RIMQc31KK1A8dnmnhA875+eA2iY1K3DFsEJ4QxhdKuRztr7V9q2Zlba0f6LgISMi6wq
	N8I39Ffi5sBMQxwuLv8NveKdBuBLfh5KPvADh+4llH6QfLuYmPV1JH4CiiQQShPOW8D6b/vHZLk
	v2WMPSVr3Hlf6ZEptA7ZMKmjO21GQ/KssDAP1v6hXTLAOyEjUw5uF6pT9Ehsz/237mWAb6PB8VT
	3b8+t9US5OKBevpJlZB1kJXcSHTObnnWs8RYGVY+XSg3Pi0/4nEvbRX8armXvOwFeaBWbzs9EXy
	sQsavbHq8O4PIOPDUzCHwzbfNKuf3P3KkHA=
X-Received: by 2002:a05:6000:26c7:b0:48c:67d6:a87a with SMTP id ffacd0b85a97d-4a639ff6138mr14542869f8f.32.1795095747665;
        Thu, 19 Nov 2026 05:42:27 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9437971f8f.42.2026.11.19.05.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:26 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2 0/3] i2c: imx: fixes for a DMA write that is not acknowledged
Date: Thu, 19 Nov 2026 14:42:22 +0100
Message-ID: <20261119134225.265242-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A write of DMA_THRESHOLD bytes or more to an address that does not
answer leaves the interrupt status behind, so that the next DMA read
returns 0xff for every byte without an error (patch 1). It also leaves
its DMA buffer mapped, as every terminated DMA transfer does (patch 2),
and it blocks for DMA_TIMEOUT before it fails with -ETIMEDOUT instead
of -ENXIO (patch 3). Patch 3 needs patches 1 and 2.

Tested on a Colibri VF50 on the Iris carrier (i2c0 with DMA, M41T0 RTC
at 0x68) with this base, the other i2c-imx fixes on the list [1-4],
PROVE_LOCKING and DMA_API_DEBUG. Each round wrote 20 bytes to an unused
address and read 16 bytes of the RTC:

  without the series, 200 rounds: 124 writes failed with -ETIMEDOUT
    after up to 1.08 s, none with -ENXIO, 163 reads failed, 128 more
    DMA mappings in use afterwards
  with the series, 200 + 300 rounds: every write failed with -ENXIO
    within 10 ms, every read was right, 4 more DMA mappings in use
    after the first 200 rounds and none more after the next 300

On a v6.12 product kernel with the series backported, 200 rounds that
also wrote 18 bytes to a device that acknowledges them: every NACKed
write failed with -ENXIO at once and every acknowledged write went
through. A NACK of the last byte the DMA writes could not be provoked
on either board, so that path is not tested.

For stable: 6.12.y and older need backports, as noted on v1; I can
send them once the patches are in mainline.

Changes in v2:
- 2/3: new. Sashiko on v1 2/2: the new -ENXIO path left the DMA buffer
  mapped, as the timeout path already did
- 3/3 (v1 2/2): a NACK of the last byte the DMA writes was missed
  (Sashiko). Its acknowledge is now checked once the byte is out,
  before the final byte is sent
- 1/3: no change
- rebased on v7.4-rc3+ (4405c18c95d2) and tested on that base; v1
  was compile tested on its base only

v1: https://lore.kernel.org/linux-i2c/20261113073250.1037215-1-mehmet.fide@gmail.com/

[1] https://lore.kernel.org/linux-i2c/20261113110501.1142036-1-mehmet.fide@gmail.com/
[2] https://lore.kernel.org/linux-i2c/20261116122707.1349139-1-mehmet.fide@gmail.com/
[3] https://lore.kernel.org/linux-i2c/20261116125940.1368194-1-mehmet.fide@gmail.com/
[4] https://lore.kernel.org/linux-i2c/20261119130542.180192-1-mehmet.fide@gmail.com/

Mehmet Fide (3):
  i2c: imx: do not carry the interrupt status over to the next transfer
  i2c: imx: unmap the DMA buffer when a transfer is terminated
  i2c: imx: return -ENXIO at once when a DMA write is not acknowledged

 drivers/i2c/busses/i2c-imx.c | 52 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 18 deletions(-)


base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.56.0

