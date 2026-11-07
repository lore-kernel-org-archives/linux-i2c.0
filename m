Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039074;
	b=cPbGJSvDZDWzNhfjQ+iEuWMuPW02RXBydNXGwOhcDNLMo0LRlX+jnSVC+yFdYn8nZSun
	 uFDMUC7Xtg0oRKT0OxYgZ1KB1GfdimJD/oS4gHcXsOe4u90l63WRPkIOVgbhBwbMOYYT4
	 2SzqH3Q8YA6T981ffYVKLDZER+9bVhNeBQA7eOhDwLKjmVVQkvKEugOpnsDSjNWJZPeS9
	 5sjTwwdWo7b7z+zCvFr14Mwsk7GPKI9ZP8sgjY65ehpbsLdXOOnD8tQ51aPDCa6XRvE34
	 /wZ1EwT/0h7QFdbxC2KBU2C4jCTiaWIdZaRxNAzbjNRSgcO1T0sJc6LASqcQY433VJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rUJh/hOnJVDzqfu7D8ijbQoRtZjwQJo7W2Gho0cz9Ek=;
	b=FysJGNcrMc1j3fD9imKvh1xjW5Yms1FHIzzDPTJBxZ+hZtfP4/vspfBfNjgFj9wvvtBD
	 iqY8s/T/WmvbfDnbNHemgQUUCkT/Qyiq3y7L4bTpCu8YvWSLYArUAKdiDcJolNEntyAsJ
	 hefjrOITKjguSF2M4N4jTkX0/BjuB95KU5oslHTNgiVTrifgVnjp82aOXrzvR2qAKIJkV
	 VcrmwKwgWH1g4r6o9RNIxKHxhCyCqAbSJXj+nRw2CgrkTgL+HIGpboQwIAMkZsRi+LuoW
	 uuQVeLNpqDSK671FoyQlMsFDipFSbmIVz+Wz4nAk5TytgmqGBWQMgwPofbiCWg9dGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKeFkqim;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E75606A32E
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 08:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E75606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKeFkqim
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so2738763c88.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2026 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794039073; x=1794643873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUJh/hOnJVDzqfu7D8ijbQoRtZjwQJo7W2Gho0cz9Ek=;
        b=SKeFkqimPya5fDVfeJLyAzYBe83AGQhACb2tnedd2tmpnurcnzmg6/64RZkMsAnwzZ
         jV5peLLmAyYCH7NKCb4IJ+xUZkAQX/0rbFVWe6l0ZyNwTK/Ib6Oey/tLHaAkxeBGpY78
         tbHXnl/DQszXELXHaTxhSkfQhlj3Mntb16zKI4+bI3Px42zgsvzEuILNO6nJVG+QoxGh
         ChCZDLH5NS58oq75I7FjOXIo0vJzYfk5NGV9UBoRbsQ2JFUZm/IUl274qydZpEtaRftp
         iWDpFVwPKdp4QzWaKr47w8Tlc9RslbobfQZKuBvKzHG5zF+Msq4Z0wFDvWX2DzNWe6Kz
         +NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039073; x=1794643873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUJh/hOnJVDzqfu7D8ijbQoRtZjwQJo7W2Gho0cz9Ek=;
        b=gJ2yXMbloBspj7yVFizG0pi2zQs/nYh790x3cly8kqGZnTIYVAu5HvHpOkK8sXYeFg
         GKQ8gFDns0E5em+06h+4FU8Xrn+JKPlqhck75sFAsNxeVBT+mB5R41sbo11RmDWS5DZ6
         XEXFrUi8MexebnaB125u/PhKQVVcy5hpB6u8y1+GlU5s4qjMa1aoRURnfdXiXusfrF0v
         q4H6MpFhZsXmMLysp0mSJGSFeriTfECzSQmo9aXunuTfWmpgzOrz+j/jemgoEfghj8Ju
         jcyIpEu5FiizR0/MffEa/GLoe1Y05X9xJLrE6SCB0HbW9PAvUtZ6bQ7HFrXnrk7D/rXr
         rnWA==
X-Forwarded-Encrypted: i=1; AKwUvBydoup/7QSqOcNfUvBtQ/5RfSZz5NQVxNyUhwgj+artPl+PRjrLF/eqP9rxjRgGZGue5Y3wOLmxi0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Htusa5prAcBWN/lwsxbSlfzfc2mOJrYOtHSppsTAalUkD34Vb
	pPKY+dtR0pHwh4wJX70U/MBgusMxOzTIMnSiCiujvH7aSOTg3E2TGt1UqN6Qwr6z
X-Gm-Gg: AYBFou278ewxCl8dEp2gp5MBQChjut4UtM8OyxARySshQ8GSwLcYeoGWQN8cnRIfdPT
	JOCEih3TmKCTPJGqJ6e8KuxhR0/EJEBFFVBHuT3DQfgUNlV4njQvGRpjfch/RmcP1ito3HWIdBI
	xlk+hSbfOPP6rOVuSD5a8dUR8YHx408lCRgdfivMln0eta5d7bNJgtRj+dVYwIKWFQzV6SF56q/
	wea/rGKC+LZIlN7tKCW6SQ2BizShUA+sQCpjJTSN7f9pjIFr7Dkieh4GVuVSLKlklfne9C9OSb4
	skaOGwrWnWpxFcmXXniyW9tiSBqeOfICn2r2trPS9hEWee+LW+dt5+fkiCBqh+VEsHqRuud7xqM
	BjhowkWcR95D+MRctnEBr1wWNusCoa0NPyicQtUCzVplzT1AzsBdwmZEs702nykQSUYdLm+Sqp/
	3Wace+Gq8yIGSGWud6iuEmmYdm1egxFCOtBewcN9MzO9ACVMNGfTNBd02O05bauI1UxUkw48dU/
	UyLq6xVwlohC3NEUzauHNMpzRorUfjWWF6efRxjfDNomV/AX1NiAyJOf/qByc9Vu5uDxGMR0jX4
	nx7GxfyTAV0i7V4SBmmTIz5bfs20Kjhkf9/idXh2xyIM
X-Received: by 2002:a05:7022:7f18:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1b25d30af77mr7905466c88.13.1794039072216;
        Sat, 07 Nov 2026 00:11:12 -0800 (PST)
Received: from asahi.tail4da9e3.ts.net ([223.38.80.59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e407cd1sm12587621c88.3.2026.11.07.00.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:11:11 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: designware: preserve invalid SMBus block count
Date: Sat,  7 Nov 2026 17:11:08 +0900
Message-ID: <20261107081108.1046163-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

When a slave reports an invalid SMBus block count, i2c_dw_read() uses
one extra read to reach STOP. It currently replaces the received count
with 1 for scheduling and also stores 1 in the message buffer. A count
above 32 is therefore exposed as a valid one-byte response.

Keep the received byte in the buffer and limit only the count passed to
i2c_dw_recv_len(). This preserves the extra read for STOP while retaining
the invalid count for the caller to reject.

The DesignWare receive functions were exercised with stubbed register
input for block counts 0, 1, 32, 33 and 255, with PEC both off and on.
The original code replaced invalid counts in the message buffer with 1;
v2 retains the received byte while scheduling the same extra read.
The arm64 i2c-designware-master.o build passed with W=1.
No physical controller or end-to-end SMBus result was measured.

Fixes: 69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response length value")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Changes in v2:
  - Use a separate count variable for the extra read, as Mika Westerberg suggested.

Link to v1: https://marc.info/?l=linux-i2c&m=179344386454087&w=2

 drivers/i2c/busses/i2c-designware-master.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a1bcc3797e4ff..49e9e36340c84 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -542,8 +542,9 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
 			tmp &= DW_IC_DATA_CMD_DAT;
-			/* Ensure length byte is a valid value */
 			if (flags & I2C_M_RECV_LEN) {
+				unsigned int count = tmp;
+
 				/*
 				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
 				 * detected from the registers, the controller can be
@@ -553,10 +554,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 				 * another byte with STOP bit set when the block data
 				 * response length is invalid to complete the transaction.
 				 */
-				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
-					tmp = 1;
+				if (!count || count > I2C_SMBUS_BLOCK_MAX)
+					count = 1;
 
-				len = i2c_dw_recv_len(dev, tmp);
+				len = i2c_dw_recv_len(dev, count);
 			}
 			*buf++ = tmp;
 			dev->rx_outstanding--;
