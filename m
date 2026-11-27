Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779853;
	b=IQLofCdYjQ2OjHCxWVfh9bs5GdRxzggeao/QLXKtf2Vb1ACyc3+jATCC+35Ok2lS78bw
	 X2qx358uaE+7g0TAgws685gcZVtxawq0Qku/v5CyUy815wpNpt7AFI6+35kCtn4zMafHL
	 0Ek9ClhqCMMZO7Qm2CRGK+Up9ggl+3vonXBaIN+6a96NHZabp9A1lRG/Y3Wq41qeI9G3B
	 p673jVjhdb+ouzwGAEZA+AABwumWBr7GuqM6whGQPSR7PT0lcQqs3DkUvW8M9SRHO9x6V
	 olv2+Tvyu5/fPlqxo28viL53U4bzY5xISZPxLFWxnfiCaUxzoE1gHSnk9lpQuISJJpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779853;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GrrAfIHYgJUF0D4AiV8HW7HVoHwZ6VNKntL3Dly9tL4=;
	b=mXn+hYNSiX9Aj3yTgQmAmbWZnO3YAupAR/R/qOECETTOXZXpn96ehMXrT/6axQBCsVjK
	 OLZEsdJd55ZOp/LfM42l6sIeCNVdevlAC8xvPpcIOgr/7krrHgAh25Mo/GM42P5Hp9eph
	 zJ0zdRwq7PDHhwJ9Ob8ks98Khl1CKN4a91mnPpwYxZfNcwjG9tJSG6HdnEIJ/sZKnHPYy
	 g1AXllDSvXeZWPh4vwR5WVLXX3u60N5smkqNaLiScxMl7ibBnlbJ3FD49yleD/tnpiBtq
	 XQPUc2597AmwuyVK5NndXjSfco9Kdt1zwV73p+b2mCVDUtHvVXkP0mgoLYJBcCM5ViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ogUmm2X5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=brwVbV0o;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4C606A323
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB4C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ogUmm2X5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=brwVbV0o
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApdQu052835
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GrrAfIHYgJUF0D4AiV8HW7
	HVoHwZ6VNKntL3Dly9tL4=; b=ogUmm2X5ySEL/FSVPUOCvU22fg1p0LaYRyc2jF
	79QJurlRiv1dzjlj8zJxj5C077PUf0KxfKFumpyiJh36lz3jqa+rILxoilfPVk4A
	flPij4KmpyAKFI8k/TC7NJ8daX4XL9V7Lw5DvWaqYmL524YFlP92TQGA/AOqTycF
	I3oa/R79QzZMcascDw1WZruwTc9xRmraXLh3NfU4VdcseYGXUL2svvEX8/UtIqQQ
	641gWZg3KD6mJPt6hHoxfmxk1qHdbgCd3QrVRbFlP26yFD0UtPdVWxREIwbXq52z
	RcPwr6cuSzoHhFHtlYe7kmS1no7En+0MTw1xPnavsRkiBhDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6s8jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb8931aeeaso3691620a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779851; x=1796384651; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GrrAfIHYgJUF0D4AiV8HW7HVoHwZ6VNKntL3Dly9tL4=;
        b=brwVbV0oDBw+fARYdOYlHSOAwBahU+jgcjthOjKl/3hp2/AJQX3rMV3t6Ms2Iue8Vn
         mPl1jiQfp5K6ZhTKSD/33J5ThVqsf63dThIFuq2O2mQJxX4UJGAPJDBADIqlyW6fEM5o
         AtSZYnV4iKlYD5Um8Bbww0s4EyDUuIpTUTxW0ri3IezVBwELJ6eX8p83yb2BAqLqeGHN
         fsCZb7HwDV/vI4Iau5eIwkwB2dBQgC8Sp2mIMeWeSMxPdu2QmFrkbE8U/pfGcpgotQzu
         0Lj1RRstvOoFexPt77EBiymKQzZX4xFH7phToaDKl5Jbb/J31bPq+ErluijvHVVx1OrB
         4Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779851; x=1796384651;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GrrAfIHYgJUF0D4AiV8HW7HVoHwZ6VNKntL3Dly9tL4=;
        b=CpQcOXEF1g36cQ7Q5ornZQQw+JQRz9Dd9NpEfVW1UqPBGLH84NcxZTxCndAztwmmii
         QTO+C5D3FIU52+fgtrJ/KxpSeeKMHsbnHt7bbpVKjDNBMvAuG/DkyGjTCSksOqIOrx/m
         qTQxjHZDF/yjt1M+vgh4O0iXKh77J8h4eNmIJwM6v86m5R+EIIMNGg7CGA+fm3yieUxC
         FbnMx/ix50ETpbs2yUWmhDKKSqd2FnLBufUsSEJRt/0ro1mn1E76Jjapbn7vEDLhqEo8
         9vAb/ZI8U3ilQyi78ZLf9qaiL9mLkcDjH/+9hWqWBoWmtovS/uH7Jz7oe//Mh6vi2qFC
         SsVg==
X-Forwarded-Encrypted: i=1; AL+hErGvQ5f2Kiw0ghTdz0jah2k3V2eARPWUQTo0T4JbG7v58Uzl64S5Jt0x10o08bzVFPYCCKGijZQ4dww=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jC4nfKBN2glZ11vTwlLm2lZxcDcAh5RzEKCEjMbhm0pbbSdUs
	0fcYdV0XhUSbVxTKpjTJrywrl2o2DjOivpg93Cam2rs6stn6cUgf2SwVsszvc3bODlazYLI3zBG
	kV13H9AZ7hMV8l5Wr4bIBjYppEgHiz6dSwMD6pDIZjaDiNg0T8z9AbnuPQtoVLJvRj68YVhY=
X-Gm-Gg: AZFdTZfFyBtBDPIPzC4v8CK2z4u+2ll36jRPWZhAS2jSDVugZ4ly576COLmIiCWNfcV
	e+FwdbmSdaJ8y8QSv5nMpVN1Cxu3Lfj+PkMNHI23Qn4Lt3rjp3kRVTiDjhj2Y1Z4aSXYN/7h8V0
	n4RgOg5gIUzDPG1B8P9D8x71jMTUHtvPTjVYh4m7OgIKkHgLBXAZA3JLRDOE4SU1WAPy5GX5LTY
	E8Igpg6hwiLChmxK2q5KoIkWoyOUAFiVZJJ78fHk8KK85TgHkaQaXliNKTlahzHhHMi8IHqlTa/
	VyCB1Nlo2DhzQSzAsvFx2UmcA5u/N9PyxKKTLwEGJf29RN5lRlWph/ZbK/MhgIkGDD2TswVfZPT
	8BZNreP+wRraPUapGIriM4alH6r3noGvIso2cEFaBuSBYTWyFTajYLF3Qq1/76QW58Ww6wu/ow5
	Lb24yI
X-Received: by 2002:a17:90b:4a48:b0:3b1:2d60:66cc with SMTP id 98e67ed59e1d1-3b41c7b56bemr21726934a91.8.1795779850220;
        Fri, 27 Nov 2026 03:44:10 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3b1:2d60:66cc with SMTP id 98e67ed59e1d1-3b41c7b56bemr21726893a91.8.1795779849640;
        Fri, 27 Nov 2026 03:44:09 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm40480933a91.16.2026.11.27.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:44:09 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH v6 0/3] Add Qualcomm Hawi I2C CCI and Hawi/Maili CSI-2 PHY
 support
Date: Fri, 27 Nov 2026 17:14:00 +0530
Message-Id: <20261127-hawi-maili-camss-v6-0-0f4844eb63b3@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABtCWsC/33RwW7DIAwG4FepOI8KDIRkp73H1AMYsyA1zQptu
 qnKu49209ZDsoul35I/H/4rK5QTFfa8ubJMUyppPNTQPG0Y9u7wRjyFmhkIaEQHivfukvjg0j5
 xdEMp3JuAWjkhKACrZ++ZYvq4k6+7mvtUTmP+vH+Y5G37DzZJLjh67zWQUZriy1jK9nh2exyHY
 VsHu5kT/DpSyCUHqhOxUwAQXNvhiqMeHCUWHFWdzmrw6FqkCCuO/nOkaBYcXZ1goEXrbGe9XnH
 MgwNmwTHVkbpV3samDUgLzvxdQqbjudZ5+mlinr8AydxFxOwBAAA=
X-Change-ID: 20260923-hawi-maili-camss-b5dc43a00ed2
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795779843; l=5448;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=yP0v7eupkcwkB0CGdGIJuJoQQiR5R20IpoAUfDVaZzE=;
 b=T83UCr3n9oR1diPm41eqpqbPuLB9cGAnt/l7KPdMWf/R6xkc+WsAiN8l8PtQhNptgpracncRj
 0VUmb3KWCruC6XnN4uNfuKpjyW5k33spdqOK8UPWGKBndSFDfgIMN1Q
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: r5QwLVeEzCGxPY83yxPGU4I6UHrykn2l
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b096d0b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MdiNbCTM_Z-SUpbbCTEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXy2gbrlSNL7Zw
 sTxt76JTXbmqD7pD2fo4ixOgbJ0pIqjj8zO95X63DAzRH8eRA1909OgyJKFXlqdBme5Hd1+SuJL
 ovQZ6PW8c6JBf8XHSBnnH2WHas9zwD0=
X-Proofpoint-GUID: r5QwLVeEzCGxPY83yxPGU4I6UHrykn2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX4O1qGc/phcQx
 fYqYo6kyLqrO/6T58I++A4hHQCNzgBsB0/W5ba02oxCpuaLpTbghLXtvFcV6cegSuaL/T0mQN5Y
 YQh8gOV7ryHfO/V2yMm6GMBYM0s3OjX4saGbMbH6s+/ze9CUgrc1ZEpSEYgWNoTKztEcMPjLhLm
 sPb/XilvWHAPH0be7ou7HZM/+pTzVG370OJZT+Nhx4wBfyOzQ1vwJZD9ZWlk2HoyT2pni3nFpis
 Gzm3d6IGtFbnGmAe9qe+4TXHrCzFSySGpICTxUmrHA7fWHkrwKGRy4SAxDInpa2zaIKz3IowOhy
 9Z/IFML47P3NnsjqdoXvZwzuREEuQAvs7rP3lK1JEHO4fvYtd26vK7rvyt5fCTtz+VNOvhHFsO1
 Im7md5yEbK8uGdwCwV/PHSLiRLwvjQJVk65qFN86CNGzS+uWW4uS6k8KjSMyxKVwgfvERrYEly0
 wqzM+5Qd99Waniid3Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Hawi and Maili are recently announced Qualcomm Snapdragon SoCs [1].
This series adds the I2C CCI binding for Qualcomm Hawi and CSI-2 PHY
support for Qualcomm Hawi and Maili.

This is a continuation of the previous combined CAMSS series, now split by
subsystem. This series carries only the I2C CCI binding and CSI-2 PHY
patches, which do not depend on the Kaanapali/KNP CAMSS media patches.

The CAMSS/media patches from the previous series will be posted separately
against the media tree where the required KNP CAMSS prerequisites are present.

[1] https://www.qualcomm.com/smartphones/products/8-series/snapdragon-8-elite-gen-6-mobile-platform

Used following tools for the sanity check of these changes.
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=phy/qcom,x1e80100-csi2-phy.yaml dt_binding_check

Patch grouping
------------
I2C CCI bindings part for maintainer Loic/Andi (1):
[1] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible

PHY driver part for maintainer Vinod Koul (2):
[2] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles
[3] phy: qcom-mipi-csi2: Add Hawi support

CAMSS changes will be posted separately because they depend on Kaanapali
media patches.

---
Changes in v6:
- Renamed Hawi lane register table to lane_regs_hawi_dphy - Konrad
- Link to v5: https://lore.kernel.org/r/20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com

Changes in v5:
- Fix correct patch history in commits - Krzysztof
- Rebased on next-20261124
- Split the I2C/PHY patches out from the CAMSS/media patches.
- Drop the Kaanapali CAMSS media dependency for this I2C/PHY series.
- No functional changes in the I2C/PHY patches since v4.
- Collected Wolfram Sang RB
- CAMSS changes will be posted separately because they depend on Kaanapali
  media patches.
- Link to v4: https://lore.kernel.org/r/20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com

Changes in v4:
- Rebase on next-20261104
- Collected Krzysztof, Loic RB's tags
- Added Loic patch to Scale the CSID clocks with the CSI-2 link rate
- Use 8775p TPG resources instead of x1e resources
- Align tpgX and csiphy_rx clock names with the 8775p platform - Vladimir
- Remove redundant CSIPHY resource definitions by introducing
  compatible-specific code and keeping .csiphy_num instead in the
  resource list to denotes the CSIPHY number - Vladimir
- Example Address should match your first reg addr in Hawi bindings - Loic
- Link to v3: https://lore.kernel.org/r/20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com

Changes in v3:
- Rebase on next-20261029
- Squash Hawi and Maili CAMSS binding as a whole - Krzysztof
- Add description for IFE and IFE_LITE IOMMU in CAMSS binding - bod
- Correct the lane count variable fallback path - Sashiko
- Add CAMSS top region to binding and DT - Loic
- Use split addr_update/reg_update in CSID and VFE 1190 - Loic/bod
- Add SOF and EOF enable bits with top level RDI status offset to
  allow their corresponding interrupts but not configured on - bod
- Move the common CPAS/GCC AHB and AXI clocks to the pm_clks array
  drop them from the VFE clock lists - Loic
- Use the GPIO function with bias disabled for CCI sleep states - Loic
- Collect RBs from Loic, Krzysztof and bod
- Link to v2: https://lore.kernel.org/r/20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com

Changes in v2:
- Not an RFC anymore
- Rebase on next-20261012 and drop the external CSI2 PHY series dependency. 
- Drop DTS patches; they will be posted separately with Maili DTS dependency.
- Collect Reviewed-by from Konrad, Abel, Bryan
- Split CSID and VFE 1190 into individual files rather than in separate
  combined Gen4 files - bod
- Remove reduandant is_lite condition in CAMSS CSID and VFE resources - bod
- Replace bias-pull-up and bias-pull-down with bias-disable for the
  SCL/SDA pins of CCI nodes in TLMM, as internal weak pull is inproper
  with existing board level pull up resistors - Loic
- Drop the unused reg_update_after_csid_config flag
- Add lane count fallback path for CSID RX configuration
- Add Hawi DPHY support by tuning register table, which prevents
  potential stream stalls and SMMU faults.
- Add a standalone Hawi CSI2 PHY compatible and make Maili fall back to it.
- Resolve conflicts introduced by Glymur in CSI2 PHY binding.
- Link to v1: https://lore.kernel.org/r/20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

---
Hangxiang Ma (2):
      dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
      phy: qcom-mipi-csi2: Add Hawi support

Nihal Kumar Gupta (1):
      dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/phy/qcom,x1e80100-csi2-phy.yaml       |   5 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c | 135 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     |   1 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          |   1 +
 5 files changed, 144 insertions(+)
---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20260923-hawi-maili-camss-b5dc43a00ed2

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

