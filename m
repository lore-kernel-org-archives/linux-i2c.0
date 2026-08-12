Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF92F6931;
	Wed, 12 Aug 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786506030; cv=none; b=bUJVuRkRuhhFNLNAY6bb0G5c7wKu2rpgz0zR49s7dG7QnCSSWwmAmPMxSCzdyJIcERcyXQeULp+iI9PbVfdSwYn0KQJ+eq07Rd01twt9Q9UAEn8b/Rwm/6fpzyffXsBpodNC7bJCSwf1Yk78MD+1q7SilMOHbhuzw4cUFjacCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786506030; c=relaxed/simple;
	bh=BcsXN0Ib6wAZjIIulVryN09L7ihMwG/FovRH40Br0Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5YYfBcITZ1x3QhDFFDzvQn4wXHsJFkf3lm/hob2bmSIsQdtF3FsO9xFQ3XNoLcgAZ2PXR92BRAp3bLxyqxMt7wRFa4C33/pFf0mVrgZ3S+XMH6rY5didceINW6ieq3zH4W3DSKjJN1BbaKP1nkpvbCvz0alyIF2mVgo2beOdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z+SJ8xlc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z+SJ8xlc"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C2gqLf1576587;
	Tue, 11 Aug 2026 20:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	yN9aTDjTBXOLgSB9yxyt/xn4zUKlKWvUMQM8Q1nQQY=; b=Z+SJ8xlcxMUwY0rcs
	Ya6ATJ7RNQ4g96rhdYUcTnmlzDvwCP0gn672sGmCtrwGswZNqE6HH7EWAggRVCCg
	qAq9If7krJ+J4IHF66um7sQvEmr0g+dse+xNnBVzHuUSaF51HQqP3sqzigxJpGSI
	yi4b39yV4R7UEULj+50mc9WHO9N4vcE6BKr6Yu5oUuu/FQDlSw6tPEYFWCNezXxk
	L+FJrM955+cL9FDYtx6ZxWy+mkzNlfR4U5CZ51kihUr+Plvlfv7jbf+rrrqBqvRY
	J3l1IodbQr74oIafsii+Dw1SOkGanK/0mf7PcD83hm11z+xUlO3S0xKmqaBgfpft
	uUABg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g0deh8m0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:40:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 20:40:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 20:40:22 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id 90DA43F7052;
	Tue, 11 Aug 2026 20:40:20 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <bbhushan2@marvell.com>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Umesh Kumar <ukumar@marvell.com>
Subject: [PATCH v2] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Wed, 12 Aug 2026 09:10:17 +0530
Message-ID: <20260812034017.3654884-1-ukumar@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804041842.3205356-1-ukumar@marvell.com>
References: <20260804041842.3205356-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfX9u9gyYMzgZmF
 GfwfKAXC3kYd0U6btTufRW29oI+MXWfYnLABuPBWJz7ZpMacc8L3XEV8qqpMy42Q+FG6sJFTxuL
 RKW0d34WlshYg/5eJyMLSf+xOdhd2mQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfX5m8whrgiu5ex
 t3NlBKGCtwKf51btK6mKZ6l8t+IGsY+NUI1er89TNxoz16DQ/LhyG9ru1Vs7cXb8HBLOvrq6rtg
 bMBelmjb52YmMIjgrF6XC+UvyH/CDRs/lS3apZD54YCCCbI+7aPq2fhQXRecjXjfBX1vhfCuW0o
 o12sD2s45p+zjVenQsV+fRuVRGtLQTcc40vGWYQ/8AWfAcMXn9yqKWf4Glusv0FfwvUAip8syyd
 BfYy8vW5m9LGSsC0mDo+5qQr+YAEFiXZlxjocboTkVxhNrtb0BL3FpsR0lAwuGhp+NoFd9AFUoV
 NA4y+APVSycYee6AyP9bZtO84v5ooWt1OjoehM7FHXNIHzDvdz+0j+PZV3QRiguwpAaRUcCrx1U
 e3EhLeFimXx9o+l9KOqhZzjapTJa4FV+y7FrcrRtO0hoC2p1Eg6iScRLmvMCSP0m4JKYV1SGUSk
 k0G4JSLYfcIYZWwEfDg==
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a7beb27 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=gLBk0peu4sbVRRmL7qUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EPkpVwX6wfXGLX_bw1gRbHNLWf0fVBGJ
X-Proofpoint-GUID: EPkpVwX6wfXGLX_bw1gRbHNLWf0fVBGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01

DesignWare controllers synthesised with the Multiple SAR feature (e.g.
Marvell CN20K) only acknowledge traffic to the primary slave address
(IC_SAR) when IC_ENABLE[19] (SAR_EN) is set. The slave enable path
writes only IC_ENABLE[0], so on such controllers the target never ACKs
its address and a remote master cannot reach it.

Set SAR_EN together with ENABLE when entering slave mode. The bit is
reserved (and ignored) on single-SAR controllers, so existing users are
unaffected.

Signed-off-by: Umesh Kumar <ukumar@marvell.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes in v2:
 - No functional change; dropped the RFC tag.
 - Added Mika's Acked-by.

 drivers/i2c/busses/i2c-designware-common.c | 9 ++++++++-
 drivers/i2c/busses/i2c-designware-core.h   | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..b6f3d71cf268 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -374,7 +374,14 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
 		regmap_write(dev->map, DW_IC_SAR, dev->slave->addr);
 		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
-		__i2c_dw_enable(dev);
+		/*
+		 * Controllers synthesised with the Multiple SAR feature only
+		 * acknowledge traffic to IC_SAR when SAR_EN is set; a plain
+		 * enable is not enough. The bit is reserved (ignored) on
+		 * single-SAR controllers.
+		 */
+		regmap_write(dev->map, DW_IC_ENABLE,
+			     DW_IC_ENABLE_ENABLE | DW_IC_ENABLE_SAR_EN);
 		break;
 	default:
 		WARN(1, "Invalid mode %d\n", mode);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..35eaf2d7404f 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -125,6 +125,12 @@
 
 #define DW_IC_ENABLE_ENABLE			BIT(0)
 #define DW_IC_ENABLE_ABORT			BIT(1)
+/*
+ * On controllers synthesised with the Multiple SAR feature (e.g. Marvell
+ * CN20K), the primary slave address register (IC_SAR) only acknowledges bus
+ * traffic when this bit is set. It is reserved on single-SAR controllers.
+ */
+#define DW_IC_ENABLE_SAR_EN			BIT(19)
 
 #define DW_IC_STATUS_ACTIVITY			BIT(0)
 #define DW_IC_STATUS_TFE			BIT(2)
-- 
2.43.0

