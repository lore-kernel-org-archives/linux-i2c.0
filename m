Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86455405872
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815580; cv=none; b=OCCkTzmJEZy7dpr3u0cBgbKqwiRwoFjgLUzZ7WrGOBedI81JgoE1W8Vgeu0J9iCkdGzl0ITj1MOuVpl1aWA1QKBCY+whucecm9pQQgZWsrfZ2EKNNpcEcKRTwf5xkiQ7spddc1UIHXZrucNJ5avZLJgKq2aA9y6HwNcKbsGmqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815580; c=relaxed/simple;
	bh=z16XuHj1A7vELH7YEt8PGS9A3NivYQGTOASzze0I4ig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rItQUSalMxBOrRyBgIKDQrRPmqFiZEepoielq7xaNWmy9ctuTQrJcCAttpGW0q1cQB0GVsiPtyVgxY2ZTi2g+8Mng4SXhHHo8TysYeVWEfyQyktCy15gLGhx8R9FmyEOPDYwExMExAsG7rX4UKL9d5NhjAJQLNasqwYoNKPhBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFZ5hjAF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S9wodx6G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFZ5hjAF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S9wodx6G"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH18iN3086573
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Pow14EwOIn0od75ybgcQR4
	L1r35iLvKxModRsY1OKyI=; b=TFZ5hjAFp43/hPTprCZQ0Gv8xR/rKTIXOujJnz
	DMVhYAHCyC6omlIDU5q2X7jxeX5ccmj91xfrs/JMGgHOczzgT4n3QEZIyyBCbFjF
	xZ29ME/hIXH5si0epr/l4zJ8V0e9P2/7+xKyA+ooJAqy9OuYDXjneshXs9S7wS1O
	Mm1B4HE1Y6BUW4mNkVbpQt20RyLp5xuvEie9kxaUbODIoV2Rv6xVzom7NYNUaUx4
	3s9xGTKGWpQOAHelvzQgUFrJsQH8oms9YQFSQ0qLbn6wa15vImnJSeeIxnqs5zjm
	JSHGASxB4caap1TkUIydwonG6KgmwUUvoaLv+RTDJNM5rwbw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edeff0dus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:12:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8292e18166so5264377a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815576; x=1780420376; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pow14EwOIn0od75ybgcQR4L1r35iLvKxModRsY1OKyI=;
        b=S9wodx6GVc7fC09RBtY9FsvTeOjR5+PPPSY94nzW5xiiayhHtTmQnsCY5syAtUfZo5
         Bslq7MlMVTPat0mnl8ZmYjVXiz9SBht4+o9DIM4Jplnl4sRusLRm36MuEoxW21JNKB68
         rltxfvrqLGZVwn6I/W4OTevk1dIztAVqVjBW4TajbM1bz8q/wQkgFLNal/jnSuGgaBP2
         U+f2w8awmY/sBO7VanejddxwzoeRRaYRi9dhb1QVDLldJXfHCYaaJOFBBTCNzeMQQro/
         CO8QFNSM6i9i0ACMocw0vjQtGAI5zPuJ3KO+QBrzQAkaOVS9lZsRBD8mrwfNyJwhr3jR
         BoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815576; x=1780420376;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pow14EwOIn0od75ybgcQR4L1r35iLvKxModRsY1OKyI=;
        b=WdueXyOb5KbIDa6RpG0t6naBcklCjzcoY21UKb8lfzjlACnMvOmpDlff4G3UF9QBgJ
         TmQUgPKNBtQQ1nHbt3vfx97gjkmqqNVJujN23QpN6JheQMEP8h53rGV/+qkMnOpKoURS
         tOEF564J829JU7Xj45UQVD3kS5Ismw1Ct7AO3Pe2GZks/OeV+XR17gvN7el7x34w6ATt
         nzxsNx/lXQp3+JPEkgnnJrA3R2RhD9gixA2Xf6qQbahVfPf9xF8ySpH4+d0C78GBPALR
         zrTQpAe2zenBk6rZU64vPIbHxUUwL/45nnKyiNpAk+w3mc4Zc4GV9c869QAb3BbYVyjw
         nZDA==
X-Forwarded-Encrypted: i=1; AFNElJ9k299nYScFEB7rynonxirGwvlRlEeNKjvPnw1U0oD7lZSwd/EAMBkFa1hVbhlrU0siFpXZydwpEAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2SwSgI+66z53Ni9+jKJsrjhkfl7KTJFg4FRVVVjoHuMkIXh5
	8qNtEwqZXvnL799/wirQxzpSgENvrii+yhMfLxlYkHfZGRkIu26z6Q7XLG7m3StHEWwTSUva7+1
	d4xJdgY7rgSdQLtCMknLh7M8KTHVSBqii10NLL4+uaNqi1w+L93uV7yjvy2MXJDc=
X-Gm-Gg: Acq92OGJR5xWGSVvqEKfEwVmTb0Q91r2N2VQdYVMZpGBgtC7aLtIBlSXbTQ2kWvcU0U
	oXqW4Zzac9DFQ8JFwWX9rf379ti7p5tngTRHoirZW1W+FF6jmOHHEBMe8VFrqcP/LWYEkXfb4GA
	5b1Zdn9YsiEJZHhRTbJMYpsgLhQ/N6VFus/ogUxkEW34Cp20YqzA/AEO73gEykua/u9e9XwemYA
	gti3URSsvJVQbfdxLUQaXAN7JGkQS5D3GGs0EAN8rOMw7GJC9NflURNhU/k3OW2+cFxlwqTqmd0
	wi5jvmDP2J1LqIyziVdgC9ehv/dtMMGoTCwZebhH711Fr75iHhtj48yDaS7C8ngSJuxm1n+F1oK
	0juGRNseiB+IrY6WAIY7D/lwGcDDWsmbH1BmSqd6ys3N3br/Ymy57
X-Received: by 2002:a05:6a00:124d:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-8415f3a54bemr18300631b3a.45.1779815576081;
        Tue, 26 May 2026 10:12:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:124d:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-8415f3a54bemr18300594b3a.45.1779815575564;
        Tue, 26 May 2026 10:12:55 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:12:54 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH 0/8] Add CAMSS and IMX577 sensor support for Shikra EVK
Date: Tue, 26 May 2026 22:42:44 +0530
Message-Id: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzUFWoC/02OWwqDMBQFtyL3uwHzuj62UvyIyU0NRW0Tawvi3
 ptWCv2cA2eYDRLFQAnaYoNIa0hhnjLwUwF2MNOFWHCZQZQCSy2QpSFco2HWjCmxz4OezHr0iMZ
 qxB7y8xbJh9fXeu4OjnR/ZPlyjNCbRMzO4xiWtmiM6RXJkmztfZYIgdjImhuhdNVw56Un8lTBf
 1RbHEmc/5LcwlylXVMprVBhu0ro9v0NFga5fuIAAAA=
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
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a15d498 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0ARVRLQPdUDne_cnrioA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: VI49Lak8Pwrj04sAkNhPAtmeg33CCtgH
X-Proofpoint-GUID: VI49Lak8Pwrj04sAkNhPAtmeg33CCtgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfX8CVXhFbHRZTI
 HvvrE+lf1F43BUs6Hmc1sI5LA70hMN/YHlNpK8K5IqIY/HjIKKEDIE2ZAfQH3Qb6J1asZj6Ns/S
 c7cVcrFF/LX/+Z1ndLxjTj+XmEQgNaPjNJ2ZZqLLpXdHTrQuOu3NmTpERbOKkDOgzaS49OJSGkP
 K4z22mZpsTJ5Mo6A3jIBKayl0Lv+jKutc+2RG+7sINPoaKO/lCUmtAfdBugWtzstx6bQ1TZStet
 qBQ40LUwsrHUtZaOAbcpYc9jDtohwbJMczCTeB6ZONsT80kLr1lbfnB03PEvxLcjka329K49F62
 PfHlZSiP7/T5Y81KjoElP/eDTCa1yguWNswXQlm+z9EcfZwlR5IwANd1VyWP2CKsK2plbZEsWVj
 YvndTRXBt/66QrLvCRgHcZ2pRdzSSIOp0U+v71OWm1pRXFyOgQIesufU8FjuoXI+bz7W9ZKDF5l
 uN1cBNGm6n4Vy0xDcUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260149

Shikra EVK is based on the Qualcomm Shikra SoC.
It lacks a camera sensor in its default configuration.
This series adds CAMSS driver support, CCI definitions and enables
the 22-pin IMX577 sensor via CSIPHY0 through a device tree overlay.

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
- make CHECK_DTBS=1 W=1 qcom/shikra-cqm-evk-imx577-camera.dtb
- make CHECK_DTBS=1 W=1 qcom/shikra-iqs-evk-imx577-camera.dtb
- make CHECK_DTBS=y W=1 dtbs

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
Nihal Kumar Gupta (7):
      dt-bindings: media: qcom: Add Shikra CAMSS compatible
      dt-bindings: i2c: qcom-cci: Document Shikra compatible
      arm64: dts: qcom: shikra: Add CAMSS node
      arm64: dts: qcom: shikra: Add CCI definitions
      arm64: dts: qcom: shikra: Add pin configuration for mclks
      arm64: dts: qcom: shikra-cqm-evk-imx577-camera: Add DT overlay
      arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add DT overlay

Prashant Shrotriya (1):
      media: qcom: camss: add support for QCM2390 camss

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,qcm2290-camss.yaml         |   6 +-
 arch/arm64/boot/dts/qcom/Makefile                  |   8 +
 .../dts/qcom/shikra-cqm-evk-imx577-camera.dtso     |  63 +++++++
 .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     |  63 +++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 197 +++++++++++++++++++++
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   1 +
 drivers/media/platform/qcom/camss/camss.c          |  13 ++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 10 files changed, 355 insertions(+), 1 deletion(-)
---
base-commit: 9aab4e30ec8ffc5622669381a245791df3feefe7
change-id: 20260526-shikra-camss-review-cf6f66ac566b
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v3
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: 2acc300a68ed8c5364fb5f2f7d28fc0d56ab07bf
prerequisite-patch-id: 391f9dffceaac9f44df7c2daffafb66fa379ca35
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 7e351b93b3a238145ca642143bd0824bb90e98ce

Best regards,
-- 
Nihal Kumar Gupta <nihalkum@qti.qualcomm.com>

