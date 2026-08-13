Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310B484227;
	Thu, 13 Aug 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629708; cv=none; b=TC0ZYxBbPuY+bskbO8wgfYU49Dx72qTx5uj6j2yV4ZKUdsXbWlh8BZ4FIFypLm9SbfbmGCWQGZWu6881PTQniwf92S4RYaM7AgnKE4FfRxrGeKWFz5U8/nhlhkKunFfkpema/nktOWDsziDii0r5uGu05UaovO/O+z6vUSuoiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629708; c=relaxed/simple;
	bh=RlQi1EywRFd9RBsYMDcmocdhYQcAlNsj9CL1/FbG/Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB8reokcmeedAtBfqykVKdAztcsjfSNFjW7F8uBK+dNbzlp7o52jGPoNHWpN8LGqsHJvGz5kCLTx+p6VwAsS4J7KPfIWLd2VCy7u2HYHhoJLd+DlhtE1FOHYc/wD/BMRL18VLsT0K/nK0gzePNv83NGUJFhTkggade8b1IwyGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fv2Fah5D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fv2Fah5D"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCJqtc2359473;
	Thu, 13 Aug 2026 14:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JDLKMnRlPP8
	R1At3WLkRwACsGLw+8JGPQKVQBcrCKFk=; b=Fv2Fah5DGcOTdynu/V6fy0gfUv5
	yPGAP+i8tBp186h/Xntpw539rhx0TPlsym7hnWaou3rhV3JIk4nOEvhcPlrrkimh
	HJBDoxH+RCYinuKrL8xu2f+m4zbuzQKQsx5It0e76Lz9Ktj3c6542MQJVNk18wqa
	W5HQy2JDG5Ahyq0CAbfyRQlRGCvbtrXeKyaBSoWb0EWiVq6EDn2ID+NhdJL7ncUu
	SElF5NGsppLuTBoLf6PoVD91khuPh2eOSJiFlOhMAWZeSvH0ihMTfpfgpz27L5T9
	qYYvwhBIUSFo5kEIkZO0ZW8100ajYblXn+s2vjRhDbGX5REJR1LEeWX3b2g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1cb5gsnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DE1a7h009616;
	Thu, 13 Aug 2026 14:01:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g0bs34pvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:36 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67DE1a4u009610;
	Thu, 13 Aug 2026 14:01:36 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 67DE1ZK6009609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:36 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id D0A84220EC; Thu, 13 Aug 2026 19:31:34 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        brgl@kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v9 4/4] i2c: qcom-geni: Support multi-owner controllers in GPI mode
Date: Thu, 13 Aug 2026 19:30:43 +0530
Message-ID: <20260813140047.1006478-5-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: N21JJMbW71sJBwBxTjE7EIPVknX76gpO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX4XUX1N9FckUM
 ZizonV53vlarILvV92oMLAjvpanvJbqWxwbxXoOGJ7nm7PflWD+BC0cmdPyOeETlco4Yvhf4Z+K
 rX7rGlYCYFC2HFLDEcNffjvLGOma0Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX+blYMzrUN0W8
 0wR+CxSNZUfUbK+WAO+DdxXkK1+2VGu5K91MskZiB2Fo8Mc/Jxm+gg7Za7vEtA+ybB/Ql8ieKH6
 AIC/HYf2Yt0MixujStaDPJTZer/XM7wr2okdkBw+IqwAAuop1w1/5TbE4OieF/EPjLHem+GuqST
 LZLgiNEfmPjvfCS/AbJEDf0Dt3R+J74olGP9tAvhE79ONFNxyY4T1B20xc0qVgpVVZE3oPGOjOW
 8B+7qKg7hJfyHNKYPxjs7KE5y9kAFhD8rSrvBJceKrZglt2zVIRROk5X9S3suu/16Ks2tzAemka
 LobT/k4fNBj6lkEKJVPaMkAI/kMkITbOFZ2+Q1s5ZD2XxZaXBwcYe3pIHVQKfxsJlaL1URxAzN7
 Bo0lvqPtxBKH43s1WN1QQMqQiMQ6H12iks24iFN8HkW6WLHPw8BP3dloZyZ3Gv+u4aKMIXubZr+
 me2jj77JbLmvDfim5jg==
X-Authority-Analysis: v=2.4 cv=GoNyPE1C c=1 sm=1 tr=0 ts=6a7dce44 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=_sOibaXk7Kr7hCVwWaUA:9
X-Proofpoint-GUID: N21JJMbW71sJBwBxTjE7EIPVknX76gpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130100

Some platforms use a QUP-based I2C controller in a configuration where the
controller is shared with another system processor. In this setup the
operating system must not assume exclusive ownership of the controller or
its associated pins.

Add support for enabling multi-owner operation when DeviceTree specifies
qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
shared so the common GENI resource handling avoids selecting the "sleep"
pinctrl state, which could disrupt transfers initiated by the other
processor.

For GPI mode transfers, indicate multi-owner mode to the GPI driver by
setting the multi_owner field in the initial dmaengine_slave_config call.
The GPI driver then autonomously inserts lock and unlock TREs around the
transfer sequence without any per-message guidance from the I2C driver.
This keeps the locking mechanism as an internal GPI implementation
detail; the I2C driver does not need to track transfer boundaries or
message positions for lock/unlock purposes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..850fb0516a87 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -829,6 +829,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	peripheral.clk_div = itr->clk_div;
 	peripheral.set_config = 1;
 	peripheral.multi_msg = false;
+	peripheral.multi_owner = gi2c->se.multi_owner;
 
 	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
 				 itr->clk_div, itr->t_high_cnt,
@@ -1066,7 +1067,11 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	}
 
 	if (fifo_disable) {
-		/* FIFO is disabled, so we can only use GPI DMA */
+		/*
+		 * FIFO is disabled, so only GPI DMA can be used.
+		 * In multi-owner configurations, the SE may be shared between subsystems,
+		 * with each subsystem owning a separate GPII.
+		 */
 		gi2c->gpi_mode = true;
 		ret = setup_gpi_dma(gi2c);
 		if (ret)
@@ -1075,6 +1080,11 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		dev_dbg(gi2c->se.dev, "Using GPI DMA mode for I2C\n");
 	} else {
 		gi2c->gpi_mode = false;
+
+		if (gi2c->se.multi_owner)
+			return dev_err_probe(gi2c->se.dev, -EINVAL,
+					     "I2C sharing not supported in non-GSI mode\n");
+
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
@@ -1145,6 +1155,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
+	if (device_property_present(&pdev->dev, "qcom,qup-multi-owner")) {
+		gi2c->se.multi_owner = true;
+		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
+	}
+
 	if (has_acpi_companion(dev))
 		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
 
-- 
2.43.0

