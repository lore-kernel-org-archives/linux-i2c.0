Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C253ED11B
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144104; cv=none; b=iIPrjjhYiDRYnDHSqnSGjICJdDt1X/0AdHO64/34UvAnVTC6VEZmcp1+zMW1InCH+IeXs2Siwxi6LmZ9gx7uHSuOfrmdnw81BznfJdEeAim7qZpNH125gbqRIy4F44E9Wc6V+QGPtdu04stwTlgAFy449sulbDLNUCKjI9zfObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144104; c=relaxed/simple;
	bh=z6jGaYwJ3J9eBNyqXIPxvjJ9Hz1iiPpalXXFH/A5lNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRWQhfhgY20gyCiJmQqgG6v5h3L21K8zovNDfranZkb9PVbrgGC2XKTZYAFtDwwHjrL9nJRlDfM/mdF0Szwdw4YUijXwFDkDalGh/Ga5xJBuuIVB+VFqykob+A+ahEK3rdmuAmc2Dgo9vLGw1cck7ERprlaJ8x85smrBxuvhL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9dYdu7d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LpbeGMbL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9dYdu7d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpbeGMbL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R8gA943093687
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvM9jqB5GS6vXpdd1t43SldobbbMZm5V/ajVJ+C6pEs=; b=J9dYdu7dT37kpUoH
	453/Z57tx3hbotbRHRCGRLf1/bAT3Kx6N7G2EiJj/TFuxo9XjphIyVN7Exrr8Kmj
	DQF6GL30n3P1dZyn7ZLQ7lXz8qeyOb1OjLyGu3CASCxE19bxFlw3NvMH7n2tH/Q4
	QpsH2iTh5fZFUroIyIvD8AhKZkT/1c9uNN4ClmKsSNLSDucLtD9XSLh0qm170hLb
	r4+tMZsrxfgnSrq1x9rCr6gwYbFcXCun2RWQRK1RDqXKBF/R/tB6+qEsRenZ9KHj
	JqxbIQHMs8eVUMTF8jbUXyNoJMm0GK62HbX+N5DG73ztCKI5032hDGBZHCC6Lm0c
	OQo3YQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2g6t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so31736361cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785144100; x=1785748900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvM9jqB5GS6vXpdd1t43SldobbbMZm5V/ajVJ+C6pEs=;
        b=LpbeGMbL/voRN7CnbL5NnO2kyieoHuLKb15K4H/aDFWT+t5fBPxomWxeZGooytFaft
         SgZvXcPmFJAS8KoM3JNgQdbWBTwZsfs1A9gNWNFd3tYv/WyilqHRraMwv7KrhU7akudr
         virhs6iyEjtulfIkVT1+IZN2tcrmfUN4+e3EEvm9JiDvm0eE0peA7lPzP+9+4TS9hR1y
         DlHZ6hPNUgeRrY/3k3VqkttGhrFV8BNS17QFxGHs7vLiV3kkzJ7jgUojDtlxtBGk3jox
         3M4gNUXY7C+8y3HTV1r7vVbdZVVwSMP9pdsPIO0q4XCZZj1c1iF27tpbMYZcTe272DiV
         Eg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144100; x=1785748900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvM9jqB5GS6vXpdd1t43SldobbbMZm5V/ajVJ+C6pEs=;
        b=nfLukh32lAJ2pK97gKHx4X8FkFbYCb4+8xUmDsDvj0O1Zak912ZUBmEhrrnnFoMXh2
         w0H3ZrqvjZC9OS9Te2dDlxdqx2ldmFQLduP5G+QlOSEmkScsAN885h+e6GjuaTK+ZY/y
         CTdzzmocFE4PgAfGButY+U19r046LiNujtL64iTA8mu0qWABM4fRyp1X1oY58hZB4cyI
         bftEOG8UWSgd/ZOwJsoOdoCZJFxhTuQyNbKMuExwMRUW9DUjlT5+Yw/IAaGktm4gcpNa
         h5Q8u+B5EASG5jIiKI1j4tUAwJggN/m9oN2NFczqxr2BieUCm1lRZDLJspTmA3PMsPC+
         XKuQ==
X-Gm-Message-State: AOJu0YyDl4cakreqirAKMWzgW9btROcZRCOBVFeXRj6AhfaXh9IvHZsy
	BLAQAKUj4VwXZZBZZ+O5JKLWITxiwM35hGfNo+F4a5y1myLfGg8l46yyabF6z9d8HhujUL+X09C
	TRpW2Vgcip2li9moW2ryGRQumO/kFKjVpyFtZtCcozvtf/EH7dM8cmITYzWshwKM=
X-Gm-Gg: AR+sD12Eqcu17rWTLWTH4/dCkLLPzq12oxeo59UT36y2IdQGElZJ2p2oNiaAdTHAzq+
	cpz1fwuMjVjutTYErw08WGyhvOOaOc8sTvM2/o5o1S8E3vEVzE9TZ+QZVjy82vqjrbjaVI7qsAM
	JK90E9RIUxBogTVqXeSpth3aM5QuhvzQAv3AjOJA/f1khG7iWF9DSXHMRDKaUGqJ3giq8R87KS0
	eE2OibAXUt+qPbN8yTkIvNpTloxPgiXIZtru35/c/G/2iFwpZaPjCs7jSS+2LNZR7e9cIYh8WZ/
	Pt7+aaEf3wxM1e8+FlP+4D2k2JZ8unOdHsCLr/xIceKY4j5+zDo1PEpzuJsS5uSGYyVJcW8yKni
	NP1JHfSEqISD0f/fW4cGBzDjtS4TeMDDEfZPhGsK8Do6WS2mn9jxbo28JMT0QgDwwP2RSp7zPVV
	RU/9UeG9YpdvsVHJ5jAf8KZSxAreItkmUBxV8jvbDXScYdQvSdWBSO
X-Received: by 2002:a05:622a:144b:b0:526:d946:fc15 with SMTP id d75a77b69052e-529cce5f011mr481161cf.66.1785144100260;
        Mon, 27 Jul 2026 02:21:40 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:526:d946:fc15 with SMTP id d75a77b69052e-529cce5f011mr480911cf.66.1785144099861;
        Mon, 27 Jul 2026 02:21:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9babsm2265326a12.12.2026.07.27.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:21:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 11:21:34 +0200
Subject: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
In-Reply-To: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX5pCO9VW7f1/5
 PyKlFjw7lYSaF1KW+KnwfLHcSrnpKoJEwD7DeBzZJIDeFesR3AUFTNWUd5VnzU5aRi2AI0AgyNI
 Jqq8pqY7ur9+gk/peBcoHCHScdoky2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX7FxIb5tsqjeq
 ARLf7/9Cvqk0wRb2VuXjgNhZ5tepKoaGsp7EKz7yavGeyAUtBSLGz1I5fJiEFdFOAPnRqPJaeCl
 I8rmMLvvpaaD6ob03740uIA6OmP7NNvEcFsW3FxdDZQkVUpe768HuIEtbPggU4nXhnifUU9od+W
 f9d9PhJjSuarw6D5uBS0+JC3ztTEIGeqJCDzmsZu4t/ZvPdpVLd6mMrR/9izfZ+mU0weujKVjFo
 smR0G5SiDgT33wd3AAhsklYJpKKGwTFouQDr7ww1I1tKFVJhlwkFTvoQ/px2N9ooJmU4mCy40m0
 hb+VQ8rnV/liFeS7Ovxs4lZi2IKDgmTjjOihbFMUdHv8mIlv3aSAqb3WQxarqdmRZ7nEulScFfA
 vZ9XFmg+OuY4QeHcU3G+kpoG3MTl2WYMDNwKJT7LEUIpoSIj5QiNFsl70k0S+D8+VDEpGc1q+wE
 RbaDMEQf2cn4HYp/PdA==
X-Proofpoint-GUID: gXmP36pK8VJqMc0ZBI9flzQkJFlXcwaf
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a672324 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=XlnqjZJP-Q2boqhwfUgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gXmP36pK8VJqMc0ZBI9flzQkJFlXcwaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270092

The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
and were calibrated for a specific clock rate per hardware variant. If
the clock is running at a different rate the I2C timings will be wrong,
potentially violating the I2C specification.

Rather than just warning about a mismatch like before, actively set
the clock to the expected rate, using the OPP framework so that boards
which (will) describe an opp table also get the required power-domain and
regulator votes for that rate. The OPP table is optional, boards without
one simply fall back to a plain clk_set_rate() behavior, so existing DTs
keep working.

Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 2ed58b2a2f31c62ee1c972a53b71f86787144b84..87d64e308a8152b99ff4cfb4255e24edfb751e75 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
 #define CCI_RESET_CMD				0x004
@@ -128,6 +129,7 @@ struct cci {
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
+	struct clk *cci_clk;
 	struct cci_master master[NUM_MASTERS];
 };
 
@@ -472,10 +474,35 @@ static void cci_disable_clocks(struct cci *cci)
 	clk_bulk_disable_unprepare(cci->nclocks, cci->clocks);
 }
 
+static int cci_set_core_rate(struct cci *cci, unsigned long rate)
+{
+	struct device *dev = cci->dev;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(dev, rate);
+	if (ret) {
+		dev_warn(dev, "CCI clock could not be set to %lu Hz\n", rate);
+		return ret;
+	}
+
+	if (!rate)
+		return 0;
+
+	/*
+	 * The hw_params timings are only valid at the expected rate,
+	 * so verify what actually landed on the hardware.
+	 */
+	if (clk_get_rate(cci->cci_clk) != rate)
+		dev_warn(dev, "CCI clock is not at expected %lu Hz\n", rate);
+
+	return 0;
+}
+
 static int __maybe_unused cci_suspend_runtime(struct device *dev)
 {
 	struct cci *cci = dev_get_drvdata(dev);
 
+	cci_set_core_rate(cci, 0);
 	cci_disable_clocks(cci);
 	return 0;
 }
@@ -485,6 +512,10 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	struct cci *cci = dev_get_drvdata(dev);
 	int ret;
 
+	ret = cci_set_core_rate(cci, cci->data->cci_clk_rate);
+	if (ret)
+		return ret;
+
 	ret = cci_enable_clocks(cci);
 	if (ret)
 		return ret;
@@ -587,6 +618,24 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
+	cci->cci_clk = devm_clk_get(dev, "cci");
+	if (IS_ERR(cci->cci_clk))
+		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
+				     "failed to get CCI clock\n");
+
+	ret = devm_pm_opp_set_clkname(dev, "cci");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");
+
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
+
+	ret = cci_set_core_rate(cci, cci->data->cci_clk_rate);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;

-- 
2.34.1

