Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9608345729
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671878; cv=none; b=XOlBltQfjJS1+zRZVEj/8x75yg254IQwTFQI15UTl6NcyICzVqGIqOBY1cBWZXH7hXuNg/3Il+NPhWmiscJL1l2+G0aiDP3OuaNCL7/DhTNZOLzDeiE2GdwmnKU0ESPg++6znWjwcTmYkFwnR9IosdYLnd/m47RyJzOArZnthHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671878; c=relaxed/simple;
	bh=4n6dn6i/Lbu50iXsvDsgw2Z2Ze680qElqnviOJCdZSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn93UpdBS+K7M77rc1874TwUwNJQP6tdARENLgT4+WI28h+Q3OhfbUuPcHgUQS66eORIb4EQE9jHZfSL+xzZOBLKENk9sXZm3nlV5UqzqqT3P4cS127vpTNodSP3qRQMbl3TPbPNJ9YndXdfUSTepY5X76tpkYdJdRcUMx7OwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHm9k3kN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dJb8Tiqo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHm9k3kN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dJb8Tiqo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H4kuCJ1768453
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6YVvmntp7p1nnGPLLGkWWmVa56JfsmVkcCJ2HQy83Gc=; b=YHm9k3kNWakKHhnE
	Z4x6wgnmFW5Odg5EaYa+576N4YBrw138wwPFe8HRCahc4cNu7gM6C5ijeekkdetH
	tibkIATVDK2YDj0iTq/oV376rwS9jo0jzlQt8QTFAvCphy63ogwMw6BBIxD7i60/
	CzlNYuC8O5su/4IjkajWN0nkZefg+k35F91Tl7v+JynATmYLQWEwLaeVHUqeisZ0
	BMcOCvh4AOKoSpS4r/8pc1PgglGPLcVye5Yq3ANNY9hhOY+B2VW5zBy2R/JWo2lA
	6lKKzWHScwRwbTHWSX0oKjjorjFU9ve0Q3ckGVtCBQqbtrQ0WtwB3zECa0tx60GN
	WZAKsA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef29e8a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:51:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423f24dcedso6506490b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 21:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781671870; x=1782276670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YVvmntp7p1nnGPLLGkWWmVa56JfsmVkcCJ2HQy83Gc=;
        b=dJb8Tiqo4og0I8NqCCXs0UhkSxBy3eCVABPgotMIsnzfT9ZDFo/HySBmriZ63lM5WK
         uK7lIG9urZXNMznpgvay4BHxPDB8soPULOHysDy4PsVlLsp30MuvYHHAxykHOiXQdv35
         quXM8MZxLwSsp/48d6bOhSr7QFMnowZkMnjixXAgCFLha4VmXNUf0+6iTvQbhJBEeT3c
         N2V1QhsjkBp4+kjye021RPHj09L1Wu6jUYpAVr5kTfx2EYZHWTpxcjw1ys7+CwsLdivP
         QpVX0i7/O38jgp/sJfcu55D5OknIiiGazOhyMNq8A3WScHhGsgfVFO9QK76tPyVAYMgj
         vesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781671870; x=1782276670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YVvmntp7p1nnGPLLGkWWmVa56JfsmVkcCJ2HQy83Gc=;
        b=I+1HmoNgWilOppH4glHuomCoCZbVGJx30EXqBgZd/qq9gkHqgUr4Pe7cDGM8PLgSTW
         xH8Pqo6kTdLPHCW3R1+VINcS6YhREB8/4kuZFZ9p/cS9NCwHIbuYvswMzWzTASHlIBq5
         3tGv99g0bWTs35IjWcRB/vt8k+n96Dk3jN8Tw9JxeqCGbZopXAt77qMu46+gGxjXB49U
         mQ5QdE2p1MN7NsBmHrYNoikip9j4QwyE9MTXI9FNmIJ5gD0u6YAY3Spmhork00w7UPzb
         BnNv9hWAI1R7LQ1ArmlTfhtz7+6u4rHM5IwPeJBGjHgoS/pVg0EU3oAQHnPniygKiC2p
         yiGA==
X-Forwarded-Encrypted: i=1; AFNElJ9xnhL7WmdMRVxiu/RwU3WarJx6esRu6RntjAoR3uWZO9cp8ibPnVFncd+PcJM88jhdAiC76+mH1oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjy/VeOk06LOqUHXq1BF7YuA1Czt6Wlbb/vGFQemQB8hrIaWEl
	mWlOF6RWt/zjg2rhhgi7AyucjF195PAwo6nVfg19vgaPbAd2OJLdWZZjgb5B8ZFMEZUsRzExoUf
	SLH7CLeoXfhr+p/1q5kkwF2z+JKY+4vK/hv/vyCyB9SMNCRmaQ5tQn2OiLoiIm+8=
X-Gm-Gg: Acq92OG1BCQ89kJjskewbLSmHA9BK7i7py0L8FGg0aT/9QxTj9OOGUG2ps3562Tl2LN
	JT3pq4k4QVJnMWP02PZPuvkBj8o2LUCX6LBPq1sPoSuxkDDbey1oiASThQWQBWqIifCpFOI/zuu
	0hsH4XbSx1B+kTA4US+fU4DTykil2cEqG+tqFHBfDwc1ADQTkrQnqvR7o7jLcK/FBy8VddD7MQV
	0NPUyFdKxIYCP4/YS3ahvjBTAEFkz7CiwgXZL0hyk4p8i9DVuMTb61JqNi+Wz4gzk68ND+Bq+tF
	z8iVhyy2Hjpw5IFDButLy+0etJWzdF7KyHTGEv/kgCs7ZtdGkRwWbuNcjUoQdHeMGrmPhTTSnfy
	EjY4c+Xm+reIldfwINKaABi6NlSCnYqUFsOFiLdR1Fy3F
X-Received: by 2002:aa7:88cd:0:b0:837:db4e:a35d with SMTP id d2e1a72fcca58-84524555db7mr2246696b3a.23.1781671869607;
        Tue, 16 Jun 2026 21:51:09 -0700 (PDT)
X-Received: by 2002:aa7:88cd:0:b0:837:db4e:a35d with SMTP id d2e1a72fcca58-84524555db7mr2246666b3a.23.1781671869060;
        Tue, 16 Jun 2026 21:51:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm14721127b3a.8.2026.06.16.21.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 21:51:08 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 10:20:20 +0530
Subject: [PATCH v7 6/6] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-enable-i2c-on-sa8255p-v7-6-ad736dbeab57@oss.qualcomm.com>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
In-Reply-To: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        prasad.sodagudi@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781671828; l=5789;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=4n6dn6i/Lbu50iXsvDsgw2Z2Ze680qElqnviOJCdZSg=;
 b=gXxIqPWNVLPpuiR7m1MmYY5CjS9pZ7DlPrDZ4nZW/XzeqwFJ8yzykR5HFK2L8beTLwMUL+0wz
 5krujsqnq8GB3+FYDwzmKCW/YQSjLvADOq5mcqmjy4ntgefwCtsihHn
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a3227be cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zgZzUwpPmSg69XYvEVoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX2WN4TNQ01EXo
 MQwufZd2pQtuTAsI1mEl+b+6mLal4cOHZ98s2P67/Qe4OyONrwtZkCgKWWZ9gd6Uzv5L+gp3IVt
 z6mEXlOHHQgMy2K4Ap/kN6gDfcAb89Q=
X-Proofpoint-GUID: _lETQYcrdxc9ODXIpTWqQf_40Qx2guUT
X-Proofpoint-ORIG-GUID: _lETQYcrdxc9ODXIpTWqQf_40Qx2guUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX2F0G6aQLMPUG
 9krU0AJlCeg5k+4IOsSCvaDI8JS7EANCoTXOwelJBO8sk/qc2BWvCXvsoRQdWeM+coyeMEAlsFk
 VwqKFO3k2o+yh4g/7bHJHlMLyAAX0iCsDk+/U+JWlLg1xBfyJvj1xz7r4UX1BnJ7jCXqxgvL7MC
 LSPPH91D/uRTuhS+Ng+XzOgjzIdU9K+/a5wS9+1WsPuClfKA4TeBHjmWMn/VwStQBxSaXT42gyh
 tK3doYZKc2lLESVBjxrwrSRioHMwFr32/VhrSoAAnjXWFXn/hfnyzm1Y/B2P6lb7w5RG4Qbkbht
 UV7voGJYgHDLw2NsIdZCZVcBjbZm34iR0qDMaf/nbO6eJyyhWeq8aYsl4WsCk8NJtXKKCOo735d
 nrjozGuYXQzhJTJJeRR9k7WOmQ6j83tU3HQNXbov0AVjyWVhpm16IcnBcvXYLRGbSWh2PmUXHb5
 tzBk5gLuw0SEFuiH4Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170041

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power on/off.

The SCMI performance protocol manages I2C frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate..

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v6->v7
- Added Reviewed-by from konrad.

v3->v4:
- Added Acked-by tag.

V1->v2:
From kernel test robot:
- Initialized ret to "0" in resume/suspend callbacks.

Bjorn:
- Used seperate APIs for the resouces enable/disable.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 56 ++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 92cccb1cce69..96dbf04138be 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -80,6 +80,10 @@ enum geni_i2c_err_code {
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
+	int (*resources_init)(struct geni_se *se);
+	int (*set_rate)(struct geni_se *se, unsigned long freq);
+	int (*power_on)(struct geni_se *se);
+	int (*power_off)(struct geni_se *se);
 };
 
 #define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
@@ -200,8 +204,9 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
+static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
+	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
@@ -214,6 +219,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+	return 0;
 }
 
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
@@ -919,7 +925,9 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	qcom_geni_i2c_conf(gi2c);
+	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	if (ret)
+		return ret;
 
 	if (gi2c->gpi_mode)
 		ret = geni_i2c_gpi_xfer(gi2c, msgs, num);
@@ -1045,8 +1053,9 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
-static int geni_i2c_resources_init(struct geni_i2c_dev *gi2c)
+static int geni_i2c_resources_init(struct geni_se *se)
 {
+	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	int ret;
 
 	ret = geni_se_resources_init(&gi2c->se);
@@ -1101,7 +1110,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 
-	ret = geni_i2c_resources_init(gi2c);
+	ret = gi2c->dev_data->resources_init(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1159,15 +1168,17 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
 
 static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	disable_irq(gi2c->irq);
 
-	ret = geni_se_resources_deactivate(&gi2c->se);
-	if (ret) {
-		enable_irq(gi2c->irq);
-		return ret;
+	if (gi2c->dev_data->power_off) {
+		ret = gi2c->dev_data->power_off(&gi2c->se);
+		if (ret) {
+			enable_irq(gi2c->irq);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1175,12 +1186,14 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
-	ret = geni_se_resources_activate(&gi2c->se);
-	if (ret)
-		return ret;
+	if (gi2c->dev_data->power_on) {
+		ret = gi2c->dev_data->power_on(&gi2c->se);
+		if (ret)
+			return ret;
+	}
 
 	enable_irq(gi2c->irq);
 
@@ -1220,11 +1233,25 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 									NULL)
 };
 
-static const struct geni_i2c_desc geni_i2c = {};
+static const struct geni_i2c_desc geni_i2c = {
+	.resources_init = geni_i2c_resources_init,
+	.set_rate = qcom_geni_i2c_conf,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
 
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
+	.resources_init = geni_i2c_resources_init,
+	.set_rate = qcom_geni_i2c_conf,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
+
+static const struct geni_i2c_desc sa8255p_geni_i2c = {
+	.resources_init = geni_se_domain_attach,
+	.set_rate = geni_se_set_perf_opp,
 };
 
 #ifdef CONFIG_ACPI
@@ -1239,6 +1266,7 @@ MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
 static const struct of_device_id geni_i2c_dt_match[] = {
 	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
 	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
+	{ .compatible = "qcom,sa8255p-geni-i2c", .data = &sa8255p_geni_i2c },
 	{}
 };
 MODULE_DEVICE_TABLE(of, geni_i2c_dt_match);

-- 
2.34.1

