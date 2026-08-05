Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAE472F95
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937985; cv=none; b=hMBx4tjkwzLP4H0/uEudeVkTCbj6FLrR4hbh3+kJ/yzgMMPVdCmenhKZLEhUHSrKy2mVS32wT06T0EvZ/VahOAOTSNpPgCpRsJIH7P0FOzeUfccSTJBoOjdwAF/VaMSt8iEozcu0ewXUSxGAYiLKkbYAY06gIsCmRb5IPbukbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937985; c=relaxed/simple;
	bh=IU2FxDbVpzPCuR4skclReRjkiNxGfVidNVcC+7xKNfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qwK2pY0OeMXkZ9H+HbAJVEK/3GriC8hPdJbxQDEnDGVa1RsKjTxksdKqq4dquZ+jREi+jz4TAuzOdY+zEI70l75LVDPzVxGwOyUjXFcJbIpurQEbcXRON6jePAqAGg8z3ca1VxoXwSxnQoeiqYvRGfPC59M5OIEEaoUkvZgulOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Phra8zm6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HnW+5uC2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Phra8zm6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HnW+5uC2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675BvX0c3998265
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 13:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NP32AYQSHmO+6xgXTmdEjr
	L55vQh0b/6Xjmlx1f++L8=; b=Phra8zm6tPbCBk5x/bOy2O6PLAvMmpNWxLwGfc
	P5SzA0kxRpyE88EfHq6gI19N7SGuXpeEOzeGZCUFNYLFaFpB3iSLzzpYsReOrNdn
	Se+756U6I15PewihFHw7fGlzz4TpSrg2yL4w1ENmMAmEh5S+Y7SbkUz4OLkCGZjW
	sgDJOTvdYbGeWbk0nlyy6zG384HSDwA/lArY/AyH7Tmg6UuFYy/+ijYv0XTcpWEQ
	vEpQn+BUSNMNG643V+CwCKL1nBZWSqrWnKckcVOm8MfaFNxDpVssihylRXsBM6uF
	61bsW2XGN/5b0wgc/u+GJyR4f5VWAtHsbnUnv3VnmdjPGeFA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3uk1kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 13:53:01 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81eddfe28b4so27063757b3.3
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785937980; x=1786542780; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NP32AYQSHmO+6xgXTmdEjrL55vQh0b/6Xjmlx1f++L8=;
        b=HnW+5uC2OouK+MAv+ifhbFlduuN0LvjFMBS6lcI5i2SyV0gUbYa8yvPVCpTSn283SN
         Vm9Fxjv2lPw3VhmX6la+p3Z+BahLXmU3i2Gaq87AN4715b650CYpB1bXmtxz0WnAuy36
         eDRAADY3Jxs0ZZVg3J4iajMJ0ogref/gTf56pVsDcGfkgjFAeXiMyWlQGIk1wTj7dnyf
         0mVQwJq6pmTinr55oEuDyMrXlzNxCorReApC/XC5LR9XQWYSvptMNYtaaNiBgNB7AcBO
         5W3ivC52kBQxkzs5q00CiMw+bntO+/bYGlBcWf2UQ5JscFkK2+OSM72qOP9WxxSSpVnA
         civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937980; x=1786542780;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NP32AYQSHmO+6xgXTmdEjrL55vQh0b/6Xjmlx1f++L8=;
        b=AohQcfNJRO+dbG0OTA5whYXBbrGvN+j4f0tjLD5gsLH68nQWf4tIJyAO7FF/L28s1e
         flh7HiqCn3FC6XPmvNrfCHFIQPdQkt257sJu2Xb9q5VK2f5YxQqfFwEp5W0u2pqh4B7c
         4cg3BbZ1T9KUegJiF8yDcBqqCDpwmJilDJK8sr1y2kjtF+ij5nl+hg6adYqE+dTH4TkX
         cjzer2cKB5RXmMQn+0TQfYCMHPemGdMPXcPTQpqz9dlNwS5/VDEHc2hN5R0GPw0BYL+m
         DMdnl6L0nLQ+txjsKdTfkuPs0GFeS4ms9oo4tPDv96YVioE5p6Ndys1Pb7pLaQayMoVX
         PfIg==
X-Forwarded-Encrypted: i=1; AHgh+RoAHDL6NNXqxatnH0/a402LhUC4Gs6M8ZbE5TsoQqILmS1bBVAfT1iIIngDf8jwdH9KBe5I+D2hKb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UAiPTpljYUj4+98aF5/tbPrBSCCYPbh6Gwinq2/SbqZbMY6e
	ws0cyTnXDxzeoQPgMNpCQ5k9a2HWbrM68Herz2TEdhktpgXSFFsCFQdz/QdIvYULil7++0m3SLz
	3M5sH3Ojyro6BCm4JSUDShyIwqZkajDYhkOaoToWj1CGF5jEu7De4JTw32RVACkg=
X-Gm-Gg: AR+sD12zGDsDiiSzRSqj5WcQNGhveHIpkpY3K7FzN4I3sSmqkRxQI7ixGr/TDngjgMH
	Tif5mAI2SoZNTw3k/ohVaX8cHsw/uYvT3FFNlk1XbMmzVbVbPuQlAveSVgcjs+1HjWeGcLHEGjG
	PgtlSD9PfAHmtX1hTmTxjjx0qlKTc6ak0ciJXCtxMda3P+eFJ6FpEv+tx3iQDc9OxYdvhP01uk4
	A0kOaOwljdlEi3u6sw+ltpEsVknhyZcwnlPXJ9vbr+MmqmDpAWOQZvT41sYTbB5aPB4gfaEZxzl
	2gd496Y2N5mplgZISrMsZSxq7a6pDa1jIwlgtoxWbLGvzssINA/fMjMrv/E9ZPBF561aci/L8zu
	ub973Y/NPIi9vFs4AH180uysIB6WQcHM=
X-Received: by 2002:a05:690c:e0ca:b0:821:e0a:6cd9 with SMTP id 00721157ae682-8210e0a7c2bmr4625147b3.17.1785937980261;
        Wed, 05 Aug 2026 06:53:00 -0700 (PDT)
X-Received: by 2002:a05:690c:e0ca:b0:821:e0a:6cd9 with SMTP id 00721157ae682-8210e0a7c2bmr4624587b3.17.1785937979597;
        Wed, 05 Aug 2026 06:52:59 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201320ec71sm20892517b3.12.2026.08.05.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:52:59 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH RESEND v6 0/5] Add CAMSS and IMX577 sensor support for
 Shikra EVK
Date: Wed, 05 Aug 2026 19:22:45 +0530
Message-Id: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1Ac2oC/43Ou07DMBQG4FepPOMqx5djt1MHujLAiBh8JVZJQ
 +M0gKq+O25AaocEsVg6tv/v/CeSQ5dCJuvFiXRhSDm1+zLg3YK42uxfA02+zIRVDCvJkOY67Tp
 DnWlyppdE+KAuYkQ0TiJaUpLvXYjpc1SfyeP2aftwT15+7rtwOJYl/e+jNTlQ1zZN6tcLG4JC7
 mXkAsb/dcp9232N5QYYA3/2GIBWFIX0zGmnpFGbQ5+Wh6N5u6xYlmNkB3alsNLTFCuUM7DiaCM
 wWG3anCcofkOBnKZ4oTRoLjREoX01Q4l/UKJQ1lkJlQbFpZ2h5JVSwKcpWShvJbcBpHcizlB4Q
 7EZCgulnMC4stYKP9XqfD5/A2yXy0VsAgAA
X-Change-ID: 20260526-shikra-camss-review-cf6f66ac566b
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785937970; l=4965;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=IU2FxDbVpzPCuR4skclReRjkiNxGfVidNVcC+7xKNfg=;
 b=O7Q39imTU4H44WaXf6L/z63Ee0Hsn4QYm/xw3GR+mn8uCnTi43LT99N6YTCtGR2X5yHGt57E0
 VeF/kQTQvL8D8kG0EqQIIvLcc3f6TToqQBUHpp9YpIDv2X3tGpHZtMp
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX7fSsb7R9aZWG
 jvLWI7MgbBZffveXtAqp05sGa1xIubbhzYEXxKaM/krHmtI+4QI92XI3oVA/5t5OkOdrgQPO2QG
 y3QDVyhUg2gCcHSN+LThf3Q0V5qO0oo=
X-Proofpoint-GUID: HGA2ougPBRwKe70_9MzCh8dd_wNCU_YF
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a73403d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SCY8RljC4g58VSpTV0sA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: HGA2ougPBRwKe70_9MzCh8dd_wNCU_YF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX7i/BFm8lqmZn
 qfSczKoqwsUdPfsbRShFALhOHvvxh5cDZgE0ZldCh5m8poZd3tN2fZhR1DBxMJ0dLTH4AtYblZI
 GFuTdScv8iDZPckbDcCSel2MsACo59HPSw1TEr5MCFHXZZ9+bq9s4H9M+t5SRVzCZMlz/EmcHD+
 BEKZezW0S62Nnrjh9Fe/fcQn/ou2L7udFauIAQIk9RtKsHhwoidgnvIB0FRUoA8wP1zoJpTY+nP
 Fr5DUFoWvu91oULo5kO6NORpoHWcgsAB1sXqP30MtGktdzVUNFu+8cJb5tNau4IZ7AIK7QI62Ke
 8lZb8y1pgQy5FMbBAEA2PQeeVhzVdy6n2AwvRHhQkk7QpKHQwtla1peXL/012M5M0QHKfoLJDTA
 6r/aKflCdmM4nCLR0HMGdWzAod1JoVBS2vGpZ6QootckIzNMVpRR6j93oNuqgH25++ROCVUXk9h
 KUws/74thpJYi39Q/qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050112

Shikra EVK is based on the Qualcomm Shikra SoC.
It lacks a camera sensor in its default configuration.
This series adds CAMSS driver support, CCI definitions and enables
the 22-pin IMX577 sensor via CSIPHY1 through device tree overlays.

We have tested IMX577 Sensor on CCI1 with following commands:
- media-ctl --reset
- media-ctl -d /dev/media0 -V '"imx577 1-001a":0[fmt:SRGGB10/4056x3040 field:none]'
- media-ctl -d /dev/media0 -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -l '"msm_csiphy1":1->"msm_csid0":0[1]'
- media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0

Used following tools for the sanity check of these changes.
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=media/qcom,qcm2290-camss.yaml dt_binding_check W=1
- make CHECK_DTBS=y W=1 qcom/qrb2210-rb1-vision-mezzanine.dtb
- make CHECK_DTBS=1 W=1 qcom/shikra-cqm-cqs-evk-imx577-camera.dtb
- make CHECK_DTBS=1 W=1 qcom/shikra-iqs-evk-imx577-camera.dtb
- make CHECK_DTBS=y W=1 dtbs

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
Changes since last v6:
- No changes in patches
- Drop dt-bindings: media: qcom: Add Shikra CAMSS compatible; already
  picked by Bryan into media tree (now in linux-next as 32179a552b8e)
- Rebase on top of linux-next (20260804)
- Link to v6: https://lore.kernel.org/r/20260723-shikra-camss-review-v6-0-7c46f9bbb4db@oss.qualcomm.com

Changes in v6:
- Rebase on top of linux-next (20260721)
- Sort CAMSS by unit-address numerically - sashiko
- Collected Reviewed-by tag (Loic)
- Link to v5: https://lore.kernel.org/r/20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com

Changes in v5:
- Rebase on top of linux-next (20260710)
- Drop dependency on shikra-dt series; now in linux-next
- Drop dependency on shikra-gcc-rpmcc-clks series; now in linux-next
- TLMM pin entries roughly sorted by the pin index (Konrad)
- Link to v4: https://lore.kernel.org/r/20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com

Changes in v4:
- Fix data-lanes numbering to start from 1 in all endpoints (Vladimir)
  Missed in last rev.
- Link to v3: https://lore.kernel.org/r/20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com

Changes in v3:
- Drop dt-bindings: i2c: qcom-cci: Document Shikra compatible; already
  picked by Andi Shyti into her i2c tree (now in linux-next as e3a8f8329397)
- Preserve blank line after compatible const in qcom,qcm2290-camss.yaml (Krzysztof)
- Add blank line between iommus and power-domains in CAMSS node (Vladimir)
- Move cam1_reset_default pinctrl state from board .dts files into the
  mezzanine .dtso overlay files (Vladimir)
- Collect Reviewed-by tags
- Link to v2: https://lore.kernel.org/r/20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com

Changes in v2:
- Drop qcm2390_resources struct and CAMSS_2390 enum; use qcom,qcm2290-camss
  as fallback compatible string since Shikra CAMSS is register-compatible
  with QCM2290 (Loic, Bryan)
- Use oneOf in iommus to describe all valid SID combinations: VFE-only
  (Shikra) and VFE+CDM+OPE read+OPE write (QCM2290/Agatti); add
  per-entry descriptions naming each SID (Krzysztof, Bryan)
- Rename shikra-cqm-evk-imx577-camera overlay to
  shikra-cqm-cqs-evk-imx577-camera, shared by both CQM and CQS EVK
  boards which use the same PM4125 PMIC and camera supply rails (Bryan)
- Add reset-gpios pinctrl state for IMX577 sensor (gpio33, cam1-reset-default-state)
- Add comment in overlay DTS explaining absent regulators are powered
  by the daughter board (Bryan)
- Collect Reviewed-by tags
- Add reset-gpios pinctrl state for IMX577 sensor.
- Link to v1: https://lore.kernel.org/r/20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com

---
Nihal Kumar Gupta (5):
      arm64: dts: qcom: shikra: Add CAMSS node
      arm64: dts: qcom: shikra: Add CCI definitions
      arm64: dts: qcom: shikra: Add pin configuration for mclks
      arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera: Add DT overlay
      arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add DT overlay

 arch/arm64/boot/dts/qcom/Makefile                  |   8 +
 .../dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso |  79 ++++++++
 .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     |  79 ++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 198 +++++++++++++++++++++
 4 files changed, 364 insertions(+)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260526-shikra-camss-review-cf6f66ac566b

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

