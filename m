Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8142FCDB
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905856; cv=none; b=Tr3o9RPoJXuYVdj0ks/wjwrvADg/tZA1t66TG2EfW/ipSBvAt06hQ8x4IFh6zU3OCrpcshxOLAZRjlUp5ysfbLFKkgAEgS72c4klKQYIi1CrgUfPM4m8DMP3YGIs1YllFj2OBnpfWcssJjsx90Ov4yWjywJql97ePjfckTad9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905856; c=relaxed/simple;
	bh=Crjw5Xus5SLMGq0l5ZYMypUoC+WdhZ34e6FQZQRfNDE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+dhHmsAKLEFZFLcT8YcUOpRIXEhdSK7XAUWY7dPA61cDylc0rvf+tbQloRcERqwziuTZ0nRQ2+eOIHkuEiWo2O8YpcRDaiQAyfPgf+Ph8gWTJGhgfdLEm68eRLVSOWiXy2gln6/lcumqseeDPyetIqs9geMM8oAOL1gvgeHEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IzD0ZEBL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EAX8LmQi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzD0ZEBL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAX8LmQi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBo1L32910100
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M74F41nUUVLcgWM+QziOZU
	0aQMN5dEs3iviwpQLRSpQ=; b=IzD0ZEBLub6pOGvZLvOAH3Uzi8qTy/ADY7rjix
	zE3HO/XMP342QkPWPCCRtF/OMU6GXzsL8IyQ18aN8Hwl1twVTwCK7EPL7Gqw5gP2
	ifjhCDH2JB6ODx776PIz+iOt0efZ9bf57hpWcyIyrlOPKbB+FfY2lbb3i83vVwzJ
	+1qlerkEzg72cRIu1AKRxJVK9tIJQ+LF8HMYeQ5MvUSS1bpp32h8BLK5ChwzJzpp
	P1ud9a5bnI28weDAFAX2HN5Bkr6ffGsYyoSEzr4cU7JuzfOmOWMwUMOWyRaoSUkV
	A2FR84mirTeLcCN5Cl2Fy6UDbVtmL2fBZGSmqd/+sf1f/T2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxtynq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2935362a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789905852; x=1790510652; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M74F41nUUVLcgWM+QziOZU0aQMN5dEs3iviwpQLRSpQ=;
        b=EAX8LmQi5jIFerWBjIULpcAnPn6WXqtaPPHj18gKCu5jt5QcKk60nrLplTTh8cHK3G
         98XLSm6GWx0HANo9X/v29F94TGDp3Dd4AIuEehQPVnRsICUujg2UsSSdTz9iHENCbo5C
         lRwR3aerPFV5AHhEtIbgGyb6osEXM0pjPWD5kSO/R6EP13JB5kd/H0EWkBhgmLyMFyRz
         uAHIrphFN51EFOWQvWTCD7lHRezHCd3RL99IxfIiPdAZHcT2Dj2iuJ6wdXU28SRQXQHf
         4fu74pZcr3/1trsDd+6yuAdIYTcmWMBwC1A3Y3EpY5oy6Lk9KbLXcKEv7VJ8Lj3UVpQd
         x0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789905852; x=1790510652;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M74F41nUUVLcgWM+QziOZU0aQMN5dEs3iviwpQLRSpQ=;
        b=BvEk7HY7kYYF+3v1U60Kr80wp87QnHT3WPfFU88629Z45FuClPhSHpkY85RE6ykjUH
         uniQxpkwXWG3AIKxHqA2n4NYS+A2GdY0cjRUX74vwkBlbuSF0whxPXfXRJbV5O0q6Kk0
         L+5Odz6pU34pleJOsoqwP+KEbwuzE7q2m6lpo8bV1i8ecXe6z3u2zMBCc+r3RJNdIp5W
         qeoVR6jYMZ6dynu2EAKP64csTCt4zvay0TmbWaGP3frt4oopOPJI+jJdJWo2Sq6P4JpE
         hHY6F1wU4S2NzcCU0Pxnwt+BNKep4se1m6uLTL9WWOEfs5uTQoKY0JaWRi72UHPwghcO
         /qwg==
X-Forwarded-Encrypted: i=1; AKwUvBwXDT7+Pcv9pLLvZPICVQnKloqjHJmYp3jZMMUS2nKJHRwh1PPFmqJQTzd23UWCt7FBZgZaXEB+4yk=@vger.kernel.org
X-Gm-Message-State: AFuF++ngfHcgx2owq1KZI4XgxJietigcJDhbyEcQcFHaNcoPvncP1+AB
	0rcgLAmyLdQT0z1pJSMH6v49JRWQhOcV/AuaGMlb+Ok9kBwuhB+2YSOg2CZMujPJOXzREjdJlBR
	0GBoUssvub2jypF8ftYlDN7U2bXWNF5vIXsl770i4SlRptsTL6LTA89ivISsQunQ=
X-Gm-Gg: AYBFou13g9ebNWvxCy9tckDcYpMYMgfpaEBrOfPpaA97U2izlMww4i5LN7CKBMRUk8U
	V/SkA9zsAuuS82h+V0/dnZ5U+AVMKu7AwOwJgzFFfSICx+xKp2rVZ/gaJKW+Jdzx/t2Uxga1XpP
	M4cFtouTVtdtnUzuEV5WNJLQM7aD5yxJ16lZTK9Em998MKYm3VhFwEsosFo0JXhDZBCUwitu/f5
	dl6Aa1Qeqs6hm1eCo7Uaz3qopycYWq758ss4zdoqect4CjcSQUWwF9xhaZDW+j6hxuBpX/jDVAT
	KQbR8cCmwfPZ5G8bY5dQLeMCEeVMpRP67gmTk+saTmikf6moNjurRKf7ZgOZZfJEsrQ/iGlt9ou
	q3OsA7hIMObakagBG+qjRgojHtLdmp4sorVY=
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr6321884a91.61.1789905852338;
        Sun, 20 Sep 2026 05:04:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr6321850a91.61.1789905851867;
        Sun, 20 Sep 2026 05:04:11 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm12109622c88.3.2026.09.20.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:04:11 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add Qualcomm I2C target controller driver
Date: Sun, 20 Sep 2026 17:34:00 +0530
Message-Id: <20260920-i2c-qcom-slave-v4-0-f7e1020f3bb4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDLr2oC/3XNQQ7CIBAF0KsY1mJgoEBdeQ/jgtLBYqzVokTT9
 O5SXWhS3Uzykz/vDyRiHzCS9WIgPaYQQ3fKQS4XxDX2tEca6pwJMFBMgaEBHL24rqXxaBNSJwx
 4L9GokpP8dO7Rh/sL3O7eOd6qA7rrpEyNJsRr1z9ei4lPvb944pRRUzFbOMZ96dWmi3F1udlj7
 rSrfMi0keCjGAYzBbICWhWCc+OtLv4o4kvhYqaIrPBaaAkItpb6hzKO4xNKrU9oUQEAAA==
X-Change-ID: 20260628-i2c-qcom-slave-c382ff4e8691
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905847; l=4250;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Crjw5Xus5SLMGq0l5ZYMypUoC+WdhZ34e6FQZQRfNDE=;
 b=hh4+H/8b2G+O2FYQrwIFVrrQpRwHQvMn12cpYGj/QmVkdBhr5Ufvwsv17P6C9MlKdu0BSWxD4
 GQjikHnGGkoBMdSv8NpiOMMBfJbxBaWxU1Ike/uLl7AzVZV+Y730cFg
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6aafcbbd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=PrR1u7VjwFllBhuBL-YA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfXz3YTxSYoIJnZ
 vakjMEQQHzwOMSLvc9jKSAyrwGbb7bzTEXpHohFgLE0WalObZKPNFiznaHqua5zEIlj+JaNCyfS
 dzVvAKrApgCZHLPYA5YY0xdSDNVo9XY=
X-Proofpoint-GUID: XNiC46D7hnx1yEIWoUYrWrEr3qe2Icpi
X-Proofpoint-ORIG-GUID: XNiC46D7hnx1yEIWoUYrWrEr3qe2Icpi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfX6DM7HHLjV4aF
 ux0wDIFg0nNr+C7b0YNHGcuqrddxLsWOnMb67x2QPPtVMw0vZcy0j7bH3EgysWeOJhN9emXtb5S
 OjUFCUtMDjE28dJDdfdaBoi1Gn/ZGt682nF9OdvdVukGZJz/X5s+ZLvOFvc2G5PCHflNJzB8ZIb
 yx8GlJPyCBhD0BiRRrx6BmHNv2JDELXpHOztzAL2L1E236wpH+OnqoxP8uuehRPGPq/JPQNS7if
 50JLZUJskS3tcGyzDdvW9Lidqgt8QLqfyp7V1rOpjIdK2QfOBTajK7faxAjdr16Iu7LE+SgnprX
 JcM4gsBoZB9ZPVKbqiae0sx9WM8itCqFBeWFXELgfY6soLGHUKWaiZ3LF2DEPrHBBEKsGSXxt+R
 lBXsHmZ/ftu8nRGVmN1JTZMZtpxhLD9+gVMNOprqA18vreDdDSBgHm65vmu5QsvDGghCL61xWZ2
 2Ko0lZGUc+eNZoO0BUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200175

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
Changes in v4:
- Replaced usleep_range() with udelay(20) in the reset path, since
  reset is invoked from the hardirq error handler.
- Avoided releasing clock stretch on RESTART_DETECTED when STRCH_RD is
  co-asserted; TX FIFO is now loaded before ACK_RESUME is written.
- Added cleanup for both clocks on all probe failures after they are
  enabled.
- Explicitly freed the IRQ before clock teardown in remove(), preventing
  IRQ-handler register accesses after clocks are disabled.
- Replaced noirq PM callbacks with regular system suspend/resume callbacks
  and quiesced the IRQ while clocks are disabled.
- Link to v3: https://patch.msgid.link/20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com

Changes in v3:
- Rename file to match compatible (qcom,qdu1000-i2c-target.yaml)
- Remove interconnect-names property
- Remove allOf reference to i2c-controller.yaml
- Remove #address-cells and #size-cells from example
- Add minItems: 1 to pinctrl-names
- Move I2C_S_CORE_EN out of hw_init; enable core only in reg_slave
  and hw_reset
- Add usleep_range(10, 20) after SW_RESET before reconfiguring hardware 
- Fix RESTART_DETECTED dispatch order; handle before STRCH_RD and
  Rx data phases
- Use test_and_set_bit in write_requested and handle_strch_rd
- Loop drain_rx_fifo until FIFO is empty to close post-STOP data race
- Disable core before clearing slave pointer in unreg_slave
- Clear target->status on resume
- Switch from devm_clk_get_enabled to devm_clk_get with manual
  clk_prepare_enable
- Remove unbalanced disable_irq from remove
- Update struct kdoc to note I2C_LOCK_ROOT_ADAPTER serialises
  reg/unreg_target
- Link to v2: https://patch.msgid.link/20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com

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

 .../bindings/i2c/qcom,qdu1000-i2c-target.yaml      |  75 +++
 MAINTAINERS                                        |   9 +
 drivers/i2c/busses/Kconfig                         |  15 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-qcom-target.c               | 628 +++++++++++++++++++++
 5 files changed, 728 insertions(+)
---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260628-i2c-qcom-slave-c382ff4e8691

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

