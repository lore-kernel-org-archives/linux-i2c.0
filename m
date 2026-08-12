Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F84248DA;
	Wed, 12 Aug 2026 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535130; cv=none; b=H6MMSsIjllKmrUg5n8o+YCEV5XJRgcPc/LiPq8psU93w8sWF97k1LPIS4RiBJEAcF+3qwOzbC76a7tMCGH27OFg96tDLtArsKHhlZcxegpLEvgms2CHJk4qDT23FYAUBAg6qVxIxgmE34DNVlHrCBYDnwL+WKM0/riBKmHN/+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535130; c=relaxed/simple;
	bh=ERD2vttEApXJGpTFT4ZjRzBGTzf2gva5/7zX8/VxokE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkJ0oIbwsjmMBVxzesu1T75gocBaM7GiVjRU7tjBnp5eVhhdhiZ9PGDopO+xJPGoXHyJYsaaPgK+1boDvhtXm/6ynDwA/mrY/6Ix3odK3bhKze5VuvB+tWIFhgfOLyKONfxmV6Rm9laR3UWEP3E7WgHjrvOJ8gAT7Fjc01jBlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lTh5iBDv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lTh5iBDv"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB4SJW1629434;
	Wed, 12 Aug 2026 04:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	WRQHk5qTarqbLu+F1qNumlCoxPiRaxpk2Bt3YQ6A+g=; b=lTh5iBDvvYSdN4pwW
	C8L7LiTwHiF3DupORcqcLcd7mvScVZlDxnnNTF/S5NeZpfqV1tK3etYD3dFeWt/G
	VKIl2iNpgDZZkr+eCNegeWpnEiR6U7WfHb1ZKz3bfSWcZogupT5X3ATzml0vlJmv
	vCM1wenDIbbnqPKexfRk6RJMLF2yA2ZB9lW4bHT2+WSVDirGhFGAy8pgxgwaUBJM
	PY4m3AM3hFhuUR6ORkjBn2wRs2uM2w/OcCRTzT8b1Gdm1r5Yq8xOudGzBE2+Ho3z
	h1Icq8HSB+649z3OZQF49qfTaUCDh0Es4Tj4UfKOHM8f0akX51gseuthGosnZYFl
	AhFAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyjvyybdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 04:45:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 04:45:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 04:45:19 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id 5F7253F7041;
	Wed, 12 Aug 2026 04:45:17 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, <bbhushan2@marvell.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Umesh Kumar <ukumar@marvell.com>
Subject: [PATCH v3] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Wed, 12 Aug 2026 17:15:14 +0530
Message-ID: <20260812114514.3817964-1-ukumar@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=QJ1YgALL c=1 sm=1 tr=0 ts=6a7c5cd3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=9AgWGjU10VSWC3nbNTEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hENFzgLBJO9PfPlSIeBfCwSx9SPL-3t_
X-Proofpoint-ORIG-GUID: hENFzgLBJO9PfPlSIeBfCwSx9SPL-3t_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfX2WaI3EzY/mmY
 F6a1DL/L8X0iYQXVoav0PDmYdC1Iw4hqCOmnR0INCF5+I0uUi1ahsdE/10CA6dl5mCxy2NG9Sbj
 AblKOHUNPfw4TWurATt3YXSK8oD8vJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfX9d4A8ryd6NOj
 LQgTDrMo5cjkhQbesbCMhEg+7rKAxN0LU9/J1EqXC8LaTwZ6iGp+4QOltn+zLcEQHjnMga0Tt9n
 gNTf0/AFCgQgukyeoo5ksgkmT5pvETWVD5dx791MWnoCpLqWKjx1LQdZh4szC5x2hW0Cwy4O6a6
 vFYIdOvb0uDfYQiZ5dodYIeoqxpb3OeGuX3OVOBRfkbQswNK4Cm+rJuVvc/YLy8u9M+hJdT8wzu
 iakg6slm5EaqusUdfkF5fYqmsOz8wct9LV30n3+sbvYbICbNF3YS8ujF0CrVnNwIeK83aUWY/be
 Xr1RGs2IjpQX7Cm7TG3vFqzlmtIM0BOj6PKu9QmT+Zb4DkPtjIdt6iyKwlFOog9oPuMf26eZKYe
 A6cz/P90J0GqRRwmUEjeBe6fQFemJx4GIPmzZ1bqYocm123TOQ4g5mgdQC9BASg/BCJjBqCUIK9
 OkHmEdmKzDRev8yoVnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01

DesignWare controllers synthesised with the Multiple SAR feature (e.g.
Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
(bit 19). Per the Synopsys DW_apb_i2c DataBook (Multiple SAR feature),
when this bit is set the core acknowledges the address matching IC_SAR;
otherwise the address is NACKed. The slave enable path writes only
IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
its address and a remote master cannot reach it.

Set SAR_EN together with ENABLE when entering slave mode. The bit is
reserved (and ignored) on single-SAR controllers, so existing users are
unaffected.

Signed-off-by: Umesh Kumar <ukumar@marvell.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 10 +++++++++-
 drivers/i2c/busses/i2c-designware-core.h   |  8 ++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..8ed0b588d67b 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -374,7 +374,15 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
 		regmap_write(dev->map, DW_IC_SAR, dev->slave->addr);
 		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
-		__i2c_dw_enable(dev);
+		/*
+		 * Per the Synopsys DW_apb_i2c DataBook (Multiple SAR feature),
+		 * controllers synthesised with multiple SARs only acknowledge
+		 * traffic to IC_SAR when IC_ENABLE.SAR_EN is set; a plain enable
+		 * is not enough. The bit is reserved (ignored) on single-SAR
+		 * controllers.
+		 */
+		regmap_write(dev->map, DW_IC_ENABLE,
+			     DW_IC_ENABLE_ENABLE | DW_IC_ENABLE_SAR_EN);
 		break;
 	default:
 		WARN(1, "Invalid mode %d\n", mode);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..b237d093c562 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -125,6 +125,14 @@
 
 #define DW_IC_ENABLE_ENABLE			BIT(0)
 #define DW_IC_ENABLE_ABORT			BIT(1)
+/*
+ * IC_ENABLE.SAR_EN, per the Synopsys DW_apb_i2c DataBook (Multiple SAR
+ * feature): on controllers synthesised with multiple SARs (e.g. Marvell
+ * CN20K) the primary slave address (IC_SAR) is only acknowledged when this
+ * bit is set. Must be programmed while IC_ENABLE.ENABLE is 0. Reserved on
+ * single-SAR controllers.
+ */
+#define DW_IC_ENABLE_SAR_EN			BIT(19)
 
 #define DW_IC_STATUS_ACTIVITY			BIT(0)
 #define DW_IC_STATUS_TFE			BIT(2)
-- 
2.43.0

