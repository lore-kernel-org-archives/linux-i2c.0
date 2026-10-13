Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0B4C650A
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887438; cv=none; b=NKro99rYSAcnRrdKaOaTiEKuSRSEQfkmi+nWLVf4mzlgmu507aUnesP9c3lGzj4Jp060lYZVcxN2NbsqZ6Re+popZIrcEF5HrfG4TBBomKXZtiqws0/SWLGQE7CY1UjCRisXeFoCNP2MHFeYZdI5LnFeMrb3Jq1w1142TdmD0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887438; c=relaxed/simple;
	bh=7VAyGtVBbJCggttmNqTk3yPvNIY7BZi3td5yxOSiMcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+dbmTwpR8gPJjo2S1HGAgs9lErbnFAC3yWJVMfvG3jTfBcgNG05hToIe3arloE9EPE85FwnUH+9YQeB33rghLBN3IkQpQnY8UFkyjF/Jj3Yt+rrL/f8omSN8Q4eCxIpSdmwmIHRpVa0cpWBVx/NsKEeNnyZEvsubPCoLSo6rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4cvlyc1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IoGO/OEP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4cvlyc1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IoGO/OEP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8MFtt924262
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cciVBdIQbrgMoMJEkC4wD80Ccvp1xkFBMF7gf+nBRfM=; b=E4cvlyc1W65d14db
	QTk68QYsQXvi8sF86ScpS6aXeSYF7ri1OhPSHnNdQZ0j7vTml/POWIdPZJH14Pjf
	k438KE9nYxBr7Uy7oTd/BGrz32b4N8pgeG6z+wMMDuPoWvIqdednz0PPnAmJhOgU
	UDWgjJ80uqcItb3Tu+V68TENjpYcR9kWZkeN2KtbhaY7BOoAQ2uLZjVqqfrNPRGM
	YmtbVXIsnYLBaosT5y6tIxdrHsIpB5nheWVdOfLLNt3GC0ULEmzMG5Pk5XR3gub0
	jx5GvKVtgvmmU8nRllCkmACN/u7P/OgkdHTqhDzVlE9mxmlE7h+ZPbjmMZFN8cOy
	ajscpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tf77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so488817485a.2
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887434; x=1792492234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cciVBdIQbrgMoMJEkC4wD80Ccvp1xkFBMF7gf+nBRfM=;
        b=IoGO/OEP/yeexlOrEpPVvYR/wz0rQbbp8peSVhlk2H4uKURmiyya6lT7kGeN06P81Z
         Rfs42YTaNpj8i1sfhKnp7h7eHKxIhI3K1vn7f1EWFv7sdrSZBHaxeMg6JvKs94bJumVD
         cAJabRo5zOIixwM14JPYUVaegbWWEvmVJUnR4y9iAm7OeLraJFvVTn23idjslFcOg562
         TnmLBGn+1icdRf7LHrsOO/Q/i7zybMYDMZkYmSkCWXy0ModYrFAnWFS2VNqrRgEVs0Hc
         jAlaLxrkK2yXT70sf46LKMzxrEHoJTQsfMM7ewZhKkjKPO+2h6IhRV2irrjJaBeg4wzw
         g40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887434; x=1792492234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cciVBdIQbrgMoMJEkC4wD80Ccvp1xkFBMF7gf+nBRfM=;
        b=0G3xHUt2io/QmvU3/ZAHk8b9UL3YgyJQ6zH2vLP1+qg9O31pX4tDzNAvelbv63I14z
         vPMv9+azJuGY6D8xqOXll+Rb3b8ts1P6QmtzTMrGaRPaUX16k7dxp14DYNSTdPdKEvgM
         2vsKKi3Q9vGHTE4HvP40ThBDRj0AwtwZH48un8RPvYgWLqL38AKgJjQWVRpdpnFo8z+j
         31YrM7nyEYI0PVDKk0EyMtn571FIN4WWy5WJWIy/KEJ4JiMsIIYcQRAigBMAG7fDuqQ9
         DyHA2pfkTReRq7cWwqwT+chDuTkNw/8ixYJzKbJyzBs42Ok9DlupOzxInLH/pqdBfG+k
         5wfQ==
X-Gm-Message-State: AFq9FYLFpHPe80ybl+iA1zso9yDpwYAKv3r7uINQvQvhSNeDKbYhM20j
	ECQxW/sz7NFcBnT4PB0XoCUFcfqztydj+EUBD7WaQOcXyjSebjWZ65XCz/PHSPwdi7uZvLXdcQ0
	Yo2mMgGMw4EtL+iEJs9wq9OGGQ9mwx/WMCS0drFjIrXYZk3hCbDo7SZD1FiZRLfA=
X-Gm-Gg: AYBFou3h9WLZlOdVCg8diDZ/Wj01IzyJhcVbnavfDh1gVjHMeJobqARDBeDKWYYZmlL
	n4SFBseuvyaeLWXjjQvgko/BnAX3U6H9C9Ctr81jYWjPNgTVobH1nLLDMRfWqdAOgpXzfv3QDZr
	Fhy+4uIkiDARsoSWHbjAKYUWGmzjHWMuOpqrRcDSsDeQdbcyunQVG3r8FGrXWROrDNUT+3+RMyh
	BOB4ridRjkTmOyaiQreHTeSrvroNLxhfF6tiie1eaZqNWHcu/2ckKKCC5sO8cUv4Z3LxdhvM0Qj
	enpNRA/5AcqYwxzNuovgj2+P9LUhDIGrLD9mJm2inVIcGmgU17Zd8C1qk6XLGOBdWz3lGORjq3k
	ASwNoc9tCZWiQG5rjeqPRTchkjctVsLph/8rQcHxoMT+qYdmN71DwccZspw4qcGNpGMixwcwop2
	YlH2tXLAmHr2Y2oijgYwZb43tylWoDo9cyDmhg2B3+N6JLbg4wP24=
X-Received: by 2002:a05:620a:2a14:b0:93b:d7ed:ff3d with SMTP id af79cd13be357-93ebd2aa64cmr1935921085a.63.1791887434171;
        Tue, 13 Oct 2026 03:30:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:93b:d7ed:ff3d with SMTP id af79cd13be357-93ebd2aa64cmr1935913985a.63.1791887433429;
        Tue, 13 Oct 2026 03:30:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:27 +0200
Subject: [PATCH v2 3/6] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cci-imp-v2-3-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace084b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=8R-5LDRAFMUVkZqLBecA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: YvMQj9J5u6RQmp5oH5sEU3IrqAs7NjNk
X-Proofpoint-ORIG-GUID: YvMQj9J5u6RQmp5oH5sEU3IrqAs7NjNk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX/rjVtpgBE7cb
 8hehjOEli/5AHsNSu05uxYWn1Qboo5mN1+VTVakK9zauZqsxkK1Cy/mcIPuQ6x4u/o4XjL4YAzR
 jRq8iFVRlhXbWFJn4C5jY1PVFpcFCrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXx+RywtazlhbI
 aK3yoQhvPaVNCHJKpOHUSiEW17YITycdJ8A+lEgXjZzalosBRRFU8fXcLdQPotm/L2LaARBRpsC
 4PeZ754Vr7DCiz53WCLSuaqlS9xQb7UK3iuSjo0nHrZLldg56/+KGhZ8rMITq8XrCYNJECWCS1o
 2Eqzk1Ldd1k8v9Pft2qimjpRr41caAYuevIqJj9W/lS0i9L3gcikLaYelyu77E4Bys1dv+gj1nE
 HnYQhgF6ywAEkXElRrTS7F5rF0RgUJUg5RQ5QuyjYpip7Zm7nRG+yIM8V/tehYzBdFAUW4ZkYAR
 33eSd4b86Ko5plVhYaiGdaK+JL/bME0bgPtR71rVig+wzOSLCu+v9zdniPG3/oxI1K8C5+xoOXn
 wHpr0RJZP6MX2ZOn2LIpcRz3vekHKwNfbi5BSeDbGFyimf4rtF0W3TQhLZlQKomal9Ajf6oB1GS
 m4/Q+4xQ2TT/Gl4lQvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

In theory, every SoC integrating a CCI revision that differs from
an existing one should introduce a dedicated compatible string.
In practice, most CCI instances still fall back to the msm8996
compat (v1.4.0), one of the oldest supported versions. In order
to take advantage of capabilities introduced in later versions,
such as larger queues (v1.6.0) or threshold IRQ support (v1.7.0),
we need to properly distinguish the different variants.

Replace the static per-compatible cci_data definitions with a
version-sorted capability table keyed by (hw_major, hw_minor).
During probe, read CCI hardware revision register and select
the newest capability entry whose version is less than or equal
to the detected hardware revision. This allows revisions to
automatically inherit the closest supported capability set
without requiring additional compatible strings.

Several compatibles that currently fall back to the msm8996
configuration (e.g. sdm845, sm8250 and sm8450) will now resolve
to the corresponding capability tier, gaining access to their
larger queue sizes instead of the conservative msm8996 defaults.

- v1.2.x CCI increase I2C write payload + burst write support
- v1.6.x CCI has increased queue sizes (64,16) -> (128,32)
- v1.7.x CCI introduces threshold IRQs (leveraged later)
- v1.10.x CCI increase queue 0 size (128) -> (1024)

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 162 +++++++++++++++++++++++++-------------
 1 file changed, 106 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 099da0069251681cc52e351fb656bd73e78a96c9..3bca29f1d2699375a0348b18a5a2e646a59fd94c 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
 // Copyright (c) 2017-2022 Linaro Limited.
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
@@ -14,6 +15,10 @@
 #include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
+#define CCI_HW_VERSION_MAJOR_MASK		GENMASK(31, 28)
+#define CCI_HW_VERSION_MINOR_MASK		GENMASK(27, 16)
+#define CCI_HW_VERSION_STEP_MASK		GENMASK(15, 0)
+#define QCOM_CCI_VERSION(major, minor)		.hw_major = (major), .hw_minor = (minor)
 #define CCI_RESET_CMD				0x004
 #define CCI_RESET_CMD_MASK			0x0f73f3f7
 #define CCI_RESET_CMD_M0_MASK			0x000003f1
@@ -133,7 +138,8 @@ struct cci_master {
 };
 
 struct cci_data {
-	unsigned int num_masters;
+	u16 hw_major;
+	u16 hw_minor;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
 	/* Highest I2C mode supported by this variant. */
@@ -144,6 +150,7 @@ struct cci {
 	struct device *dev;
 	void __iomem *base;
 	unsigned int irq;
+	unsigned int num_masters;
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
@@ -245,7 +252,7 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	struct cci_master *master;
 	u32 val;
 
-	if (master_num >= cci->data->num_masters) {
+	if (master_num >= cci->num_masters) {
 		dev_err(cci->dev, "Unsupported master idx (%u)\n", master_num);
 		return -EINVAL;
 	}
@@ -371,7 +378,7 @@ static int cci_init(struct cci *cci)
 
 	writel(val, cci->base + CCI_IRQ_MASK_0);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		int mode = cci->master[i].mode;
 		const struct hw_params *hw;
 
@@ -615,7 +622,7 @@ static int cci_get_required_rate(struct cci *cci, unsigned long *rate)
 	for (int ri = 0; ri < NUM_CCI_CLK_RATES; ri++) {
 		bool supported = true;
 
-		for (int i = 0; i < cci->data->num_masters; i++) {
+		for (int i = 0; i < cci->num_masters; i++) {
 			int mode = cci->master[i].mode;
 
 			if (!cci->master[i].cci)
@@ -690,6 +697,81 @@ static const struct dev_pm_ops qcom_cci_pm = {
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 
+/* Hardware capabilities, ascending by version major,minor */
+static const struct cci_data cci_hw_catalog[] = {
+	{
+		QCOM_CCI_VERSION(1, 0),
+		.max_mode = I2C_MODE_FAST,
+		.queue_size = { 64, 16 },
+		.quirks = {
+			.max_write_len = 10,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 2),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 64, 16 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 6),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 128, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 7),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 128, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 10),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 1024, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+};
+
+static void cci_detect_hw_caps(struct cci *cci, u32 hw_version)
+{
+	u8 major = FIELD_GET(CCI_HW_VERSION_MAJOR_MASK, hw_version);
+	u16 minor = FIELD_GET(CCI_HW_VERSION_MINOR_MASK, hw_version);
+	u16 step = FIELD_GET(CCI_HW_VERSION_STEP_MASK, hw_version);
+	const struct cci_data *data = &cci_hw_catalog[0];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cci_hw_catalog); i++) {
+		if (cci_hw_catalog[i].hw_major > major ||
+		    (cci_hw_catalog[i].hw_major == major && cci_hw_catalog[i].hw_minor > minor))
+			break;
+		data = &cci_hw_catalog[i];
+	}
+
+	dev_dbg(cci->dev, "CCI HW version %u.%u.%u, using caps tier %u.%u\n",
+		major, minor, step, data->hw_major, data->hw_minor);
+
+	cci->data = data;
+
+	for (i = 0; i < cci->num_masters; i++) {
+		if (cci->master[i].cci)
+			cci->master[i].adap.quirks = &cci->data->quirks;
+	}
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -705,9 +787,6 @@ static int cci_probe(struct platform_device *pdev)
 
 	cci->dev = dev;
 	platform_set_drvdata(pdev, cci);
-	cci->data = device_get_match_data(dev);
-	if (!cci->data)
-		return -ENOENT;
 
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct cci_master *master;
@@ -719,14 +798,16 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		if (idx >= cci->data->num_masters) {
+		if (idx >= NUM_MASTERS) {
 			dev_err(dev, "%pOF invalid 'reg' value: %u (max is %u)",
-				child, idx, cci->data->num_masters - 1);
+				child, idx, NUM_MASTERS - 1);
 			continue;
 		}
 
+		if (idx >= cci->num_masters)
+			cci->num_masters = idx + 1;
+
 		master = &cci->master[idx];
-		master->adap.quirks = &cci->data->quirks;
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
@@ -777,10 +858,6 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to add OPP table\n");
 
-	ret = cci_set_core_rate(cci);
-	if (ret)
-		return ret;
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -799,7 +876,11 @@ static int cci_probe(struct platform_device *pdev)
 	}
 
 	val = readl(cci->base + CCI_HW_VERSION);
-	dev_dbg(dev, "CCI HW version = 0x%08x", val);
+	cci_detect_hw_caps(cci, val);
+
+	ret = cci_set_core_rate(cci);
+	if (ret)
+		goto disable_clocks;
 
 	ret = cci_reset(cci);
 	if (ret < 0)
@@ -810,7 +891,7 @@ static int cci_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (!cci->master[i].cci)
 			continue;
 
@@ -844,7 +925,7 @@ static void cci_remove(struct platform_device *pdev)
 	struct cci *cci = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			of_node_put(cci->master[i].adap.dev.of_node);
@@ -856,51 +937,20 @@ static void cci_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 }
 
-static const struct cci_data cci_v1_data = {
-	.num_masters = 1,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 10,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST,
-};
-
-static const struct cci_data cci_v1_5_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 10,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST,
-};
-
-static const struct cci_data cci_v2_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 11,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST_PLUS,
-};
-
 static const struct of_device_id cci_dt_match[] = {
-	{ .compatible = "qcom,msm8226-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,msm8953-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,msm8974-cci", .data = &cci_v1_5_data},
-	{ .compatible = "qcom,msm8996-cci", .data = &cci_v2_data},
-
+	{ .compatible = "qcom,msm8226-cci" },
+	{ .compatible = "qcom,msm8953-cci" },
+	{ .compatible = "qcom,msm8974-cci" },
+	{ .compatible = "qcom,msm8996-cci" },
 
 	/*
 	 * Legacy compatibles kept for backwards compatibility.
 	 * Do not add any new ones unless they introduce a new config
 	 */
-	{ .compatible = "qcom,msm8916-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,sdm845-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8250-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8450-cci", .data = &cci_v2_data},
+	{ .compatible = "qcom,msm8916-cci" },
+	{ .compatible = "qcom,sdm845-cci" },
+	{ .compatible = "qcom,sm8250-cci" },
+	{ .compatible = "qcom,sm8450-cci" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cci_dt_match);

-- 
2.34.1

