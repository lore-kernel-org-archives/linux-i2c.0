Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D12455600
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137627; cv=none; b=jsrTOBaAMP64Rc/4aUst1pDwivG6+vWYm4AO10eCndKgPNGkU4n8ICHMcasxvjwMwU/F/+xv5U1kBY8qAh91uYpe5UiBsJdkyeXYh1t1vZWMBIn7lTtOrrmL0FfPc51mzYpzONbhkDiZqRTL7PIk3kdt36snxgNOaTftzjc1zHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137627; c=relaxed/simple;
	bh=Y/i5TG2BWv1bj5vFWDfme6D9khtqs4zFRS0e+mXFWMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8LaXwxl6hWNBt2z/UYgHk8TQsfMWJ6gHwRXo6T0qyEpM4P1Rp1dbPg9IucmVtfYvOg8H/z24h33cxUvcUepO55dKdQ1xIm8bTbVTGo1dicuCuVcqTzy5mw3ihgXdyt7r2LvmYHHFyS1IO4ueMKFZO4NACiiYr0v0c2CCrlcC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U7dZ5HFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R7rgs1Yd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U7dZ5HFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7rgs1Yd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G2NalD405986
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x9iyrvCSZjiLcegVSMJNGlx3q4evyuIE0YOIWSOSEUc=; b=U7dZ5HFjfyER77GT
	OtiGDXtPB9dOZRX2kX28DW92GD8a0HIsRasGIv0rt35CUWRPxKesdLQvLF6su0me
	qM4ljbAy6Y6kxm3i1+c4P2Oppx9O6D5IIJqzG7li650sxmXUxhruRXUeAA4XGuuk
	ptmNDt6ydYs5pYxqEJ20Zfodx9cLt1ejUPYNa+0BaKnUuMkuq0qQ8+fXyzRC/HXT
	J1U5C5OvMH9K2iN7kr5oorIYVDzlE5z8oAXJAljOIBM9rQr26Ui7T0IYXIyk4ebd
	e9VZ0LV+SzqLj32e4Qoc92Ykadv2JCngUqI3JhsY3SO+UMKwBw6atpxEXXd37Cr/
	LmvJLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa2pt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936aa34873bso481209085a.3
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792137624; x=1792742424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9iyrvCSZjiLcegVSMJNGlx3q4evyuIE0YOIWSOSEUc=;
        b=R7rgs1YdPj4bMQCCchq3JFOAs0BFC9/BN5862aC3rKHgKcfRslQnhwg2WqVMVAM47a
         U+X69aANm/55GyX79VVPclDVxiVkny4UabkJF94TmsW3zOTqJ+xVIQIU36nuyZJTw7km
         Hyb7uwTK/P1FB9w4ODJ772zCBhG4sE7Jy9xFOVF32xhVESKFcYuQvh00htwQ9jWXihRX
         TmZGU/tz+BABJfo9+1KHFfwDUrrBERhmXQNBOtAy0NaCXIEvXIUbrzqySKJYjbVvDzZZ
         TVtjH15+e0B5NYZY72yOQRcIZbKYzV1/BJOmWlqO96Jpo7FwNagif/CL0+qgaJGioVxP
         rRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137624; x=1792742424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9iyrvCSZjiLcegVSMJNGlx3q4evyuIE0YOIWSOSEUc=;
        b=H24Utok1v8lW+bSlaSsZsbHjzn7Nh9WsLtvtS3jyToH745OktBvPFLs1VH3/0U26zn
         QBe3XQE7n72M36786jPf01ocVUJve8W3V2ojDo4/U8VRrIuJTC8Yuv7KFXHfFCeyrDt/
         z8Yn09IuvgbfKwm4cPMMUXh5Kweq7uBM/5Wossd5knzHEGtlYrbG+Uw4Ipmes0JhrXdK
         Tn53g0BeIzeMU4xfHdDSEtnpeaMvxrj+Ua7ZIfenLz5kFfXArIRgjHf9JQdfXTz6iqM+
         zMOjdTdj7qhYiTO7rTuHecHFDo71c9y1YV4Jj85u99d8o7mjQmOLTHaMdZfyY0oUX/3c
         Ymjw==
X-Gm-Message-State: AFq9FYIpZl9mF2DyvAoYkaMxPmZaCgcDZdcOGFzOV5gMhsyQvXCgLMIK
	sig8NOobvZ61rccR9RSrLqPQ5JF4dbnlDBz/aTBKSHFPEgwIjwCmWbBlMu/njMJFeGEFgqrm2KD
	lG6n3qBkAXBriee94jfoat11qS8o6KkG78DQtlCu38nEmp/XgYgrLWCTmTorlzDg=
X-Gm-Gg: AYBFou0G+dFWeS1V1NwyeUsUSVL47hJ2ZALO0IUX2UT4dvOaTsMyqBJceMl/7yJnw2e
	ZOiCqMekYoJsYQM4qhziRup9yZ5b68tqJ258iWHWpryeFJaGvJHVnTNuLb4FC3kfw4QhsN6HkhD
	l8tOHC4euxkPF5vSQhaynJX/3Uz1A/pW8W9ZsxDV/JD4iNN3/bbxX7FqRkqexTQgViw0BLBGx0e
	3zAXva02kJNrVoY+ek9OxQTWmLCPFs7iCllaMUUYQWB7CSnEHvMkdY891Ii+pPwRGb6wTdkE/Jr
	lscFv2eet2EUjbbuKX6qTD6CYPSDEzYVIcVsS8jSX07tfCsKx8irmjrCduS4LJ8Q8fuwIdc7a3g
	yOhDXYFKlVruI4313QuKSLNALURCF758/ut3BxsmzYXuhEkvESttiocpa3DbMuzBW/uRnAQVS+b
	THhO8lUf2ddzsd4pH//y55T4P6UGQ0BmQ74rw/NJ/9637Jb/IrW5c=
X-Received: by 2002:a05:620a:19a3:b0:93f:22e9:7aed with SMTP id af79cd13be357-93f22e9884fmr24434785a.56.1792137623508;
        Fri, 16 Oct 2026 01:00:23 -0700 (PDT)
X-Received: by 2002:a05:620a:19a3:b0:93f:22e9:7aed with SMTP id af79cd13be357-93f22e9884fmr24428885a.56.1792137622862;
        Fri, 16 Oct 2026 01:00:22 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm5471446f8f.16.2026.10.16.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:00:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:00:14 +0200
Subject: [PATCH v3 6/7] i2c: qcom-cci: Add burst read support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-cci-imp-v3-6-5ee7ec1ea1a1@oss.qualcomm.com>
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfX7ZRM8bIwNKR7
 HsHELzfgioJThBM2968f3S2SrZm017Y2Nwx9WiD24H/P8i+wYik8LwFhrHl31IdSOPxE4NsYcU6
 s4/B0fSlaOdTe1WfdnrdNEQgoRJegMs=
X-Proofpoint-ORIG-GUID: PhL0YnNAKcNOqWxvgLt9CIL7fm83VuXn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfX1jRgbkTmP8jr
 A3siNuobjZFVHdWz3+xqGRUoWS1L4V8BOMr4kohoIZT6KTB/izc0z6J0pyJCf2nW3QzO6lf/fOu
 Hik7hBnMHq27ha5jLG3OK2TZKbFfXDeMNzXRNY+1//PxbShDCmyJrOY44QosHCXGB446T6q8S5C
 pE1/65D245NLdTvxql+kzUo37FKTdOCG4SrsflWJak/w33Ff7uq6Ozix0Vvp9ixznFBAOi3+2Xn
 ApAXp5FxBUEFAVvVm8v+vzo+DGtLj4zqaNgxcRrSM0ppXYoemm5OnqxoHV7cucMnOdHFHPA5Ukk
 ruR9wV2xeHmAP0fBw7fcKOQf4AZRCXIwaXJFsONri+OHP50Vdzd1yqXEbchauDGjFCX2vBBs2Yi
 bq8qlMbitd9SL/X+QsrPp4cCVpHWbSbwNhbiVRyahjnALGlAcsWWzIwPDKMPnG44M5xIi7UnY1k
 8hfs2bbjyACRXT6jZYg==
X-Proofpoint-GUID: PhL0YnNAKcNOqWxvgLt9CIL7fm83VuXn
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1d998 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=lNqXhXyNEWYzk-AvLucA:9 a=0YZ0O0O0cT6BRUpX:21 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160031

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
 drivers/i2c/busses/i2c-qcom-cci.c | 173 +++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 18cfe03439e204691a9ea873f67faeaa119b45ff..280d34b54dde6c505ff627ed35fbbd392b6f7c25 100644
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
@@ -391,6 +472,14 @@ static int cci_init(struct cci *cci)
 
 	writel(val, cci->base + CCI_IRQ_MASK_0);
 
+	val = 0;
+
+	if (cci_has_threshold_irq(cci))
+		val |= CCI_IRQ_MASK_1_I2C_M0_RD_PAUSE | CCI_IRQ_MASK_1_I2C_M1_RD_PAUSE;
+
+	if (val)
+		writel(val, cci->base + CCI_IRQ_MASK_1);
+
 	for (i = 0; i < cci->num_masters; i++) {
 		int mode = cci->master[i].mode;
 		const struct hw_params *hw;
@@ -419,6 +508,18 @@ static int cci_init(struct cci *cci)
 
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
@@ -481,13 +582,20 @@ static int cci_validate_queue(struct cci *cci, u8 master, u8 queue)
 	return cci_run_queue(cci, master, queue);
 }
 
+static void cci_clear_status(struct cci *cci, u16 master)
+{
+	cci->master[master].status = 0;
+}
+
 static int cci_i2c_read(struct cci *cci, u16 master,
 			u16 addr, u8 *buf, u16 len)
 {
-	u32 val, words_read, words_exp;
+	u32 val, words_read;
 	u8 queue = QUEUE_1;
 	int i, index = 0, ret;
 
+	cci_clear_status(cci, master);
+
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
 	 * This is to avoid overflow / underflow of queue.
@@ -502,27 +610,46 @@ static int cci_i2c_read(struct cci *cci, u16 master,
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
+
+	cci_set_rd_threshold_irq(cci, master, true);
+
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
+						 CCI_TIMEOUT)) {
+			dev_err(cci->dev, "master %d queue %d read timeout\n",
+				master, queue);
+			cci_reset(cci);
+			return -ETIMEDOUT;
+		}
+
+		if (cci->master[master].status)
+			return cci->master[master].status;
 
-	/* The first byte of the read is the slave ID echo, not payload */
-	val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
-	for (i = 1; i < 4 && index < len; i++)
-		buf[index++] = (val >> (i * 8)) & 0xff;
+		words_read = readl(cci->base + CCI_I2C_Mm_READ_BUF_LEVEL(master));
 
-	while (--words_read) {
-		val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
-		for (i = 0; i < 4 && index < len; i++)
-			buf[index++] = (val >> (i * 8)) & 0xff;
+		while (words_read--) {
+			val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
+			/* The first byte of the read is the slave ID echo, not payload */
+			for (i = (index == 0) ? 1 : 0; i < 4 && index < len; i++)
+				buf[index++] = (val >> (i * 8)) & 0xff;
+		}
+
+		if (index < len)
+			cci_set_rd_threshold_irq(cci, master, true);
 	}
 
 	return 0;
@@ -755,7 +882,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
+			.max_read_len = CCI_I2C_READ_BURST_NOLIMIT,
 		},
 	},
 	{
@@ -764,7 +891,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 1024, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(1024),
-			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
+			.max_read_len = CCI_I2C_READ_BURST_NOLIMIT,
 		},
 	},
 };
@@ -811,6 +938,8 @@ static int cci_probe(struct platform_device *pdev)
 	cci->dev = dev;
 	platform_set_drvdata(pdev, cci);
 
+	spin_lock_init(&cci->threshold_lock);
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct cci_master *master;
 		u32 idx;

-- 
2.34.1

