Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB643F4A0
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110033; cv=none; b=igOwHyFdalrYIK6jWpe7WYMH6mC3IVW/vxmVZRD9I1v+5rnVktAlQ9S3RrwE9LdwzChzQ5/blpUkig1kb80kFPl/jm3NxN4JIpkch1v0uzp+iGMUm76U1TmcUFHDkbfvDPVEHcRNafoncvPUxFoqZ5BbEedlRHVMBxQlmjl5Zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110033; c=relaxed/simple;
	bh=ylkjx/zKj9feNOcLIH+wx13fieHyCJOIYgit6seCmw4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tnDEW2b1L2nP6XfoPyBVBi5Drc9kSJKMiSCPCmPe2Fkr2O1Q9lSdZ3tDyhPR1lm7udjrZul7jyhHX0GxVOGoj0ACjObLNoR20mFsa7v1eAhPNSaG9Kk+6e6Cgzr8JLxTsmj/UbihalhHvYTVIdLugdC/XHypZpQO5XoFb98c+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GjSpZDbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VGxGLASU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GjSpZDbn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VGxGLASU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B6kJbd2695747
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ot0o1fL3FlIljmyMpGi3Yg
	ySihAQwuGmlbW1iDnqSlA=; b=GjSpZDbnuxfZj4YnlV8VWnN5/xDr803fZPn6g5
	YiJpokORQACDmSQJYtG8fpJdl+Th93P8uHshvkoTXg8jAoqtcqpYDXHNl+/EpcPF
	SOajObKqY8qUvr9OazhuYIxwZS4qPpvhO+vzd51dcJtMvLS0sHJowWT6X0DyMGyt
	NCWSvu+GY8szkMJ8L4JCMVB5P7/XAjB416IEZgs4lBl4rrpmURopjpT2umk57hLK
	DEWCZxtPR3Gn4blCSAOMct2lzAX0b6+Pv/7u/ph24OMWGE4SkWUqkpq5FcLgcjpt
	9BSfa25H5YdsO4q/3VrvKjDtU2Y/HrhzmflGDMgde2jTAYaA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfg38r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso2083678a91.0
        for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789110008; x=1789714808; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ot0o1fL3FlIljmyMpGi3YgySihAQwuGmlbW1iDnqSlA=;
        b=VGxGLASUqlboHIgHTBtQGMfAIxy6gWraBKc4ydL86vS38+beIspYbJ3rb7fHyO+E5z
         KF5Itt9Y8QyhXhEIJ3c8Zos38atPpFa+eEe4dyeg4ZI1n1zIaY+qEOLvo2qedXjqDk5U
         bvS/Yufavbt3AXRu0bBZPbkbI2GRMCxgiK/NiG1r/uzzv9eSY5lU39ojfwAvDv04BzO/
         7wt6QUC/fqdTvCA8mCQH7r33kzbdJyH8Ob8WoUFOiTrQYsfGxkOterVo6sb0kbBUafMh
         nW7ry0h/g0t966ufUlHMzhj7S2pnfeQZksaG/0SUO/SoRc4yXVGSU6P1ShlvzPRSEFrr
         656Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110008; x=1789714808;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ot0o1fL3FlIljmyMpGi3YgySihAQwuGmlbW1iDnqSlA=;
        b=SoJrbtKEkyL3fIIjJHpz11eQQVZ7JI9rXsrhkBHxomEMgmU4SFZixLgiZHdc9+ZHvg
         bj0VgG2rmoZBlbBacRiwRZHbTU4wrU1YOp2cfQRbFZo2Hb/eoCZpksYKHGAlnIp0N6Hr
         IKEd/cnCd/JQvjN4ftxdqvMxaRihXaK1w8fI2TjVKpWsup+sbZoWuEBzv+CpWRhNcDys
         A8mjLYMVJaXC5uDlHgrklOdV+Gl06f1HlevH/1QV3mo7vTXmRU+UGU0isCj5W23nl5Hx
         /2/O3esBs0812a1zp25J1/3RK6VL3lJltZXhdLPZy4IT+cGo8AlT7WvVCmVpb/iVP+vH
         Z9UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRQmtgnG8T6k0xVvRCIlpCpldvy1eNDo9MC27AR0OXWyH9pCbdLDA6HJV4AU99svx6+qgpRDkFt54=@vger.kernel.org
X-Gm-Message-State: AFuF++kcG4KYAe7Vg5d51/bZ8AJMXR6C8kdnKc5oA0nefRP5x8RMvyuy
	+g/XVtqfWWGbxOEPDqGrqtu3LWwBaHaiO/YZvmTSfUyFYq4KKSWPaTaZUNDlz4PDPNEw43oTLCq
	2H/U+RbMwvLBNz/rke3fu4QKDYqyrArD2mEPc5sRXdc87tuZdF0TLSkQOlDSDMLKpiekg8oo=
X-Gm-Gg: AYBFou0wOHGatw0it8NvYrV8DsBT9WYUWjm6Q3N6TKwsbavyJv5utFy/+yunIIkbPn4
	LL3xfb67MZpsDMTDdYwg7nYfWRpWBrZPMwzBSKb+26a1pK45RnDpYmd12WCSrLrZzrpYhWE23Ck
	diCmFPpp5l7gw84YFiUTVjTuTfHJXRGBFTBf11NhWFPvuv90DHnH/BT9MlrB/3gDogS4ichWvHp
	f7/JBQxbslYbUWyR5AoYVs/QJJviJTeX8ySquPaWeyrttbjf1r3HRYD0RiM4clRRRhXVp3EeMwR
	UV+dTdjdylMkNAnCg4KUznoYV1ePw/rZ8MOAqNNDG9jM5GZ3x6o9w7fwcy+dLPWMf+LO7l44U8Q
	1aAWue+uh9T3r6QDvKiFGnTjKlRsmAZKUnr4=
X-Received: by 2002:a17:90b:4ec7:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39d77b770ccmr11682967a91.23.1789110007737;
        Fri, 11 Sep 2026 00:00:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec7:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39d77b770ccmr11682908a91.23.1789110007177;
        Fri, 11 Sep 2026 00:00:07 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm3799532eec.13.2026.09.11.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:00:06 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v9 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
Date: Fri, 11 Sep 2026 12:29:50 +0530
Message-Id: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOamo2oC/22NwQ7CIBAFf6XhLA2loYAn/8N4oBQsxoqyLdE0/
 XehjcaDl00meTM7IzDBGUD7YkbBRAfO3xLIXYF0r25ng12XGFFCG8KrBg8KRhOw5Z1iXHNGpUJ
 pfA/GuucaOp42hqm9GD1mOy96B6MPr/VT5Hm3RUVVf6KRY4JrK0lFtJWUyoMHKB+Tumo/DGU6K
 Lej+LEp/9oi2Uw2rRaVZinwx16W5Q0R/ebS8wAAAA==
X-Change-ID: 20260716-master-f7da57c7529a
To: Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        naresh.maramaina@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110003; l=4088;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=ylkjx/zKj9feNOcLIH+wx13fieHyCJOIYgit6seCmw4=;
 b=cNYpkOrAYObvZYLEbWVlwSo4eX+zpxX1cRCnXHr/rRAqg1EF1iiv3OYF1Jzy1a1XAx7yIQnvr
 N+M5USBmP/KBZjTZ1xoXqkYB2eemF4AiOiN8DQtodT3I7wGQCIqD1ub
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfXzbMvU43772ub
 ydcSXTmeyKF8hILy56bAVHoTzwV5ipZ3U/hcjCb/WRgHJbp5FW6K+a5atUOlPe7p+WoblLSuy+X
 kFL//o4sUWZnv3aHEWnlQRd/odDATotYCs3SkexZ5NpSDzNxNPtaINenO6znBfulqyfvpXHW+mI
 m7Kiwrsa7169qov3p84Fd82bnx386LonokH5wcZOOFtx57UGE+2sTWhzIAsFXoNv0E7pxd7AOlB
 pdwqoWMxy4VF+tUlaEi6T0ng5uX8/zVRwAcaHDC0Tk7hRQVAqUHO4oE6mPp2FdIv70t7jbvw8cu
 2L3pTDREkqGmWBMzcgNyLo9nWmYTkhHWFxq0ZfLHTomaaIoF7INyF/fEcYMYN2dXpzMg1IK13hR
 BjCMo1OH2cZ1BS5lfVkRL1JvPmrC6Q7CzadX5TMEJ3XfvuH99yz3ZQ8X//IK8jGTfYzvUOERojJ
 EQsvbMhFlVWsk9Wz6fQ==
X-Proofpoint-GUID: XgjBgJUfBLLhRYkuWDKYrUIW1xdizoRv
X-Proofpoint-ORIG-GUID: XgjBgJUfBLLhRYkuWDKYrUIW1xdizoRv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfX390SI6iYtd18
 jVuqjSB8pPEJDyGlCqZp4j22ewibMAvrpazK6f93o0qtznTEkzu2o35wTjPaPU9jNTcdfPhUd9b
 4N0xRVp3wo1xkjKBoJAVhyo0CVedS54=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa3a6fd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JvO64EORAAAA:8
 a=ernR5N_utsnnydoaGBgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110095

The I2C core and many controller drivers currently rely on a fixed
timeout value that does not account for transfer characteristics such as
message length or bus frequency. This can make the timeout unnecessarily
large for short transfers, while longer transfers at lower bus
frequencies may require a timeout that better matches the expected
transfer duration.

Introduce a generic helper API in the I2C core to calculate a
transfer-specific timeout from the expected wire time of a transaction.
Store the computed value in adap->timeout so that both the I2C core retry
logic and controller drivers use a timeout value that reflects the
current transfer.

Keep timeout policy decisions within individual controller drivers. Let
drivers provide their own safety margins and minimum timeout floors, and
avoid exposing those driver-specific policy values as part of the
generic API.

Convert the Qualcomm GENI I2C driver to use the helper while preserving
its existing timeout policy. Preserve the static timeout behaviour when
CONFIG_I2C_DYNAMIC_TIMEOUT is disabled, and let a userspace-configured
I2C_TIMEOUT value take precedence over the computed timeout.

Suggested-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
Changes in v9:
- Add '---' demarcation before revision history in the cover letter
- Link to v8: https://patch.msgid.link/20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com

Changes in v8:
- Compute GPI multi-descriptor timeout using the total length of all
  messages in the batch, since completion is reported only after the
  entire batch finishes.
- Guard against zero bus frequency in i2c_update_timeout() with
  WARN_ON_ONCE() and retain the existing timeout as a safe fallback.
- Link to v7: https://patch.msgid.link/20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com

Changes in v7:
- Add CONFIG_I2C_DYNAMIC_TIMEOUT to gate i2c_update_timeout(); no-op
  stub when config is disabled preserving existing static behaviour
- Store userspace I2C_TIMEOUT ioctl value in a new adap->user_timeout
  field; userspace-configured timeout always takes precedence over the
  kernel-computed value
- Fix geni_i2c_gpi_multi_xfer_timeout_handler() parameter type u32 ->
  unsigned long to match wait_for_completion_timeout() expectation

Changes in v6:
- Split into two patches: core helper + driver consumer
- Moved timeout calculation to i2c-core as i2c_update_timeout(), which
  writes directly into adap->timeout so all consumers of that field
  (including the __i2c_transfer() retry loop) benefit automatically
- Driver supplies safety coefficient and minimum floor as parameters,
  keeping I2C_TIMEOUT_SAFETY_COEFFICIENT and I2C_TIMEOUT_MIN_USEC
  internal to i2c-qcom-geni.c
- Compute timeout once per batch in geni_i2c_xfer() using max message
  length, all internal wait sites read adap->timeout directly

Link: https://lore.kernel.org/r/20260715101805.3615166-1-aniket.randive@oss.qualcomm.com

To: Andi Shyti <andi.shyti@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: naresh.maramaina@oss.qualcomm.com
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

---
Aniket Randive (2):
      i2c: core: Add i2c_update_timeout() helper for dynamic transfer timeouts
      i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency

 drivers/i2c/Kconfig                | 13 +++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c | 48 +++++++++++++++++++++++++++++++-------
 drivers/i2c/i2c-core-base.c        | 43 ++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c              |  3 +++
 include/linux/i2c.h                | 13 +++++++++++
 5 files changed, 111 insertions(+), 9 deletions(-)
---
base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
change-id: 20260716-master-f7da57c7529a

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

