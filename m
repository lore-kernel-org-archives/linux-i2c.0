Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92B44A406
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137622; cv=none; b=STelcqz+c82EuFEqN8p3j1+7jLEWzcEVhxPqf9rRdPKSuIQaobAAmUkEwaHlwHhhMQch5Udkfnr5xsx1hX37l3X52+GRfGQ6ymLPHMNgWpQDAtZw/Ww4ExFPiT9ypVClIE6P11968Yje6kiKmJWYjQFJ7fSGZTaSeNvunI0V3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137622; c=relaxed/simple;
	bh=Omh/r/EkzbxDwK4u3Jsf7Qm/OF6SY/r+dH/xbsZP8xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aa7lAuPzaVL7/K6dckJgegqKgnJS2CP/l76f0gUksrHG1I8xYsh5H2h7pO2zn9wc1c470gqPMcGYISen6alh+nuONgSgZFZsWF71ZZd4lhvGvQ9GBJ8Ot83y9pftP3VLh3IMpyUNVBTwzOfPthB7bbdHfotcm9uVpc0sh95gtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=caal9e1B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hP9hUHie; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="caal9e1B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hP9hUHie"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G4fnks3462711
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tFotLrkKB0thxNBZAni68bXXHHliGXu4ceaayS8YZzk=; b=caal9e1B9XQg3K7F
	oXeIJMMnfIeIEIelUGSMhQdDgiR/bmtVSI3+8ZZhaiRbllVCC/obZAyuQABrqL4n
	voE/hA54yDcthsjZ++3Ox2Jds5vLgywvM7gOTEQE3/M1zBlezGD9uDh4VEp4FSfK
	dNwSTsKuQlzrBxb0GS7yzZAj3PLINtiQVQ2JdKUZTE7NyKjX/p/T14xxHzl5opiN
	e545JtXU5jAeMyfBGHacAzjz++YF17GlrcZt/VIe2paKpFhMep/H124xigqR+cI3
	1nCnr2GPDpzONKDX1vgWpNzPxlkGb+r3csMGM6bw88Acd5DZ4d8mYfT8Q2aEq8xu
	7cd3Ug==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu6bueq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9104eedb5b0so75351606d6.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792137619; x=1792742419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFotLrkKB0thxNBZAni68bXXHHliGXu4ceaayS8YZzk=;
        b=hP9hUHieeJJ+mezUo5GxrKAcSO52nl3lf6dYnFpZEcyNcgJaOsLXvcfliWb4xIPRh/
         nLPPXWyNUjpaS/7VvUiIGah1EvZkiX0gjel9YYoS946/81gjBHPR+uJEw7sBgTcz7wM8
         Lo/hphFHk8JrG+KZGVgPR7F9JEcHtVgxoHIoznjjdcKs4smdi17Ycn9Xa6GRrlxfg7S0
         kkm1HnZ9bnwULSkcoXvDYWVEhTN/BjrhJG3uLpapdXqExOmhfE5IIzd+0rgj7ey3OvqI
         a06LpmX2N8gzQt6Ix4yPRM9RCuhlHe2pt72ya9jUeMwCVRZ1OVpTWWs9iLOOPMOcBIov
         A2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137619; x=1792742419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFotLrkKB0thxNBZAni68bXXHHliGXu4ceaayS8YZzk=;
        b=lEO3Q1ugj7cW7CjyTril4VqEW1d2gVbsGzK2/cgIKSRcb3xvWrhPYOZvMGRbT1LuHx
         bGzx6ywQnrFiu6EN1aWOVj/5bSeNTwWgotlOPwHgcqlNPDgKJgap2yXUaWdjCrvvrt+X
         u7pL27cWVLLSLykPOec56kcsYMjIi7nypwIe8nuj51h8MKI3VsZbHlpFNBxbB5PRld/T
         1OBlLIKzZ/v+DRVjclp7HgACQM39Lvdzx0Xd+B5UrePOECz4/Ywh+zwrHG98v2IJC9SZ
         F63CJQH3ReWKR+mzSYMOQnbq+aRXVPn3s8zoI+ZOOINDS7oj6WOl0XFdf5HNuNciRT8M
         cvLg==
X-Gm-Message-State: AFq9FYKBwGKLWDJ2LqBOKTDtD5CblFadcJL1iSYYP/cJkDb/stjcbWAo
	0gUnHvZtA7bLA8wVK9AkysZFjkOBGm9+PqseLnL5zbZzKjnGzpv0iGJ+AU27sajFEheczbhMiKq
	kDBzlGvinl+2jFju3FOGIxP6jANo406Cf5vkWNgVBMEQ8f7O+1FAjYDZ12ewVxIE=
X-Gm-Gg: AYBFou0X8EpakkwJpi3P4erO8f7U0SDUL0oPezohNXI3cTBN2mRRyk2qhiSnmFrIgsM
	9mS/O8E/G445S/E3wTb3AXdsUgVp3dl2/SLoQpkaEKv+9NOrneNBPfPwai22xiT6cSC0pK70ytW
	uzIrxllPHaenpvmCnpE+8ExmXrixEt19RuQtq4kX3CtzP4rwuXb0P/y2/eXBJm5yipbs1PFyegd
	ciKjQGxjh+0LsF/RgDM0IXd14FIB8ozNEJe+ysELL5d13CxUylhMAreCgZaXZd+Fo9u8b1kHDJL
	KEuw+3K3HXmScopKIQyXgv2CRSC4G6YkytthYriu/D5KOtQAewWNIoBku+q6NygoPNUQkgLcmPe
	kX9oCDGso3zwDOzP1SHpqbLcZYNwkmkmVMfN7xImk/b1zjJmkGPiT8QjBM1FtczwSQZvJQcWVnY
	paw28wb9MZ60JdJyaCKl6YPW41z1xxWvODpBmv9NxRmupwWYzpwC4=
X-Received: by 2002:a05:620a:1720:b0:93b:d7a3:45cf with SMTP id af79cd13be357-93ebd29005cmr3366277385a.56.1792137618942;
        Fri, 16 Oct 2026 01:00:18 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:93b:d7a3:45cf with SMTP id af79cd13be357-93ebd29005cmr3366272285a.56.1792137618284;
        Fri, 16 Oct 2026 01:00:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm5471446f8f.16.2026.10.16.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:00:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:00:12 +0200
Subject: [PATCH v3 4/7] i2c: qcom-cci: Add burst write support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-cci-imp-v3-4-5ee7ec1ea1a1@oss.qualcomm.com>
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: P9WoCmy2zPg_rxj4KAR8SxDC9z5Vghtp
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad1d993 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Yp3SuMTfTe4RQKdpiVsA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: P9WoCmy2zPg_rxj4KAR8SxDC9z5Vghtp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfX77QHMNw2jH/n
 vijV3Ib/BOlOo5oNQc1gNkTMxYcuCxgJaysDa0olbP7TXBPAjhSVDQINPEJwCcaiiozuOJHuCiX
 doRa9Cqm6HjYfyuZTLcgWR9yGqsVQ7GgbQV4RtR4/O6H0jcMToRCuB3HKboPPlfG/mg/TH6w99A
 5GkPGRUL6lL/KyxG4wbjS2eGF5h+B9K9NUd6++GZVMhbMvsQeuMgMzIuziC++edMD0iIx2kbt4F
 G8qpB50E+QdUZsMMc5ACB8tRnG9PuggpgCNyIWieas98zDPa2C/8se4UIxbA5EPB/VrPCjfFakO
 Zm0jni/wbCCRkemoeh1ucgmgCYhWLDX0cfywTK2FRD8j+F7HXe5hie2OjbxskwNU8L68UkrbAhg
 kE1993lJfXO3SqcGyKPiKxXb2lPwGokxzv0yJ78+sfgTqgVKxUI5g70xt5a5wJTGqCzvNJ0DFaw
 yiY4udutlko/kLEyIMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfX6euQjZ+wBMnu
 0bCuM5MknoUQEKyYuFjPpVPLbcNPC8yztV0v1qYjs5fP+jL3PoD2TTqZaCZPT6bluHm1ct7Fxwe
 URx3Aezj/1gH5Fma9/r+xIxnZrLV500=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160031

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
 drivers/i2c/busses/i2c-qcom-cci.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 7d2e214ac62c652ada122791c69306724425d0f6..bc4aa3c6431f385e07a74c67323674c183a31f97 100644
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
@@ -521,11 +531,11 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
-static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+static void cci_i2c_load_write(void __iomem *loadq, u8 *buf, u16 len, bool burst)
 {
 	u32 cmd[CCI_I2C_WRITE_WC] = { };
 
-	cmd[0] = CCI_I2C_WRITE | len << 4;
+	cmd[0] = CCI_I2C_WRITE | (burst ? CCI_I2C_WRITE_BURST : len) << 4;
 	memcpy((u8 *)cmd + 1, buf, len);
 	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
 }
@@ -534,6 +544,7 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
 	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	bool burst = len > CCI_I2C_WRITE_MAX_LEN;
 	int ret;
 	u32 val;
 
@@ -551,10 +562,22 @@ static int cci_i2c_write(struct cci *cci, u16 master,
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
@@ -716,7 +739,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 64, 16 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
 			.max_read_len = 12,
 		},
 	},
@@ -725,7 +748,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -734,7 +757,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -743,7 +766,7 @@ static const struct cci_data cci_hw_catalog[] = {
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

