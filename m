Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF743CD8D4
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615067; cv=none; b=iLDwfs5odrj2tvWLTaeEw+WF9Vy34TL3zKmKtxDkFvEsIDstjMaGwq/eL7/dRVg0QNCxbTFN16HdXE5/aOuomZC37+1iCIL+NXX7jZteTVEdkMnBaA5wTYJdQ53+AMiGdD/zcHehYwtxPUicju+9EP6JCeEu2x+splf4UgZEXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615067; c=relaxed/simple;
	bh=74m7wkLHW21LfcOgB4KjSGixQGbfkbQUoRTyNxWozRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FE5Br1Dhb8LPyw1Tje2WsgxfmZI9aGfynq17Q0NS+S8HOOH/PqazXB58R4aIi5uY0JCwyBfvh/XHFI0C7QVASMSRSXPsXdSyqVQQOi9dRdiMYynoRz2cptV5Rbxn2R5+eZvuivAZ7qASZVx3K2uO3mGWOCijSVB2CPG1uZhgbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guKxe5yN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isRiFVYj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guKxe5yN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isRiFVYj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671IxYjA713570
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zqxf4qZpAOcD3l4fL9Yp8vqCfTxgDyeKBJZ2NbWHMZQ=; b=guKxe5yNSg78h21Z
	Apf1xGIPjiUUGDF370BCQNezt6yr79OW/JoqwfJQ2YZx9BzX49Vb+Inho0VsyDbu
	ia4e08J9KAfPFI26aeyXT4u7cGHF1HPwsNcfGu+28aMjqIA+NEF+T3FV6gQ0FDY+
	Fv8v7fHHV4OKcDp2kl/Vt8+0wysORA4/h+BNrHC3mI5pltVyl0CSXtFkh38nHaUF
	WezV7kAC51/GW6bxH0BlJY/WBV/ruaMF+oeLkCO2qtom8y4xu6UXxZny4lln3JGY
	R4jq0sdl278gXjGtopdJdiDYkYM2QqEpDXE1X6NcbRP7+opz7hQBAyf0QySmtOj0
	tcr1Rg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8pg1k2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:11:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-529ae8e96e8so20174781cf.3
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615064; x=1786219864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqxf4qZpAOcD3l4fL9Yp8vqCfTxgDyeKBJZ2NbWHMZQ=;
        b=isRiFVYjYiNDrPV65txnSxnR1NPtq4f/N+sNahs2YWglZJGGftdfd1jaYHxX2EhWOP
         xz3xWF7+W/9yZu9qDOm03Y4q6n8CFMLQNKO9fanZ5tKUNS9w+2EanKLktSYAi9XlGrfx
         sfG0BC6+eb97/TOX8aqvfmnPiLscKZQVJ19GAhY7osSN/cXBKKFgU+YbH5v/uKsU6D5c
         qQxymSMdzXs6DrqnkiU2eVuweGwoFwRKM1iSuTxlmExb44P7EMMOvkuM7sKunh3u20fl
         8DcVMTRqTxYKzfmdrnhUxfIiVLdcTnA97nS+0JmsQ30rbcQsUi9NPMd+yuQpfh9xwyXa
         N6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615064; x=1786219864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqxf4qZpAOcD3l4fL9Yp8vqCfTxgDyeKBJZ2NbWHMZQ=;
        b=SJFb+Pfg+r2VL2orrDaxarOI+2obWc521nz8+US5jYfCjchER3k/OxeW9ScWpUWvnv
         T53vHONfCBsTNo6xnvO3GHHxJFqietdbOKvsl3lXnPUtedDG1SNlQDs3i6Tr3njlw5fm
         0iGVfPtg0DnfyP0hk8ZvE0PSwnbtmjNQ2XN3tamZLxig5EmLxU8831jkIlAZH5ANMf/K
         fb6A8IjDRHsYjzJWi+j0bpUOB8Qu4kYwyZXn46RIYT5G+Q2J958if/V+vYo/ziOhHYJA
         bD6dp7AA8bnDQqJEw92+cN8OwOtywDPZ9vaWc3rFmFesObHgi1FwC3XT26BhiIvwRQ7i
         BQHA==
X-Gm-Message-State: AOJu0YwiVylxIv1qfjfekggEbahM1QIZhlz8gQNv7Nb+BH80PfgdXVZf
	N5S11lvLEC6U29x1a8GYzkNFLt3LjEfAeY4jXZBRvQFjgchgSa9X3AjONLDn3DAFTHjoDIlTwtG
	oKnXQ18pn8r1FZ2eL9dqrtrgzNJRmuxIMyM3QIFKkvJeqxrJJ23kR1ooNuf0H5zY=
X-Gm-Gg: AR+sD11JYMJGT3DQe6TiKDjmpUwXHoVUOLArC5ulPb2M9EpOb5ej41lrZr8eqAau0FW
	QIoU4mrGO9uxkNS5Li/irD3tEfleTFHuIgMSQDY20iRIgUlMZk7OdwpIkqD6jZVOKvlQUAxv4SI
	AEUE8N1ALpu5jbKHek8Ylp6ESXauZE6ExS0UyAebp5B5xBaSPDvVuPAHoHr+CnvcQ6JVVRcrUdh
	BqXEckyA3k7wZTGWDZFDwLXsHsG95UB5oA2HOdpK4T7VhruXemRg/rVNsZ6YZc4f/6QJpTsWhsg
	Uz0HYAfsNkPgcXR6e7f2HPKNDHktGZmRPUEnODCmN6dO8gn9uXu0JUCPNyOQ/pk77tvr9RYJWGZ
	YUEORWeaLuOIkkbGwPo3tDtY0WoNihKMelSp0fPhcQ7ILBltYhglqyn99VYpyeL6w/pe0A4P18M
	jgUvA3hRY/Owr86j3ODKgxZnOwiEQkhUcp0vQ5DVOpyynpLPFIgFNK
X-Received: by 2002:a05:622a:98c:b0:528:15e:d1d5 with SMTP id d75a77b69052e-52b566f6f59mr98941511cf.2.1785615063623;
        Sat, 01 Aug 2026 13:11:03 -0700 (PDT)
X-Received: by 2002:a05:622a:98c:b0:528:15e:d1d5 with SMTP id d75a77b69052e-52b566f6f59mr98940731cf.2.1785615063147;
        Sat, 01 Aug 2026 13:11:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:11:01 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 22:10:47 +0200
Subject: [PATCH v4 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-cci-clk-fix-v4-5-e1d80da54e01@oss.qualcomm.com>
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 2ffRxJG13rsYFCvpEWQDnlWeEYcJpo2x
X-Proofpoint-ORIG-GUID: 2ffRxJG13rsYFCvpEWQDnlWeEYcJpo2x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MyBTYWx0ZWRfX4xGoqCUiVswp
 o89gbYcO8AuX45A6CPRS6PoCl78Je35KYboynsr/OPZxff+QiEPB6TZB1Frd0pUq4u88N24alF7
 ZGu2lcyY0wglD7uQwZ+vrbnpJJCnySE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MyBTYWx0ZWRfX6hDQlByzYE64
 z8wbMfTCnDDtOpHWj+P1w1HJrwlrdFGOjzNuB9UTPpczKLHNe2NClPdLaeuCXS3Ru7+o1R/66ba
 x06XTXwsNLlguDcxkNLadMw+hlX7Ix4VunZr1zRSpKkfCb3OKQWbPfiv7T08Rk8SzvGOIv1E8gL
 uOk4GRqwQ1gZ+iKlUAFDLCr5keWbPwtbkU5CBJGAb5pSZs7CKhNGzBwviszdPlKN0GLkKy+t+12
 wxalojhu3QTob8QjXf0LX/FL1oMd+6DIceBBOWBigd2u1FZLXMivNrO2JFm419uX0glKdGtSWRm
 SFqLehXyxXEe5152q13j4XcUB+vaqnLnQpTovTFohF+cQ9k4YZnlNRrQ3yKLQ5esijCdWP1aqyt
 3tnltHoImObOEyEyVlT1VJCbuL6ocIDt7+gyqu6QS17zXCBH+lZZOxxswYYeYociVhRblStg2XG
 qMUJsTqONZnwy2BhftA==
X-Authority-Analysis: v=2.4 cv=U4Oiy+ru c=1 sm=1 tr=0 ts=6a6e52d8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=vhKaAwP2Rx2hMH-_sOQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010163

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
Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/Kconfig        |  1 +
 drivers/i2c/busses/i2c-qcom-cci.c | 75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
index 21695c744502f7fb5d333f1272f3771e4d9d5508..0a4418401737809a628fec37c46b2beb1446b31f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
 #define CCI_RESET_CMD				0x004
@@ -575,10 +576,67 @@ static void cci_disable_clocks(struct cci *cci)
 	clk_bulk_disable_unprepare(cci->nclocks, cci->clocks);
 }
 
+/*
+ * The single CCI clock is shared by all masters, which may run in different
+ * modes. Pick the lowest rate that has a valid timing set for every active
+ * master's mode.
+ */
+static unsigned long cci_get_required_rate(struct cci *cci)
+{
+	int ri, i;
+
+	for (ri = 0; ri < NUM_CCI_CLK_RATES; ri++) {
+		bool supported = true;
+
+		for (i = 0; i < cci->data->num_masters; i++) {
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
+		if (supported)
+			return cci_clk_rates[ri];
+	}
+
+	return 0;
+}
+
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
 
+	cci_set_core_rate(cci, 0);
 	cci_disable_clocks(cci);
 	return 0;
 }
@@ -588,6 +646,10 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	struct cci *cci = dev_get_drvdata(dev);
 	int ret;
 
+	ret = cci_set_core_rate(cci, cci_get_required_rate(cci));
+	if (ret)
+		return ret;
+
 	ret = cci_enable_clocks(cci);
 	if (ret)
 		return ret;
@@ -678,6 +740,19 @@ static int cci_probe(struct platform_device *pdev)
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
+	ret = cci_set_core_rate(cci, cci_get_required_rate(cci));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;

-- 
2.34.1

