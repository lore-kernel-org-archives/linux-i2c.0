Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193373F5BE5
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515805; cv=none; b=NOR2wg/8cb92oqjQeRdseRKDLvMx9D/wjlX/g4GUZVnunOco0GPygc9XoKUWjkdn8Q2dQ6TY+lCaGtFYWAg4zjoFm4OLZppr84UkKGJdqkIZUrzrvYe4YAemuoAndYvEGeSZPJbotajowO6COIwZvucGyrs6iaOjcgxLwmI0Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515805; c=relaxed/simple;
	bh=EcYqHQhWBLVrPH5lWQCaNhqi2mIGTjKR1YgvXUUL9OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMelcOX6io5JnbdD7fSV4RTrGZEv7fmDUsAJXOxi6wwIgCaeSY4Vn05gYmW4OusQwenBrATofM3SVk0Rpgo6YVT0lDvWYnuG4J+ldwFIfS4CnlzVEGEOjgtgSuWJRHWOH4dQVJtXN7QccqJrDQ3asBGoJCIa1EU3Q5fG70VGmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nIdIB+DF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LNzzuIKU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nIdIB+DF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNzzuIKU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R2Xcjo1643337
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NWcvuKnDqdyhAyMihoeLtDe/fuSBhNJ/UjMOuxZTSuA=; b=nIdIB+DFJw1KjqJh
	/NZdakFiNWHGpZNu469Q0R6gmJg6o0s3R01RGM+6vKn8H4b1FQ0Orv2Q6AwcNUTV
	fLRoSSYsPJfdKv10wHtge+y2bFd5w96wwHthAaTOECdzaeJ31UoEt2AHk7XuX1Em
	LgxICF4/jlA4OMgW5sTTZVPoosj6bVtOZCr94oxSc21KDVS+NwCbPTyx34qZ94mM
	XhhdTR7y0oILPhDNX4iOWR9gR5TjbXVnFD9H4WNrdgfkSYVLqiMY2iOiCxDzuygV
	n/PMdru8LRud+saEcNziIo88K96v6ycTkYuEmxb53iAUDY4FQqFbtaVdK4qqxHGk
	/YWh+w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx64uu5ts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93c6a0d2122so121793385a.3
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790515802; x=1791120602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWcvuKnDqdyhAyMihoeLtDe/fuSBhNJ/UjMOuxZTSuA=;
        b=LNzzuIKULicX+8MkPiqosgx/CAWsR6VjRa6Tn3B7ZiKNT9ojxD/ypJLDedQHSOAg/b
         XxNDn89WaPedHSwxytPS5ljb2yhRE7ulrJS4LR73E1xH9odaCXUuxHCqJiNw2UEcaRXh
         swGYhoY8Ix9TbedplAiLjtqO/3jPjS5pC5nlG/S1/e396ZSNYyql5Edttg91ZMoPAFB2
         OC0Rj43sA68fCC0mM0I7F9IpZlMYWLRARY9x7NsoXnm7BUytvDYH8PLdlNYqnOi2Mnpn
         c6LFxD2Zk7TDjGJyJ3dQnIaM7M14S4tIo+28oLsHqoHm3MMsM+s6NuUKnmiEMktNqJCV
         6x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515802; x=1791120602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWcvuKnDqdyhAyMihoeLtDe/fuSBhNJ/UjMOuxZTSuA=;
        b=iCyHJ3JBnSgAo3KrC3ZujGR9jcoQv71AiMNXZ7QYc6DLpGQIG2agdp1Qn0Bh+fDPk3
         TD4jCYppwV2KsN/UnuAvpmEWG4k+7xUktWHyrDArlSPTX5YAVEomtn7CcF1FfY57ur+/
         oA+Zg+ySTprLF3e9APhC8S89TzIs89UFQjhSGU8D/AigU9yfVJ4OXZFPjzDrP7Q9XOMA
         GdwY3I6KdSkGxpF7wageArJ4A0wqDWz9JXiKVyHCrK+5kcSEJKPjyQ/adsP9stTxR5km
         iZDIYeWhsSxrFmRTmb272nl6w1JHFb2WkqMbrJjGEVwrJ2PTVCjkes8PmPKrOa9cGlMS
         +XMA==
X-Gm-Message-State: AFuF++ljFnYsQkrbWsH5ockWuS6rQTFgDtoigvSjt/0m4t6WQUh+elrq
	63n59KqEy4ZQMzSc8XHp/Qb6ph6H/aolwFGEK9wbulFGax3cIlzwKCnXlq1Qn5Xzt76w1C4SN3C
	2DlYmGEanFnQI6f1Qqdpu2cVQKu8DZtTLzt0EG1p98JeteS4Vyf5Tnk2Jc49uJbc=
X-Gm-Gg: AYBFou03VKJzSA3RBG6kAnMcOkdWHIYfdcKvckmEW8tZykp3HQcjdF6iG0J2NsUEo5b
	q91ABrycSlP74EYH5IIMvd/TpOiet2ZSUiAPaVeaTQsnQGesmmVbK0UyGFkdeNAAVkPlYeQw//L
	pCXUZ60vvwNA/PUBOr1iu+/THT9dsoSg2NdAuKtFcPKILMhK0mVo1YHDoKtps0+IHnUKrMVJZVo
	jFBxn/S6Jx3FCjETYVe8VYJ+ozHxiZPLgcbEvNLYS0Xf3aTBBWw0G2HDTYox5jyoeRvE9ER/gE2
	DD5ypRvdFZtI/BtwzCWTzmZf8oDtr+g8iPVytNzgMcgAjOFiPUjjUwACBIbDAb2cQZcYFmz3C1g
	0dRUp6P6PUvBWi8g9McgwxKUjGq6JVo3TUeBK1vc9webzftGtpRRcBhIRlu8IPMXHLWPJAq79wH
	ZQAsz/cY1zJzLBRCs0vssFSVT3JhTOUwEg+Eo1DzqpyAkph28QQGY=
X-Received: by 2002:a05:620a:1b99:b0:93a:3d71:c9ec with SMTP id af79cd13be357-93c43b7ee3dmr1440518385a.7.1790515801339;
        Sun, 27 Sep 2026 06:30:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1b99:b0:93a:3d71:c9ec with SMTP id af79cd13be357-93c43b7ee3dmr1440513285a.7.1790515800839;
        Sun, 27 Sep 2026 06:30:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm94636745e9.15.2026.09.27.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:30:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 15:29:54 +0200
Subject: [PATCH v5 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cci-clk-fix-v5-5-4cd498559ae5@oss.qualcomm.com>
References: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
In-Reply-To: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfXzNQnzPBrXcZx
 dacP5lg8VfotfSJu+9mirocNAE6KED+sH4rM53dooWsh0qX5GyTqtJF+y9TojDN/VAuYvqGQOWn
 KE6UaQgawTYWxVd5Y8adnykF+wJ00V4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX+IbKc5SyYZ/k
 qA6H1GQ1yDFV1NFWDKxLs7FSbrBnpRKg9GSugNvSHr1w+Uo8ePF9zpiX+kECv9rhCNCHtv046pB
 MyuJMvvIh2AebpQvUUeHe2HqOiXzx1+aZL+njQOjtxSX1uIepdR1OivwFrNPduq14LFmf5fqYv4
 m7qP+n7lcymagOKXUf2YJEDaRj/Jc55qImgQR5cJZC9MDgVhBxQ6ZKvs/P0GViaAiLMy0ew4FUp
 4OUSn7ZRikJfT27+7CewqLTNxtRkmBCTAFs6jbjkuGZ3Gpuw/nEgRGk6em4a2TPpi716c0APO6k
 k+rJMPmR3dw/0VMoNjJyjBb1+794Y/3o902rJxX+Bps+elg05lX8n5WUtZ+pLHW4/1TO6i2UcV2
 AybPD6ygALsVxIg+YAT96xp5rKrXW1dA3A8Xy4qmz1JTWsywpAn504y3NhkhCyRs92hQmvzmywF
 ztAYe+VcaLPfdYwGQZg==
X-Proofpoint-ORIG-GUID: GRyveoyEN3X73AMIu2s47PSq34rAt9D1
X-Authority-Analysis: v=2.4 cv=E6xYNqdl c=1 sm=1 tr=0 ts=6ab91a5a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=vhKaAwP2Rx2hMH-_sOQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: GRyveoyEN3X73AMIu2s47PSq34rAt9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270053

The CCI hw_params timing values are only valid at the specific clock
rate they were calibrated for. A previous change made the driver select
the timing set matching the currently running clock rate, but the rate
itself was still left to the DT (assigned-clock-rates) or the bootloader,
which is fragile: if no rate is enforced the timings may not match and
violate the I2C specification.

Actively drive the CCI clock to the rate required by the configured
modes. The single CCI clock is shared by all masters, which may run in
different modes, so cci_get_required_rate() picks the lowest rate that
has a valid timing set for every active master's mode. This avoids
clocking the bus faster than necessary while still satisfying every
master (e.g. a Fast+ master forces 37.5 MHz).

Apply the rate through the OPP framework so that boards describing an
opp table also get the required power-domain/regulator votes for that rate.
Boards without an OPP table simply fall back to plain clk_set_rate()
behavior, so existing DTs keep working.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/Kconfig        |  1 +
 drivers/i2c/busses/i2c-qcom-cci.c | 76 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311ffc6cbe1ccd302a6e84dfa83bf6fe..14eb7e802bc86a06b7ec0688580886880026cb0e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1050,6 +1050,7 @@ config I2C_PXA_SLAVE
 config I2C_QCOM_CCI
 	tristate "Qualcomm Camera Control Interface"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select PM_OPP
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in camera control interface on the Qualcomm SoCs.
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 21695c744502f7fb5d333f1272f3771e4d9d5508..353d841ae02a99910eaf4a0f25ab72400fe28414 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
 #define CCI_RESET_CMD				0x004
@@ -318,7 +319,7 @@ static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
 	unsigned long rate = clk_get_rate(cci->cci_clk);
 	int ri = cci_clk_rate_idx(rate);
 
-	if (ri >= 0 && mode <= cci->data->max_mode && cci_hw_params[ri][mode].thigh)
+	if (ri >= 0 && mode <= cci->data->max_mode)
 		return &cci_hw_params[ri][mode];
 
 	return NULL;
@@ -575,6 +576,66 @@ static void cci_disable_clocks(struct cci *cci)
 	clk_bulk_disable_unprepare(cci->nclocks, cci->clocks);
 }
 
+/*
+ * The single CCI clock is shared by all masters, which may run in different
+ * modes. Pick the lowest rate that has a valid timing set for every active
+ * master's mode.
+ */
+static int cci_get_required_rate(struct cci *cci, unsigned long *rate)
+{
+	for (int ri = 0; ri < NUM_CCI_CLK_RATES; ri++) {
+		bool supported = true;
+
+		for (int i = 0; i < cci->data->num_masters; i++) {
+			int mode = cci->master[i].mode;
+
+			if (!cci->master[i].cci)
+				continue;
+
+			if (mode > cci->data->max_mode ||
+			    !cci_hw_params[ri][mode].thigh) {
+				supported = false;
+				break;
+			}
+		}
+
+		if (supported) {
+			*rate = cci_clk_rates[ri];
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int cci_set_core_rate(struct cci *cci)
+{
+	struct device *dev = cci->dev;
+	unsigned long rate;
+	int ret;
+
+	ret = cci_get_required_rate(cci, &rate);
+	if (ret) {
+		dev_err(dev, "no CCI clock rate satisfies all masters\n");
+		return ret;
+	}
+
+	ret = dev_pm_opp_set_rate(dev, rate);
+	if (ret) {
+		dev_warn(dev, "CCI clock could not be set to %lu Hz\n", rate);
+		return ret;
+	}
+
+	/*
+	 * Sanity: The hw_params timings are only valid at the exact
+	 * expected rate, verify what landed on the hardware.
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
@@ -678,6 +739,19 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
 				     "failed to get CCI clock\n");
 
+	ret = devm_pm_opp_set_clkname(dev, "cci");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");
+
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
+
+	ret = cci_set_core_rate(cci);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;

-- 
2.34.1

