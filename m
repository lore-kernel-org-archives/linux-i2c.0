Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BF493643
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161375; cv=none; b=ovYDVsoAklEQW+7HfX+ZjN6pUZE93CdVOmiwQBXlXyI5d+5q3ZByYMjh0ysN56S6We8atyxErGEsNF2VnQBcuP/S6/wW8h7/4PfBZmSpraykQHPYBujS5roWPBVRW3R+iIoMBtY4WRnJsnQdY+autcrLg/UGqZrWCqK4LPgqC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161375; c=relaxed/simple;
	bh=Q2YLPUSRi1FMgeSQZaI3+vZ2bOUy2qKeiy1uQmOl4Fc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hCUy+tqvD8gg6jUEHCan98JloF4ccTfHdgnuVwcfNX3FLXU5jvyLXCKcG6KrYVP0atqXz7KTAqFY6O41K3MiI7pwFG7DmX4qrfTUrLnCMkNK5/9ZZnc9LKPdthytAmPDLk/05YVu1nkklPP0D2QOlM2s7o37pSXGFO/kB9xi3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RVgGdHS0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0S2hG8z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVgGdHS0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0S2hG8z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA3hUg1623776
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4zDC52bRM9681hQxHZpw6K
	B9r8MvxloFdAbrtwYj+4M=; b=RVgGdHS0wPBmLfu9uVRE7JaHsT4fdVklYsmM+c
	1yoOJA272FkIXnNOVWWkAsnjewGw5zOtD09EVVCNNb6NxKu5CE5aI6NJgpfVSwem
	bToK67fRvc7rn/XgR2YSpSDT1tjlOKWsjUNmlVYpMWHTcmXVYSiRPj+BaRhI5pH+
	srAoaiB9ALMwzsQZUiW19WfO48rObk0Ty8/70wnKg3En79DvxZv2j6tqauxR3oGX
	O8cZczQDDP2EQgANJ57zPoOt5DSq2TMLgVqJlGYNT5rfH9bZomjtSmKV2/mKF7qm
	CHTCRfq/kK6zpSYg3YkExxwiR76cLfGqJbFTm5Yh9Lk1Wr/g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma3hd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:02:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-333543ac378so922425eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161368; x=1790766168; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4zDC52bRM9681hQxHZpw6KB9r8MvxloFdAbrtwYj+4M=;
        b=g0S2hG8ztqlgi5v/E5Geq/nXtVSXCMDixFNwFWu5xXXOWEQnHdf63ekrwpPe2aF+/S
         /TVZ21FnA8Zm6Rt9Vex5X9tnrMW4aO4ggvSbvaFEtuIV8PYrXuITYLur63XwcKgzXuua
         5OoLLkR9TNRPqGyiIWu8khfYU30xeiPuMBtZRlxTo8xpqFNL6JV3RfHG62caVWIQfpL6
         HI8FunSK0NUKzYYC//zcLjSIDNQ90qMf5EotJPLpPOaOHKcn7pG1ERttqcdEl0ixnYRt
         WMvlVZMhljhWoSSU2GW2n6VgV9RSapkcrbgydwv/A723i6LEeAm0E8zjhsmni5p4cXRU
         WdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161368; x=1790766168;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4zDC52bRM9681hQxHZpw6KB9r8MvxloFdAbrtwYj+4M=;
        b=TIhn8rrVPxffdEsoX5c8r3RGksa0MJpQxyVI/VA6SXtWQno7bsHaq+aDSW2SFaRdsc
         wYVLC0qHOjhLqi1WNeFeQD7D+z4J3QFpPP4HG9zSA3ELpuhEIfCGRbSEzODiQORxod6W
         DLLNvdolAAnhQb5PYrr3n06YtsILaeK7m7ukdnQHZ/9IiylgSGPxgEpGb/ae994UPrgL
         nuo8JwPLDEBtEG99LSj2TVSsmRXTYdMNwenLGdJ9/X2TN7A/H4KVobJheCjRWSrpJRLG
         rrm6PvAtTy/J7BLt45Iva8nULrSgtu98LtO5xtrZ1QDg+1LNC9NNhURw7uyhGdG44rrP
         xgHA==
X-Forwarded-Encrypted: i=1; AKwUvBwGXTerecuQirCiXUMssL0+xPiZpuUHGgfHddGMPcMil7NgsFQU42wLe+8hAJCjGZ5hzw9BlU1lX44=@vger.kernel.org
X-Gm-Message-State: AFuF++nZGMUoZT1SJi4aaaKQW/TMriXidUgcN9/RvIpbyITA8FXbTiY7
	9Iiil+HOM7sS9oypmDTahFU2xcG8m4aY8nFBJ669cR7Sl02iltoXeKbNw4vXy6/hbJ2rNDqIO7a
	aNAKsUMJmwkHGJZAayh8DOhqnky30sqh1R/zM2ktyRjZ3UJo1B1c7t1c9jEhxpkk=
X-Gm-Gg: AYBFou21s8W3IVaKQZ6F4Tec6/+ldmY5xSIXZpoki7XHI+/50MTKjciyfEVe6sIVmTJ
	35B8G+Enf4erFNMhOudQqLgAYvNoA855iYHJHQzPtaowS+MyJe/5jvs2cQlbO4NAGGZHxfoQ562
	5fbAColvB0RHjBQcrY/SLnfz8trt1h/zEV/tX2XF5wZNyIh5pFLJwqhIsZvSG8EN9XEzpZCE748
	e85G1OQndobXhtJwqoJgtzL1rtVwMfWY2hWHQklztEVoQGdeuk3G7D09uTpP3A7d4c5bu46m8mI
	n/lXvcpehqQ8kNUu30z+VRg84HqTLUe73+LwGcccqYh5hhHdlbZGLAUNUMlRYqxEJhUSGCscaHi
	09HCBzd70cNlYY0Sbm/ya2FPgkDFN50iU+ZE2Nq2K
X-Received: by 2002:a05:7300:e31c:b0:339:79c9:a711 with SMTP id 5a478bee46e88-33e8e1b7258mr2578309eec.33.1790161367699;
        Wed, 23 Sep 2026 04:02:47 -0700 (PDT)
X-Received: by 2002:a05:7300:e31c:b0:339:79c9:a711 with SMTP id 5a478bee46e88-33e8e1b7258mr2578269eec.33.1790161366945;
        Wed, 23 Sep 2026 04:02:46 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:02:42 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH RFC 00/15] Add CAMSS and S5KJN5 sensor support for Qualcomm
 Hawi and Maili
Date: Wed, 23 Sep 2026 16:32:31 +0530
Message-Id: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMexs2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNj3YzE8kzd3MTMnEzd5MTc4mLdJNOUZBPjRAOD1BQjJaC2gqLUtMw
 KsJHRSkFuzkqxtbUA591w9mcAAAA=
X-Change-ID: 20260923-hawi-maili-camss-b5dc43a00ed2
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=4947;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=Q2YLPUSRi1FMgeSQZaI3+vZ2bOUy2qKeiy1uQmOl4Fc=;
 b=WEI+GPot5SCnpANnfESBpz78wtFsNjpe0gNz7CznPtMEk+qVsfd5nc3VwttCkFg/R/uMmz1+g
 6lBrCGwa92fA2YwprsBRADySgLC/nMMERVTSHNRdUd8EG0Rou8jESSy
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: OAklaOI6M4CmH9mwXVgsu_JPP-K7ZqvU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX2aQi2OUiL0X9
 puqjYqcmKpBO8KRjovbmxkZsnlFwWBQT6nVoVFaKMFmwv95hqUcG3Dh273Q0o/5Kp8/HMZcIlYc
 t3t8y2eIinjn/FHvlemxUGLkhh7VZEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX3mI2rSRbgJ6V
 A7s9V8aQbHIXf7AiQPR1Pjm+7clW5u7nmavbiMJLoB0C3PE1sNt5OoPipytOiwDCfYnBYkp/9bi
 QuPqHQP63BwdaIdRZlc+4afje/AX8Q6/eQVTNb0CMIA6oMRdKuMNnJbviyyPqIJTwwp4Jo5xMI8
 kt8dpXGwUbxveOOauBgdRBhzix5WERPqMzQSSCNXk+yhjMWOtb4CCquRGLBZXPTa8XF9HuCQOHH
 XrRJ9hAZtS/mqEre1CpWyosmotioOHgIrsESaVZOQKkDMtcCeN8UD0QxAnDJlUMZMLSfs0beOka
 nXclw2p6SmsIHhkQ8kQXT78gppZw2l6Vjfh1sfNjofg0vJrZhG3Qy/sDCOXWCxqIsAEu/ZjG+T9
 KaX75xwmH53XRznsFRcqIrcRc3zM8yYhWfslN16Pu54SswXmkPapQ0mh50zB03MPYLVVObABvpR
 ID/1j1pxTjWgiycJa2A==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab3b1d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ETi28isEjJcgAAb20b0A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OAklaOI6M4CmH9mwXVgsu_JPP-K7ZqvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230043

Hawi and Maili are recently announced Qualcomm Snapdragon SoCs [1].
This series adds CAMSS, CSIPHY and Samsung S5KJN5 rear camera sensor
support for the Hawi and Maili MTP reference boards.

On Hawi MTP the sensor is wired through CCI, requiring three CCI
controller nodes to be added alongside the CAMSS and CSIPHY nodes.
On Maili MTP the sensor uses QUP I2C in its default configuration
and requires no additional rework.

Tested on Hawi MTP and Maili MTP using the S5KJN5 sensor with the
following pipeline setup:

- media-ctl --reset
- media-ctl -d /dev/media0 -V '"s5kjn5 0-0010":0[fmt:SGBRG10/4096x3072 field:none]'
- media-ctl -d /dev/media0 -V '"msm_csiphy2":0[fmt:SGBRG10/4096x3072]'
- media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -d /dev/media0 -l '"msm_csiphy2":1->"msm_csid0":0[1]'
- media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4096x3072 -F /dev/video0

Also tested on Hawi and Maili using libcamera:
- cam -c 1 --capture=10 --file

Sanity checks:
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=media/i2c/samsung,s5kjn5.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=media/qcom,hawi-camss.yaml dt_binding_check
- make CHECK_DTBS=y W=1 qcom/maili-mtp.dtb
- make CHECK_DTBS=1 W=1 qcom/hawi-mtp.dtb
- make CHECK_DTBS=y W=1 dtbs

Sent as RFC because the following dependencies have not yet been merged.
Each is actively being followed up on. This series will be reposted as
a regular patch series once all dependencies land.

- Series is based on next-20260916

Dependencies
------------
[2] https://lore.kernel.org/all/20260917-x1e-csi2-phy-v18-0-6515b5255fa9@linaro.org/
[3] https://lore.kernel.org/all/20260915-kaanapali-camss-v16-0-c9f3f6f4180c@oss.qualcomm.com
[4] https://lore.kernel.org/all/20260914-sk5jn5-v4-0-386e84cfb2b3@oss.qualcomm.com
[5] https://lore.kernel.org/all/20260916-maili_camcc-v2-0-f30b394bfd50@oss.qualcomm.com -- Maili CAMCC
[6]  https://lore.kernel.org/all/20260915-camcc-hawi-v3-0-5b57f45477f1@oss.qualcomm.com -- Hawi CAMCC

DTS dependencies
[7] https://lore.kernel.org/all/20260923-hawi-dt-post-v1-0-e41473b6298b@oss.qualcomm.com -- Hawi Base DTS
[8] https://lore.kernel.org/all/20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcomm.com -- Maili Base DTS

Functional dependencies:
[8] https://lore.kernel.org/all/20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v18-0-f85c9103177e@linaro.org/

[1] https://www.qualcomm.com/smartphones/products/8-series/snapdragon-8-elite-gen-6-mobile-platform

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
Hangxiang Ma (8):
      dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
      dt-bindings: media: Add CAMSS device for Hawi
      media: qcom: camss: Add Hawi compatible camss driver
      media: qcom: camss: vfe: Add support for VFE 1190
      arm64: dts: qcom: hawi: Add CAMSS and CSIPHY nodes for Hawi
      arm64: dts: qcom: hawi: Add CCI definitions for Hawi
      arm64: dts: qcom: hawi: Add camera MCLK pinctrl for Hawi
      arm64: dts: qcom: hawi-mtp: Enable camera subsystem for Hawi MTP

Nihal Kumar Gupta (6):
      dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles
      dt-bindings: media: Add CAMSS device for Maili
      arm64: dts: qcom: maili: Add CAMSS and CSIPHY nodes for Maili
      arm64: dts: qcom: maili: Add camera MCLK pinctrl for Maili
      arm64: dts: qcom: maili-mtp: Enable S5KJN5 camera for Maili MTP
      arm64: defconfig: Enable S5KJN5 camera sensor for Qualcomm boards

Taniya Das (1):
      arm64: dts: qcom: maili: Add support for cambistmclkcc and camcc

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../devicetree/bindings/media/qcom,hawi-camss.yaml | 310 +++++++++
 .../bindings/phy/qcom,x1e80100-csi2-phy.yaml       |  12 +-
 arch/arm64/boot/dts/qcom/hawi-mtp.dts              |  62 ++
 arch/arm64/boot/dts/qcom/hawi.dtsi                 | 713 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/maili-mtp.dts             |  64 ++
 arch/arm64/boot/dts/qcom/maili.dtsi                | 497 ++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-gen4.c |  49 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss.c          | 259 ++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 12 files changed, 1952 insertions(+), 20 deletions(-)
---
base-commit: 6f4f19def65d7c6cac6fa0b420bb34f1173afa83
change-id: 20260923-hawi-maili-camss-b5dc43a00ed2

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

