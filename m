Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB93A7E12
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078982; cv=none; b=JCTufePOkqbAX2tihdMf5V8S16SgJRoKy07+UnMWc6B+hMV8Ci36QO3QW1r0vMydIE5sOP1xF0KyXeetUWyLoMGRcFtaKpapRIkJOMrcBl48RrqB9emr3x808lc7xqNST+F61IqvLtouHRXDmlbYv5t/LIZmjKLxbKjQF4rRGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078982; c=relaxed/simple;
	bh=nC6j/UBzkg1YNyck8xT90UzhtDTGOguWkcxnNWp6ewY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mvUMH0fUpjrzPD/FKY5LKY/kxaJUR9ANBLbS7d5bMnSto3NAyfqMDKdP9jcTAnJPnZUKF3JqA2v8M3Cyqwdpyn4cVyIYUfK+jYArwJu5aUZikEMuCkZxoVOVgxCt+rAN7W+kuwQQ7mQ8ZnZxLhaJPP7Bky8d8esVuPITcZZ9XCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPcbKyPF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K33elY8g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPcbKyPF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K33elY8g"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7Or6U788977
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/MYp/oxYtk9Ft4NZVFzK+z
	wSsyfBXDmUHdLa/l+8vBY=; b=nPcbKyPFl1LlOrXFRS5IYtwNwJ7eGQ9axLyCaM
	gwFuXsMqkZ5g+cWQqgQ5u9BoSvvITGpvTyrSnu5jpajJHy4EZ/b3qA/IlUIQHuK+
	gU5GwiYT2GefaQr00ONaxrcv6yP0jpfp+KeaD3JPwNt3qcQKbNneAkmDahx01GkV
	CZj9JrtlLROAdHvRTKsbtMB4vKLh7BSTjaNbdGal6Xwfa86MPMaecpd+VlRo4UtI
	FudTqsZlkhPRbjPvWLvbYWNlwyKNHEeWM0RgyJJcaI5dAuA67uuKoc6v5CI6rYyp
	dvzoBH6MfNcWVXREngSDUkcoztytctdOwonUTfJ7RKAqDHYw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6p1j4uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89470bda22aso27325476d6.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078976; x=1769683776; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MYp/oxYtk9Ft4NZVFzK+zwSsyfBXDmUHdLa/l+8vBY=;
        b=K33elY8g896gOvHRkevd1t6Ptgb5DVys5dcyYJZj3+PxrDANcnBBffTS8dZVzva+H2
         c78/6EiNSprh44EW0ZVXE9PjCplR4JHb39tyba5CbDC41xn9XAqSSH3b5FV+yiP7uHNx
         Hc/vTmBykfoEw3ucL9tUIwD5lBuzdtFRccq2VWwXGP11wOaQBPk+k9x+m/8rREkBl2u9
         Pswr6Hpp5CPWunqdPVBJiOeip4cw0FLOZLL6wXwJZmIRyY6SJVrLZRd+CMYgIWHwbmff
         3Eijf+zR/tU2AhG+Nxt9Xt/v/h80XzcKTA40roQK6Ifva8vfcUiM/AlG9pb1oTxefrdT
         uTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078976; x=1769683776;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MYp/oxYtk9Ft4NZVFzK+zwSsyfBXDmUHdLa/l+8vBY=;
        b=g2u9ynfadMlaFqFgRuKtRpsGGTrPdTQZ0pvM2+rCZSzqlPOvBBA5wbRZG+4oj6JK6d
         fYTnZCkc29kGkzC52XPPVF68VBBWWtnJJGD9EiCxAXeRR6XwLiB81GKGnj9vn0GY2u7p
         7rYFZBPwD1XojnPekeVNtCgRZ5FoV72lhnHlzk0XN+SZwwOnkS++++ttpZ7pZGy84pAw
         nI3t5ERZVS2zHTP7qSahp1EGmQ3YtV05PitXf/86clfgqmffBkeBn2fS8tI8r0f3pOVz
         h/IQde2ZpNJocqG79tQY7LNC9L5y8nzQdSU85UIMO5p7IOa9BxBbv1iORtpVh5AwC9EL
         uabA==
X-Gm-Message-State: AOJu0YzfZH6+SAqy2ffFe0evdA4JCZFvyI1S7ogfp+TTY/+YlzQtK+98
	CF+p5I2GkfnQ4FpEuS7sv+7wv17+cYcBMrMj0ASAzZxb0/vhDej4qzI3Q38cpPF6F4pJVEfearm
	FmDaLq64x+hR2B5+lLyGr5AXPt3+d3jW6eB8JurgY+rY6NH3R9+d1jCtbEp7IIeI=
X-Gm-Gg: AZuq6aKRgXrdQOZSYCip3OLY5zab08B2aDo5VzJL61iZDcVrZlfuQDEWPEOsJubMjoP
	k6lL50j/cQPBgyCFkjmlQ54gVBT14ac9q1e/KRLZIE5oa/F2wQe7UPocPYbr8oQiUtGq0xBWc0S
	tjgZkemV57ZTnVG2T4C4ufSCgkgZPNw2wO4upG4vmo73CbmVyhH7ULRJ75ATpfrYGgqKbUOC1Jd
	RtnalhOJJf69VedT7IQBCcfb7M8J1CYGXlncYhCgSiunD4rgBazocrR7NTPlgDPqnyzVenK7P3O
	Esz6yjPwWGguBgfM2JVLn0lwuPe0NFo8VnOSDirJNEvgxBTyFV0htbbna4bRJjXeySkdrbjNJqj
	l6ayxTKvQKlXYMYiLN/e4frwj5ZXRd0Rq6A5SF5cUbELhhp2IRym7R2P+p2OC6TxfgAiGm+8URB
	V8
X-Received: by 2002:ad4:54c5:0:b0:894:7c02:6062 with SMTP id 6a1803df08f44-8947c0262d1mr36539626d6.32.1769078976010;
        Thu, 22 Jan 2026 02:49:36 -0800 (PST)
X-Received: by 2002:ad4:54c5:0:b0:894:7c02:6062 with SMTP id 6a1803df08f44-8947c0262d1mr36539466d6.32.1769078975577;
        Thu, 22 Jan 2026 02:49:35 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm121704901cf.14.2026.01.22.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:49:35 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: [PATCH v5 0/5] Add CCI and imx577 sensor support for Talos evk
Date: Thu, 22 Jan 2026 18:48:51 +0800
Message-Id: <20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMAcmkC/3XQS27DIBAG4KtYrIvF8IrtVe4RVRWYSYJq4gRs1
 CrK3YudLhyp3SD9CL553EnC6DGRrrqTiNknP15KUG8V6c/mckLqXcmEM66Ac05T0KDYB+ZP2qB
 F12J7FLYn5cM14tF/rdjhveSzT9MYv1c78+V2YTQDprdM5pRRawF4bxvhdnI/plTfZjP0Ywh1O
 ciiZbERQL0IoggNKK6dA6Wk+EeQG+F1lCyLYFrWONk2LcfdH8LjOWLE21zWND3nJAFTMuuaut/
 WJDDGpKhBAAMtKdDyNo1Dxvmapogm7E/B+GFVi2lNQrqU8VNXZV1DS2OvS73HD4OMZKKeAQAA
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
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078967; l=3130;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=nC6j/UBzkg1YNyck8xT90UzhtDTGOguWkcxnNWp6ewY=;
 b=Xd0CsYpg8UgAyqxe9Jj2R9X0n/yVlm2cjTXkC+S6JwzzYyLfg+OKDfCYkcYmJXxCov/MqfH1s
 4xGu8GXMqtcB5dWVc3F+dYIMLIAocYY9x73zft0MScc3fVy8y0jdJhS
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: 5DP4lWrYrqJ4kDlfv0vBFwwYGeQkgZEK
X-Authority-Analysis: v=2.4 cv=N7ck1m9B c=1 sm=1 tr=0 ts=697200c0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ld4WfEqAmRoefWT_AfQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 5DP4lWrYrqJ4kDlfv0vBFwwYGeQkgZEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX2/dV/bVGA3DW
 ehX6Y0WXcTI8FNA0OtHsZj10dEfNmfcps4d2EDGTJNVr2Km1uUc98isajyZ29w0cbPFmHnp/DWg
 SP7MvkwG2+i9o1kowdkPYXeHAsM+3gNHNnyorMalrcj7BHMa3L2yXnkEE1yR2jhKToqpLlOa6XO
 qZiary8gaPz8fiJtWydLFaMXnwzQKeQ8qKY1rg2+rULEOkaptqfFrEHmPMtc/QpE0vnYmIhrnuA
 GM/KDBkP1vlT+fIYraQnQCKl0gGyK9MdjI8okZAzwTOSlsGyjK5LC/6yNxMze+v15Hn545cnCY/
 1YtLLQqONSYjnGBTRysGNVbKywSNcO4JyOsU/e1qcIaFtdR0WphhSncPVv9YfnPq/+VxUpmHcF3
 APlK6bZZkujTpxdnta4wkpFJwpST9xWtC4qrZUvcE5UMfCe/WMf+A4mmdY4Yt3Fg9gqxNXIYsYb
 v54lpxjTSPNb9skDScg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220077

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
https://lore.kernel.org/lkml/20260114100043.1310164-1-tessolveupstream@gmail.com/

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
      arm64: dts: qcom: talos: Add camss node
      dt-bindings: i2c: qcom-cci: Document sm6150 compatible
      arm64: dts: qcom: talos: Add CCI definitions
      arm64: dts: qcom: talos: Add camera MCLK pinctrl
      arm64: dts: qcom: talos-evk-camera: Add DT overlay

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 arch/arm64/boot/dts/qcom/Makefile                  |   3 +
 .../boot/dts/qcom/talos-evk-camera-imx577.dtso     |  63 +++++
 arch/arm64/boot/dts/qcom/talos.dtsi                | 279 +++++++++++++++++++++
 4 files changed, 347 insertions(+)
---
base-commit: c8a4a774a9b0d2c86593492625874e27e9cbc9a9
change-id: 20251222-sm6150_evk-8ebed9e9f3bc
prerequisite-message-id:20260114100043.1310164-1-tessolveupstream@gmail.com
prerequisite-patch-id: 065fda916d7faca61113e1230fcc0ce3916442fe
prerequisite-patch-id: eddd1b1714715707d386608e4f9b24396f51cd44
prerequisite-patch-id: ae777d7e17e32afc36fd1f741bb57ff0d3556841

Best regards,
-- 
Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

