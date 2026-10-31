Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444057;
	b=43cAkerr7QHA8Fo1p2YkaGQJPbAWymghtsmhCHO7jJGU5zVGMQWj97jNGl8+Oi263G1P
	 UbV9mzJHk4PMw+fes9RHnEDy/WtC0YtFk5Zg74GR0/8IoQODwQHKhPs18KI4+Ib2IO/pY
	 1s5166zraMDIsetJt0hIa/Rd+RVk3+tSK1D4jqgICKlcP2BWsI21QJn6tiSYrzZCfxtA/
	 4qFjwAapD6oZ86oCj4cs9c4lQntuLcNcIqYworsnpMD3BK2q1zdZpbxPQ5ki0Cuxba5A1
	 Km0mJIcMdRhfYPn15LTcCSQQZPpUI7cBp4S0P+ypy2+TBfznl7ZkD2jKKDAZPAUr9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Xy5C3gd+08js1GAOtSSRa04UMfhl4cyMda6mXjC430=;
	b=GktKLT9hPQtgUB7rWdzz/rwBRW78JPCnh6YBf38NtAF2DoO+MC6QDi7d3T7X9FV6w6qA
	 8nx1UoQbNICELb7DsIr0FBaFMSL3MqrJfUNMaUWf1vXTkV6z0ElB505cfXS3cyKhGTNW8
	 qibbOnETERsdfVQEeTFYIqO07mokmj1hIya4In6OP3Qw58eeRQX7iT2VLwBom8ugf/LbP
	 +uyElqTtS9Y9BvKyXmGND26RdKaVa8mHs5VmKscsPNforb2brPnCWFExWDOj9R9xXlPtz
	 TahDu8MpAZuHxGtu5cxMxDIWCxOvWTlZMB9/ZMP/V6GfYEsfLnF5UYszVkivnKdaYFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ji1qwbZK;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEE606A31A
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 10:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ji1qwbZK
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9ae391a05so10630355ad.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793444056; x=1794048856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Xy5C3gd+08js1GAOtSSRa04UMfhl4cyMda6mXjC430=;
        b=Ji1qwbZK23SCMCsXbvXhhK0j2k+HOHjek/jkDVdy9oS6kMdxCsu+3km53Og1wNOE5s
         mCVeGhqtbPm4dt6FdBsVi0XRVZlQ/le9h6az2enJAmmlkyQTietyTPb5PQqYTNQMuXSo
         D7G4vD5VUUBkVf23zVvUljLnEELunSyoh1khXH5O+e68fEFay3ATX3TNHdhC9AwyNb8X
         NMspy/H7+H8f1nVyKIEJwm3o9fgd+oyXg+brxzKbS5h0gj/6uKhrG1k9c4cyNzHldym0
         Z00JjHjGMJ75ADSZ+VOgicvHehUmOEt5OPWMtY2OZYjmP44iQTqCsUTZJCpGWqes+4ZN
         cxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793444056; x=1794048856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Xy5C3gd+08js1GAOtSSRa04UMfhl4cyMda6mXjC430=;
        b=sPy+n7MF7FYQXnzwF8ANRnuSKsn6vKzKTwE42mnaVO6LZmWr0ovu5lnGHGL8/CRdO2
         MgKX5VeGWbWVBXtlSMulOfHgakInnjw15nIdQ10seN4Sh2l0NxuXMyJJjksIT4EIlBp2
         IzvAh3DBT/3L0+Icp4WrlxncxnJtCJYSlmVCK7iaVvqVSK6wapkc/VkA44xfz+WpZTr2
         v2EVV6MIRVG8bMVZmKYpwV1rlVZIoS8cnyYV5WFrkQQXOg+oEJ0yZZMdouL988HJfKDk
         6YKPXRWZ5mknTCszhw456Wz31Q+K6LdxkImJavAbn+plH91Zezpel6rBardbwOpG37G1
         H9QQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8QAQI64vqLoRZU+TppDUfRYJ77HKOKT8wduljR9UTRexnYXsMlcCTD9JCLfWadqrwTQd+tV4eeOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUVb3ABmhOXagqyK63wLmfiteglnMWwblu7gmVtKbO+n26GCEN
	zarOPqdAdYhMIFym+ewBpAncVaZU9rK8EmFpyNvLQ19tZObdFJD2iAri
X-Gm-Gg: AYBFou1DK59moRsoUvbeRofB7stvWoUztQdQd1WC4zFtquAXv5QnTNSVBL4ZXianFl4
	aU3CaSnnOeE6FIFbY4urm169JOnyHICuu5scCUyI88oFXqjBIYHnVREaChOVlpbU2jT8aAlCIZ5
	nAgyUoUaIbBtpQOGI8dTC2b7VZJzxK3sdDCdzaDtbG2kQd4BuisXMN1V82CeWaxmFXa4ptRZwaM
	/J3bNqGnAWKSgM7k+ueTe7oLYKZHk1QSCgoxmSJDGyO6EKu3iGVZ9QrhypQsdyMsK8gnH+fvaKx
	KWH5foR82ie1gIgUzKyEyZPxIO4Y7XNZxiIgP63vL2H0/4meEtGjcN4D41mwOZg4jf6e9O3aoLr
	ADZVv5YZj4Wz0K5UpHYMHomn6us+OOsry6T3hnVNrjGSeIGRfILpkcS4WYFek9iMpgTv12PBu2A
	gWuyL7wVpfGBgYilQSCBPS9Bd4b4ZhNRIH2EueqnyC1C0QdJokGv1JgM2nscAjM708GyXFiS9NN
	Oj1wYiYFda12HZHndKKo+hURVTQVj1n8wC3lU+PVZzzy2ggRVZjx/Xv3w3emBLSLeh+xecU1rn+
	sMQLDOjljyCYfsoAxa+RbDLeGQZKguS3yipylZ+fd18p5w==
X-Received: by 2002:a17:903:1a4e:b0:2df:9e44:32f1 with SMTP id d9443c01a7336-2eb364e1741mr34179695ad.29.1793444056037;
        Sat, 31 Oct 2026 03:54:16 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052bcbsm14745625ad.10.2026.10.31.03.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:54:15 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: preserve invalid SMBus block count
Date: Sat, 31 Oct 2026 19:54:12 +0900
Message-ID: <20261031105412.16825-1-pocj8ur4in@gmail.com>
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

Fixes: 69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response length value")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
The DesignWare receive functions were exercised with stubbed register
input for block counts 1, 32, 33 and 255. Counts 33 and 255 became 1
before the change and remained unchanged after it; both versions
scheduled one extra read for an invalid count. No physical controller,
STOP signal, PEC result or end-to-end SMBus return was measured.

 drivers/i2c/busses/i2c-designware-master.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7e1d9a2e77332..f38ffc5b0a347 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -563,7 +563,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
 			tmp &= DW_IC_DATA_CMD_DAT;
-			/* Ensure length byte is a valid value */
+			/* Limit the extra read, but keep the raw count for i2c-core */
 			if (flags & I2C_M_RECV_LEN) {
 				/*
 				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
@@ -574,10 +574,8 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 				 * another byte with STOP bit set when the block data
 				 * response length is invalid to complete the transaction.
 				 */
-				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
-					tmp = 1;
-
-				len = i2c_dw_recv_len(dev, tmp);
+				len = i2c_dw_recv_len(dev,
+						  (!tmp || tmp > I2C_SMBUS_BLOCK_MAX) ? 1 : tmp);
 			}
 			*buf++ = tmp;
 			dev->rx_outstanding--;
-- 
2.55.0

