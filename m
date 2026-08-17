Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F263C2BB0;
	Mon, 17 Aug 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956035; cv=none; b=uFK7IzPEOBq9HT1zrhKdtXYOo5aALPolBOCVfrUPp3T6k4nqnl4VD0eF37zGgpBMNLG04zbDvOnGUFZyvVH06voMY9IqrxV44EFHmqsyW4Do5uPWanjunQJfc9xb5D6VDM01MYhGbjBakP/tP/ItabluzqIOok1m0izE+OwSY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956035; c=relaxed/simple;
	bh=yojrIk1uDZt5HRJZ9Kp6bd5+2IwrCV07VWwK59vUibs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G11gXHMbdNeIRJYH91jywq6Ah3gJpoceFM/mbNPDAwZWmKi7igqCfUO66AuhD4cWLAO6eAfSYrnY2noczeaV3fJRmEjPR1mLSGJPF/fDcLuAkZj63GEG9maZMq+L4JWD7XtZUHQus2XcXByGRoc5LSX/YmzusdpEwB95ufE4Mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KMC46MF7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KMC46MF7"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GNRFjd1364775;
	Mon, 17 Aug 2026 01:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	cUxkoLT+pGtSPrN6FnA4xzBepbYwjGvRg+DkpSsfA0=; b=KMC46MF72ujs+O5ih
	k9tLwIVoNqQjy60vuB+4GRSEgLh9OfxNp4MCb2pr5go6Nh5j24WcZXzumUFnYDun
	1I1GPV2VrlPR/sW0HgTEjG2bpRXtIeng3p51vzyExcixxz2XXW+pDi0p5D/sqRa1
	RJ28AAwPmZwx+6yVd7AVdJr2M9XvYvl/0xgwec0LPG/JkYK/onfirTrUbaa/UUat
	u0C4xte33tIrReqpR0s43x+2S/TgYc7YVdbntDNr51AlP25iwXEs3kcn8n3EMcT1
	9rermJ6GlRYPAiHFfjxABEtifFG/M4mfqav8TfGnmoW+0Bg0aBfQHX2EcLfpyfce
	0V7wQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g38v8hsfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 01:40:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 17 Aug 2026 01:40:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 17 Aug 2026 01:40:28 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id 862473F7040;
	Mon, 17 Aug 2026 01:40:26 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, <bbhushan2@marvell.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Umesh Kumar <ukumar@marvell.com>
Subject: [PATCH v4] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Mon, 17 Aug 2026 14:10:23 +0530
Message-ID: <20260817084023.176584-1-ukumar@marvell.com>
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
X-Proofpoint-GUID: C0skv5F5CjcPC6_QorZbcYSxyBgz-sDe
X-Authority-Analysis: v=2.4 cv=ZpHd7d7G c=1 sm=1 tr=0 ts=6a82c8fd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=T6lopHUakFnDhHt3QoIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfXwI5F/MmsJUZV
 DcDnx3gmyU+rdviIcRF+AQC+nbPqyyxmj0Gqj55cdbvS8+h+oDPyrSkuzoipbIghcq+ogSKxwf4
 T+uWjVf85wx3JrffEbxoq85RvtfnrEerT/FSpQoYimdTp6/RegFHLTHvmzLyhZpozKjlLLExqGJ
 vvK6eLd80QeIe0XZV+TgSCTnS4k6aQEJI9O37W5WAVkKvmS5taDAMAnnSEndUhoz57QUyGeZpZ1
 vtHMQgAnf4SHwTlK91CGXeTrq3rgzSi2VetdxTM9if/O+L5C/49n2KQZbd740l+k1xrHzl/pmAq
 pRQewSsWd7l93+S6/1W3NUwNs4nL4Dsdbw62IPlXtRVzv6YcDie5vVPu+Y7tBq7RwyhzLoAX1ml
 CGrJloOYNJ8GqacHu5mC7UPsT9LefWo4YTB+uiOsyz7l4V93cRHyN2w7ZNJk4s6dAlqlHMqDXsn
 t8wkThVjj8Zfuif+C8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfX3TyIPPDrztYy
 jqu/whtFKaKOzZeJ176TlRnC9Goml5asJhaBx8y0hTvnoiesm2rULE4KACt0Nb25+nceKULBpfR
 ZIupcaVh6G9lYxFhdf76+PwumNFUCT4=
X-Proofpoint-ORIG-GUID: C0skv5F5CjcPC6_QorZbcYSxyBgz-sDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01

DesignWare controllers synthesised with the Multiple SAR feature (e.g.
Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
(bit 19). Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
feature),when this bit is set the core acknowledges the address matching
IC_SAR;otherwise the address is NACKed. The slave enable path writes only
IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
its address and a remote master cannot reach it.

Set SAR_EN together with ENABLE when entering slave mode. The bit is
reserved (and ignored) on single-SAR controllers, so existing users are
unaffected.

Signed-off-by: Umesh Kumar <ukumar@marvell.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

Changes in v4:
 - Added DataBook version (v2.03a) to commit message and code comment.
 - Removed duplicate comment from core.h; kept only in the .c file.

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

