Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C22727E2
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507563; cv=none; b=bPQZlh7Ks5DQje1/XweHbEsm9BBPC04vaV/4V85gB0VwZTkoU9XCjswcbmw2Vh+bsMZLaTOBmvBFGdKkuQsXtdSNE06BYaCbMiBaJJkojWlO03ctzgw67f+Qec2Mgb6p03MClN2ah9ux2Oe+xwOD6i4HOqsTV17gZTJY3gjeljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507563; c=relaxed/simple;
	bh=IrUmHrBRqkDfW33Cxo+N1eCKaHZXw08FALCQEegKAw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NZEdU3SDQ7VTAIXkXsVzznrLj2PsJTkqzq+VFPgNilFVIPftsqGYwaqoNiiQLBiWd2CcUJl1hjJTSiTq6ajDdid6La+XFAEtCkKvymmctNg0UQ7fsMV2n7Yfg2IdN7vhm+VVpFWlt+rZCNO6ZUkzijbqcqSxDVJURNvwmviTQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HilPuDdj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d3psCNYF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HilPuDdj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3psCNYF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L5tt3828339
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dtGXzzXGIJJhIcmQFrksFN
	DykhrwB6PnwdRQr25l7qQ=; b=HilPuDdjj1OrO7g0mjHnpbyEO5NhUCALWWYlay
	z2EfX4OUpyHYV5uniyt0sftardFLDEzGdVRVdYO8/Mvmanlieech+tHwPXgux86c
	oXmols6D1QEkrsjt3mILjv4mAOHaypCdZ8hui5RI0dEA1DbCNOb0YCkX59J0Itrl
	CWymD6TLVDKy8iHeiU7n4baJ279u2g/3JiC1AHkwLLYInyOWYFg5tOvsdPfZ3q2m
	l1GjNz/mDH4/qq7lrmnFcsg95C0OzrsKu/ZznV2WqXbLJrMRFontLYqeWfgq/6a6
	bA40L/WSTQyCy/T2MsqyY2Ttp+IH8OKwAQIpG85JUf5E85iQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u64bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so2312482a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781507559; x=1782112359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtGXzzXGIJJhIcmQFrksFNDykhrwB6PnwdRQr25l7qQ=;
        b=d3psCNYFnA6R8HB0ocLSwRzJ/zM9xCH4v8JukI+pkNx0yFkcCynsQSZPvpqwBcAyWK
         CUR+i6RuSiopr2d7Wv1+Vc7kRhLNMFCo3k/h+PAh7StVR3TmdUbcb+Ls0HSeeWUXTIAH
         GATlQCHiajCGjXaUJQPIfFlZbXUOHn5tqvvAM1XBgPLq8FIt9g7sltMLIyk7gm0yZw2Q
         4QeUj5jrku51aaGXPyyE2joJHLSN4GKvSZl3Ftl7+AF4HOBrmxQOJyxJqe8s8cbfnk40
         u13J+hR+ExfRepa30R4U01VMevYDkxvOd+Y+PiwL7uZ7GF2dvpOzxvIm6s491RT1m/tF
         ZdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507559; x=1782112359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtGXzzXGIJJhIcmQFrksFNDykhrwB6PnwdRQr25l7qQ=;
        b=L5U8542M3yL8zSr8Q4iQus9xmerB9V1x5WCfZHMasIwxqSKyLCqOylN+Rz2CaNInfg
         1jb+BnbS9hgj+M/WiLWOdFFnXyfWOOb3FZrTyXdkS9yeHeTrtp0V6iluaOtuoAKsR/uD
         ZrdhHa4rfof5MEhCnwe+Owe6pQx1ddPk91+VjfC2ozlluz+vQtAJm9zayZ0MESkqB6Qd
         SnT3IV20JOvpiQh8lGL7hGccgJPRtLCl95ETCtUlYEufcQZ0ZzP1N6zGbPwKLDLqfuC5
         cYUtAGE17IMdvAa9TGgiSAbW67wmNna/nr74iWPlQFdWZnqdCERfjlpV/tKDsAEJ6zkQ
         07Fw==
X-Forwarded-Encrypted: i=1; AFNElJ8PdPCk95d0yA/D9H3dgndoM/1xmV3gls1q13IM9s36HI9TY3BOuE0i6IQ5OrLPYGgRIxvGZoTe7tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPhW9fJZ8sH8olBKW8C86r/vnUfRd7qVgaxADVHhjXnQFJsMn
	dXkcMaPZMR5VYQa9w6hSARElkVgFZ15ix1eidcmqg1c5uRAN9/4KgFOEFue13Z+4DYHEV03Wspd
	60qj+jJNq0sI07NEdJXI9r6BEZyH5gPHhycASnHjeDDGA27Pg6BQjqzZYzIzek7M=
X-Gm-Gg: Acq92OG2qoDsgxPMtT+J8Cbsb1b3n1DksJCLgBrcgqijndLkjDu1mPkIJK4+7aPMtcg
	x5z5udjWwq/Ex+R8z3tCmBgcU3IlrITTymMZNh6A9JluIyWEfEk9npLg75WBa56o+uFmPHSXDLo
	zbdxxphW2CLEYaQ19NzpTYbUhVXe+oDbl3QgFNinzpjIYWhVFJgwg9LKrr3TVxzCuwdsxjTYs+D
	PTfyYgOefSIsanLY5pQkQFsOqSikenx1VQ8LpKRufEjz89pFWV/FAbTfa0J7dW+uKTPt6q1w+Jo
	3F2EdZCiuSMQZENy1Y8UwrwaR+75y0TCXdTL9GccI3Ru73MCRF2Oh77FGQSVZ6PnxWLkEbUDEwp
	wDRFgAj+K1xzl396gv8xGRPyw5bAx8SC4PHnEobyWgpbNovJmiFA9
X-Received: by 2002:a17:90b:4c4e:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-37c2bc4375emr9441055a91.5.1781507559261;
        Mon, 15 Jun 2026 00:12:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-37c2bc4375emr9441017a91.5.1781507558739;
        Mon, 15 Jun 2026 00:12:38 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm14867474a91.16.2026.06.15.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:12:38 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH v3 0/6] Add CAMSS and IMX577 sensor support for Shikra EVK
Date: Mon, 15 Jun 2026 12:42:11 +0530
Message-Id: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMylL2oC/32QwW7DIBBEf8XiXCKDYR37lP+IeoAFYpQ4jsGhr
 SL/e7GtqFUV9bLSrDRvdvZBog3eRtIWDxJs8tEP1yyqt4Jgp64nS73JmvCSQyk50Nj5c1AUVR8
 jXRz2g6IDB6BQAmiSnbdgnf9cqcf3TQc73jN82pZEq2gpDn3vp7ZQ2oJk+6pGXZHfwW2xxTL2j
 DUTNbU0TS2kAAFtEq8MgjdPwwmRhlufJ17OkfKyEdY45ypdtkmS5brOx2kIX+sLElvP+7dtYrS
 kIKThuMdaqvowTn433tVlKbTLY8Um/oOCcv8axTMKFWsq0I5x1hyGGP+g5nn+Bq8WycmmAQAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781507551; l=5077;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=IrUmHrBRqkDfW33Cxo+N1eCKaHZXw08FALCQEegKAw0=;
 b=O2ujAcCjZj9ALcD348LR57pwCkphyltvWZ7PmPcj9JVeMHfVleiQlVTybdHNUzV1YbtmkVsUL
 ChzDQDRdqhuAEV5NYwSccyP97VC6uUYFT0mklWthkVRE+isLKDZYBFt
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fa5e8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SCY8RljC4g58VSpTV0sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: GrHRYc6UnJdofHQSEx9W2otoavUX88FJ
X-Proofpoint-ORIG-GUID: GrHRYc6UnJdofHQSEx9W2otoavUX88FJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfXyeiPsPLH/I2N
 dy5BXmH6fVHXNLMK490aXANhKYcltSAlBVEQWIgVFRwmRH/1mZpdEUwxWBXLmOUFH3hrFVG5CVl
 oIh0uIJKKwp507fx94yOd7ru2qPgPIq68YBYQ2Ts/Xo5ORQMRn0MryAJgRQW0Fso8h+hlU6iwAW
 6ZaFInRau/66zD72llvllV7PRJtCqpgQZwD5gMIymPPj6a49dMR68S/9vA7VXH1RaT0AsarQ++J
 PhWkAQYGCEJHE/vTtb7jCNgho+3zLLbshNzq52FZvIWozEBCqFJ+mCHLSbthBdof4Aarn7KC8Aj
 5diNzLM4P/hlyuYYQy7NjAKEe/65JySmWsq3th3u8dhVNqRtY7hKz7ccImf6XnNfVxqTvYiBD5b
 TaJCtQzye01XIQhp61CYZTuZd0KwRxMCEvCZdGpHV+aqidh9f6+Eh35NgUcpBdEh+PEiiccqbyD
 R1iz1hkgavgZZoxUauw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfXwyjW87k3wWQf
 0104fpVHYO2OtP3N6g6sXeQmwHX5EZ05/xY8DvT+M0tSZVinhzUIvgDmzSl2Pk9OauvSM2DXINc
 7NQAWKK4ud8pnIaBGyoxeJbK4XpEQFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150073

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

The Shikra CAMSS binding patch does not depend on the rest of the series
and can go through the media tree on its own.

This patch series depends on patch series:
https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
https://lore.kernel.org/all/20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com/

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
Changes in v3:
- Drop dt-bindings: i2c: qcom-cci: Document Shikra compatible; already
  picked by Andi Shyti into her i2c tree (now in linux-next as e3a8f8329397)
- Preserve blank line after compatible const in qcom,qcm2290-camss.yaml (Krzysztof)
- Add blank line between iommus and power-domains in CAMSS node (Vladimir)
- Fix data-lanes numbering to start from 1 in all endpoints (Vladimir)
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
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260526-shikra-camss-review-cf6f66ac566b
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v4
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: 2acc300a68ed8c5364fb5f2f7d28fc0d56ab07bf
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0:v5
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

