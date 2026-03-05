Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05691379974
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704113; cv=none; b=LBliguNzic3hxj8qCfcCRVB4QXei7lxedeBw4WaqN2Eu1uijqbJ4hdaBD51wsyF1z2Mrw8h8y+CXemvZxGCnc7fGizuqm9pnMFkVwRbhqoqJz52dFKhxuO3n6XWg1cgxhsq1ODmOSyAGdjrDFpC0RhrdaxAx2WwdKCj7HEvH+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704113; c=relaxed/simple;
	bh=psIXUkMn5+R5k4TdgFnB0WZTOygVxEGKBTdZs3l2WGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rILcc+hDcEinX1CADoZ/EWbeDPXzIwSmA2Irwac7UYFAmYO/4Ewbu3z8MuVbeEhG6wJM4epitaFK6VGCmQkc1A+NCHNW/QT/Lu8hdmLQdY/H4QAtmgH5gZJ42rsqHqGgwHLY/+/lO7KG++7HblvXzPaGQJfirtRm+o4p6Qrexc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdQJgTBn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQC5KBzu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdQJgTBn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQC5KBzu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6254tYOC218428
	for <linux-i2c@vger.kernel.org>; Thu, 5 Mar 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9uMywlkuTKkzvOtJwTHxup
	57VnJ284vbdhoXFQYAsUg=; b=RdQJgTBnBTp6E/tuzzGJ1MPF4ZjdP2+esGps7f
	LuhmfZJKAlddrS80rXFkNWvQ3GhHttlOSAv1z5lpHyh12fj/S5uXQwSqAxu2FYto
	jPxwWm2cZ4PNHmPMfSKP+G7Sp3SKW8ERZepVbvVcKQ8TyroMT4ly6UnadJqd7hJl
	oG6cuSqp5HfzcgUYhDNo5ABLwDmXUBJXdueWiklibrFVEJ5Clj+WowjvL0l4aVoO
	6ojG3YcP5IlP0MpDa8BnVZJCA1UmdzeIDMHAg+z6cLvw8lXCUkjUFvl5qHVgrmUo
	PhwK7ZxOk+EaVOm7BrbayGOZiUZIulJiIeAJXbuQx5LUFyig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380ry6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 09:48:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5033c483b76so600482731cf.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704107; x=1773308907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uMywlkuTKkzvOtJwTHxup57VnJ284vbdhoXFQYAsUg=;
        b=XQC5KBzuC8qsONOPtohKazD4pAWyw9FyxiU4LUTX3VITktYiVK/7Pky0lExJAdFF7L
         TbQKJz4C/F0HEH2u62yKlWY5jET2HF4zzUXrdOZCLwJth4yT0j6HssqrqxN2elbRlJgt
         EEzgAAQoZ9HVN0mzWeKuz8h+wqQFIhHlHdmlWWCco9Q8Tobkbi83P5pqoQ020IY5OVUT
         ZXGIIvqebnmbuGVG1cdjdXDrMZgTnygw4IoPwscqNISZdvyG+/npanfxHmIgs7R+tjJ6
         8zPRD8VPbQKVe4Ze01/Lsv0YZBmbvr90YhdQflLjzahTToE/pEfckm4nxLWCdaxgJZFJ
         kTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704107; x=1773308907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uMywlkuTKkzvOtJwTHxup57VnJ284vbdhoXFQYAsUg=;
        b=eHEQClWWDxMfzuPhErR9URJfVsAKTXL/0JeJMblEQUzo7wAJ1l4piMj8vT6bmxUpMv
         B8c94lAxHiF3K3lnD8lQphf61/rENTbL2O/GBTFk7vOz2qsL42QxXx+V6sCjGJcghju2
         AZI4reTUkLeZ1kcMCnYoD3OM30vanvV7DmF6WC+7yLg1M1577P6Nu50Ur6qOkoRQk0o8
         EMtqrCVDimvgE+9lv45VerBOMwptzedJTR1K/taBWXa+WP08lisPEjuk74uV9pbADFnK
         0Vk5Jf7MrCO9u+uiyFWdXRRrtTUyIQaL4KOR4Vn5g5fD3MuyRGxZWhc+j6iLE//UC+Uf
         yYSQ==
X-Gm-Message-State: AOJu0YzqmJHxAWASlrb225/9D3D3dMyldfP6Sb9qVXBx652iDlQ0MFgD
	UOrb2qX32srCO0YwIhad2c0ts3vrTPz/EUFOh7fD7FCaOjiVlvorcQ8OlKf+NYID60H8E3PVl+B
	lPO/8pf7G+oUFJojLLeAaC5TdPfS+GBgA5I1/wIsEXg5tm0ATDeGEarB3EM8uGhA=
X-Gm-Gg: ATEYQzyZ09U7uQpMEyxF5wjxgtn4GBckRwo0l22slozWhXJVv1gHzOEfLwDl+S0QeI2
	GvNCT8Y0wIql8IaWoiBlaGnkBhhY+7+YbdDyFYzLA033rWyrj/KtMZjpeyna8M6AtXa31rYOsL2
	0zAo+o0rcO7D+mYiDZrlJn6MgXcHzQVskBSZn0CO4KJ5iLAPKvO1LDqKh6Rx/1w8gafbEeO7JML
	dJ6/ITh1j9DvKbyTuPPf5c86bkMoUouBDGfWOaHfx2V6Qgj8glg0QE3uYZ9hL7o9LJvXmtppe0c
	y6bSRONm8SJd/M42FNqpxAJLrRsVgPaSJlOwCBalhG3lj3nOud6Q5jiUGtGT/8d+v7lMdmh9Uyj
	omdrU6HjhPntRQ5rnV+sPsZmwIALTPmAsKER0q/207pKenMTm2EF1nQ8WHYtK0YH93O6ntz0tz7
	4pNAMydMqvbW9W
X-Received: by 2002:a05:622a:1909:b0:506:98c9:a3e5 with SMTP id d75a77b69052e-508db35c1e2mr68937931cf.35.1772704107065;
        Thu, 05 Mar 2026 01:48:27 -0800 (PST)
X-Received: by 2002:a05:622a:1909:b0:506:98c9:a3e5 with SMTP id d75a77b69052e-508db35c1e2mr68937761cf.35.1772704106529;
        Thu, 05 Mar 2026 01:48:26 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074496300fsm177126211cf.2.2026.03.05.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:48:25 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: [PATCH v6 0/5] Add CCI and imx577 sensor support for Talos evk
Date: Thu, 05 Mar 2026 17:48:11 +0800
Message-Id: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtRqWkC/3XQwW7DIAwG4FeJOI8IDCQhp75HNU2QuC1a07SQo
 E1V331Oekml9YJkBJ/t/84SxoCJtcWdRcwhhfFCRfVRsO7kLkfkoaeagQAjAYCnoZJGfGH+5g1
 67C3ag/Idow/XiIfws2L7T6pPIU1j/F3tDMvtwlRCimrLZOCCey8ldL5Rfa13Y0rlbXbnbhyGk
 g62aFltBGleBEVCIw1UfS+N0eqNoDfC6ypZk+CsaHptGwtYvxHMe8GQIJT1shbaCPffDI9nSBF
 vMwU9PZNiA6bk1qDbYpWVAAm0oi2lVU1lNZecHqfxnHG+pimiG3bHwYXzyhLqXUK+9AlTW+S6F
 Dx2QP0ef4P7mtzgAQAA
X-Change-ID: 20251222-sm6150_evk-8ebed9e9f3bc
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772704098; l=3459;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=psIXUkMn5+R5k4TdgFnB0WZTOygVxEGKBTdZs3l2WGc=;
 b=TE/lqu7xbHnOc+2UELh7+dMJu0JAe1+ryIaqgvIFDYuThmkLOYD0u1zWmJeJJF+uqrKNUCkNX
 fgGoDBHzqggDmz536KNeduNSG3S8XPJ+/yf0jylsI+nuH2wr2w1R2MO
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9516b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ld4WfEqAmRoefWT_AfQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: xEEitrt97uI12ddyOotL4aulMJ9psapa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OCBTYWx0ZWRfX2dWNp4NjUTTh
 9zZe6EUk112WBN8mWDJ1Dp8zoxfE8hfTdvN5onEHLgYbvP/ue4v2LEQG2YQzyBEaqeJRAv6TaAx
 UdWw0hwAxhwnPSkSbvEF9FGeHrGj2fzsc0juskjcBhCU2kfXNU96UAq1WRDyeau3RSyUMxuyymo
 Png0s87qMOJhj9d3Yv9GfmsEg08vXdvySubHmOgYbQR0iCfTXNwcWjU76f597fjStoCGVxZUhn9
 wxUyoi04eAjEhu+Hx5dx71x+BMzbtswtdsEbnxComJ6IbRBYkUxl13aggiZLK/XZ+yBbaSW7yr5
 XKkVnDPYQsh1u4sJuaIFNXa08qdMrOVlXtFecJFD0zpmHIIqy1R+ULd+KrBCW4xaG2Joj9zc7DT
 xVumptiXuwVUjDcDoPQuCt7B7nhsHldo3WuMFI+w5CANRsE7XrRPQF0r0qYKKJWur/Ov1oDZYL/
 WwZwr3OKDKZEuaOVYgQ==
X-Proofpoint-GUID: xEEitrt97uI12ddyOotL4aulMJ9psapa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050078

Talos EVK is  based on the Qualcomm SM6150 SoC.
It lacks a camera sensor in its default configuration.
This series adds CCI support and enables the IMX577 sensor via CSIPHY1
through device tree overlay.

We have tested IMX577 Sensor on CCI1 with following commands:
- media-ctl -d /dev/media0 --reset
- media-ctl -d /dev/media0 -V '"imx577 1-001a":0[fmt:SRGGB10/4056x3040 field:none]'
- media-ctl -d /dev/media0 -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
- media-ctl -d /dev/media0 -l '"msm_csiphy1":1->"msm_csid0":0[1]'
- media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- yavta -B capture-mplane -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0 --capture=5

This patch series depends on patch series:
https://lore.kernel.org/all/20260302121159.1938694-1-tessolveupstream@gmail.com/

Changes in v6:
- Adjust patch order. -- Krzysztof
- Change MCLK pinctrl name and add reset pinctrl. -- Konrad
- Fix typo, rename imx577_ep1 to imx577_ep. -- vladimir
- Link to v5: https://lore.kernel.org/r/20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com

Changes in v5:
- Modify the commit message of the cci dt-binding patch.
- Link to v4: https://lore.kernel.org/r/20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com

Changes in v4:
- Add CCI properties to the existing portfolio. -- Loic, Krzysztof
- Modify the incorrect dtb install configuration. -- Vladimir
- Link to v3: https://lore.kernel.org/r/20260115-sm6150_evk-v3-0-81526dd15543@oss.qualcomm.com

Changes in v3:
- Add generic names for the CCI clock. -- Loic, Krzysztof
- Split cci node, removed double space. -- Dmitry
- Rename camera dtso name, add detailed description. -- Dmitry,
  Vladimir, Bryan
- Add dtbo-y for dtso. -- Rob
- Interrupts cell change adaptation.
- Delete cci sleep pinctrl state.
- Link to v2: https://lore.kernel.org/r/20260106-sm6150_evk-v2-0-bb112cb83d74@oss.qualcomm.com

Changes in v2:
- Modify the CCI dts style and commit msg. - Konrad
- Split mclk change as a separate patch. - Vladimir
- Remove clock-lanes. - Vladimir
- Add mclk3(GPIO31). - Vladimir
- Link to v1:
  https://lore.kernel.org/all/20251222-sm6150_evk-v1-0-4d260a31c00d@oss.qualcomm.com/

---
Wenmeng Liu (5):
      dt-bindings: i2c: qcom-cci: Document sm6150 compatible
      arm64: dts: qcom: talos: Add camss node
      arm64: dts: qcom: talos: Add CCI definitions
      arm64: dts: qcom: talos: Add camera MCLK pinctrl
      arm64: dts: qcom: talos-evk-camera: Add DT overlay

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 arch/arm64/boot/dts/qcom/Makefile                  |   3 +
 .../boot/dts/qcom/talos-evk-camera-imx577.dtso     |  63 +++++
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi        |   7 +
 arch/arm64/boot/dts/qcom/talos.dtsi                | 279 +++++++++++++++++++++
 5 files changed, 354 insertions(+)
---
base-commit: 9fad1d148df6f36105159c2503d0ecb1397bc89a
change-id: 20251222-sm6150_evk-8ebed9e9f3bc
prerequisite-message-id: 20260302121159.1938694-1-tessolveupstream@gmail.com
prerequisite-patch-id: 065fda916d7faca61113e1230fcc0ce3916442fe
prerequisite-patch-id: c009966e432e7f11bbb895167e32e517b6ff76e3
prerequisite-patch-id: a44d58bc0cfaab99dff8c4e12ecd0312447766be

Best regards,
-- 
Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

