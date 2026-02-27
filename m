Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C13E9F61
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173021; cv=none; b=S00jZnu3xXlIeH/M6tYp7wU+UfIj3s/jVEGC3uqjpZ4DkUjpNjUyjOLu7fy/Cre95X/4iFZnJfhEuuwMK0K3pBe6+HOkuC245JCixy9uLb/0HYh7ZXGsuOdJbxvkfbUXHyaZ3aIEMUdoQrX0nVyVsH35Eakniak0XmbCFXmNxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173021; c=relaxed/simple;
	bh=S/vIeyOk0etlagZVP40JWlg+UBzm8Qxfl4zTRXy27jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMAKstJoJfODfedZ9WnQ6U5H0dASgqmWDwAYEQXuzB+ZWbJcQonCPuq+sHtdGoXDZd/h2Fg1BDFU5guqHCSdlIGOWLyizxFZOl92/45q0AUayUCDh5sA10jefho1YcOKjqRWoMf3EgBxAiANLjaPbbYUPkjsQczacyF2kFcYvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eTGPIHAM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDGgjcXJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eTGPIHAM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDGgjcXJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K3jH2439977
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2FSw1TauRxw
	uUqMcF+pvf5bVYnR/BuNas3ylwyrIGN8=; b=eTGPIHAM1nW1Q81LCsO2Yu+oxT3
	Vx4z4p3vELH0YhyxmkZ1wBs9Pid54Mes1q1auovZItydqBg2JgTGLNeYHlhYvDrb
	Slbd0dBa1wE2aWnNcjWUezGBoE4oom+jIdqXhQKxV7ASwdMp+qQ4kcO0EoH+nZ9y
	V3hBnU8K5lxoLagnOYf7cYhWwVaAOg1s8whvyUntji7UBP2Z8hFipZmiqQkxr1Ke
	l8nSUYwsH9n2kBAMNHE2oMHI7K3VaOXAu0SFZHanQKiYX6ZWbqdrFOjs0L87OFiT
	rkhbIavnhoIJMvcwgXDaHxBbR1YS+Xfgi8fqcAqZAnSzpUyH90IebzpA86w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r26kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so16921525ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772173018; x=1772777818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FSw1TauRxwuUqMcF+pvf5bVYnR/BuNas3ylwyrIGN8=;
        b=HDGgjcXJfiG0IGD8fyOb7zCmpYbF+XEyKG3JFWPZaB6+V+V/lnwooUsJ4QTVMtUtmf
         jiXlGyao87IQdETb9CuXzZPFeBiuutTa4fRqpiX4NmUcb88YrWks5F3wc/oCbc1Nfl+r
         mAf/7T28GecYA+kgg/oWRMMC37Z7sLIfRUfP9bdRwsSnTKeq9FQeYTB4GKPOhPB16LEs
         c1GXZhLNIG0Kf4giK1zr3C+faY3ech0ulfU3+IXVysfHZKYU1bQUpNu34MA4tJZ1/tyJ
         pVLQrpUvLXAOjhIq+QvGGYC+ObD8tMtc18wjs6mhA1sAo0KuXB29IXjAK/0OoQcfSm2q
         V4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173018; x=1772777818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FSw1TauRxwuUqMcF+pvf5bVYnR/BuNas3ylwyrIGN8=;
        b=lIm4EE1ySljaVKdAYABqtbDOdJ4JNWvF4IsNBoKN6nJ0On7J7sFKTaKLlLJznYTmr3
         eMtw3F3UEAOuEKK8W7ohyAdDwjo6QSYfiKUZHqb8JwsVaooGFl25W3ySE4wG4+aDPNnk
         ebINouFspsmJ+/uV+0tKTITKwejjxt4SYJPgAMPazTDyzIK5i/+q5Huire4B33tRAXYJ
         yDuDdQTI6z3oPrZ5uF3bFFjHPYgYuTbvDKQW+o865SgXtGUeXoWR6Fbh/fE4M9Gq/Ob6
         0ajZCkHt5fig4FYOEenZ22RgPovFYgTTB2sAgza6dD6khgx/Z54YoDwivKrp7xdwSYLI
         +14w==
X-Forwarded-Encrypted: i=1; AJvYcCU7echDyerS1Jt9ZIDyF7civRiskFSdn+a7/7uOCKPvLjmVZaLZkRkIHoPRN22hNSfvbOWGa4lMJPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENkekt9a+AWdbDYrndAH7Z9HBjxlEVJdHZUR/XMmLZ34GjmES
	BBh3KiX8RERI4VvNyrsyMvcAbpX+XsZwFQ6jwjOWXN4rJcyc66NupdE33jErtca33PwbW6vim9C
	7TiovzbUoflGvDa9ZGMaJEKXJqarMdTHm5Yb3HYlpYWl/LRrlaSpf4ACPqpsMA2Y=
X-Gm-Gg: ATEYQzxPWxhHvdB1bDGcPQw2aUAFuMjRZ+NN9rri4lOpK46YI3ZGMkEVuZYU2Em7y80
	9aEFZHWx8tiOC2gdILBB7mL0Qprx8bHN+Ua9PiA8nyLJsl3nisCSJ6YYxXsnPNekoQMNspOyciB
	7S8kjsuPnLdPCkQhCm6MALsHK+vJVr2yHd0hYi6Yxk3FCSEthylS75K9Lhtcy4qTpsv3HAagw8c
	T6stEM+Q7DZVTdR1+vUdblUmDQ/R6LOO7fzOFkglJNzruCxTr+k7RCwDGembpF7ICT0YZxFldA0
	fWdbHGMvEG7msC3Cfe6QDuC1Ajc/+MeuHXNns73En0eJZN5Kxhk2oDJ0yM/R074Ad9tjkyAKrVS
	xtX1fPUsiBymrCGN9yV/hIhOzTMPh2fFvArUWClV61mbF1Fg9RvVELt8=
X-Received: by 2002:a17:903:41c4:b0:2aa:d34d:a805 with SMTP id d9443c01a7336-2ae2e47d9c6mr14787545ad.27.1772173017809;
        Thu, 26 Feb 2026 22:16:57 -0800 (PST)
X-Received: by 2002:a17:903:41c4:b0:2aa:d34d:a805 with SMTP id d9443c01a7336-2ae2e47d9c6mr14787115ad.27.1772173017185;
        Thu, 26 Feb 2026 22:16:57 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:56 -0800 (PST)
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
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
Subject: [PATCH v6 09/13] i2c: qcom-geni: Isolate serial engine setup
Date: Fri, 27 Feb 2026 11:45:40 +0530
Message-Id: <20260227061544.1785978-10-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX65dl8X3/5qmA
 8AbJk5/wk28EbC1cNkYVY/YxTPCMWrOCnRTQs4z1JsgrxabKCmJWbG7nvJNkREt+puvU/L6hL6M
 NqXvDevbmaoTQ4RLLigeOi38i1O3adJ6ceu8eXbMzUcflyCy42fj38pNAt/wo7RB+eLXy3FvUEJ
 DNgX9+dMdFtzLxM9ZkP5zqKX/XGgj9oW9eRs1JmV3zBDjEwrQrG0VVJrBRu9gT/IIoaMzilCca9
 Fcq4NjFwmCDtdIaunwoTy2SD8AFMtTOiNSygt/EbQ3oP1VkOkpz5Vu/S+bPX9owjqyqB5WCOzfX
 jnodxYxZryVbRAbv6qpOZcOJKPhGqgIPe5vLphGBgn4ol/4k+O5wrEuuv6XBThmRGot20G5YUwc
 oZdApgsjOyQXFqtZ2NWqURh+4M/Q2nx7EbLMwScNFhEn6sFFXOiNO4Dq5wdbeF6Ops/fp0MAwSf
 mj0N7R7U2gashQKutvA==
X-Proofpoint-GUID: S2eDI33eFGfi6La_kyi4PleKUAcj14_a
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a136da cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=6GPvvr__t7aM35KwLhsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: S2eDI33eFGfi6La_kyi4PleKUAcj14_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270050

Moving the serial engine setup to geni_i2c_init() API for a cleaner
probe function and utilizes the PM runtime API to control resources
instead of direct clock-related APIs for better resource management.

Enables reusability of the serial engine initialization like
hibernation and deep sleep features where hardware context is lost.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5:
- Added Reviewed-by tag.

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
index a4acb78fafb6..2986266695c0 100644
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

