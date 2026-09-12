Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709647ECCB
	for <linux-i2c@vger.kernel.org>; Sat, 12 Sep 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218298; cv=none; b=UFSSHX1R777Jt36wEVryRJi+rH3bfkNnfws13/8lqd3dQvGbegxaiMl2tof0eedn9YAR05eOE4sjZd8E3jzofotmZsFPEPglqoR4lJrP5rIWQqqVIpAZXr2L4a9eabsCMqFy64hboDcLS/A0di8DdOg/ryY+fIRQOagRuXZgwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218298; c=relaxed/simple;
	bh=DkkEzQFnQCcvHnMLCKFA3jA92+aSOLwvVO7CiE/RI9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U83Oyme2TPKMpW+6yziiFN4EsXZ0ku9KBbosfj/0uc+Djz77IfkG4EPWqMuOzWpCs6SgNXlonFvLJOmu35ythCy95sup+xpwLsbVOgRYsHJVMq6PGthQK9IGwSrcsPDG7iFuo9bjqlivOwQZGsXnmRQ1yzXnVB7s0gPGEz8QJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EM5d+Z/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I8JX7HKd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EM5d+Z/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8JX7HKd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CBdYBi2779751
	for <linux-i2c@vger.kernel.org>; Sat, 12 Sep 2026 13:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DQkvfoLaS5EsxGhnG4IY4K
	FoplS1RraTacfV3jWzacY=; b=EM5d+Z/5bAxLv6Pf3ZqKoTC0wDDeFQH+r63XLy
	SGGUqwbkQepj/R0wv7kE1xQD7JR5iUw6X6PLai6QX9W/M44xq2sYvE6ZjjfIvLl1
	w6DAy0iXpp+/QDpTGORPD9ng1SowpeoQYpBDo78RMRuThhMVhKg3hK1iZovN3oFa
	8MlGK/DYSzNDszD1OgLQSUV6z5HVoR/LgC+0wzrTbgT9f5iyad1lcuNPT2sls0cs
	BezZxDhDdwtv2Ovx6N8TlxAuHcOK4PECNZW5HZFdnzX0zmD7pyqvFB5gHJ7DVUJw
	hJWkOWKuaZk42HQu93D1nTRK9Ok0QxJMPTzX59Z/W5pjdHbw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d8yk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 12 Sep 2026 13:04:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so3739026a91.2
        for <linux-i2c@vger.kernel.org>; Sat, 12 Sep 2026 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789218295; x=1789823095; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DQkvfoLaS5EsxGhnG4IY4KFoplS1RraTacfV3jWzacY=;
        b=I8JX7HKd0TWofsUl8+3wRkAmd9r5Q7rdxkq90rddw5Jt6nM7s5qTQhkAeTrP9GxJoP
         hEmhGreA2ACtrfksHoCrpYvWlAS+BNSMdec0a9/xGYU+hNSTZEWRfYnmmNQaMhUASWV2
         Cj1NdGskqfU3qQeEb0WG68Ynz68t+U25s0LFTB1F6yTxSewatkLNLBNqrtSumBGVu/8l
         sTINMgWvd5Rc5Md8PLHykCR6nh1T00bs8IDk/brdcEwoIAoxpvr8go5F1PFBal9mgnEj
         B6Qi3XjQ2/J7BGhskMN4BZDmfqrcrMkw5u5ZIRZkjEDfmBEc9eMtyPJvp3IIfprKEbHD
         ujJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218295; x=1789823095;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DQkvfoLaS5EsxGhnG4IY4KFoplS1RraTacfV3jWzacY=;
        b=lWt0DOOPGMzoHp54uIU+vote5ta3sAtxBUKRLM4X674MKAfrqc6UO3KhGnejpuXMuW
         uQdNwMxGUME9NsdT41dKHU2lft+EfGb5Po1zOLVLbWphGA8XqsVBEGfQD87LTzUasraj
         AYS2SDha8wyxdes3W2cRgcN6yEbj1jhLxNozdwN7XBTpBKdp9TvHo0kWTCMi0pltdZEh
         qGho0OOvmkQI/wwJYKsWCxaz5Z64Vz+2XEuuJ+1PFL6VcrBgH114xNw73AjhtZ9CYy58
         je1+cjdktofLs9/gcBM/x+N7i5PfriUtG9lRaOt54wbO5hucr+fYjt1VcBQnLXTzFWtV
         Z33A==
X-Forwarded-Encrypted: i=1; AKwUvBw/1VEb86uH31TOiF1XWyllPa6gEw2a5c63fq29RxFyx3RWa68V7xBZRUCy0A1om3ZqBHnv0xNgI0w=@vger.kernel.org
X-Gm-Message-State: AFuF++lO1sYp28kCoBBoYorTiJP4506nA+ivINsupQm/QL1ttuMAhWqt
	jwhYd2qFWXg6CyCJqFxJbclqmfDkrKmMou+ROHRpOliiiypcnx7BDLIN/nNZ6xtk6CG9aLHgbZi
	6y9XCVrNEwR9XOLB78hs26xOWXfmRcQaHwUmAqxrucPKGL9UZ7kNIR9OKJBBZAPsv39XIyFQ=
X-Gm-Gg: AYBFou2Syzo/WNucEKr+3LAd/MJ7Li1flZmdipSj/iLmcAovPzoNkXzKHuzd1rh7KnZ
	r8gtZdSmPKtHey2rb3JQDSpAwgrLAnoghYbfkR8BNnlm7C5XD8oDXJgJJaJUs56w8AW7CHc+ihS
	KeUVVzUQrJbfRB0RVDoH/sojdphTQsSaSlAJYpxE+5P7XLvKlSWbmCbFetO7zycKFHlXNQaHHgg
	q2RRMNBreN4nKQdhRsih/skn8Y6/CbeWZWb952NmjsWlcOx0DGsL0OOzz/BGH8lrNjoySpxJKqs
	mkGlwv+TBJETLXaJ/vDZPgnjoVAvebacj12TSX8BTzrCZbdjHy7ML++yr09qK7b4a4KUwCrJsB8
	lmPZw1v0e2l2uX2PDyQ50OaAVZJFG+SPUVgk=
X-Received: by 2002:a17:90b:57ce:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39d9c1dbb3emr16516952a91.12.1789218294595;
        Sat, 12 Sep 2026 06:04:54 -0700 (PDT)
X-Received: by 2002:a17:90b:57ce:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39d9c1dbb3emr16516874a91.12.1789218294184;
        Sat, 12 Sep 2026 06:04:54 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm13665036eec.22.2026.09.12.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:53 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] i2c: Add I2C High-Speed mode support for qcom-geni
Date: Sat, 12 Sep 2026 18:34:21 +0530
Message-Id: <20260912-i2c-hs-v2-0-b0901791e244@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVNpWoC/zWNQQ6CMBBFr0JmbUlboRZW3sOwwDLKGKHaAaIh3
 N2CYTPJS95/MwNjIGQokxkCTsTk+wj6kIBr6/6OgprIoKU20molSDvRssikPRmby8KaHKL8Cni
 jzxa6VH/m8fpAN6zr1WiJBx++26dJrd4ezfbopIQUtmmKDHNnlDqePXP6Huun812XxgPVsiw/W
 We8qbUAAAA=
X-Change-ID: 20260821-i2c-hs-408768509865
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789218290; l=2065;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=DkkEzQFnQCcvHnMLCKFA3jA92+aSOLwvVO7CiE/RI9M=;
 b=k4QwrthsYIV9aqQ3hDCmxAiD9GjvFuZJqZIK/piYk2VDnUseWJnUakoiuc/LRv6EUfZrhnqd+
 YhaPKFtr7x2BBg+M+BPMkDQac6yUzZURGrgbqIqA6bWrfWJFsQc2qPK
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4OSBTYWx0ZWRfX25rjB4AD3d5Z
 yae2dCozKilZBwNQdOGJlt+1HCxpn55FeismKpHpDHo5O4EYBDPf9o+Mi8oVl1L5t8w5Sgo8PYP
 RpFSNNodei4JoQQo68sXihfniAUJz7U8lrXRaqmjLvuMvHSQpvq1k0z9XOaSOE9drsSbxvvojqE
 vZPe1HCFzoqqbx6NVXZS/1/l9fzb6T8BTrOyHfWoLaUWwGFppLF47aQ3mCY6N8376rQL7pqCT13
 YNcpN5k8yygQaDjzDB4Se19+SCdu/onqPa7hEl9jYNGTACr35LHPSZoWVl4l8Z09t/9FDqMAlpm
 dXBxuAPrmZ5+09s9QJK8D2eyXXVccFEwOmTKlhSfVcmNrm6MG0U1KqlyQli4k138SVY/XaMNTYq
 b43YX+DJi9509Dd9Waf+iErgGoPkTZzuCldcTQt6KXIPIuiUQ9CyWKYBv1/uxIw19LcOTyEIQCd
 b3ew3HT4ub31zytYDIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4OSBTYWx0ZWRfX9Pp4Xsskepk9
 p8rfqkaspBAl6gB55CTpvr+/RYpYFw9hb3Z396nB+oTq2XdmUFNqR6yigzZjT++Fvhu7nrTqsTZ
 qEDMUd9He6/Z1bucwxitdLz35s3GVow=
X-Proofpoint-GUID: EnkKnDPsCU027FP-1eQhvR0r7UfJsXLu
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa54df7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0Vh9vUVPWsnviaz4y0EA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: EnkKnDPsCU027FP-1eQhvR0r7UfJsXLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120189

The GENI I2C driver currently supports Standard (100 KHz), Fast
(400 KHz), and Fast Mode Plus (1 MHz) speeds, but not High-Speed
(HS) mode (3.4 MHz).

The underlying QUP hardware supports I2C HS mode starting with QUPv3
core version 4.3, per the GENI/QUP Hardware Programming Guide. Add
driver support to enable HS-mode transfers based on that QUP core
version.

Patch 1 (dmaengine: qcom-gpi) adds a CONFIG1 TRE to convey HS-mode
timing parameters (tcycle_cnt/tlow_cnt) for GPI DMA transfers.

Patch 2 (i2c: qcom-geni) adds HS-mode support for FIFO/SE-DMA
transfers, including the required clock/timing configuration and
master-code preamble.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
Changes in v2:
- Update commit descriptions across the series.
- Refine code comments in the qcom-gpi DMA and i2c-qcom drivers based on review feedback.
- Fix issues reported by the Sashiko bot.
- Optimize geni_se_setup_m_cmd or I2C HS mode condition in I2C QCOM driver.
- Link to v1: https://lore.kernel.org/all/20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com/

To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

---
Jyothi Kumar Seerapu (2):
      dmaengine: qcom-gpi: Add I2C High-Speed mode configuration support
      i2c: qcom-geni: Add support for I2C High-Speed mode

 drivers/dma/qcom/gpi.c             |  56 ++++++++++++++--
 drivers/i2c/busses/i2c-qcom-geni.c | 127 +++++++++++++++++++++++++++++++++----
 include/linux/dma/qcom-gpi-dma.h   |  28 +++++++-
 3 files changed, 189 insertions(+), 22 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260821-i2c-hs-408768509865

Best regards,
--  
Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

