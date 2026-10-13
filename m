Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85D4D956D
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887443; cv=none; b=clgn3htwBQgT9QO3ZMnD7cusYAc4G5B0r9+YvfQCSr++6g1DMFqXrve4h56trF6QVyNrBGTzhPE6i7ICGoAf1SFSZzqEnurdDsr7meMvmEK0BMev3UiCyr6eZGatky8a0UyogaGgjimgcdi4yhfKr5X2a4mL5Dw8WwY+CEWDnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887443; c=relaxed/simple;
	bh=rlLDrbVxx7OktVNZZzwby0arcGlHr/lUer4SD6jeyv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQoQVv+vrdPiNcmUPPhdSkcNtSEAnyxVJlf+dSLmou5am0iuOoU6IHZthP+MmG9kUeXPssPqIh+K5WjPXx/fLGA5v/HsCdzCv8V+R34OF6oLep6Ig00YM+mzHu24E6NE6Y3KuJ1tyUxVr4hFOxmA37Qx4e3SmHVq5QNKD1dS5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YklR1vkh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZmzIPUt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YklR1vkh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZmzIPUt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8PxKT3907367
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S8NX9xiw5xX66h6BpN1qrXdTi4yOZiML317moCyPLXw=; b=YklR1vkh5yMY0LQH
	uw+mjIh8zg2VxD++c+5qNk/JTaQm7KTq5JfYLMxhSmJMLmvX54ZoBgFfgKLipwkL
	9bdWOaJ0k9pYFjm+b5QxbmmJnioX4I4KGr4WwWnd447sYwXttvUnJ+RElFQcH5/P
	JY1iTg9PCEly9ywPhfCHygS3uhOmF+1+ums829fWnJ+jaLxYBzwPDV3DVtD0m3wD
	4tdI/j/QmNUKO6v9rA+xW9807RZEI9WRgVxJU+LkeKAYUKLDCmMSoyfHr2/bDiP6
	1SJlB968t0DTqV7oVjlrA1Q/RECSGShZW9gCKURIbx9gOoyI8L3XquSEOIDFWa3O
	CZ9u2g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqu2cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc0b31ecaso576101885a.1
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887440; x=1792492240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8NX9xiw5xX66h6BpN1qrXdTi4yOZiML317moCyPLXw=;
        b=DZmzIPUtgxMSJclrjLNhr2RUUKCBc3dhVFQYiHokFQ1q3q/zlCMKJ1voGNCRmLSPIP
         ipe/br8guo8647ge3oFMSla0fy+EWVUdXAMzoB82aA0nXiqhW4gjHCZq4pKba75B9xqJ
         XACCBOhpz3QL9E+5tfUSVmGm1NmSLosyGKlUZIhanalTkYrzlPtz7HjyJhp9AdPtD7Aa
         6BKpqiiDo9xM8QSzozfAwIFOOIJPpZaOIcMtPjWw3ucrVGQGCwimvzJG/adnoQUUK7fJ
         jMuIJ/em6zqM7QpPY/h4BOZYyJexrKVkQ1ZqZS8P1sQAws3Z5DjNLspY0/RvLCsBc93n
         Ms/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887440; x=1792492240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8NX9xiw5xX66h6BpN1qrXdTi4yOZiML317moCyPLXw=;
        b=j5VkHfGXUdiEthnAipMhq4jCo7KlaGEEwN63SzdzL1+/Oxx3kGJISuywGJhxhhmc5X
         SCfNMOAYE67XXR5+XJcHndsP2jW039WO6EyvGjMLPYshaFC9x13/wR2pDpyFxSx8og/2
         GCvbRgWYreq26jhbzaGYcu+PJGU2QnL04XbWe7jr0icYbi/jeZmOGh3oHz61MFSTiAUE
         2HmTu9z2ur6RQ7L3xO793isMji2QgpScg579aJWVupvzWuqNjGQr4dZJXUujkOfOEect
         kODqQzl6f26/2tqIdiYwIL0s0Fy/SwjMij4y/T3Cy9Y83A52hjumpWU44U4zog2C0glb
         RjVg==
X-Gm-Message-State: AFq9FYL0Q6ApFM/G/gCo+QTc8cOTSCuyn/9eIaI8r9AquA2fvC70i+u3
	iPt5y7S8ZwG7V2mOPG8K8LARhEJ3gRVT5RCQwp0vAC2QxprlUH5xSo7NHH2Lfxk2UOt5bKdBBCb
	W/n4CzGhHX1iVgnzpAC9UWsLms+/24tz9SIxq7Vz8a9SDxTWZ2yPy8jjf9Aw9DNE=
X-Gm-Gg: AYBFou19Zu9osftZdGWssiPoAGqvuv10JDFPRlc8L0g4iANq+O8DZjTyn/W3ZAcZ52r
	LKYbFtwAbkr1z83C66G5Uu/kXkeC4DuuvSV+hR9jafv0PwJGfYifcr5OjQ7JHEwiH5fYn8fYTRo
	qbVEqU+SohHhuj5yQZvoF3k4kvcbEgyAR6O5qBWoxvs2p9ezGFVRJxVcZSd3Ywk6UtF0S1UGZIp
	hCJI4C0fyCIdjlABUXGNr09cyd9/wvC8bBz1npw8MmIkzoMUNso16fjuKCimwPqCkyzXwkLsDLs
	VVXdKkf9GfTmCoYjjeDOHahlPPGcwsxyRYm1diLdoqP4ErziwdkFjNBBSUb6EpO98UMJHy1r6Ca
	VyqJCHE0S5utRG0rGWBFxmKJknLTSws9rtTyCC49h7jsg66QncLLB9MCSCp7wbk71fTuV4z7Dl7
	D94wf6T+rmVeEB4/jAOXP9sbIitDOD6dk2qQWJXa98lGWV/jt50c4=
X-Received: by 2002:a05:620a:460d:b0:93c:b766:2bfc with SMTP id af79cd13be357-93ebd22539fmr2129255485a.17.1791887439301;
        Tue, 13 Oct 2026 03:30:39 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93c:b766:2bfc with SMTP id af79cd13be357-93ebd22539fmr2129249985a.17.1791887438710;
        Tue, 13 Oct 2026 03:30:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:30 +0200
Subject: [PATCH v2 6/6] i2c: qcom-cci: Add burst read support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cci-imp-v2-6-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX19R8L4xNQ1R4
 ljOThlVaqoDxohsdeWqN9gAs7b3BGiISDsYTUuf+VxLpIrt6T0C/XSiHXtXXuDNRUwUOdMhDEmm
 vuG7PRnL8PZx/O3aaOZNAcDTqe53RryZgg1hGUgylY1tRbAJ6maQBoyEidJNMWfffQxYzpPkPVy
 1MVhgPWyL0iWM/uxmq10AZtY5cL/MNVnUQVLUeXqQ3Kw8NCv01IsTru35xmm81TnEvCT3bfom+n
 zB3ododyH3LrlH7okAYRVBW0dzx7pLoX2lsvfqLwygWiJmr2m3GvVxFl2LXnSEUeb42Ks+DdPkx
 JPtWSQZVCdizm/t2xznfK+tOCQ3VlQkKwthM2j3cLYFrDX6NiyGTl3ESYDktY1Vj+QUulINesuW
 ZZ31bM+2NCq/k5WKrqtxMKXkFYyad2vsiXNkRXqeDeYmSISEF1IGQ9n5qAhEMq8W0ngDv5n+jFx
 ETbFJPDuBLpXVHVrajw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXxXKM1/4RVRLe
 qT4ctlAyunfNeulvmhedhg16Orguk5O3Vy0GTkOursTzHcHk/qArPVPI+X2FSo63Zypc390WRM+
 tV5IeA++pMYd8VwJSiUfoCcwxJVjNsk=
X-Proofpoint-ORIG-GUID: usgTWTHOw-XqJQXoXocIRO8lyNEu3Wjd
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace0850 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lNqXhXyNEWYzk-AvLucA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: usgTWTHOw-XqJQXoXocIRO8lyNEu3Wjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

CCI_I2C_READ transfers are currently limited by max_read_len to the
amount of data that fits in the read FIFO, as the driver only drains
the FIFO once after receiving RD_DONE. On current hardware this limits
reads to at most 254 bytes.

CCI v1.7 and later support reads larger than the FIFO depth by
generating RD_THRESHOLD interrupts as the FIFO fills, allowing software
to drain data while the transfer is still in progress. When the FIFO
becomes full, the hardware can also apply backpressure by stretching
SCL and reports this condition through RD_PAUSE_IRQ.

Program CCI_I2C_Mm_RD_THRESHOLD to half the FIFO depth on hardware that
supports RD_THRESHOLD and update the read path to drain the FIFO on
each threshold interrupt until the final RD_DONE event is received.

Older hardware revisions do not support RD_THRESHOLD, keep their read
size limited to the FIFO depth and continue relying solely on RD_DONE
for completion.

Also emit a warning when RD_PAUSE_IRQ is observed, as FIFO backpressure
is unexpected under normal conditions and may indicate that software is
not draining the FIFO quickly enough.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 163 +++++++++++++++++++++++++++++++++-----
 1 file changed, 141 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 9a8d201c890622d6c1f7b6b7aa2e0d7c075008ac..2ef4af603aa2b80614c6bff3a56424da6e4b0b5f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_opp.h>
+#include <linux/spinlock.h>
 
 #define CCI_HW_VERSION				0x0
 #define CCI_HW_VERSION_MAJOR_MASK		GENMASK(31, 28)
@@ -36,6 +37,7 @@
 
 #define CCI_I2C_Mm_READ_DATA(m)			(0x118 + 0x100 * (m))
 #define CCI_I2C_Mm_READ_BUF_LEVEL(m)		(0x11c + 0x100 * (m))
+#define CCI_I2C_Mm_RD_THRESHOLD(m)		(0x120 + 0x100 * (m))
 #define CCI_I2C_Mm_Qn_EXEC_WORD_CNT(m, n)	(0x300 + 0x200 * (m) + 0x100 * (n))
 #define CCI_I2C_Mm_Qn_CUR_WORD_CNT(m, n)	(0x304 + 0x200 * (m) + 0x100 * (n))
 #define CCI_I2C_Mm_Qn_CUR_CMD(m, n)		(0x308 + 0x200 * (m) + 0x100 * (n))
@@ -58,6 +60,7 @@
 #define CCI_IRQ_CLEAR_0				0xc08
 #define CCI_IRQ_STATUS_0			0xc0c
 #define CCI_IRQ_STATUS_0_I2C_M0_RD_DONE		BIT(0)
+#define CCI_IRQ_STATUS_0_I2C_M0_RD_UNDERFLOW	BIT(1)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0_REPORT	BIT(4)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0_UNDERFLOW	BIT(5)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0_OVERFLOW	BIT(6)
@@ -65,6 +68,7 @@
 #define CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW	BIT(9)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q1_OVERFLOW	BIT(10)
 #define CCI_IRQ_STATUS_0_I2C_M1_RD_DONE		BIT(12)
+#define CCI_IRQ_STATUS_0_I2C_M1_RD_UNDERFLOW	BIT(13)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0_REPORT	BIT(16)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0_UNDERFLOW	BIT(17)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0_OVERFLOW	BIT(18)
@@ -81,6 +85,18 @@
 #define CCI_IRQ_STATUS_0_I2C_M0_ERROR		0x18000ee6
 #define CCI_IRQ_STATUS_0_I2C_M1_ERROR		0x60ee6000
 
+#define CCI_IRQ_MASK_1				0xc10
+#define CCI_IRQ_MASK_1_I2C_M0_RD_THRESHOLD	BIT(16)
+#define CCI_IRQ_MASK_1_I2C_M0_RD_PAUSE		BIT(17)
+#define CCI_IRQ_MASK_1_I2C_M1_RD_THRESHOLD	BIT(20)
+#define CCI_IRQ_MASK_1_I2C_M1_RD_PAUSE		BIT(21)
+#define CCI_IRQ_CLEAR_1				0xc14
+#define CCI_IRQ_STATUS_1			0xc18
+#define CCI_IRQ_STATUS_1_I2C_M0_RD_THRESHOLD	BIT(16)
+#define CCI_IRQ_STATUS_1_I2C_M0_RD_PAUSE	BIT(17)
+#define CCI_IRQ_STATUS_1_I2C_M1_RD_THRESHOLD	BIT(20)
+#define CCI_IRQ_STATUS_1_I2C_M1_RD_PAUSE	BIT(21)
+
 #define CCI_TIMEOUT	(msecs_to_jiffies(100))
 #define NUM_MASTERS	2
 #define NUM_QUEUES	2
@@ -108,6 +124,9 @@
 /* The first and last bytes are reserved - not payload */
 #define CCI_I2C_READ_MAX_LEN(fsize) ((fsize) - 2)
 
+/* Unlimited read via threshold-irq support */
+#define CCI_I2C_READ_BURST_NOLIMIT 0
+
 enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
@@ -169,16 +188,52 @@ struct cci {
 	int nclocks;
 	struct clk *cci_clk;
 	struct cci_master master[NUM_MASTERS];
+	/* Protects read-modify-write access to CCI_IRQ_MASK_1 */
+	spinlock_t threshold_lock;
 };
 
+static bool cci_has_threshold_irq(const struct cci *cci)
+{
+	return cci->data->quirks.max_read_len == CCI_I2C_READ_BURST_NOLIMIT;
+}
+
+static void cci_set_rd_threshold_irq(struct cci *cci, u16 master, bool enable)
+{
+	u32 bits, val;
+
+	if (!cci_has_threshold_irq(cci))
+		return;
+
+	guard(spinlock_irqsave)(&cci->threshold_lock);
+
+	bits = master ? CCI_IRQ_MASK_1_I2C_M1_RD_THRESHOLD :
+			CCI_IRQ_MASK_1_I2C_M0_RD_THRESHOLD;
+
+	writel(bits, cci->base + CCI_IRQ_CLEAR_1);
+
+	val = readl(cci->base + CCI_IRQ_MASK_1);
+	if (enable)
+		val |= bits;
+	else
+		val &= ~bits;
+
+	writel(val, cci->base + CCI_IRQ_MASK_1);
+}
+
 static irqreturn_t cci_isr(int irq, void *dev)
 {
 	struct cci *cci = dev;
-	u32 val, reset = 0;
+	u32 val, val1 = 0, reset = 0;
 	int ret = IRQ_NONE;
 
 	val = readl(cci->base + CCI_IRQ_STATUS_0);
 	writel(val, cci->base + CCI_IRQ_CLEAR_0);
+
+	if (cci_has_threshold_irq(cci)) {
+		val1 = readl(cci->base + CCI_IRQ_STATUS_1);
+		writel(val1, cci->base + CCI_IRQ_CLEAR_1);
+	}
+
 	writel(0x1, cci->base + CCI_IRQ_GLOBAL_CLEAR_CMD);
 
 	if (val & CCI_IRQ_STATUS_0_RST_DONE_ACK) {
@@ -204,6 +259,28 @@ static irqreturn_t cci_isr(int irq, void *dev)
 		ret = IRQ_HANDLED;
 	}
 
+	if (val1 & CCI_IRQ_STATUS_1_I2C_M0_RD_THRESHOLD) {
+		cci_set_rd_threshold_irq(cci, 0, false);
+		complete(&cci->master[0].irq_complete);
+		ret = IRQ_HANDLED;
+	}
+
+	if (val1 & CCI_IRQ_STATUS_1_I2C_M1_RD_THRESHOLD) {
+		cci_set_rd_threshold_irq(cci, 1, false);
+		complete(&cci->master[1].irq_complete);
+		ret = IRQ_HANDLED;
+	}
+
+	if (val1 & CCI_IRQ_STATUS_1_I2C_M0_RD_PAUSE) {
+		dev_warn_ratelimited(cci->dev, "master 0 read paused (fifo full)\n");
+		ret = IRQ_HANDLED;
+	}
+
+	if (val1 & CCI_IRQ_STATUS_1_I2C_M1_RD_PAUSE) {
+		dev_warn_ratelimited(cci->dev, "master 1 read paused (fifo full)\n");
+		ret = IRQ_HANDLED;
+	}
+
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
 		reset |= CCI_RESET_CMD_M0_MASK;
 		ret = IRQ_HANDLED;
@@ -232,6 +309,8 @@ static irqreturn_t cci_isr(int irq, void *dev)
 			dev_warn_ratelimited(cci->dev, "master 0 queue 1 overflow\n");
 		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW)
 			dev_warn_ratelimited(cci->dev, "master 0 queue 1 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_RD_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 FIFO read underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M0_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;
@@ -252,6 +331,8 @@ static irqreturn_t cci_isr(int irq, void *dev)
 			dev_warn_ratelimited(cci->dev, "master 1 queue 1 overflow\n");
 		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q1_UNDERFLOW)
 			dev_warn_ratelimited(cci->dev, "master 1 queue 1 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_RD_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 FIFO read underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M1_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;
@@ -389,6 +470,9 @@ static int cci_init(struct cci *cci)
 			CCI_IRQ_MASK_0_I2C_M1_ERROR;
 	int i;
 
+	if (cci_has_threshold_irq(cci))
+		val |= CCI_IRQ_MASK_1_I2C_M0_RD_PAUSE | CCI_IRQ_MASK_1_I2C_M1_RD_PAUSE;
+
 	writel(val, cci->base + CCI_IRQ_MASK_0);
 
 	for (i = 0; i < cci->num_masters; i++) {
@@ -419,6 +503,18 @@ static int cci_init(struct cci *cci)
 
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
+
+		if (cci_has_threshold_irq(cci)) {
+			/* Hardware supporting the RD_THRESHOLD interrupt provides a minimum FIFO
+			 * depth of 64 words, with the threshold reset to the full FIFO size by
+			 * default. Configure the threshold to half the FIFO depth to allow burst
+			 * reads while maintaining sufficient headroom to drain the FIFO before it
+			 * fills up.
+			 */
+			val = readl(cci->base + CCI_I2C_Mm_RD_THRESHOLD(i));
+			val = max_t(u32, val, 64);
+			writel(val / 2, cci->base + CCI_I2C_Mm_RD_THRESHOLD(i));
+		}
 	}
 
 	return 0;
@@ -484,7 +580,7 @@ static int cci_validate_queue(struct cci *cci, u8 master, u8 queue)
 static int cci_i2c_read(struct cci *cci, u16 master,
 			u16 addr, u8 *buf, u16 len)
 {
-	u32 val, words_read, words_exp;
+	u32 val, words_read;
 	u8 queue = QUEUE_1;
 	int i, index = 0, ret;
 
@@ -502,27 +598,48 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	val = CCI_I2C_READ | len << 4;
 	writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
 
-	ret = cci_run_queue(cci, master, queue);
-	if (ret < 0)
-		return ret;
+	val = readl(cci->base + CCI_I2C_Mm_Qn_CUR_WORD_CNT(master, queue));
+	writel(val, cci->base + CCI_I2C_Mm_Qn_EXEC_WORD_CNT(master, queue));
 
-	words_read = readl(cci->base + CCI_I2C_Mm_READ_BUF_LEVEL(master));
-	words_exp = len / 4 + 1;
-	if (words_read != words_exp) {
-		dev_err(cci->dev, "words read = %d, words expected = %d\n",
-			words_read, words_exp);
-		return -EIO;
-	}
+	reinit_completion(&cci->master[master].irq_complete);
 
-	/* The first byte of the read is the slave ID echo, not payload */
-	val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
-	for (i = 1; i < 4 && index < len; i++)
-		buf[index++] = (val >> (i * 8)) & 0xff;
+	cci_set_rd_threshold_irq(cci, master, true);
 
-	while (--words_read) {
-		val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
-		for (i = 0; i < 4 && index < len; i++)
-			buf[index++] = (val >> (i * 8)) & 0xff;
+	val = BIT(master * 2 + queue);
+	writel(val, cci->base + CCI_QUEUE_START);
+
+	/*
+	 * Hardware supporting RD_THRESHOLD can handle reads larger than the FIFO size.
+	 * The FIFO is drained each time an RD_THRESHOLD interrupt is received, until
+	 * the final RD_DONE interrupt completes the transfer.
+	 * On hardware lacking RD_THRESHOLD support, reads are limited to the FIFO
+	 * size and only one completion (RD_DONE interrupt) is expected.
+	 */
+	while (index < len) {
+		if (!wait_for_completion_timeout(&cci->master[master].irq_complete,
+						  CCI_TIMEOUT)) {
+			dev_err(cci->dev, "master %d queue %d read timeout\n",
+				master, queue);
+			cci_reset(cci);
+			return -ETIMEDOUT;
+		}
+
+		if (cci->master[master].status)
+			return cci->master[master].status;
+
+		words_read = readl(cci->base + CCI_I2C_Mm_READ_BUF_LEVEL(master));
+
+		while (words_read--) {
+			val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
+			/* The first byte of the read is the slave ID echo, not payload */
+			for (i = (index == 0) ? 1 : 0; i < 4 && index < len; i++)
+				buf[index++] = (val >> (i * 8)) & 0xff;
+		}
+
+		if (index < len) {
+			reinit_completion(&cci->master[master].irq_complete);
+			cci_set_rd_threshold_irq(cci, master, true);
+		}
 	}
 
 	return 0;
@@ -755,7 +872,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
+			.max_read_len = CCI_I2C_READ_BURST_NOLIMIT,
 		},
 	},
 	{
@@ -764,7 +881,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 1024, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(1024),
-			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
+			.max_read_len = CCI_I2C_READ_BURST_NOLIMIT,
 		},
 	},
 };
@@ -811,6 +928,8 @@ static int cci_probe(struct platform_device *pdev)
 	cci->dev = dev;
 	platform_set_drvdata(pdev, cci);
 
+	spin_lock_init(&cci->threshold_lock);
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct cci_master *master;
 		u32 idx;

-- 
2.34.1

