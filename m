Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851502D5A19
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925706; cv=none; b=J1RY5AzdpLSCpEjlaqV8meWFHL2GGHSNjdgnCkLRHDb+QD8z6AhLYVJ+Vc/OOYM5cqUEJ0jGoEBmrtAQHMronzayOocNcfqC1H/5XuhxAgvIWi5/9SDqcNqYp2y+HX+M9GKQy8ADiz/VnqvrJvtc72ZCOX5Uo+frTAW530hWN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925706; c=relaxed/simple;
	bh=R5JgCdy/DB1Ih4Sq3LY6luPtR7ymrleLMrLZ1TOIim8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HS1gN+Q5w3SaJZXn0yrd79gdNcYZglFY8iO4etQ5sbjD/gbfmnCud6aAcTS3rQ+06QQkMMVTJ9RoXl9C3Vyo4WWW7nazTERch/7F4KN86hHJztH4sH6zPuS5kRwnko+nsXSxl11hU24qXUTzhjXxEmMKPx3XDZUnv817SpWtWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=kvJxzkSU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="kvJxzkSU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-356337f058aso2869392a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777925705; x=1778530505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7Frq7y1uLHJifdiiUIm1aT5EQRSrBV8yFq1fPIMTZ0=;
        b=kvJxzkSUyqaR3AzlLoD1SsN93VvxgnulPH4jrBDYvwly5mhDxk0Pz+cJx31R2flpO0
         VntItqrgHN5XdbGB6HtR0jKcX1U8fq7ouavnCLnx+E5VXjqmKBCiY6Q6qTUPM+KY9BLk
         6KgY+wNVB8E6DCMS6FMvxIwOJVJmVdRoocvvyEtjZ8EnMS+sJDtDdO/3ENgYqJJBMWyZ
         xiFTmoNdIAz/dE2liKntCiPtJcwJ+AUDtbvVI8U3ueRc/03yjwfSPvISgBe/UyPH3FWw
         qYHpFNlNtVLWIfqwJPiDRB7oBgWSOwDAq/5pG9wOK2hgH6jmVVZUxWonTkPU5bM/WT1P
         8ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925705; x=1778530505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7Frq7y1uLHJifdiiUIm1aT5EQRSrBV8yFq1fPIMTZ0=;
        b=o0cKbse5advWFZipqq8XysVvLE3nDo4vwfO/OQb/defP2xjwArW8mODQNylGBorVgx
         5AzCD4baKZEIWc/3GtMqoBiWH0VBEtLDJHoiF21zCbI8o88b3LaAY2M6z0iDTDdVaeGU
         U4CzsfMh5s06pe9UUD90GKVB9uIXytAHnERqC1axxF+4n9osRN0+IOGI43RX35PYwymW
         Wxw2YkuOXTk0eo+4gi8uVvsPuiLTIzhiziJe8mztFUb+uLiQc6BrrB01rECAgXqgOUTF
         Vo+bcMuNx+LYfjSO4sSkEsvxme8YALyaIUQy1ohUJo9Stmm0sUhloDJK8TOWtfjKHoWJ
         oc5w==
X-Gm-Message-State: AOJu0Yx6U0cJ/T82HmLCHAVtNhjoAbTInSwMSrvkUvDRL9T7gXoCC/nA
	xZ4Lc3uGzjn/5uPTzdV7KMWCquAK2+a6fHff5+Q1IloNmAcq/O2hHBaKGAQysjNqKdQ=
X-Gm-Gg: AeBDiesKKjolfSmOP0EGqGdKVQhTEvufMTS+AKB3Tz+tdpOS3lU5kHRCSH3QUz94+rm
	7RRCRlQrzGE8xMf/32n6896ZMhySf5bFCgcswSesvZXqvtO55WCNJebSPicKbctOOG7ch5XqH7B
	63Y8prWmq3t2x2yUq3n/wwqnJ9YEXyrDEO7vykvYpXDKE0236N1HFY88Xx1+4509nq9em+pD55G
	xmc6JXLARv+oJmbtpQqNOTbgiYeH87EruZ2xe3aMcAjwx5tmmVIzmVxNRPWxbQtcacAB5lJB08p
	3+cjXAHOqlKGWyKP0O4DjkxvdPkqDJEFsZW2+bhp6q7JXSjwhtWLPN40586Oh5BecvHNurZT1Rk
	Ai5u+tXoyCCefMuTdePtmqUJUmFfEFl8XnaE88/c1VrCEEUAF1nLysfjBBfvN9HhpHv6sBm2EC3
	cAuVDM5rK3+Q8IkstgvxEKXMhskrp3ycXX1ZI5ODYeWLW7d/qeQOC8VGeG2w28MvL5vNkbNca8u
	B5wWNal3fe9qJ7JqSvJ2nTPkQ==
X-Received: by 2002:a17:90b:35cf:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-3650cec0ce2mr11560093a91.20.1777925704571;
        Mon, 04 May 2026 13:15:04 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20568593a91.4.2026.05.04.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:15:04 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 04 May 2026 20:15:02 +0000
Subject: [PATCH v3 1/4] i2c: designware: Introduce shutdown exported
 function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dw-i2c-v3-1-57e56135d602@wkennington.com>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
In-Reply-To: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Introduce an exported shutdown function to safely shutdown the
DesignWare I2C controller.

This shutdown hook gracefully sets the slave disable bit before disabling
the controller. This guarantees that any incoming requests from the master
are immediately NACKed during shutdown, preventing the bus from hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 24 ++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..0703fb29038c 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -1028,5 +1028,29 @@ EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
 	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
 };
 
+void i2c_dw_shutdown(struct dw_i2c_dev *dev)
+{
+	unsigned int con;
+
+	/*
+	 * We only need to handle shutdown for slave mode to ensure
+	 * we NACK any incoming master requests. Master mode cleanup
+	 * is handled after each transfer in i2c_dw_xfer.
+	 */
+	if (dev->mode != DW_IC_SLAVE)
+		return;
+
+	/*
+	 * To quickly NACK the master during shutdown, we set the slave
+	 * disable bit while the controller is still enabled.
+	 */
+	regmap_read(dev->map, DW_IC_CON, &con);
+	con |= DW_IC_CON_SLAVE_DISABLE;
+	regmap_write(dev->map, DW_IC_CON, con);
+
+	i2c_dw_disable(dev);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..8b422249acbd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -393,6 +393,7 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
+void i2c_dw_shutdown(struct dw_i2c_dev *dev);
 
 extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);

-- 
2.54.0.545.g6539524ca2-goog

