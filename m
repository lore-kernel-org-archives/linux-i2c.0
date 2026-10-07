Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5F3446A7
	for <linux-i2c@vger.kernel.org>; Wed,  7 Oct 2026 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411760; cv=none; b=ptygxcEi0i1JEUd5svzAA9CJeG5KxP9O6k91ulXoEUlF9Jkspp55ziB9Fpe/aQtzXrYzTQpPi8mwY+cZYRJBAG08nbM6h4+Mfx4r0epHEbu8sQ2QAhmkbw7jqiCRoyD2hgK8UANwl46X8Lo+C01bKLBwPzdfrEeKuMEar4/gD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411760; c=relaxed/simple;
	bh=AnwEDrUGE4MUUvOGEddWUKxbpcB5Iaa2uoXisjTJdGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHdDOhaovj7C2MivNEjR6e/kTns1i6QfJBQ+BSg5ZKqwwOcL91NLZ4P3kLtNQRwcHAJ1OF0ftH4ALXWVvAWVJl9LMLTXErTvnAJvR1sDKuy87+243OjoMvZ5Hg8PrwxWohsjD+w5OMomiQIQ+mhi4/2yV6BAlZw0bJ6Z+Qzx4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2YGYBGf; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2YGYBGf"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15943c9be84so8335c88.3
        for <linux-i2c@vger.kernel.org>; Wed, 07 Oct 2026 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791411758; x=1792016558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGr58K3fMn98ZuMySMu/K/tOp0DqOIyDjFOb3yn9tM0=;
        b=d2YGYBGfEZM22Xboazg84oYSpuR/dj/shdAPEGUF8pnR/CuW/hXhdn3Dpd63mGMEmQ
         UDD6LfuH667qYAzSLDjnguEBgxKVsxIWxUU8xtINwdhUHRMSkM16QxwnpNvpaBO/rt6e
         hTRpbUNtPFlnjA42tYv5WkWPzx3C1nYEpaB88e6LjD2SsOctmduP4P39kvLZRl3Ra3rg
         g/is+JX5eBo2KOya5HGdYINW6+IS133R4zkS8nax0GMSd7L8v23UCkTcqrM0uGjCSTvI
         MGZwOPJwmzSakU05ZQvvrnTqQq61UYDeTMD5JlkF4lkN1Y3YyaqQ4BQDD26Mu8FOGist
         MZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791411758; x=1792016558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGr58K3fMn98ZuMySMu/K/tOp0DqOIyDjFOb3yn9tM0=;
        b=cvY5FoZTM7UsK8Mo+q5WYpE/qVEA47VYi8CEMU6a0MGCZFn3gJKTbh3hgjHq0X9k4J
         Poa4h9vUx60rENl+ugdQ1Veus5BZTz2rwLeJBzS49WCPWmxkCDHhK2WPVspogY3z4K9G
         OMQ21KKPaojyyhrW3H0iMI4pw7pf84xTdNQgxw4KJnXDd4j/AmmRZOKmeunLfYw2fKY9
         7RhciqRwhQeu6Ccc2NeQEABYn+Uu+8NDlG1ZIxOgYCHOz5/IZPvZWbTmpcrth2wtzp5D
         KoA6wDaNw4T8X0r1btXege+IZTfsD5yqT9Lx/S9RE2PQYFAfjCrSJTd9+kjq32qsFWgC
         dWPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfLChFOzKB758PNH55X4jOQVuS/t0rxuTUt6EK3fDBrBf59BsRJ53Gv4pd064UoavOPHiO3mV1ogU=@vger.kernel.org
X-Gm-Message-State: AFuF++k1t0MLsu+ZNGaqDkP45Kmj0LqqcMK0AuY3LtfHSxlMu5s9nBsH
	NgJ85d6QugO8/rBr3Scsw8UysvMHy1hF5GDIt5dCksjOJ0npi3dUSe3r
X-Gm-Gg: AYBFou3OeUFaE+7WKA9EZX4DFo/N8abIjBcKRKs8YSdo59NSfQk8/c1NZdm0QJzxB+v
	ioP9PHwFsPmdJRBOYWtBBq2MbcVZggt9LPB/Q+G15rv4KcIRTl3iMLdmC0cg0MswOQpd+xjSCqK
	U38sRA8txcsWDTBTs42ZL84N+rZszR2IZ4ZymknDguJ/Qwg68H9iKDLpzCDd7hbb7pZPvymYtMK
	r+Gt6cbbfxgr5wNv9AhOGuHjfal8a9kMG5HqaFbYPzjpEMoUH6eb2x7/PDIMbrv0S8U31Ow9Goy
	s2ttzzOVoyFUYrNHZX50KK7Q7KAHXBw3dxV34NY9JbjGH6R74N2uD5a2zdPLt8dLyW5veHkQXZT
	Mzd64Ez4I/gvew9vX1mHWFOYNW406In8QkG5EnkRGhqkeqjAF6Exu/oscWmJyictPqop6Sa6+jy
	AZdtmaoF9F7zTT1LNevlgtuIkGdgdiKnh9FPnjhRcYLKUvyWqtuiQzxji9W8sx1/hRprEq7fbbS
	sUgyZUYYcXVH/RdvsFv9BBZW65ycdNupHZNdOhJJraTGONDRblukNHi4CEWpFdP/hHGz2PHLz+2
	uWBsonusSxMURhWNjw==
X-Received: by 2002:a05:701b:42d3:10b0:14c:f3ae:c1a1 with SMTP id a92af1059eb24-1657b80bf6emr1206317c88.0.1791411757811;
        Wed, 07 Oct 2026 15:22:37 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16375a1f898sm5386947c88.0.2026.10.07.15.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:22:37 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org
Cc: Navon John Lukose <navonjohnlukose@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Thu,  8 Oct 2026 03:52:31 +0530
Message-ID: <20261007191911.502428-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_dw_xfer_msg() leaves DW_IC_RX_TL at the 0 that i2c_dw_configure_mode()
writes, so the controller raises RX_FULL once per received byte. Program
RX_TL from the reads already queued, capped at half the FIFO until the last
message is queued, so there is room for the rest.

On an Arrow Lake-H LPSS core with rx_fifo_depth 32, a 22-byte HID input
report costs 2.00 interrupts instead of 21.43, and a 452-byte descriptor
0.14 interrupts per byte instead of 1.64. Polling the touchpad with
HIDIOCGINPUT at 142 Hz draws 1.58 W less platform power (psys, 32 paired
runs).

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
v2:
- Drop the cpu_dma_latency figure, which read as advice to set it, and
  move the latency figure here with where it comes from (Andy)
- Add the platform power figure
- Add Mika's Acked-by
- Rebase on i2c/i2c-host

v1: https://lore.kernel.org/all/20260919232647.448748-1-navonjohnlukose@gmail.com/

Mean HIDIOCGINPUT latency rises from 2522 to 3268 us, 94% of it exit
latency from the deeper idle states the CPU now reaches between
interrupts.

Since v1, also tested on a Goodix touchscreen on a second controller with
7, 21 and 64 byte reports; 64 exceeds rx_fifo_depth and exercises the
half-FIFO cap. Still untested: a RECV_LEN continuation longer than one
byte, and cores with rx_fifo_depth below 4.

 drivers/i2c/busses/i2c-designware-master.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7a301c8..f52f52b 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -376,7 +376,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
-	int tx_limit, rx_limit;
+	int tx_limit, rx_limit, rx_tl;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
@@ -482,6 +482,19 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	if (dev->msg_err)
 		intr_mask = 0;
 
+	/*
+	 * Size the RX FIFO threshold to the reads already queued, so the
+	 * controller raises one RX_FULL for the whole burst instead of one per
+	 * received byte. While messages remain to be queued, cap it so RX_FULL
+	 * still arrives in time to drain the FIFO and let the next TX_EMPTY
+	 * queue the rest.
+	 */
+	rx_tl = dev->rx_outstanding;
+	if (dev->msg_write_idx < dev->msgs_num)
+		rx_tl = min_t(int, rx_tl, dev->rx_fifo_depth / 2);
+
+	regmap_write(dev->map, DW_IC_RX_TL, rx_tl ? rx_tl - 1 : 0);
+
 	__i2c_dw_write_intr_mask(dev, intr_mask);
 }
 

base-commit: 04e9bf1648f846976b543e91c1838a712433772a
