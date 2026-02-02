Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC238BF87
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055847; cv=none; b=cmJh7qO5nSBL3tmhL7mQSD4vvXstKEs7Nu2w0k53AWqupCms8lwtNksNV5oRbsRUKKy3U63Vepm/jqH2XS0N/zAvDRibKJiU7UdaL0rewIFyyIsjnSWcfF+NizF+UwKL4/u+qjLLgdRTcDXLL1PCoe8VGXNE1bL/dF3hyTY9/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055847; c=relaxed/simple;
	bh=L5bLTQa7zwHJTh1VWiuGpTOvZWKavJhytKPxRE0/sfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBEkEXw9iAQi5KbEdsy5UpKSNL/Nd+sCynDO40jSqQ/7qs0hejJ6VwB0ZRWKA5UiR4ErzKJdZgNP6jKgbk2s4cdutMtuVYOnLKV7wo11iGgSIxTGXvKMiIY7LHDwVrkeqGpMG7rObU/XxVlBVNqSSGAFGX2GtJE29OihdfeQHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPjz6/ly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dkh1hJLB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPjz6/ly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkh1hJLB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AvoZT2261760
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qfXRkiX70F7
	J+5IZZ9fYqWyzFFOmyuc1s3yJyTWwBI0=; b=cPjz6/lyQo6XcVKdg5PQSNYDnW6
	naUaoWe4uMaUVLntsOzP4kW0XEzWdqJWbLNibqecm4dAAJelUV2+3UGhobHrph4s
	UR3PiPG43r7QNh1H0K5Auk6qW3sgpUJJsV66pvkxQFeXue+azRmqGv6AldMuW7GO
	7+jd+2I4uP/nXaclc1iXLwUX7F5qDWRm12wFD4grt5fqgiV84uq8v6dUIxmgEVgm
	Evdzn2p3XAv7QasLmo+aqbdFNVZn4RAAnbT/QXLLOPx//MjWNY4JalA8bOppjmmg
	MyANJ/tvKVCsbR4VH8OjevNpfCIypysWD/2S/yhzONaU4p2cELNoYO+zafA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tmth9dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:10:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f8c209cfbso2579456b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055844; x=1770660644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfXRkiX70F7J+5IZZ9fYqWyzFFOmyuc1s3yJyTWwBI0=;
        b=dkh1hJLBVno0YTtYtmWv40Fgz7vrsPwKJhb2GNpvw+aZMgdXajYmN00M+2NZSiSLlX
         l3vqMQlPkv9fUXqPhDRQDfWjRww8VfzMglbIxO0GuhQdtDRHw4Mj2EDbV/gWWy8QdX18
         uKTFYqVo7VjD8kmgLlhCPjV5XLuV4/U66uGigrd0gx+LVEFdInWefPHyWQMbw/OCbvxq
         OFeVgC4Rv7EwRO+SYbCLgMJX6C9UDHyWYNiFambw4uTtA8OocVFc+X5PvPmvw9qtBDoG
         H1JzMTZz+dqAJ+DpGQ36hLfZ0buV5Y2dfk+NQED6U3z1E5RufvNODlV0dI/eBNBM8Ead
         CUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055844; x=1770660644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfXRkiX70F7J+5IZZ9fYqWyzFFOmyuc1s3yJyTWwBI0=;
        b=Dl+UIxqGHgp8bkOBVze+9lk5UXYydEi6KLl+ib7O8bxvzTHx5rHqkfJTQt1+Xcf7Cz
         wzGphj+wrMvkQsXTkQQWzB+EMMqFvA36yqU7T1L3Z0GRi1GwpQ/plgJnhcSWfuZao2HT
         OBfyjPMotl6Ieje+PfDZ8eFrbh9IbvtdiH4OutjFoWTU0lhA9sf9kYhxsNKBejgRQEuy
         JCM2wyqL01nemNe4orGHkbRjclX53I2rj5QrgjDaYa081HFYILyymDPVlKRR9copH17u
         GqLpEH6vVpzF6zBzD5SV/YQZ9GtSHzFRIhtDhL04Ln/4+nDE+flxGOfpNA/D5w6+g7ty
         VDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTP8/IHzfKxXuAROKhsH86qlhJDXHGmqVKsoifStTMM+UgnD9GWGuPyJNMaZL+L0o6rob2qlh2QAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOcBUqIQVACit5HDO4ezE9sXJdpd+RnmdlQ0I1JIo7GcLw1X2
	4/epoFkUx2CPQHYzCN2zM+ZbzG9a02wFpIyOlIZ3byX+74AZOoz7SFd0P8l6RwVsW8/G2J4EVFq
	GQHEvtpFgLkUAzsak+Ac4dc0v8Xvt/6jpQi2b1kW2tRmboIb48lyjl8w7ejt6IFc=
X-Gm-Gg: AZuq6aKCunhKVXF4nDI39F0kGO8jbRoueQhcp1WnBaPedCP9pxZx6c0rYN+wlJj0AFU
	LQx+4ajjEhh3WO7R0v/MoyKfyp5Voz+3QhrQqMQq0Y1sHhmbPkAOJiYdOHwSXzhJf+gFOr3Gngu
	e5d22U4Ng/anx3HJoWNRxAj7Wq5TI2DUzDleNhzMvhMqPIqBBRMSqD3lJkbR/uYk8VvhvaXc5lW
	d7iv/i7qGnjpY7Pa4DI8GTFae/q+fd0gELKRs29lp06S2A0kgAqCs8b60ym+jedfeQA4TOORIeu
	ep/HUZxIPmKQThSWh8ZQWN5YHeAA/dbYOft3a1+6T/EVX3YM1Inf5vaYw5FEyy8fcQdvAm68Z++
	d425OK56mMSt7LbDhrRxON6voEBM95fSrLq0ni03ixK4=
X-Received: by 2002:a05:6a00:12d4:b0:823:16e2:66db with SMTP id d2e1a72fcca58-823ab425e00mr13012389b3a.0.1770055843857;
        Mon, 02 Feb 2026 10:10:43 -0800 (PST)
X-Received: by 2002:a05:6a00:12d4:b0:823:16e2:66db with SMTP id d2e1a72fcca58-823ab425e00mr13012330b3a.0.1770055843031;
        Mon, 02 Feb 2026 10:10:43 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:10:42 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
Subject: [PATCH v4 09/13] i2c: qcom-geni: Isolate serial engine setup
Date: Mon,  2 Feb 2026 23:39:18 +0530
Message-Id: <20260202180922.1692428-10-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xb6EDY55 c=1 sm=1 tr=0 ts=6980e8a4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6GPvvr__t7aM35KwLhsA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Ziwy1BkaV-MUqSH4AKNyVeoRzoPyyroV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX8TDwbDuqsdXL
 391Gi6HR9AALqpu7lfKDjjfp5zk8NwI2NLnUOC012dhdcZgv+QO5WJOY8eeJChTO4vct3qYU/BQ
 OJ6P0whgadcpD6ge3Uhzgz79Tk0sIw7d5WwD6BNEfttgPjrbFh88sEyF236yw2BEp3EulcnQSiu
 0/bSoMJ/kCcH7mi6s2yUnRxGGZLro1ivFtiFVKuCAcrt2Fgm4GDQhGFANFTKuGoWZGkwqtFoWDL
 zkn3alj4K5Jy3Ro+mc3QbnS95xBX3ND1GnDRPaanv/26DqWXr+ja/jRG71nVDhinWTWVq9PCxER
 h4oo4JRDTvJL3bp/nTRGEuO3KQCnmHF4hH9spzDzZ4A24i2yUZtcBh4SGWXIRWDrPmpm/8eO61L
 6MJt5yBn6w6JygupLGiXPrIQ3RNq9rmMUui9cbT6OqXyrEfmiGRhoh8kZzAVrpL7dxfdnIO/Shy
 +n0qNZVa4jCNNk8nrvA==
X-Proofpoint-GUID: Ziwy1BkaV-MUqSH4AKNyVeoRzoPyyroV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

Moving the serial engine setup to geni_i2c_init() API for a cleaner
probe function and utilizes the PM runtime API to control resources
instead of direct clock-related APIs for better resource management.

Enables reusability of the serial engine initialization like
hibernation and deep sleep features where hardware context is lost.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v3->v4:
viken:
- Added Acked-by tag
- Removed extra space before invoke of geni_i2c_init().

v1->v2:
Bjorn:
- Updated commit text.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 158 ++++++++++++++---------------
 1 file changed, 75 insertions(+), 83 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ae609bdd2ec4..81ed1596ac9f 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -977,10 +977,77 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
+static int geni_i2c_init(struct geni_i2c_dev *gi2c)
+{
+	const struct geni_i2c_desc *desc = NULL;
+	u32 proto, tx_depth;
+	bool fifo_disable;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(gi2c->se.dev);
+	if (ret < 0) {
+		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
+		return ret;
+	}
+
+	proto = geni_se_read_proto(&gi2c->se);
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
+		if (ret) {
+			dev_err_probe(gi2c->se.dev, ret, "i2c firmware load failed ret: %d\n", ret);
+			goto err;
+		}
+	} else if (proto != GENI_SE_I2C) {
+		ret = dev_err_probe(gi2c->se.dev, -ENXIO, "Invalid proto %d\n", proto);
+		goto err;
+	}
+
+	desc = device_get_match_data(gi2c->se.dev);
+	if (desc && desc->no_dma_support) {
+		fifo_disable = false;
+		gi2c->no_dma = true;
+	} else {
+		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+	}
+
+	if (fifo_disable) {
+		/* FIFO is disabled, so we can only use GPI DMA */
+		gi2c->gpi_mode = true;
+		ret = setup_gpi_dma(gi2c);
+		if (ret)
+			goto err;
+
+		dev_dbg(gi2c->se.dev, "Using GPI DMA mode for I2C\n");
+	} else {
+		gi2c->gpi_mode = false;
+		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
+
+		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
+		if (!tx_depth && desc)
+			tx_depth = desc->tx_fifo_depth;
+
+		if (!tx_depth) {
+			ret = dev_err_probe(gi2c->se.dev, -EINVAL,
+					    "Invalid TX FIFO depth\n");
+			goto err;
+		}
+
+		gi2c->tx_wm = tx_depth - 1;
+		geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
+		geni_se_config_packing(&gi2c->se, BITS_PER_BYTE,
+				       PACKING_BYTES_PW, true, true, true);
+
+		dev_dbg(gi2c->se.dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
+	}
+
+err:
+	pm_runtime_put(gi2c->se.dev);
+	return ret;
+}
+
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
-	u32 proto, tx_depth, fifo_disable;
 	int ret;
 	struct device *dev = &pdev->dev;
 	const struct geni_i2c_desc *desc = NULL;
@@ -1060,102 +1127,27 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(gi2c->core_clk);
-	if (ret)
-		return ret;
-
-	ret = geni_se_resources_on(&gi2c->se);
-	if (ret) {
-		dev_err_probe(dev, ret, "Error turning on resources\n");
-		goto err_clk;
-	}
-	proto = geni_se_read_proto(&gi2c->se);
-	if (proto == GENI_SE_INVALID_PROTO) {
-		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
-		if (ret) {
-			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
-			goto err_resources;
-		}
-	} else if (proto != GENI_SE_I2C) {
-		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
-		goto err_resources;
-	}
-
-	if (desc && desc->no_dma_support) {
-		fifo_disable = false;
-		gi2c->no_dma = true;
-	} else {
-		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
-	}
-
-	if (fifo_disable) {
-		/* FIFO is disabled, so we can only use GPI DMA */
-		gi2c->gpi_mode = true;
-		ret = setup_gpi_dma(gi2c);
-		if (ret)
-			goto err_resources;
-
-		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
-	} else {
-		gi2c->gpi_mode = false;
-		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
-
-		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
-		if (!tx_depth && desc)
-			tx_depth = desc->tx_fifo_depth;
-
-		if (!tx_depth) {
-			ret = dev_err_probe(dev, -EINVAL,
-					    "Invalid TX FIFO depth\n");
-			goto err_resources;
-		}
-
-		gi2c->tx_wm = tx_depth - 1;
-		geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
-		geni_se_config_packing(&gi2c->se, BITS_PER_BYTE,
-				       PACKING_BYTES_PW, true, true, true);
-
-		dev_dbg(dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
-	}
-
-	clk_disable_unprepare(gi2c->core_clk);
-	ret = geni_se_resources_off(&gi2c->se);
-	if (ret) {
-		dev_err_probe(dev, ret, "Error turning off resources\n");
-		goto err_dma;
-	}
-
-	ret = geni_icc_disable(&gi2c->se);
-	if (ret)
-		goto err_dma;
-
 	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
 	pm_runtime_enable(gi2c->se.dev);
 
+	ret = geni_i2c_init(gi2c);
+	if (ret < 0) {
+		pm_runtime_disable(gi2c->se.dev);
+		return ret;
+	}
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret) {
 		dev_err_probe(dev, ret, "Error adding i2c adapter\n");
 		pm_runtime_disable(gi2c->se.dev);
-		goto err_dma;
+		return ret;
 	}
 
 	dev_dbg(dev, "Geni-I2C adaptor successfully added\n");
 
-	return ret;
-
-err_resources:
-	geni_se_resources_off(&gi2c->se);
-err_clk:
-	clk_disable_unprepare(gi2c->core_clk);
-
-	return ret;
-
-err_dma:
-	release_gpi_dma(gi2c);
-
 	return ret;
 }
 
-- 
2.34.1

