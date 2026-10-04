Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8E497B81
	for <linux-i2c@vger.kernel.org>; Sun,  4 Oct 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141008; cv=none; b=CDQy07h8Ya7al8trDJl2Zr6HzSyn0HHDshkELMO8Ux+7nqYwBmt8DUdCi6w56PqbaFIsWP1Rkug2wZiKdfAK6iY305NMyxSpT4dju2r8IlBGWfW/Can7hjvCftfkEL9B187tzKVxPm+KOcC9yfC9H3ODeUijkCS5+gpECMEexIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141008; c=relaxed/simple;
	bh=2MPVuOKTsu+qiTVVCZWs+5Limvxk1zCeCGybsaPvJec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwafuR5D0rvru0S22hcUenCDeoiSL7PwD9wffbdlpfKQlVhrvgTm3IDMFQmtbGSYsq49Izpjew0iNqY2Hu9GVB+fFkZsDjXZ6wyIps/3wDSaV90nwU7hx+hmyLfSBw6oHXEohKaKLbLADupsx+3d0//Oe+8ERx2KXOitdfUvh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YP4+uC9y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VPenI/8C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YP4+uC9y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VPenI/8C"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694IHgms119810
	for <linux-i2c@vger.kernel.org>; Sun, 4 Oct 2026 19:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	59zywkqWAOH+Sf77rQKm1VSFzR6HE8w0Xnvh3qH53is=; b=YP4+uC9ysIMuApyI
	ZO6Sl0t39h6Jl9EoNHdxO0fbSNAHsXjBstHzseE4iix4nVO1iz0pICcRZG16GjO5
	A/vukpOFeanL98WfVw+1rin2FtolAORRHSa8EA3q6oTWZdzfrlj0DGjpCZSEqIQ0
	5uTRe9cgt2kO2oxw9rhCe3SI45eBjMY1bchRd5UvZ5+Q1XWRCP3ibmrN3EngqUho
	ziuewe3fwLyVkDxCMSXqKmeNk+htF8Xdww89cz9+8n0c1gPbPe2x/+oF41N586mH
	jHbt7VPNi0hiDab2nZ5kmkqxT74itGFfqupaj003PyEw2DG2UisHKWg1uatqYGhy
	yjQ1Bg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8umkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 19:10:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb93c874bso185210885a.0
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791141002; x=1791745802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59zywkqWAOH+Sf77rQKm1VSFzR6HE8w0Xnvh3qH53is=;
        b=VPenI/8Cmbog+6B89SOcaFEe1O++p6GLxZQK8Mlg1dYr/tfpOeKqAQkENHtKdYZ3LE
         wsLpooDMvLZKIG8DwsWWN9JmCrBT//iit1XtR+ww8mJ/MffZCWmm16DXdGnLqe1OTc8i
         dW80/8176cf4PF9to0Mve6XAAhqDo4eEJU+81fKMDiGdty2B73CLF4IAxzYs/OEtrDFF
         wF+mYdMiGJyxH1uT+nJNmUYR5tHqSTL+hwOzUOb9qi6zWJnc6YlYBysckkJXe473TuxJ
         U7Pk1p++/PwSMX9p24kSpBrokKmJFPQh+wc8EG3wahtCjv5INuz1rxozpn6ye0lgaADx
         2hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141002; x=1791745802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59zywkqWAOH+Sf77rQKm1VSFzR6HE8w0Xnvh3qH53is=;
        b=EBhDdSWCYTKEwLACog3yWUXi1ciSstqdsJxjWaLH8g0zq5lHyNI13JkOhSHYZ7fZl2
         uDluhEmWRlEJzF8Ew35ar3V+gbh3QD7kAYuPFNvs+MjsgYespJpYONPJDVVwbuyHHjGV
         1PCB1AQOSgulvFP2XPczQ7b/yMOUbb5HCHuNuQPtCdmY8UoiYYRvqyoa+75937iIFbTc
         2mvW8CGWNcPKASW/0QEdRzJa6ZA2A2rmQICDzOiICgU1o1566xS5UDZD3U7/FhSMjERm
         Pgeilo8FBnMvp7bE+e+SMbnQo/cOOT2wfXQAHVpB/DmOLQfUJYPrtLTZaHKCPK5kX3yy
         NMUQ==
X-Gm-Message-State: AFuF++mGUazEyUPB/erOOfDC4yet1/SPHfAAN/GVSpp9jGQq4aokVzNn
	Cz8NDo1VFIFQ0irZw+2cNv62kJMw7Bix8dktB6m1kjsspxNCGVxn+NbvrrRSUMBezaX5K8J03ec
	mcdTlnWl6ODr1FYJTGf/k60XF8sZTmovI05SkjC+++mKNrtSZXY3Tc5hsZQeI3CE=
X-Gm-Gg: AYBFou1S4ZBonYCI+hMQ+bDHRBBrSQgQ4lbe2+zuwNQgwc4opPc1Y0qx5Xrly2znFlB
	RlUVQtQZ7ub+/tPMbp0rjZSS2bSt1QSwBed0R+yoT2EHVWyRTI3toxC0esKPKlo4BYIrGIQkG+i
	rz49Kg9TXw5z6O+WuraepvB2NheMkR55dHeavI7nns8xpIWqOZZMopKhFSuTC8mwT/VX68sm4DZ
	+JQgBOSZAkPD1TFqlU91M81z7lklT6DuzmbOvnXxQqaT+ZcA8ECUY9rxzl2wUIbfzRRnx/MW84N
	lMXeyk983VOwOfPCrtqsSI20uqe5RLo9jVE9mdFNAYo34stGji75iRsSNybL0QSjYXUn8JTM629
	YIuViqjee/6bdbi8V58Ymuk3No5lALZqbNfl8x1JO+u7ogMCXS9eJkdWlTAzdci+3GVytfot5V8
	JTkYo6gpkf5Nh0p536JJQthZAY7eO0TsqKGBZiKCnKIJw+el5q8g==
X-Received: by 2002:a05:620a:2682:b0:93b:cb64:25a5 with SMTP id af79cd13be357-93cb5a52e38mr2150125785a.12.1791141001555;
        Sun, 04 Oct 2026 12:10:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:93b:cb64:25a5 with SMTP id af79cd13be357-93cb5a52e38mr2150122585a.12.1791141001067;
        Sun, 04 Oct 2026 12:10:01 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([37.169.59.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394ca0f0sm176318385e9.1.2026.10.04.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:10:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 04 Oct 2026 21:09:49 +0200
Subject: [PATCH 3/5] i2c: qcom-cci: Detect capabilities from CCI_HW_VERSION
 at runtime
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-cci-imp-v1-3-227d12cb4829@oss.qualcomm.com>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
In-Reply-To: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: vEXZdvzXXK-JXGEIpeAA3J3tmdXJu7ti
X-Proofpoint-ORIG-GUID: vEXZdvzXXK-JXGEIpeAA3J3tmdXJu7ti
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac2a48a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=1Gfya9YG+27Uq/30OuQ23A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8R-5LDRAFMUVkZqLBecA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX1+RHeq8kbzcX
 kynmDquR19YFfAYjMGf6HtsEiGQ0pyw5rSXZ5IyOrLtdiDzMMIHnIGg3cOILl2fJYJNK7FE+1E6
 VdijJeqtvK3sIczUAgOCK1GyH4ylxSQBkrO0SrQYkMpZVMhPrkb1RLwmYsYHCMRAARaVmyG8LWl
 lSOicEuNKXLfAbv6stM73+/Ce0GXe86A08C9xbolXQFhmIJDbjzh+04h4DRcSG7EwB+73WnlxtB
 QNLFCu1azYaxIdQp3wLM/uSnRVQJjMz7nDFxlLxDRl0Y1lwPYvU0NLs5SV8q5zpvPkXM6IGeRlW
 KSO+BEwH6e2Gm+rq5jBB2x+dCpVztY8TSzcRyTKv66jVJRnUI+CunwnvTFND7Gs+m5N3tmF9BsM
 fjFGRL1RR5vstYbG58IFqsDksMke62bhJx1mHzT4x53FgoLKtu8VgqZ2TcOGksBpxGryKnh8AlS
 gUN3YqV3Dm7HdFgA3eQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX6PWaTC7/N3TI
 x1nHm85Rj9SDfrRg85v0+1EMLFaJmDM7hZQzEiUoesXVBu7PAYBOWhoKZxLZD1Pe3UGg0YDxJjx
 I4EJGy+Yl8Xf/6WiO+mDouC3LvTkyhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040076

In theory, every SoC integrating a CCI revision that differs from
an existing one should introduce a dedicated compatible string.
In practice, most CCI instances still fall back to the msm8996
compat (v1.4.0), one of the oldest supported versions. In order
to take advantage of capabilities introduced in later versions,
such as larger queues (v1.6.0) or threshold IRQ support (v1.7.0),
we need to properly dinstinquish the different variants.

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
 drivers/i2c/busses/i2c-qcom-cci.c | 158 +++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 54 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 099da0069251681cc52e351fb656bd73e78a96c9..c0b39d419e296454a083d38ce302940875b8ad2b 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -14,6 +14,10 @@
 #include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
+#define CCI_HW_VERSION_MAJOR(val)		(((val) >> 28) & 0xf)
+#define CCI_HW_VERSION_MINOR(val)		(((val) >> 16) & 0xfff)
+#define CCI_HW_VERSION_STEP(val)		((val) & 0xffff)
+#define QCOM_CCI_VERSION(major, minor)		.hw_major = (major), .hw_minor = (minor)
 #define CCI_RESET_CMD				0x004
 #define CCI_RESET_CMD_MASK			0x0f73f3f7
 #define CCI_RESET_CMD_M0_MASK			0x000003f1
@@ -133,7 +137,8 @@ struct cci_master {
 };
 
 struct cci_data {
-	unsigned int num_masters;
+	u16 hw_major;
+	u16 hw_minor;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
 	/* Highest I2C mode supported by this variant. */
@@ -144,6 +149,7 @@ struct cci {
 	struct device *dev;
 	void __iomem *base;
 	unsigned int irq;
+	unsigned int num_masters;
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
@@ -245,7 +251,7 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	struct cci_master *master;
 	u32 val;
 
-	if (master_num >= cci->data->num_masters) {
+	if (master_num >= cci->num_masters) {
 		dev_err(cci->dev, "Unsupported master idx (%u)\n", master_num);
 		return -EINVAL;
 	}
@@ -371,7 +377,7 @@ static int cci_init(struct cci *cci)
 
 	writel(val, cci->base + CCI_IRQ_MASK_0);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		int mode = cci->master[i].mode;
 		const struct hw_params *hw;
 
@@ -615,7 +621,7 @@ static int cci_get_required_rate(struct cci *cci, unsigned long *rate)
 	for (int ri = 0; ri < NUM_CCI_CLK_RATES; ri++) {
 		bool supported = true;
 
-		for (int i = 0; i < cci->data->num_masters; i++) {
+		for (int i = 0; i < cci->num_masters; i++) {
 			int mode = cci->master[i].mode;
 
 			if (!cci->master[i].cci)
@@ -690,6 +696,81 @@ static const struct dev_pm_ops qcom_cci_pm = {
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
+	u8 major = CCI_HW_VERSION_MAJOR(hw_version);
+	u16 minor = CCI_HW_VERSION_MINOR(hw_version);
+	u16 step = CCI_HW_VERSION_STEP(hw_version);
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
+	for (i = 0; i < NUM_MASTERS; i++) {
+		if (cci->master[i].cci)
+			cci->master[i].adap.quirks = &cci->data->quirks;
+	}
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -705,8 +786,8 @@ static int cci_probe(struct platform_device *pdev)
 
 	cci->dev = dev;
 	platform_set_drvdata(pdev, cci);
-	cci->data = device_get_match_data(dev);
-	if (!cci->data)
+	cci->num_masters = (uintptr_t)device_get_match_data(dev);
+	if (!cci->num_masters)
 		return -ENOENT;
 
 	for_each_available_child_of_node(dev->of_node, child) {
@@ -719,14 +800,13 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		if (idx >= cci->data->num_masters) {
+		if (idx >= cci->num_masters) {
 			dev_err(dev, "%pOF invalid 'reg' value: %u (max is %u)",
-				child, idx, cci->data->num_masters - 1);
+				child, idx, cci->num_masters - 1);
 			continue;
 		}
 
 		master = &cci->master[idx];
-		master->adap.quirks = &cci->data->quirks;
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
@@ -777,10 +857,6 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to add OPP table\n");
 
-	ret = cci_set_core_rate(cci);
-	if (ret)
-		return ret;
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -799,7 +875,11 @@ static int cci_probe(struct platform_device *pdev)
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
@@ -810,7 +890,7 @@ static int cci_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (!cci->master[i].cci)
 			continue;
 
@@ -844,7 +924,7 @@ static void cci_remove(struct platform_device *pdev)
 	struct cci *cci = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			of_node_put(cci->master[i].adap.dev.of_node);
@@ -856,51 +936,21 @@ static void cci_remove(struct platform_device *pdev)
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
+	{ .compatible = "qcom,msm8226-cci", .data = (void *)1 },
+	{ .compatible = "qcom,msm8953-cci", .data = (void *)NUM_MASTERS },
+	{ .compatible = "qcom,msm8974-cci", .data = (void *)NUM_MASTERS },
+	{ .compatible = "qcom,msm8996-cci", .data = (void *)NUM_MASTERS },
 
 
 	/*
 	 * Legacy compatibles kept for backwards compatibility.
 	 * Do not add any new ones unless they introduce a new config
 	 */
-	{ .compatible = "qcom,msm8916-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,sdm845-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8250-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8450-cci", .data = &cci_v2_data},
+	{ .compatible = "qcom,msm8916-cci", .data = (void *)1 },
+	{ .compatible = "qcom,sdm845-cci", .data = (void *)NUM_MASTERS },
+	{ .compatible = "qcom,sm8250-cci", .data = (void *)NUM_MASTERS },
+	{ .compatible = "qcom,sm8450-cci", .data = (void *)NUM_MASTERS },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cci_dt_match);

-- 
2.34.1

