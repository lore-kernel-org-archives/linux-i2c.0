Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C66257827;
	Tue, 18 Aug 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064197; cv=none; b=Oivpq3U1tKeaSX9Cxot2gmOhcz5c/BELh4+Z3+TzHAvpm9X/b9dob7D7gxLQ5B+27tvukzc88oVGskFt6Dqw6gdzEbOlKWjtwDRk5cjffSr0niBLTJgEC2P4JSkZadbovXBNH7EOQMQKH/aAiFR9byZwSYmtYHrx3mvqxSEed4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064197; c=relaxed/simple;
	bh=ZKCahBDrEbjKlh1nLwxqFHURJc7ZiKY50+FFFCDAqpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfU6SfIDimOTG+RHlhtrIVKMY5FuEH3R6hbPhtr1CCejMli+pu4LWQm7cHINSlUbPxgNwtQID/RsEfPxcNbV3IVc5X8Xqg7OAieF0RWGrgft6wAD72hqLsL+fcoXtNh33o5FGxIJkZXlaHNZsx9gLxMWmuZJBr2HKcP/yPlh8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SyhddAyM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SyhddAyM"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3lE11196826;
	Tue, 18 Aug 2026 07:43:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	OOyKvXjNjxVuztluSz2VuyWnqGHoUit3AkqeISrZ+8=; b=SyhddAyM8BG4nqMJ1
	lyfCFsdbs4V4D6D3GMN9Dp15AYK/hyqiI7wielxMo5Q+TpuPfKXi2cjk+Rbk4kW4
	uUnsMSrRUqp+PiQC6S7J9hSyzw0XyO/F4Meh73NLzYyJXESnGuVpz/GtqpJJr7A8
	1REBPlphQL2nlkAoC6CWj48IvuqX2HyKUTOHdHbE/Jyf5biimbZlGLC8Np63YzTy
	pSdpRoWH0lumF29JGJ583DG1KnRDIrebf+taWExO5FZe0ko/HTqGyYJiNXRHDBRa
	5KmNjJFJNL/LEqfAC7MWx/Iyp/09TcpLodYgWfWFsD/M2SOTQ3f7AMrxmvnCKOmc
	8nr9Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4kk0h0ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:43:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 07:43:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 07:43:12 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id BDB3F3F7050;
	Tue, 18 Aug 2026 07:43:09 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, <bbhushan2@marvell.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Umesh Kumar <ukumar@marvell.com>
Subject: [PATCH v6] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Tue, 18 Aug 2026 20:13:06 +0530
Message-ID: <20260818144306.357243-1-ukumar@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=T/G8ifKQ c=1 sm=1 tr=0 ts=6a846f81 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=T6lopHUakFnDhHt3QoIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: pnL_--y-5MSdYheEe7eYwnt5QwX4luIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwOCBTYWx0ZWRfXw6RuPBuMyzVk
 PZIeoTvSQ3MhF/l8lPgMM5VqqBhZYI0NEzt00uL5dvVIsLrebj1ET7vJFdJu6qKSCF3iwsC6ApK
 nKc7NckLi4xcbxA/tkueeZqbWtbFT4EbTfsrqAfwgIKmcM+eFtqg4lqZ0G4kjhq6BponyX6xL+d
 u44aY3GhdmBQ5yg3FqZlC8jSnq/DYe5h1f5TvvtMwUCtB0Iaey4wet7Nnt9sSUE77Q7oEZWx0Cu
 SMhMfdBXt8Tc9TVRABr+F1L5D019ivteIEoYRS4PsJfHdtPIKXWajal7be3ACUcZ0J4T7jWCX7K
 CBh0Pdq9UV0dusZ1qEUciR7aA2PG952igyVlB8o6WGtirihRGygTQEGkZdYOpfIfrNGvN7iZ9i9
 fHLvzkH4Jq+ivbymUo6/Kq8ibhUIZEoHqat8LBmuNyR3ish2z8UWmVluxuYHqcamw2iP6yTqqDu
 dHIzhz425KZ3CrrkihA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwOCBTYWx0ZWRfX0dn4nLii9xOv
 Q6FGKGSOxBYG8sX+l50ipEH2sOyREPAp8kto4PxJXiGC/vxsW1U9d7BQ87IxSVA4jOXbrRGX0gk
 nFBeBH8YLlPnvt5E8VNL7tYXp4XIdI8=
X-Proofpoint-GUID: pnL_--y-5MSdYheEe7eYwnt5QwX4luIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01

DesignWare controllers synthesised with the Multiple SAR feature (e.g.
Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
(bit 19). Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
feature), when this bit is set the core acknowledges the address matching
IC_SAR; otherwise the address is NACKed. The slave enable path writes only
IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
its address and a remote master cannot reach it.

Set SAR_EN together with ENABLE when entering slave mode. The bit is
reserved (and ignored) on single-SAR controllers, so existing users are
unaffected.

Signed-off-by: Umesh Kumar <ukumar@marvell.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v6:
 - Added Andy's Reviewed-by (missed in v5).

Changes in v5:
 - Fixed missing spaces in commit message.

Changes in v4:
 - Added DataBook version (v2.03a); removed duplicate comment from core.h.

Changes in v3:
 - Referenced the Synopsys DW_apb_i2c DataBook (Andy Shevchenko).

Changes in v2:
 - Dropped RFC tag; added Mika's Acked-by.

v1 (RFC): https://lore.kernel.org/linux-i2c/20260804041842.3205356-1-ukumar@marvell.com/

 drivers/i2c/busses/i2c-designware-common.c | 10 +++++++++-
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..880b9a74b3ff 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -374,7 +374,15 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
 		regmap_write(dev->map, DW_IC_SAR, dev->slave->addr);
 		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
-		__i2c_dw_enable(dev);
+		/*
+		 * Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
+		 * feature), controllers synthesised with multiple SARs only
+		 * acknowledge traffic to IC_SAR when IC_ENABLE.SAR_EN is set;
+		 * a plain enable is not enough. The bit is reserved (ignored) on
+		 * single-SAR controllers.
+		 */
+		regmap_write(dev->map, DW_IC_ENABLE,
+			     DW_IC_ENABLE_ENABLE | DW_IC_ENABLE_SAR_EN);
 		break;
 	default:
 		WARN(1, "Invalid mode %d\n", mode);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..1390c8862a68 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -125,6 +125,7 @@
 
 #define DW_IC_ENABLE_ENABLE			BIT(0)
 #define DW_IC_ENABLE_ABORT			BIT(1)
+#define DW_IC_ENABLE_SAR_EN			BIT(19)
 
 #define DW_IC_STATUS_ACTIVITY			BIT(0)
 #define DW_IC_STATUS_TFE			BIT(2)
-- 
2.43.0

