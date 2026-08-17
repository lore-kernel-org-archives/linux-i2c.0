Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0399446040;
	Mon, 17 Aug 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983713; cv=none; b=BP3xhGxJrR0jwgwadH9gyeRWhDLHboZw9pidCCnRN4iJHD2u4blSj7Uw7Lg56iOUoJTiMj11lhuUSQQwWEF4onbzdCc0sKnUwraSwlZtjrtgLGJMVtxiAdSNnebe5GBI+HSYutDeyek5gNadSR8WSWAl8kkZ48WFZC4d72XrNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983713; c=relaxed/simple;
	bh=yaxfFhUClog3uDKVozaiUGHKRRL8HPjNZbutCz8L9bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhrdZKU5f9hH9hssoKxahY5CS30J6xaYNoOY5iO/u2f/YCDZh8E6v8esqAeiFtF5KT4XxERULX5UqDqsj1Cbf7tGIt+DgtiFUEbms/yGI6RCHxEy6f93kW5AL5Il1Sx1FXARE3pVNRZo7LadWbgHMl3GS+L0KSXJlaD4jAgM3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jC2lGRAw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jC2lGRAw"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFaDvJ2981265;
	Mon, 17 Aug 2026 09:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	o+LD5h8XeNxuG9tM0x3yDfwTG0Gu+QIfzuJAu7YuLk=; b=jC2lGRAwjd49zqfY/
	4qf07yvgXGr9m1bB7Ndri0nxwx4p7eR4UP9bun30OxFTJrx3d3D66nnTbeLvOXc9
	zexEUIfWzNs41Qy9ZbTcCMojbDopDYlEMcobc+nBL1uwz3mikVNLs0k8wwgxN2QO
	/GaW2uNleimPW7NAf8WmGjRnnJ92MqxwQF0tguOjD27Rw98iht6InpWjNLmqSkyp
	/ALKLUBkQI1oZMwk8t0pxmw/j8ytPZrmfI5ekwwYQg3gg2QQOR/UKEVP0yketGxf
	7GVvVRVWWGnFP69v705K7sKp+6lMcNnup9k1RAujFqG1aiMaLox2iYj0f7F3v80E
	RaOQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g3cc62wkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:21:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 17 Aug 2026 09:21:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 17 Aug 2026 09:21:47 -0700
Received: from marvell-Dell-Pro-Tower-Plus-QBT1250.. (unknown [10.28.34.91])
	by maili.marvell.com (Postfix) with ESMTP id 818E13F7040;
	Mon, 17 Aug 2026 09:21:44 -0700 (PDT)
From: Umesh Kumar <ukumar@marvell.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, <bbhushan2@marvell.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Umesh Kumar <ukumar@marvell.com>
Subject: [PATCH v5] i2c: designware: Enable SAR in slave mode for Multiple SAR controllers
Date: Mon, 17 Aug 2026 21:51:41 +0530
Message-ID: <20260817162141.300658-1-ukumar@marvell.com>
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
X-Proofpoint-GUID: OGGfjo6r9YdY5lbRfXUaQoY-bQQ8KBbW
X-Proofpoint-ORIG-GUID: OGGfjo6r9YdY5lbRfXUaQoY-bQQ8KBbW
X-Authority-Analysis: v=2.4 cv=NNLlPU6g c=1 sm=1 tr=0 ts=6a83351c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=T6lopHUakFnDhHt3QoIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX7qM1OUOi62+q
 iRI5Khs57cbSNyyYWoDzt9cQCmzFQCpyIu/EpP//MsT0a7Ja+8eKu+gDEICQ4wzc9iXIHMOTQvz
 ZWV3W67AvoWM3gy94hHX17LOgZBMV6HGiePFSNbSDHv5/RS2t+LyeGbY07pjTl3DqvSbAKlFe7g
 LQ0dYRF46jnwGPZHHsnnwPF/Ew9u5m9pAPR4XIMF6TXGf1YTQMM/NXYey9VR1knynCTjMTwaExK
 jBAr92ztwqynurbCP0HqNWMNw98vsg+7x58OixKhC2fqFrTTWmOhg0oMG9iuHSBJQxYPGP0zUCi
 Xk5wQ293q3pe7gmAcuuPUozcjBLOyDQ2u5Aee5fJh4wc9FLSyEhleJ0hWWE4UiZhgfQ1JxLex83
 yNQdfwxrlHWxnTIXWmoiWxyNCp25OUMbX21UIJzuhX+zAlXiaKLaUzcurwmDBYq9TjfO1EmjTQ2
 Vp6ZWARZ2FA/0QoGK9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX+jspnMnlLMHX
 z++TjQuHUXwcKmOZ71yxywgpQguyOqT7pT1rxyTg9lt0PKt974PuQAxjgO917KpMnrcDjpiqeIb
 xrjOv7nrUhidjkmZLEj/E1Xfj/mCH00=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01

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
---

Changes in v5:
 - Fixed missing spaces in commit message (Andy Shevchenko).
Changes in v4:
 - Added DataBook version (v2.03a) to commit message and code comment.
 - Removed duplicate comment from core.h; kept only in the .c file.
 - Added changelog.
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

