Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9E3B52EE
	for <linux-i2c@vger.kernel.org>; Sun,  2 Aug 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676427; cv=none; b=Vn1xrvixg1oB79uN9Xa0Ie7Io91oXLtJre9mYmbgszWecJJc7mna47UwOMid0O2h7aEjXVH6NfcwXvmwd/J6zSLPlbpky4EEHFhyt5DQKdz/DIHE7HsaRK4rNoqjWEYkH5yCGxMo8QcF79h5xFz9BruW3uwA3op8l9+I4FEOxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676427; c=relaxed/simple;
	bh=3JrNJ/G0EUvTyzif/NQQUhJZcvkrXeITFTFjWrFKoLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2IEQCzOxc+z5m4lWS/jWalOTEZfuXJp/Bckmah/sela8U5WFkLlHDeqAWnMHT1Kh+15diYoAd+VUDHpAGvi72z3uLVfIEpOIwmrfXmI6fidg52en37ObGh3JY9gKxzquQgpFKc231eyoqeanK8OPO1CFWshKr8ymRwMhtHYWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iSd6S0EJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlIz2cSH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSd6S0EJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlIz2cSH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672B6saq1319011
	for <linux-i2c@vger.kernel.org>; Sun, 2 Aug 2026 13:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1yLxcptYuKZkzjHyVREZqT
	cfxcanCwMU3cX59aS+gMQ=; b=iSd6S0EJmJFQkmCiK/rl0ICy2oNICxAGpHiEYj
	REM0lpao49Jop/dpAvRrBpW/A2vehDtbUAEnuBtJz/E9XAeclZWve4Y5dzV+ze6L
	bukJrHrinolFz82ki1mx6EaUMUg+yQ2xT9YxeTHtYQO7ga3Frv+OFVNrZxrKMDpt
	dtMIEoCTEXQbNxT0NWWzY+O0LWmD54gl9+3VdG4yAILIHfIdo3cEwP4zijYvTosn
	ae28l4s9uj90lDHNz7Pk0lsHYes/norz37A/LBcTzusSP1K+gKbbWNfsOXvml7Lu
	JsQmsdrqxldSos4xTlhKXz/J/nIv9UxB23iiUIaS4yGxtPsw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs966atkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 13:13:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1306923a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785676423; x=1786281223; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1yLxcptYuKZkzjHyVREZqTcfxcanCwMU3cX59aS+gMQ=;
        b=DlIz2cSHbFm+dEErHbmwSoMpUgVQalf8FKgaYd5hcyF71LYojVx5G67EmdZ2vTEWp6
         7g7rGVYd0yFhsDDZpRo/agwXI5kNvgUDkH8odbgvoCby3lBHDv0Zu8wFE7qGA2k0QV3Z
         BjSxNi6Ydg2XXjuqn+BXXQHsd03u1DMpT7hxPO65dQcNq8ByEMASxPMvICuJqh3N8IvA
         nLqCNipyRhvzSragMAsbdcZJ1xdM8XDTI5J8X7UcAKlEMecVNrFey7SiAGzOwEIA2kDt
         1GksX5wk3y+bobmdFU32w+UY5dFlMHWm/5+V6TwZS59VqpW6re+nOjkAI5uu8z03l6r7
         vVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785676423; x=1786281223;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1yLxcptYuKZkzjHyVREZqTcfxcanCwMU3cX59aS+gMQ=;
        b=fd1fKQXrgfiRKA+yg1ovQCeg4Ri+KL5yzgRw/I0p6Hshu1v2ykeI5GNg656OKuZr6N
         dApAxbX54RFrGnKJUQ6j2iVTn75ccai1nowlU9u5wm6dAqWVzsEMoLlZMl/2emxlSd3L
         Y9lgmMh/H+bSnco5ajZojJx3wa+yluYAlvA+QeXE8fcOjgErcuZo9jXhVUZWU7T0XFbn
         /pvg6yNl9RGqsYJHKZowcifd8CY+FUR/X20y/iG+GkJFAd55SkB1SykfjXtlsXRRlS8Z
         zLbCPYqfou+AxFbtMf4bf2ihQX/tMeano+duXKpsn54EdfS12n7cimxEB9PK+s/Ykh1p
         tSAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8KEEVqp3iHYAklptVtcXUkcxX+MLYRwIqPVRBPqn/953oJCoQSh+mtUBvRJ/xSF+JMEUBKe+WpME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq07Kx7eZzycDOK0C0UiJflhPUPkeLMNgeOoNcc/yDPc68/THg
	Ky2AVo2oPqVP91wIHNwowfnWdt7lGPCOj/RQ6MLd1VIYFqQ6DPnIeGcCtcpe9pjjGHjulEp3Q2G
	wPDw9oe7cdhhrn9771TyRBLDEWXP7axkblpUfxFBDo26UmaIk1Xi4vUWmzqOG4po=
X-Gm-Gg: AR+sD12b5IT9ICQtbGkJWklVVyrx3zCGEFCfI9xJkU6kpIWInAwYP8oQvkzMtrTChb/
	I+867h6N27GaXe34nNkMjw868eLS5rGfRBDRi5pPPrzD0JhpUAa/WKr8eRq9l9+xYauhxaMBUv6
	6AC0KNQGfPg3kD1xyy5ioR3xXjWC/0m0PihDmGmOIKFp/Xa9oUp4HbsXmxfEgbdWpJBswnpx2L6
	XB4Jnh+L54qpkz08OBg7+XU2G7+BW8PK5Z+/EZfqQb0fQd3P7CDk+drO/CWjbvD4LDJ0ORsd4WA
	qZerPlgo8GYKpGgajalRAMAnFZ3HEeJR6dMvMuPy7PmU4KmMBYo+I0TSyYdNnUf/Z0VatD0efB5
	rvsvJhummKrp8O+LnxyUhQp9xPe4Xw4P/lz+x
X-Received: by 2002:a05:6a20:7f8a:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3c92a598347mr6484779637.6.1785676423433;
        Sun, 02 Aug 2026 06:13:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f8a:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3c92a598347mr6484755637.6.1785676423000;
        Sun, 02 Aug 2026 06:13:43 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f8dbsm28303457eec.22.2026.08.02.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:13:42 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add Qualcomm I2C target controller driver
Date: Sun, 02 Aug 2026 18:43:29 +0530
Message-Id: <20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlCb2oC/3WNQQ6CMBBFr0K6tqSt2hRX3sOwKHUqY4BKBxoN4
 e4WXLuZ5CXvv1kYQUQgdikWFiEhYRgyqEPBXGuHB3C8Z2ZKKC20MhyV46MLPafOJuDuaJT3JzC
 6kiyPXhE8vvfgrf4xzc0T3LRVNqNFmkL87B+T3Ly/8SS54KYR9uyE9JXX10BUjrPtstOX+bB6X
 dcvwzMwgcUAAAA=
X-Change-ID: 20260628-i2c-qcom-slave-c382ff4e8691
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785676418; l=2485;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=3JrNJ/G0EUvTyzif/NQQUhJZcvkrXeITFTFjWrFKoLU=;
 b=HRXjgE2+o3WQ0LBVclaJwXIZHF68aTYTpoLqB68q0M0U6elSBowy9CT+Z+An6X+cF/SNiBgCt
 CHCd4x4mFIgBvTjvSDcYrQnzHPRoz1eSDkE9J8Cz1enHqk9FpO3SiGk
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 4ch3hJR60WoNz60Gvq1aQbr-86A-yM2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDExNiBTYWx0ZWRfX4VYZHGBthAtj
 cEvuzXd36Dib1X2BjlVZRNM239KXDRHfTxzyZZmg25hNPJC0ESWFNHcxfR5WgesqRe8BYWIpQyg
 EHOh2ia/OztBYHc0eMPxpRPJ52++yYxclGAG/pkQIR3pV3Zakf0tve8AIrTCSDqjxlDTSJA2iQF
 FVhSZWAwlF7c3Ss2HeBWkJZoefQUwJhZ7RJLwXyksY3DyIgh7dFWD3Cqr51CeiqKz7jTU8rKSrm
 AEHJy+jeG0wtyU65bWRr5YAs5FGCw6FqUfYt4LhS6dLBDGhCPlQb4LQ0B+yBtMEUHJPbge47bZX
 l7G7HG0MdK20Yc3xTljXX7xTMPvf+iFHf7spEcQea7JcZfqnFObJ4zLv2eQMmpUDih8OY4bIF2a
 mx6ve7HQE1iTc7dlZXpdipOMwubAWzKMAhfUVoujiHsmP3fdqTcxB2S9fjCcCfRYL+/6x7aLO8z
 k0HUtzx+8gUETtSJkzw==
X-Authority-Analysis: v=2.4 cv=TpfWQjXh c=1 sm=1 tr=0 ts=6a6f4288 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=aaKBQedqJLfJNiJMrcsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 4ch3hJR60WoNz60Gvq1aQbr-86A-yM2O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDExNiBTYWx0ZWRfX8zryX10L+7fz
 I8CyX2dnEXxGUKtwZBq4GtVYJxjvZzZQOsXUxQwRA2llen9lxbkCI6Hpx9pPLw0k0Brrn3K+A3G
 DTXVr89oOEzszTg16wufQs4ErytdIaw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020116

QDU1000 and related Qualcomm SoCs include a dedicated I2C target
controller that operates exclusively in target mode and is not supported
by the existing Qualcomm I2C master controller drivers (GENI, QUP).

This series adds DT binding and driver support for this IP. The driver
uses the standard Linux I2C slave framework (reg_target/unreg_target,
i2c_slave_event) so any slave backend (e.g. slave-24c02) can be
attached via i2c_slave_register().

The series is structured as follows:

  Patch 1: DT binding document
  Patch 2: Driver implementation including Kconfig, Makefile and
           MAINTAINERS entries

The driver has been tested on QDU1000 hardware.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Rename driver and binding from "slave" to "target" terminology
- Use SoC-specific compatible string (qcom,qdu1000-i2c-target) instead of
  generic qcom,i2c-slave; add allOf/$ref to i2c-controller.yaml
- Replace SMBus layer (smbus_xfer, I2C_FUNC_SMBUS_*) with native Linux I2C
  slave framework (reg_target/unreg_target, I2C_SLAVE_* events)
- Remove qcom,slave-addr DT property; slave address taken from the
  registered i2c_client at reg_target() time
- Remove staging buffers and spinlock; bytes delivered directly to backend
  via i2c_slave_event() per STRCH_RD/RX/STOP event
- Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS; PM core quiesces IRQs at noirq stage,
  removing need for manual disable_irq/enable_irq in suspend
- Simplify clock-names (xo/ahb) and interconnect-names (i2c)
- Replace icc_enable/icc_disable with icc_set_bw() vote/unvote
- Merge MAINTAINERS entry into the dt-bindings patch
- Link to v1: https://patch.msgid.link/20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com

---
Viken Dadhaniya (2):
      dt-bindings: i2c: Add Qualcomm I2C target controller
      i2c: qcom-target: Add driver for Qualcomm I2C target controller

 .../devicetree/bindings/i2c/qcom,i2c-target.yaml   |  84 ++++
 MAINTAINERS                                        |   9 +
 drivers/i2c/busses/Kconfig                         |  15 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-qcom-target.c               | 560 +++++++++++++++++++++
 5 files changed, 669 insertions(+)
---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260628-i2c-qcom-slave-c382ff4e8691

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

