Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD03CB8F1
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615059; cv=none; b=nhWE/zIrKX1PBs2d5wrY1XCKDo2/Q7Tes420bj3gwSJQFExo5oevnjHjt5mCeFgqwdfr6BwtxMdUyOdYnWHb/E9jAQOEzy+LVbx7zBSZzCN5Ch3awmPpH4NCSn1DTiN8j+clPfH82B+48KVadlnGJNLHpc0XLbHM0kktIYdbKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615059; c=relaxed/simple;
	bh=wuSugMFw7du1ubNBPNbGxn5teYp92r0oIhUfiHjDrGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJcID+Uq/62KstfudZdeYxUG6lb7eV1sLg0NLHvn9rMgnpjEKgUBNdC681g+38LMg5dYq6Ss957SAsRwcOul3ZUOQ1inkFhUYtqZOFs+6K6wHBkUFcbQMRXhLPQACmhTO7UKwEMNZ5dpXa7STJEFUESNBYIYrbRPvgB0U75k6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIecqnx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqVe+qPw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIecqnx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqVe+qPw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J0AYB3564044
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GDgHay8m77gRxkFUh/jBO+4KoNBLpLg4Twtd7EBouJg=; b=SIecqnx8OFicbM7O
	H+785y6Nxp+nbyPlF5OyahLynj3mReQz7YnxQ75sgA2PP4/7APPFMt8GlagrYUk/
	FzThOFSDvrxJX3dBc5QRlvVJ54Q86jBoO1jaHwtN8s0KIS+JvYs9Oqz/gtrsja7L
	hux5mWPnwcnVyVeCeqhLCS6Fmh6NL9Y2OFi7HozaYgd8hVty3aDMui1Z/lDGAW11
	ks9eemcWHPuAuNQx6IBsVhLpxr8bjvIyy1z6ZB++rDnQR7/yAjtki96DVOt5VUVX
	Xvfn+35cHbRv/rfDCA3g31k+Yr9K32Iu+CjhdTReucljDjMk3BB/XmscK39pX2yp
	xHut0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9669jgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:10:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so37840091cf.2
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615056; x=1786219856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDgHay8m77gRxkFUh/jBO+4KoNBLpLg4Twtd7EBouJg=;
        b=JqVe+qPwKAB6/WtOmBziCBmiUyeM8n+ffN+GpTIKvIG+i7onSLjGb1/t/QNbq2l5/B
         wthvb7I9Dg4lxDJVP+LxTd7bRTyTjJMP5BKOwcOu7JZiCDbgty2aydUGt3NU4o9yYGb2
         iJI58vGEHyoqlOJ0ncPCEFVNqhm/oUpcOByHTnG49CSOCkTMgf2odhvvsujetveVpCvC
         vW5k9rkdfq/T4v2DCcK8OJ5Gw7Pa+SVSZho5t7HIvpDWbUNvJp63U2rVK5VfOeomSNs2
         uS7lCLDUylLF4uqKyeL0Jep5x8yANw/w4Y+3Ry2NkEIaZTd4fWPBsVC4GlTvFkNPw7/w
         vAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615056; x=1786219856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDgHay8m77gRxkFUh/jBO+4KoNBLpLg4Twtd7EBouJg=;
        b=Kq4/rcdd4iLDBW6ZSA9iRtRQkZK4QbbR81tIqDL/jt+84pj6Ik7cPT9Y9y2bGdQ+5t
         UfH7dxz0jxDAZFfIDUw9L51+BiHsmGCLpyk8piVoT/zS38/8D+KztmKpRHXf9Kr4Bxkv
         5VTrp+KAMvkU9vRDTEeqjR9RIi4/6qDEeTo+mnKmTEomfBZHQIozUGom0+wSDg730Fgz
         QGAFXYfjh9tuQuI6KTOgWSiF5DmTET+PDSJGbNiSPCAPZCEvBurXaBERYSrsepkfE+dp
         1lDXyAsjr25SU+DAm2+bSoAI8W34SpVIhasIILm18g2Ieg5iQ0nWtZbfzI9xWNh4jIuM
         FXWw==
X-Gm-Message-State: AOJu0YxsNTF+laafcGYTJ6A74hvT+hhIl9HF9MazXHzobssMk6byAYrN
	MgbqspDtaT2eUwC2+46cf99ed9wqLsL/x67cKgKeXwCfxBa5hK42VAHu7wMHbxafqUVrWd84Dit
	EdsVBLg0KuuAOMFz+XDI3mAP+uUm7IkZWcFTVux6eY7xekmK7/Wg22M1saEZkkyD7rxE078c=
X-Gm-Gg: AR+sD11WISggnplRN33cNIOIxnCAToD164CqCrlHq1D1rGxK8CE+sn2H5RNW8ndcZfL
	JFRcgomWTVBHFRUeaQU5i5TCiIY7c+vKgTUebfOzUoeXOSLLCrGV2oLEqTWAV55MpgXtIEgl8fu
	n2Ge+Cm0rcJO9djUJhy0zpH/PwY4i5V986N76KRwmMjx0xxQ2a6Pjve24fw0IGhjhYwEinTL3un
	q7YbHoZPhP0FX0vbOOo0kDyTXBOO0Mt3fO04LK9W2IGLXYhY8NYURDZcalVCJqeRQgDSe+pN1ek
	y766VkoHTjvZ4GBs9IWftXCcmX3l41vFY/e8hbVYjiE9a2nMMD1+EoofT2lhpwioxjFy4yjhkea
	IbLQXbHYeElXchNvJm6XB0GT896N7rirduJApWY3hZ1+gV2ewRNH36vUX4Lq0CRsO9nxnr+y6P8
	4G/aSbwWOOYlC/yH9LINmH7/MLu5/3djj3CNvaoRsBid5UZh9KYNLJ
X-Received: by 2002:a05:622a:4888:b0:51c:1d0c:605f with SMTP id d75a77b69052e-52b5674c191mr108668201cf.20.1785615056134;
        Sat, 01 Aug 2026 13:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4888:b0:51c:1d0c:605f with SMTP id d75a77b69052e-52b5674c191mr108667811cf.20.1785615055764;
        Sat, 01 Aug 2026 13:10:55 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:10:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 22:10:44 +0200
Subject: [PATCH v4 2/5] i2c: qcom-cci: Support per-mode CCI clock rates
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-cci-clk-fix-v4-2-e1d80da54e01@oss.qualcomm.com>
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: iF7YeO0e8zq58f5XEH1KAW5q4EwTv6xH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX/zpi4HosxGe2
 pQxNssqrx2/KOCiG08O4cBaGy0cbbJsXyRE4EEhQLMgVyQ6Lzjm3bGu41o/UoueLAP40fcZsquQ
 /j2sQYWG//2KvaGBu0ZF29xaR83CqwUfMVfYBdd/DWM9J1PIUTs3NGz2yIWi+sF2mMrblaoRTjC
 lad2VlsgBVcpxCR5yTv4Gm/t9vcQ7nXJiHb0ukugbW9cpilZV+NwpvMkAb3xNsepIvKClu6wqOe
 qY2ZSqD7vfGpvVpEli/FDb4C/ziNKSvUbVXeBj9hCOwtWSQ6f5CEPiuqdKk6RTv7rac0eMI5DTe
 FQFausXpjoHlz11hA+H2YnNAFIU6F+AwwpkYO1LuYf5gpO/pvIOqbsnvbQMP+hR/G/SAKk6MI6S
 k1n1Z6HGXRQ3lk8ieqeA6Xy7NZSqhNc1PusANZ/iYETfRIluo+3rKNVG8soNnkCAcXb7LwFe3OL
 rDh0gud5Pyl3R8m/kTg==
X-Authority-Analysis: v=2.4 cv=TpfWQjXh c=1 sm=1 tr=0 ts=6a6e52d0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=SSN5QVRp6N_zrvNS6moA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iF7YeO0e8zq58f5XEH1KAW5q4EwTv6xH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX7BEba3Thfnfp
 H7kd6I6z91iAqUljsKZOICuoV+iV7nPQOzeX+GVGzl9CRMG4Dk4bgJgDWDvPGw6BHDuRM6oDeUw
 UvUqh8qonelsR1OcemaCdlNI7Ht2cZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010162

The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
clock ticks and are only valid at the specific CCI clock rate they were
calibrated for. Different I2C modes may be calibrated for different
rates, and the single CCI clock is shared by all masters.

Turn the timing table into a two-dimensional [rate][mode] matrix so a
given rate can carry timing sets for each mode, and select the entry
matching the currently running clock rate at init time. The existing
per-variant values are moved under their calibrated rate (19.2 MHz for
v1/v1.5, 37.5 MHz for v2), no timing values are changed.

At this stage the driver only validates the running rate against the
table, the timings are only valid at the exact rate they were calibrated
for, so if the current rate has no matching entry for a master's mode,
fail initialization rather than program incorrect timings. A following
patch actively enforces the required rate so this becomes a safety net.

Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 74 +++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 0a216c4d08114f267c8441925e8811ca64f1a909..1092ce0371429ef64c7cc44cc23a42ba4c135af5 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -82,6 +82,13 @@ enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
 	I2C_MODE_FAST_PLUS,
+	NUM_I2C_MODES,
+};
+
+enum {
+	CCI_CLK_RATE_19_2MHZ,
+	CCI_CLK_RATE_37_5MHZ,
+	NUM_CCI_CLK_RATES,
 };
 
 enum cci_i2c_queue_t {
@@ -117,7 +124,7 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
-	struct hw_params params[3];
+	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
 };
 
 struct cci {
@@ -127,6 +134,7 @@ struct cci {
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
+	struct clk *cci_clk;
 	struct cci_master master[NUM_MASTERS];
 };
 
@@ -225,7 +233,34 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	return 0;
 }
 
-static void cci_init(struct cci *cci)
+static const unsigned long cci_clk_rates[NUM_CCI_CLK_RATES] = {
+	[CCI_CLK_RATE_19_2MHZ] = 19200000,
+	[CCI_CLK_RATE_37_5MHZ] = 37500000,
+};
+
+static int cci_clk_rate_idx(unsigned long rate)
+{
+	int i;
+
+	for (i = 0; i < NUM_CCI_CLK_RATES; i++)
+		if (cci_clk_rates[i] == rate)
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
+{
+	unsigned long rate = clk_get_rate(cci->cci_clk);
+	int ri = cci_clk_rate_idx(rate);
+
+	if (ri >= 0 && cci->data->params[ri][mode].thigh)
+		return &cci->data->params[ri][mode];
+
+	return NULL;
+}
+
+static int cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -249,7 +284,12 @@ static void cci_init(struct cci *cci)
 		if (!cci->master[i].cci)
 			continue;
 
-		hw = &cci->data->params[mode];
+		hw = cci_get_hw_params(cci, mode);
+		if (!hw) {
+			dev_err(cci->dev, "no timing for mode %d at CCI clock %lu Hz\n",
+				mode, clk_get_rate(cci->cci_clk));
+			return -EOPNOTSUPP;
+		}
 
 		val = hw->thigh << 16 | hw->tlow;
 		writel(val, cci->base + CCI_I2C_Mm_SCL_CTL(i));
@@ -266,6 +306,8 @@ static void cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
+
+	return 0;
 }
 
 static int cci_reset(struct cci *cci)
@@ -283,9 +325,7 @@ static int cci_reset(struct cci *cci)
 		return -ETIMEDOUT;
 	}
 
-	cci_init(cci);
-
-	return 0;
+	return cci_init(cci);
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -488,8 +528,7 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	if (ret)
 		return ret;
 
-	cci_init(cci);
-	return 0;
+	return cci_init(cci);
 }
 
 static const struct dev_pm_ops qcom_cci_pm = {
@@ -570,6 +609,11 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
+	cci->cci_clk = devm_clk_get(dev, "cci");
+	if (IS_ERR(cci->cci_clk))
+		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
+				     "failed to get CCI clock\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -652,7 +696,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -664,7 +708,7 @@ static const struct cci_data cci_v1_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -685,7 +729,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -697,7 +741,7 @@ static const struct cci_data cci_v1_5_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -718,7 +762,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,
 		.tsu_sto = 204,
@@ -730,7 +774,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
 		.thigh = 38,
 		.tlow = 56,
 		.tsu_sto = 40,
@@ -742,7 +786,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST_PLUS] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
 		.thigh = 16,
 		.tlow = 22,
 		.tsu_sto = 17,

-- 
2.34.1

