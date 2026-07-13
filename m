Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3C3DD500
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934929; cv=none; b=mT3l/MwYtu9gWXHrtvJ5F9CDjH1QC8Z8vv/S8GB67m8wQ+T7R723RiFjpAfcbsM2rBppdSG7SrMMzKohQgEVj47yupDZO6Kqwnxo9uLk+dVVDEH9WfYbPZpHK02Chs2A6mxCrHxbL5DCwgX3lgfeY6TX6wtuFf6U1yi9pMcxwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934929; c=relaxed/simple;
	bh=PuN8ENYNOK4zFEX7iR5tP4Qc4qPqD1yrqd+US3xeGx0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bxGw95ceeXJ4dq4pUhTTR6w0FdnSjnp/JTshaZI4G0XXS8xw2F4T5Cuya6ij9DC21VhdG2sp810sKO+wrqeTD4Om7OOMjUOfIEho/1/GDj8Pkp+0FOYguEVqq4kQWUHwltbSbntdzKzDGViXeqPiDa7mBvNvOXGF75ZoMFpcc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+ZsdQW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtVC9AWO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+ZsdQW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtVC9AWO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NiK9507140
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q0wnSw6IM70ZatIRQ0h/nF
	SD5yzhjm8eQKBwsFtZV7A=; b=d+ZsdQW+UAY71hYNVEJ643lTUkZjPviGbuF5op
	k0sEWRytegRpGwtK9ToTMm7Dz9hL3MCKu/ULcWKIAjCI6Nak9Fke9FpxK05xy7Op
	12SUOXu2GO2cYp4hlF90R2u2/z16pC8CPZzUjo95r8sG30urqX3iijmeWSZX8T7D
	KeN9lL2hSHgaFifpHC2o3b6TJuCiLFA0dvsP11Yb6Yj0qiRxC2i079ldTVBZUnoP
	alKO6zA21PiXRhWpO/HGC48Ym+fqE6bjiW1Mql6Gs4Q2IpgIFjf+jYDTgDtIF9jH
	3fg1gm7d3v5/q7IqAouL/d4iDlH8rix+HL7R15/Kd7S6lBhg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8gu51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:28:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2273043b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934926; x=1784539726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q0wnSw6IM70ZatIRQ0h/nFSD5yzhjm8eQKBwsFtZV7A=;
        b=UtVC9AWOjCmKwTp5BLPPuMzLGvHQXJ6dkzfvQltuumVZVWL8DRJmDd/9DdYSwAotUx
         FZHf6JeOiBOP+sFuBLj4zqGSYrC1YtYk/LIpysput+N/Yfg6u6vbbdXNnXT7/YqSZT/w
         oRYMzm+36cmsLdtYrYTJntliHO20IyOnnZO+4vyfU9IVvS3YK+T4i1fzs9PO94zsekG2
         PVoIYE5sIi0sbx6fJApUyuYAIl9C9WdxzDh0R382LFC8ZfUfFRmrja91g3Dbf4rbMMMj
         H4GX5hs/lLGL9a8EOgqBn02p8vA2QhxhY+MNj9lntxui7Vcq20jA78k8kPNiUK9kt7Kg
         oUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934926; x=1784539726;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q0wnSw6IM70ZatIRQ0h/nFSD5yzhjm8eQKBwsFtZV7A=;
        b=DeGrCfVbsI6m/QaTGB8BAr+hrYak+1rnH2PJuTGRdZlJPv7UKtpweBQjM9N0NmqQY/
         uaEapckArF8TPu1raA7eKeUzdNoOkB5KJqj1bgy3P05rchpNKILmvpTL5R49jAQd+gkJ
         RL6aljsFa92o8K4JEuPotwXlfMg/CzyhJDhqADfLvuKsjUoH8dBMvTD7rvzdcJUEXy0h
         1kpqOfrp9LBErNLsuYrk80ZE5RywTzS01D4jmLBno4fw1Nu4XoR12oE0yPqnykrZ/ZVO
         Ed+WuUpZlTR20z1Y0btWoZt43NKIna0l8Na68ZYPjvkKQueIxkJtQWZdL+/jCt7JPgvb
         eVAg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2XbQcTsM6iauyY90KnUPJiawuvmFOLsZWDwEfoh2PhwliMgcFDZ8K3gb6TLQay07+GsQMOUNtVH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIg4MCrW/0035lwOWrsCOcCatA40MDjiX6ErTGvobflDK81TlF
	Xz94Co5pqpp2gVc+Dj/kVcyUsbZRHmOKzu0Kl6NYOqq3dVbSzniwYOWOZ9wH05JfklboIedxKxt
	3eV30U7EIMOCjf+bhSG9ULUxbImriYty3IyVYz07B0CMU+Qkt8BGggCfbzp4VpUY=
X-Gm-Gg: AfdE7cmksywN1JK15R0JODzKRKzO289ytj5sbK7iq9bIs/fHbXomIQdnlduMSKuSLX+
	cOR5O59JE3UO9JPSo7YOfkzlipy1+0/8yJyCBMIXF/VwEMy6H5egAwO1daomqu5vZTlLECvGU29
	kjMVsGg8b3kp3GhG1usKzpPn8t5Si64k/5yTv6FF+xHJDBbMupl+wI07/VotpkZxlmodAqzAPgi
	a5vATQON4ShygFbIaQgvJL8fmgnTsfFcnF3P4LcYtZB1tp1eyFVxfUfZ0YAnDp1AnzF805RopSK
	3YFOu9CyU8M6t2mHDlNt9y4029j2tak/lhstyJ7fbnvkeygdrz1hYj6/+SxnUntu1ilm+RA1jy8
	6uadMuaf5ArLj59u1Fh/haEMwUClPJOL0SHX2DErXXA==
X-Received: by 2002:a05:6a21:648e:b0:3bf:80c9:6b3e with SMTP id adf61e73a8af0-3c1109f717cmr8402587637.30.1783934925920;
        Mon, 13 Jul 2026 02:28:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:648e:b0:3bf:80c9:6b3e with SMTP id adf61e73a8af0-3c1109f717cmr8402553637.30.1783934925471;
        Mon, 13 Jul 2026 02:28:45 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm47495569eec.24.2026.07.13.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:28:45 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH v5 0/6] Add CAMSS and IMX577 sensor support for Shikra EVK
Date: Mon, 13 Jul 2026 14:58:31 +0530
Message-Id: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCvVGoC/43OTW7DIBAF4KtYrEvE8DMmWeUeVReAoUat4xoct
 1Xkuwc7i3ThRN2M9Ea8b7iQ7FP0mRyqC0l+ijn2pxLUS0Vca07vnsamZMIZR6Y40tzGj2SoM13
 OdGn4b+oCBkTjFKIlpfmVfIg/q/r6dsvJD+eCj7clsSZ76vqui+Ohst7XKBoVhASyvG9jHvv0u
 35qgrXw9P4ElFGUquFOu1qZ+jiMcTeczedyYlfGyk78TiHT2xQvlDOwF2gDcNgf+5w3KPGHArV
 NiUJp0EJqCFI37AEl/0HJQllnFTANtVB2g5rn+QrMUnlzzgEAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783934917; l=4511;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=PuN8ENYNOK4zFEX7iR5tP4Qc4qPqD1yrqd+US3xeGx0=;
 b=EKIr3fC4K4hhA9EAn48PYmRKnOCL56cBopti13qR6AQU4CmzUuuVy6UWePcII27pGzhDh20fI
 UycOoqoIeOICfIByBVGqXJqdTH1mDw6i/FM7OrwttkHWBF5eRfn2avS
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: 2Udw9vGkNNW1xTEui4bvkkKxJccar52X
X-Proofpoint-ORIG-GUID: 2Udw9vGkNNW1xTEui4bvkkKxJccar52X
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54afce cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SCY8RljC4g58VSpTV0sA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX6n6jK9fIgXyF
 hgadA7bBqAkBQCpXvUciW2lssj77IQzqCEM+IMS2AVxH5y3tKo2ZBvBdzfnCdJDyiRP2pg9uSj3
 zpltQQxbvOCkQIYjE0DpB7NlVAwj5TU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX/hiXUEF0H/al
 QGjUx307ttE8+f9BGD2V1a1d4AzbpaJQCuqBCv93Hgo3sNXI8i3TJ32k4hLjdpnLVyuZBReCbhV
 olI8Fe3IfLSf7zHpfuXCdTglqtoNe2Hc8AtZ0azpXlZrgkQDKlNyXiGqcCm6aKDXZpBDG12LGFW
 sSqvxzqCZr/JxkXXOwxB2xmoW5Q8N9KUF6X6s0QmX5jx++ufGPgOm9tHQR7R8Ud+L+xdBxrAu2C
 ahfwonN42a+OpqMmRNBYpfenyDiEBbqJoicNyCOE6xqnQbBJfAkOqxA3nRELO6YSobFk8UGd/To
 WX0CXXmXJnkPFQrClwIFthTsyGYNXfuBOpNhgourLshi1jrqFRj6ZDz/k3VzfyfiQg9BvEiymqL
 QnXpGGRCDqyAVv4TUD7V3yc9PhqXIm1a4QfcZxGVmKBPV8acHEKaUAjk4pTiT52rb4Fy9nQ9soj
 9KVtErzJDRjp/m9y/Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130098

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
Nihal Kumar Gupta (6):
      dt-bindings: media: qcom: Add Shikra CAMSS compatible
      arm64: dts: qcom: shikra: Add CAMSS node
      arm64: dts: qcom: shikra: Add CCI definitions
      arm64: dts: qcom: shikra: Add pin configuration for mclks
      arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera: Add DT overlay
      arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add DT overlay

 .../bindings/media/qcom,qcm2290-camss.yaml         |  15 +-
 arch/arm64/boot/dts/qcom/Makefile                  |   8 +
 .../dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso |  79 ++++++++
 .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     |  79 ++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 198 +++++++++++++++++++++
 5 files changed, 377 insertions(+), 2 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260526-shikra-camss-review-cf6f66ac566b

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

