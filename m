Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023076.outbound.protection.outlook.com [52.101.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AA3D6496;
	Tue, 24 Mar 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361176; cv=fail; b=bOezhi2XpU8CVg6UK0qXWSu5oZrq2sAF/d7OMwgqNdvU5OTpNs7ijZWdbMdQJCgosnbPJ8ihytID2kC6imeXldZJr/Kzo1KnYo0EFmTEsEeSZotI/Ogk3s5CkzLKNBDsxuVs4L06bdACEhZQJpaaIsjMrmOMckx7ULsAm0oRK9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361176; c=relaxed/simple;
	bh=IYsOSzzQi2wPVMAsVXdGg6cr84aReKCGEK8/N2h1vuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaZQrNhKBLmNOP3KotjNBX1JUlT5AFJRq2AmJFTk84Tl4ALKFIODjz8SBh+30WRIrkny1CXZXVLxQkFtdiZdR3HOKJ6YybPELJQ7dg8YRUa1GyP73gkOpwbm00mxi3U8VGWulZnCCQzwF1H5ALKnCirCCKB2pAjH9oyoEtoDP5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=jw96WrCm; arc=fail smtp.client-ip=52.101.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="jw96WrCm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqRig+ljAI9pZu0PRTDR9cPiLHBa2v65l7J9aJl1rUP/Bmi/rw4DuAWOduxz40WfEk8LIuBpOwng7gCqXHPbecieaIy+ifVDpt8fx+XRCgiXIh+1f4KnEYrEkKPw3rF2uM6mBgbJ4cLYWKcKoLv+LeKFCFSn8e/H2sxYLKzlMjq+/NqMoV8EIM9qY6wOewhHqxZKuN+cA+SPJpswUZWA+jqks2VYniGJXwRl27VNcNL5zs1kmg9UOfS+9f3WcDQludgjD2mWOSvSsB5s27HVpQDft+eJV5cl7+3OdEQ0Ra8lQpwbCuTqWhOkW6ka50p15iq6+6n6y1eSI2iaewghOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ5sQn4FlZBcYVMs45uGu1SZIrkdHjMRgfTx/MT7wWM=;
 b=vOyxvfbKbuQJ6ls7jX2QYmxPERTYOd1UlcTP1UkZ7du1PGe0sFKrp1fWj+IaRGch388N1RuwXKc89Ie+8BVTt6IQoPv1tsCPrSA8NE/cuQKRHliKt7hHAVwHEu2rguhWd9VD/4WIWXKWIp0bM5stNTMUlEkHWz1YKVqBDopqQc/trFLmYVRScWaq+y7WC0VHfV6ZPbEzlvMWO6ynInad7MKugsdARXFlQ0t9cX5O+4BjfHGJJzTKzqDEbQ5ypGbfhQfHNjHLQvBpArcHgCVuhdX2gA0Xx1SOC+vxpBn0YTmgo/N2hXavoq7DHjBvnmjlk0n5Begglfi3dzy5o43z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 185.67.228.71) smtp.rcpttodomain=korsgaard.com
 smtp.mailfrom=bachmann.info; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=bachmann.info; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ5sQn4FlZBcYVMs45uGu1SZIrkdHjMRgfTx/MT7wWM=;
 b=jw96WrCmOSroHp7iBWwsNIG1nkHI32bJlnmr9ULAoLYUXos+L6Asvdy5pPKPaUTAQ0vVrL3NKbzDyree4OEgKSzzPySzNq5T1s/jvSZZwuKxKaVtmu87lldrwSddtLkDcdupNfUj5yCmU6R054Ew5cbifD2OG1h7G7sYQsiQtwA=
Received: from AS9PR04CA0170.eurprd04.prod.outlook.com (2603:10a6:20b:530::14)
 by AS8PR05MB8327.eurprd05.prod.outlook.com (2603:10a6:20b:3c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:06:09 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:530:cafe::a4) by AS9PR04CA0170.outlook.office365.com
 (2603:10a6:20b:530::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 14:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 185.67.228.71) smtp.mailfrom=bachmann.info; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=bachmann.info;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 bachmann.info discourages use of 185.67.228.71 as permitted sender)
Received: from webmail.bachmann.info (185.67.228.71) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:06:08 +0000
Received: from ATFKPCLXMAAB.bachmann.at (10.204.120.2) by atfkex03.bachmann.at
 (10.10.10.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Mar
 2026 15:06:08 +0100
From: Martin Aberer <martin.aberer@bachmann.info>
To: <peter@korsgaard.com>, <andrew@lunn.ch>
CC: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Aberer <martin.aberer@bachmann.info>
Subject: [PATCH] i2c: ocores: Use read_poll_timeout_atomic to avoid false poll timeouts
Date: Tue, 24 Mar 2026 15:05:56 +0100
Message-ID: <20260324140556.2249039-1-martin.aberer@bachmann.info>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135249.550925-1-martin.aberer@bachmann.info>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: atfkex03.bachmann.at (10.10.10.31) To atfkex03.bachmann.at
 (10.10.10.31)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AS8PR05MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a416dee-86c6-4371-0da2-08de89ae7f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sL3Vab8I3G4Ia98ZH9hadSBuWeXaX0M5QaSzIWxcvaizC5pyrlmKWF6ZlQGfhNq2Gyq9oRmbAOmjMslXHGYvilXzVmoqdYYqOSzmTHCfNxtEorpIYndpEBG9Z3GhdowPMWqG7Ko9+D/Rosu42UkrPt+0I8kmrAVyS9m9OxP6HfL2daU0AbWcf8htxkfVIAt2t/iYVlUs+Hzwphn0cqb1c2tsZexyW8pX8ca9DBEfQBScgyQcxyB4vc1VwUY5RYuHJFfqet9ERmqCGH3r4DL8M3dhfdkuWszbPw8GFxcjjGbRabfaeYCnk6rK2U54KDYRLdaFqIC1e/ATD2QdE/eokJdKlMM/Ry1wv8qrxHd6ZuuLjppW3zhCEf2QGLuxXNNQy79NakZzXK3NhHhFomswF9YL1RpiUh84EdwhiTqAWUCe/uuC+3KfdZlaAkIZCqr+qY1FMhUN6Flkf4VdSFxKU9Vg/sBVKQ2LM+9r9NPBVXo9D7TOaSgJ3btykDxv0n8xNGOEjbGZENIBF9duqFgDoDErE1TuFfr4YVLNLQmY6X+UDC0rzLo+Eevr3oKTx6JNyEx5Ak5t6qFBOmP1qLZh+JLfMp9d84xHEWSCR4jXiAGOnx0j/TT0Qq/d1OgrMNkvjvZpxgUe0nmY9pYKP0e+g9SSItrbEfPG4m/QPIc6EX50+KQ8LlPj7L/muxanqamIaDzPvEFiJyL8numikFs21pTVxzSfS5modG+kGGT2DFR6T+qIwaaTPvlE0qXwhyDVlsLy8EO6ZpJeJRIi6ZPlhA==
X-Forefront-Antispam-Report:
	CIP:185.67.228.71;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.bachmann.info;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4RJFVOk6QNqpDVh9AY63znm5ubQKAR+1k4buNsdN7xeowAma21Z95xuelT6/i0l+JYd25arpeLNLIZbJQ94tu/EXQGABGR191IFSsQaY6GNTMVm7cGJqjQvKBo46NMWToMtgNLXPfEcwLWh2DPk+0iZmsCOHPWZyYCWalJ4TTKrGKCvfKxWifwNkwDckY2RF7ktXqA6nj9v1vaib+H7UYiBjgsDlW7tVlVR3zyavg0TlvRX1Jszw3d3/O467QyVMQHQby0vYHVpxGrtVbUMREYhZjgxkyLKB5S2ZveQg9BIImPTooWa6fT3IUlty7aulyfUK5PDoHNzcvp8xwMIAsiYbJKihh4O6aeMyz1eaQNkWQ0Oyux9bYUE8UtHoe0+bPwz6DwyLi1tU2y0bRaznHMB9KNag/RwPbTRqicmJzEkQdCaGn934bn6XFenfpcLz
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:06:08.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a416dee-86c6-4371-0da2-08de89ae7f74
X-MS-Exchange-CrossTenant-Id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e3bace4d-d2e7-4d8f-afb8-152509ee3f1a;Ip=[185.67.228.71];Helo=[webmail.bachmann.info]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8327

Replace the manual polling loop in ocores_wait() with the kernel helper
read_poll_timeout_atomic(). This simplifies the code and ensures robust
timeout handling. By using this helper, we avoid spurious timeout errors
that could occur under high CPU load or preemption, as the macro handles
timing and condition checks atomically.

Signed-off-by: Martin Aberer <martin.aberer@bachmann.info>
---
 drivers/i2c/busses/i2c-ocores.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0f67e57cdeff..df6ebf32d6e8 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/spinlock.h>
+#include <linux/iopoll.h>
 #include <linux/jiffies.h>
 
 /*
@@ -258,7 +259,7 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
  * @reg: register to query
  * @mask: bitmask to apply on register value
  * @val: expected result
- * @timeout: timeout in jiffies
+ * @timeout_us: timeout in microseconds
  *
  * Timeout is necessary to avoid to stay here forever when the chip
  * does not answer correctly.
@@ -267,21 +268,14 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
  */
 static int ocores_wait(struct ocores_i2c *i2c,
 		       int reg, u8 mask, u8 val,
-		       const unsigned long timeout)
+		       unsigned long timeout_us)
 {
-	unsigned long j;
+	u8 status;
 
-	j = jiffies + timeout;
-	while (1) {
-		u8 status = oc_getreg(i2c, reg);
-
-		if ((status & mask) == val)
-			break;
-
-		if (time_after(jiffies, j))
-			return -ETIMEDOUT;
-	}
-	return 0;
+	return read_poll_timeout_atomic(oc_getreg, status,
+					(status & mask) == val,
+					0, timeout_us, false,
+					i2c, reg);
 }
 
 /**
@@ -314,7 +308,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
 	 * once we are here we expect to get the expected result immediately
 	 * so if after 1ms we timeout then something is broken.
 	 */
-	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
+	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, 1000);
 	if (err)
 		dev_warn(i2c->adap.dev.parent,
 			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
-- 
2.43.0

