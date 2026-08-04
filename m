Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01467233926;
	Tue,  4 Aug 2026 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817147; cv=none; b=Msoa230m79StBKSMex+ngzDIFlA5Q+1yk458rlAu2xYttSgDMfpCm96cW7F0ESWCmUExFAsylIgx2p2iaXhXdfIXx4N2BCRU6Sd39Jo3WNS7qK3LKCIJyptD7rXZF4YEMtDWf/quJ7gCir13bxG9k7QoxDCb6vRnBCs3dKbbSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817147; c=relaxed/simple;
	bh=ZW3Qgwms2rNtj0uL1lNQTkuFLMiHguGod/raWk9kOLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abtiQkJv076o2PdBXCL4z72vXCmsE3IRb6gfiH8Bxxf2lU85KEXnHJtAeWCcZxcDmALq+cZEfTwpPGcmhno4BTUw3VCmxkhxiQZO7ULM7MwqYGj7NBKv1RFit1YsmEmlWGQJ596A1NTYi79+PrRwDrprxDxQ0L8ogD9gDfDIFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eJMG88z5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eJMG88z5"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67416Vu41839087;
	Mon, 3 Aug 2026 21:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=B6Fkh02NxHkYwalS3mo5r7J
	i9ZiMiDeIxRj4LKwZ0ug=; b=eJMG88z5qKZ8eKfUPmZa3/Q84dG5tG0qf4dtPGL
	/4dkP2e/rONu/pC0lCKXlE2zstU/z3aMit3C9lAOvBit3iklSHdYN1c3JYsjgGvw
	wumayFJmGn+fvpKR+qEdYnShkzdjMWFBL+F7/WD6qZ5IRqfjLWOlIpStpl75x8JU
	xTEoBvz01x8ca27QZtjGWF1uNaPgK3cWELM4OAD0e0qMkRbyJ6P0vuNb9vUNTc+R
	/SNToPhrGPU7K3+C9TRRokqgnT5Ho0eltl6mj+emEoZnmwz2P5C7uOly2kLXEH/o
	N33atL6uMlfqLRKM49Ff9QeTyb1RIKvMUsBdfx2sRTpQCGA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fu4pfrsm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 21:18:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 3 Aug 2026 21:18:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 3 Aug 2026 21:18:48 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id 3FDAD5B6939;
	Mon,  3 Aug 2026 21:18:45 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bbhushan2@marvell.com>, Umesh Kumar <ukumar@marvell.com>
Subject: [RFC PATCH] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Tue, 4 Aug 2026 09:48:42 +0530
Message-ID: <20260804041842.3205356-1-ukumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _BOeKOviEK9ecxMWzhUWtDNWPjscyowm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAzMCBTYWx0ZWRfXxdufCXTuMdkj
 nkoGmiv2GwP/Fz7KpMBWn8joUn1TW9OCm3GC9XaI0VChmtWG/r+v9BbPwKbORklyMjpeR2v2VDg
 lUXuNRwvLa6GUr6Dhk23pZj3NWauZ+UpsLku8ODMCrCHzVVN1en4aUSwzuXtIVgIvPr1YwoRKMc
 vn5T1tCP9BQf1LTHck5seOEhnPgnBR7OzK2E60jSMshUm/EGMk3BwsIYXdrBFOmeAuehZCt2Dfl
 c82xtT4HKa1tVWo0Ahq4IhoWxdQA0byCrrd3zR2o2RaP4++xYWR1gcxGPZ2LhFH+hKpPcC6TM82
 6f5HGE7UuqIs+g0DCiHx1n7meWYTdD8luIr18uqKfgS2y8dyOfY3WcYqMNB1zFxrmHqD1BlaeRA
 /OHpEqKucgCPwN6HVxd9pCxtJt8dRN04b3KCh/rwF0d/u/IYIJzd+ieAyw0KSETezAiIqiIMePw
 yq5c0kw3ni3kTJR37qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAzMCBTYWx0ZWRfX+zjowILU4Qkg
 DcO9H8sUVHO9VIGzKsmnPzQOd1wd5wd9ZRDqTkp8lWo7AVzhzJ5Jm4IchgS6GxfYNcD7/OrP58P
 gdgdVe2ACdINQK37+O4jBMDlIje8pNc=
X-Proofpoint-ORIG-GUID: _BOeKOviEK9ecxMWzhUWtDNWPjscyowm
X-Authority-Analysis: v=2.4 cv=TPx1jVla c=1 sm=1 tr=0 ts=6a716829 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=gLBk0peu4sbVRRmL7qUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01

DesignWare controllers synthesised with the Multiple SAR feature (e.g.
Marvell CN20K) only acknowledge traffic to the primary slave address
(IC_SAR) when IC_ENABLE[19] (SAR_EN) is set. The slave enable path
writes only IC_ENABLE[0], so on such controllers the target never ACKs
its address and a remote master cannot reach it.

Set SAR_EN together with ENABLE when entering slave mode. The bit is
reserved (and ignored) on single-SAR controllers, so existing users are
unaffected.

Signed-off-by: Umesh Kumar <ukumar@marvell.com>
---
RFC note:

On our multi-SAR CN20K the slave only ACKs with IC_ENABLE[19] set.
Existing single-SAR users work without it, and the bit is reserved
there, so I've written it unconditionally. Would you prefer this
gated behind a per-device capability flag instead? The CN20K PCI
device enablement (which would set such a flag) can follow as a
separate series.


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

