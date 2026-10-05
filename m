Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7071940B0
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218761; cv=none; b=VmZaOXiteobTd4uuU4P9FPTpwPVEbINOc1Je1GhWcO4H5CDT5aIlZzu5960QuTusm36IHNoYcP/VxN7BGQxcnSkCemWu4X33SZtJ4fRm8Ymfm7O2Y185u8OOeA9I3czA/efcb8N5I23JS6MgxU+lWaLD0tdGA4gVJwo5Bs0+6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218761; c=relaxed/simple;
	bh=Qdttc+Uull2B6NlHs+W5t+MNibElOhjui4YrHJLoqA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ej4RDFAFm9X6yZLysJQ5tCHJrHjVrIV7MMMtWfOEeMxO1VAP4yPgYJ8i2s4Hg1HFW2W2Yn2ACLGCgtY4GVyslw0kXZxliRvhs6FS57VHQi9wwDPDkVCWYfTtN3WKGxqfPjY81alYgh7vd7wF8CbrsPLgB2lCLnS4+ZMTfBCKRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXCeWGWU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cHbtUGrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXCeWGWU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cHbtUGrQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EP5t51583387
	for <linux-i2c@vger.kernel.org>; Mon, 5 Oct 2026 16:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=06UdcohYwj/NS7PUtyFuZZ
	u3m1KXSF55e9gfl1wyMec=; b=SXCeWGWUE6r4bD1/qw07uFOmXfQtmhA58cnlBG
	MXWOhCa5Ax9xh5GXi+JUqSC6kuBa4GotSB6b1c/KRkTj67ZCYx8R00Rp7HsbUUEJ
	Zfrey4sIfR9Ad49jz7bw1B4qNoI3oWiWY0fUHSca1iT52dt48VgqYyXKaT5QiN8N
	KWMkPtxMHbs0CK2OHHHANbfCUxj1cR3a9lIhOx+GkLeWrTGoEEgMD221OpIkZ/wV
	sQhFN5hYR6bAzKAR/ZbvVjahbF83SA6gsMwkgdDjrfaYxnZlbFN6lB2lgWZUr4JI
	eHgbzFgh71S/X4Z4awdMNHLiEmp8u85KvKXEyJQwZ2NfeIBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gnav33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 16:45:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f75c1219so28816525ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791218758; x=1791823558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=06UdcohYwj/NS7PUtyFuZZu3m1KXSF55e9gfl1wyMec=;
        b=cHbtUGrQjGU3B7D+9a9tAQSIqCK7ICx8WjIelf/0oz7VREtCfziUmqUinBrTkoekxB
         UVd5z0AxQ+uc+ZceQLcotKNEuD4rODIYuljZs0BgiaRt+we4fUzENWERACBNB0Ar+f46
         WDCyU00DiwxEDgY4yY3Vz5hKqyMmqPpcu+B9QhTMclqeCDWIgPUt1fw0cn46x7gkkITN
         fljg//1FSp7EOBK9Xf5ZHC2GcLzuZUyFZfHa0ErIHyex7myisusQ8Qnrk3DmZQamiuzY
         dTxiTw195bs4qs7UWKM1Zn+6CzSiCsVTKFRaC6TKS5qwqmbs1h6uAgPJRy7fnTOYzNXF
         DEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218758; x=1791823558;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=06UdcohYwj/NS7PUtyFuZZu3m1KXSF55e9gfl1wyMec=;
        b=ze3egbAzS+a71eRQaNfqXl/RGpbHo3X/GomW8IBdEjXjFBFc77aiIVyyjaiKqxYqpi
         s9ARq8PxBuNSA834rb1848hpzTuM7V9Z6A9K+JQaB6TbxD22Q9HXzeijvTuQenqW3JNS
         f13tRCfZjv2pNE8nCQcNu5XvJDtHtInQqLX/a6G1AV1sRx1AspLGUUQClXA0Z4bbzarv
         zKcslNKmq5LGhFex2C9qan1aB3v/nJqP7O9zYCDxHnqCMReNUaZZ1ygt+mIcbV3LfSCB
         Slz4PIrwI/Jp/C2r24/cq9FcqB8d1ih23AE9Hb+tlc538pWw686foW3HSqHBVrSdQT1U
         Sp4g==
X-Forwarded-Encrypted: i=1; AKwUvBwK2V2uaS1NL24OLGoX7Zg514tVWu5aEjZYWaAE5owVDJeI8/hkXHJRDmnXoVInDYcdyOwKYvHtPBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX0C+wRfx1cL3T1Z25YG8RigexyTcUjHzDKpYMGHMgqQwDq9gM
	Ia/VBu7LRTwVP3VRzJdsPOr/f8iK3uJnl/DF2XgdtAVjlKES/XFH66EZ/qkSPZdom/90yDXVbYN
	NVhdWgNrhnRZVaDwJCbt9uTr3eoObp3/9vlk01OLYuTgB0NuJHe7agFNQbFcGMEc=
X-Gm-Gg: AYBFou35VUp7/bKARHgmITs/j2m3WDYqRNDiEX5Xvpdbr6LMTna55x7ahFBYTiNEfm8
	olc0MwiebxNxjYd4YftINTEqcc7p2nl6skkqoG+EPIyphaem3Eby3Iq9mUB/5svnNor4gyCXBeW
	nDbMvuzkY3JU20MU4q4FbzZeAKRJa/WI1y9PmT/yQJxRIdkKZj7pyaf7Kz8EI1l1bAKM6E6Bhif
	0TX10qRxvdEjpZSI4tid2r/uif9+sCGAhAWyi3maw0uCNq8BuafFeav1cUv9JSF8ZBKq0FD3Vx0
	Obi9iiYaXE9A3nBr6xIE8+vu1YxCWzWkVRJk7OrLE026dVthrhparxxVQbhqwU7heWWeqQdlLKg
	uDjxfSv+63R36sK8xv03xkZWhI9cmd2tdjE4=
X-Received: by 2002:a17:902:a701:b0:2dd:c100:313e with SMTP id d9443c01a7336-2e510684ff0mr53210225ad.58.1791218758084;
        Mon, 05 Oct 2026 09:45:58 -0700 (PDT)
X-Received: by 2002:a17:902:a701:b0:2dd:c100:313e with SMTP id d9443c01a7336-2e510684ff0mr53209965ad.58.1791218757430;
        Mon, 05 Oct 2026 09:45:57 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b6161sm10665605ad.1.2026.10.05.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:45:57 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add Qualcomm I2C target controller driver
Date: Mon, 05 Oct 2026 22:15:43 +0530
Message-Id: <20261005-i2c-qcom-slave-v5-0-6254cc7c08d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfUw2oC/3XNQW7DIBAF0KtErEs0M2DAXfUeVRYYDw1VEjcmQ
 aki3704XaSS681IX/rz/l1kHhNn8bq5i5FLymk41dC8bETY+9MHy9TXLAjIgCEnEwV5DsNR5oM
 vLINyFKNmZ1oU9elr5JhuD/B995vztfvkcJmVubFP+TKM34/FgnNvFS8oQboOfBMAYxvN25Dz9
 nz1h9o5busR80ahp+KAFgpVhaxpFKKL3jYrivqjoFooqirYK6uJyffarij6qbQEC0VXJVpGIIi
 q6/Q/yjRNP13t4iyXAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791218753; l=5289;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Qdttc+Uull2B6NlHs+W5t+MNibElOhjui4YrHJLoqA8=;
 b=hnjQMLMOM8wUBifhNFQMQno+41Ug05NC6OVqt6iZ/cVDdgpR/VXgdGZEMKj4kPtoP29wohG89
 ah/KOby22FbDcgCN0Wn3DTT+pI8KH4pmkeW8yI8Lqz92CReHLIlBSHD
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 4aGucEbLiIIlsrs5YyIM0dS8n5EyXKCG
X-Proofpoint-GUID: 4aGucEbLiIIlsrs5YyIM0dS8n5EyXKCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfX6+rwpdEIV9G9
 WREH1TbNQ/L+Rnq1C9fHU3nQkOiy5ndSEAVicBThOO5qwRzodPGEYdEOqG5cShvRAO2KbpjUR0z
 igA8Owda2sGX7yGBZ1knWlmF+Mv8PI+SIUdm0PzJP+syfTrRWZLSeqz9lmLOb53tZnSiY2Vodyx
 S+iihFRgmiZThlBLp/Bq111GaAFGiWDSigd1wvKw3AS2aOD8PXY0e7jnZUQPmKQsS6OulYwLV3R
 eB+SF6vwpZGL6q3yZfSAw0HxuvpeEJKrtIDOu1TfgOsX1Ny2SgI0dZgCRm8jRZLznqyyLnH0Cdb
 9cUPQFL6yM7dpgfun7+//368IUbjWU/PX4h74+gwiia5waG2WblRrQEMEHr7oQUZv2zmRYskXNL
 JrNbyDEmYWark+DzFs7ZREJh9l1tupcf09APKt21Gt3PVRmer3yZxljslsEQbxft9uuInASMo6C
 IOLyoK0Gjr7dSJ88UzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfX5ml9COJaIsLz
 /dAptosao9GViDRpD8ZixP3EQ3BhAUOLanm5mbyIOUuwHQq+YltZtLt7b/TzB2Szk85tzwd50Sh
 m8tmHoJZotgTDU2WL6yDolk2Ug8ctSM=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac3d447 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=oWxMlBoAAk1XZI7vwbsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050065

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
Changes in v5:
- Handle errors returned from I2C_SLAVE_WRITE_REQUESTED and NACK
  subsequent write data until the transaction ends.
- Use target/adapter terminology for driver-internal structures, members,
  callbacks, and comments while retaining the existing I2C_SLAVE_* API names.
- Initialize the I2C adapter owner with THIS_MODULE.
- Express the interconnect bandwidth vote using the ICC kilobytes-per-second
  units through Bps_to_icc().
- Make clock enable and disable ordering consistent across probe, remove,
  suspend, and resume.
- Keep the interrupt disabled when resume fails before the clocks and
  controller state are fully restored.
- Mark system sleep callbacks as __maybe_unused for configurations without
  CONFIG_PM_SLEEP.
- Reject 10-bit target addresses before programming the controller.
- Update short-write handling to use the common write-request event path
  before delivering the STOP event.
- Link to v4: https://patch.msgid.link/20260920-i2c-qcom-slave-v4-0-f7e1020f3bb4@oss.qualcomm.com

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
 drivers/i2c/busses/i2c-qcom-target.c               | 638 +++++++++++++++++++++
 5 files changed, 738 insertions(+)
---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20260628-i2c-qcom-slave-c382ff4e8691

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

