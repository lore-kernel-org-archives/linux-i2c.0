Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C84D37D1
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887441; cv=none; b=O4zgsc3n3wc8hHPFS1MoNiYCqBwpUIvF8ZgEANiFDJx1eKs3a120S5Dh4ZRKSEegRgEu+QalW3RCtWIEXbi1LKF+fQsQGGKkLOPm3b9SHNKdtfFgAqM4OPxMjldNTSaYh0GNjvhcc8eNlzI3XIzNhVuPXkM3R425PoWgWG0is/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887441; c=relaxed/simple;
	bh=9e6MEiIklGJfyndXhTPPr9nVDCPp6b5rGMxzkp0B7YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGuu66MGsCCB6aUicmD26qzanhiGalZAQMkVw2bUSuA8woRpiPiNPmzSb+Gjc0Rizh22z2OD72LkPtSgsYlzKxsx/Glzta7OoyPP0mMRUH2GksZi5XSjlfjV68aXp6/aqIQsobgYphHKhrJKGh8Iwp4x3ZSJtVvx0Dce6oh13PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9DDXyBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzvAU1/W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9DDXyBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzvAU1/W"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9fkBC3475851
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vRfB3REly7l4Yt4+ScKAJ76g8z3HDR/+4IYPDuXkwL0=; b=F9DDXyBxTg4Q8Gsk
	f3hDD37cLqRM6RQHwVbJGGj/xPephT0QSlHtWSW87k0hRkr0djLTnqW823uAzb8E
	W+H7geety4BGl4qwat2G8Y/48YOxrgyyL4BwYHE78vfG28Pwu+t7ldZD3nXkrHad
	hmQaLt691wlCve/SUNVCEBKF3suRc8e2nq5KI71YC+vvhORrXvkoUdcE87L/a/tZ
	Btq4vyhw/X01Jrm7e6wDlC5QAL405C8CPCS3OjskN9IqmIMKbw/3kLP9ya9UPnzs
	2Fp0xMqr6Rvj20RY1sMBd102S1JlYDwzQjP65+01DPiUY6cvEj6qisiiXB1ISQpv
	B8rtvA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j9j5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1de6d5c3so651152085a.3
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887437; x=1792492237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRfB3REly7l4Yt4+ScKAJ76g8z3HDR/+4IYPDuXkwL0=;
        b=CzvAU1/W6XRnPSUBTs1t06SGyl4m7JcfGGAr4c/cRyDlUtItWU0X4/3dFin2MbLI8U
         Z3nfg4dw+UEp4EB+799jPHoF6gvjKCsHDR2WlWpabr3C82xNNg5zh54CNIdZaNf7gu8x
         kbMbLMQi+5VhlDbRHrwkC/YVEn+Yl1BLk5a4T8h8i4LXC3xBLrqFrDkppX9eciUpEk1F
         9EfkmG3p/FPGb1FyJKLQZxfU2PuBXgpziwBmFG1F7svd3W4u4xTHaDRA+xk0hFfKFHzd
         mICMAxmMn/iKjPIWL4yHbp6OJ29ezQoyE+Me90qX6qIyD8P5c7JQnhVnh+chSSAtzcjk
         Vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887437; x=1792492237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRfB3REly7l4Yt4+ScKAJ76g8z3HDR/+4IYPDuXkwL0=;
        b=guc9rgj5BA02oua6MI6UrGhwpZwAQHsP2QrgcHsBIiDG3Fl1z39hY5IHNUUjnJvXOT
         6Zt++7rBjDkVYPf165zCZvgBst87c0azfW6cEmzbUzgkQbZN4LK9hjZomdo+BptJz/Kt
         U3gHQitKA6iLxBjuMvx8cua8mY/2FXtyNevZZd6qUfA13ZQ5WgfEMRSCQC9VsV/E6c03
         maI1kHM/QCU2y5paw2F5TybvGNrE5CNwCnkXqF+U9KEe6vXBKYfzws+K26dZeHAYENdG
         smiyONVW7bFOW8LVRO0TiauIsVblLXckdxgZF674gTTjw2D8rV1wacTC99f+srW0u5cd
         YE+Q==
X-Gm-Message-State: AFq9FYLf2bVOl4m0SzUbsBwpNzKt677EA4JdmP91/2WvxYZ1OBJXzkiM
	U8hecEYGjsne9FCf0JGKl3HIS9Ee55vn1ZVCDhgNbn5pV6XHcWnOMLtE0TYzBukuF0gv5kY4v47
	PqwZSaLYW1UlXfyfVrm9RRHZ3qvCxJAM9RVb5Vw6ufLil7Xfku/POzkix+FTIBi4gTD7hDBzEsN
	3W
X-Gm-Gg: AYBFou0mwpy8KbIt7mzSILjjqJSK2A4adZLBraoEwi90jDZPEp8LayVobDnscHXpsNP
	OIc6Xz4grmBwy0MPf1KWwO2jQ+SkwuC6UE/u7W5hZvlA1DIwlfT2xSxwDmVMQhf3aleirm8hhox
	M/a1Q6fevtG8AdQuNscPI7zawWCprhnJ4kl3vwJgI7ZLE5aF+c2CtWoQjPPmYk2fl6RQFIe4P2g
	loi0C2Vf0z5Q2jlEse00+YYIxIf4OgKLnZq2bOKWOyQal1illT8ndLAm20JPwEHkRQYN2MYCiTL
	7/3Jvwgx6W86IuiN/Z336BuMOqs9ZFjgyQ8WOlmYixfaI3Shwfe/3y5QQ4k5anGPqUPHqop9Nff
	6LLJumSFM75jJVADFytjDEbTlmEIj9PCYAfoonb3/YnhT7w/pDFFxLjuM2HP5RtQUOV7DdklGPV
	R3zn66LO16TxDCAejXxbRzI9nm4kiHchoRp/tbaf3i97CXQKNSclQ=
X-Received: by 2002:a05:620a:2989:b0:93b:fde4:4923 with SMTP id af79cd13be357-93ebd2a0815mr1925321285a.63.1791887436849;
        Tue, 13 Oct 2026 03:30:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:93b:fde4:4923 with SMTP id af79cd13be357-93ebd2a0815mr1925306985a.63.1791887435261;
        Tue, 13 Oct 2026 03:30:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:28 +0200
Subject: [PATCH v2 4/6] i2c: qcom-cci: Add burst write support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cci-imp-v2-4-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: J3313QjFUPH2CY_TPZeOiVw-WvovdsLt
X-Proofpoint-ORIG-GUID: J3313QjFUPH2CY_TPZeOiVw-WvovdsLt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXwcyJf1hkqccE
 zPzYWRkVlwckpUu3Oz0C5SqcDLzFJz92fbmBVKGvSLgENxgP+EBHLmvyu67nPzWy9xROnPsjcS0
 JtcevvP1miJeDtd3+kDMCsfoPabxxJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXwyKOY71MhOl2
 C2ZqsCBZZK9vUPt0FOLH+Sl7hBYQ9KQmFdQ94XgKmdg99CdAvKDvMJWp0olfTO5JlleLD+fwtAA
 LWqBXToQO+IPX7sdxZ1yFINWY1wlQXzkdqRqVAJbNZWZLtnw1UakjvuZu+EhlhTqoivZ0lM6aRT
 KqO7TbROronmTJJkFUJf7qbm8CpYK4QjLxEZ1K/9Iuj12rb13ibxF5O7ST6/b9UsvgY8Fk0YyGs
 Jczhbdv0znGKTY83wWbd1bi21bs8510sbHGSgzd9GwnYXpy+w2aMvXShvzJAks9ypvOR3uxDfVe
 YohNTP39jf71fhney2icwFLd8v8/VQS9Y5x/c/8mIgQY2FklmSseHOsThHeLTagAsA5wmc22G20
 UAil0GZS2YWH2Zk4FCN02jnUnAxGWZjqFny4GFn5wa1WV8lqTnBl9s5aqJz1NqH83WqR5X1A5+E
 ewtXqX8bCvW03p6vN4Q==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace084e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uN0qKeaNodZ6YgCSxmEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130041

A single CCI_I2C_WRITE command can only carry up to 11 bytes,
so every i2c write was capped at that size via i2c max_write
quirk.

CCI v1.2 introduces burst mode support, where consecutive
write commands (marked as burst) run back-to-back as a single
transfer.

Use this in cci_i2c_write() to allow longer writes across the
whole queue instead of a single command's payload, and raise
max_write_len accordingly for every CCI revision that supports
burst mode.

unlock/lock commands are required to ensure the commands for
a given transfer are executed atomically.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 44 +++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 3bca29f1d2699375a0348b18a5a2e646a59fd94c..27bbd1e196f9c55c1af14168b83eb6e6d51c75ed 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -86,14 +86,24 @@
 #define NUM_QUEUES	2
 
 #define CCI_I2C_SET_PARAM	1
+#define CCI_I2C_LOCK		6
+#define CCI_I2C_UNLOCK		7
 #define CCI_I2C_REPORT		8
 #define CCI_I2C_WRITE		9
 #define CCI_I2C_READ		10
 
+#define CCI_I2C_REPORT_IRQ_EN	BIT(8)
+
 #define CCI_I2C_WRITE_WC	3
+#define CCI_I2C_WRITE_MAX_LEN	(CCI_I2C_WRITE_WC * sizeof(u32) - 1)
 #define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
+#define CCI_I2C_WRITE_BURST	0xf
+#define CCI_I2C_BURST_OVERHEAD	4 /* LOCK + SET_PARAM + UNLOCK + REPORT */
 
-#define CCI_I2C_REPORT_IRQ_EN	BIT(8)
+/* Largest write that can be bursted through a queue of @qsize words */
+#define CCI_I2C_BURST_MAX_LEN(qsize)					\
+	(((qsize) - CCI_I2C_BURST_OVERHEAD) / CCI_I2C_WRITE_WC *	\
+	 CCI_I2C_WRITE_MAX_LEN)
 
 enum {
 	I2C_MODE_STANDARD,
@@ -521,14 +531,15 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
-static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+static void cci_i2c_load_write(void __iomem *loadq, u8 *buf, u16 len, bool burst)
 {
 	u32 cmd[CCI_I2C_WRITE_WC] = { };
 
-	if (WARN_ON(len >= CCI_I2C_WRITE_WC * sizeof(u32)))
+	if (WARN_ON(len > CCI_I2C_WRITE_MAX_LEN ||
+		    (burst && len != CCI_I2C_WRITE_MAX_LEN)))
 		return;
 
-	cmd[0] = CCI_I2C_WRITE | len << 4;
+	cmd[0] = CCI_I2C_WRITE | (burst ? CCI_I2C_WRITE_BURST : len) << 4;
 	memcpy((u8 *)cmd + 1, buf, len);
 	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
 }
@@ -537,9 +548,12 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
 	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	bool burst = len > CCI_I2C_WRITE_MAX_LEN;
 	int ret;
 	u32 val;
 
+	dev_dbg(cci->dev, "master %d write: len=%u\n", master, len);
+
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
 	 * This is to avoid overflow / underflow of queue.
@@ -548,10 +562,22 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 	if (ret < 0)
 		return ret;
 
+	if (burst)
+		writel(CCI_I2C_LOCK, loadq);
+
 	val = CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
 	writel(val, loadq);
 
-	cci_i2c_load_write(buf, len, loadq);
+	do {
+		u16 to_write = min_t(u16, len, CCI_I2C_WRITE_MAX_LEN);
+
+		len -= to_write;
+		cci_i2c_load_write(loadq, buf, to_write, len > 0);
+		buf += to_write;
+	} while (len);
+
+	if (burst)
+		writel(CCI_I2C_UNLOCK, loadq);
 
 	val = CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
 	writel(val, loadq);
@@ -713,7 +739,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 64, 16 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
 			.max_read_len = 12,
 		},
 	},
@@ -722,7 +748,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -731,7 +757,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -740,7 +766,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 1024, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(1024),
 			.max_read_len = 12,
 		},
 	},

-- 
2.34.1

