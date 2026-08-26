Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9033D3D1E
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737899; cv=none; b=eBTBUnOEtzTD/zJGpKxIS9JWIXrEIt17bV8BOmEXr+6P3psZVyLhfI2POUgyOB2fNbjsRToYj8jJbYgzlMxM/UZg35ZD3Wu0IMqCgDUfbUt7brF7llYEnyT7eLwscvAuGdIDsWJVqxsAmwjt+IymSg40mUZvzF7Og0xVlcIabis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737899; c=relaxed/simple;
	bh=5pCdhqBVog5lmnEpDifngttIyyUpwkdB9WQKZlEV+9E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EtKZAmEDeCaDLgQuIuKWf5QSsiVV6f1MzKu6TD/lWbWLFTBZB1nPBru1L4Nv30hfspIcc/1Ehtf+++PILgrXE7tCNNFaPE13gdGiJWc53Y0+zrlJmMM1YURBVly5csI9LOyuqHFpLEMwNvX0zi/yMExFFlMhPep65IfmCu+wfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0stfBq9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T60P2RpJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0stfBq9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T60P2RpJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9CMui481710
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yPL9gxgfBZ1gr2Z+L2cF5q
	p/4izv0nN+GyUhSS0KxaY=; b=p0stfBq9WBBqFyqV10kSPNNe8YSl3lWXDEHc+6
	yWfTW76eASG3t7yga3H7gh5ooouaGP8raDK1VsGQWSsswhsTPzskA7UxRUwx7fqD
	4oTU1lr1VQ2QtG0hQds9Q8lfuT13YCAX3fFstOywEI2hj+SIvjDcHndsSgfqwLai
	xPWSP3mHqersgY3vgfHv4say8gUpRYJ5EEMo6BR47xD8RYuJHENl9j9V22f6AdiC
	SMhiRETJUUrQnONb/qVpOoqVk9sG8RTWUxVJe6aIJGvZS36cjUkdmvkLbwXzNUaQ
	3gxcSMhT8AfBFmfbJDCoAANjSIXztod+z4oRpk7mkDRaeEbw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k1gh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1696094a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787737896; x=1788342696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yPL9gxgfBZ1gr2Z+L2cF5qp/4izv0nN+GyUhSS0KxaY=;
        b=T60P2RpJtVX/jxshn2tFFS84v138Ba2neVq78EDlETf6yREE/bFCMfMXKqISzmYIEY
         aSnFIe/9kF8B0KybfC7U4IlQ7WN8ewRXLEgpjAfx013l5GSdPYk1+HDE3nKopMyK5+wp
         mPVkbjYcIU5n1w7RVcUcR3hADjkVDB+VRQi/uuxZ+8aPQbeCDo20hYbgFIjYwA7EEZdM
         i78W1AflJD+OVPv4RtrnI8A9lV8PBiG3C0fsnzNrPO9y2Z9ObHWqV7GK2gE2DJ/zAUEo
         2MVzxvvHxDVJVWXpYPZtVKp6zTfo6urk9v02TkQ5Wjc+5anKoOcl6P20m0Ntmz4OFM4y
         ZQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737896; x=1788342696;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yPL9gxgfBZ1gr2Z+L2cF5qp/4izv0nN+GyUhSS0KxaY=;
        b=HRz9baUOwSiLkluxISZDv1PhMpRvxID3MSQt7tNhHK9lDo8MpdH5yKWUfzxWSV5vfO
         S6Duor8RRuXnz84PFSDRGRCu2+x0E7tGKH/w0cLmZHjaA6d0Mv0X6DwjpZqTDEFDdt+6
         ERfbCZmq+QeGHnUONtp8JW30FQJJTIvwvh3FEjEb7KPsk1c7zK+8hjLZlLXZaHRNjmiq
         g74LTcC9OCiOWe6pM/+fDLZTnpT41xJBco7P02oQt2iFitrLpuaU6NNA++qmCGm2std/
         NZqyBPVl5YE1m4BPay1XFYZj2H80vVdHf2TO+Vh7RyrlfIeoI9yBVechWM1toR74d6Ye
         YsHw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr/goQZePzWT1t0a8ZQuqohhkGLijHl7r2q0/jVPy7o/iPtCZUH8Wp54W0zIvzBVHie6waT18lrJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kS7lgsHaSR4+mapOJyP8E87Qjn6iTrdWUixO9ir9ZLEYVjcimE
	MmVKujk6GYR9z77aPs/K+7vLs6Pqwlqkz9qu0C8dTQgVaBmvLZ8JeOZy5iC8cKJo5i6f4F4ko0u
	6rep3gYwxvMdexIrroWwq42akKDUUekExfo0xrrf/nZze/U1aOOaE0KyjCYfP4WM=
X-Gm-Gg: AR+sD11vlRGliocFFq40wAoFNfcJw6waLLpDEd5RQtLNQlIHBQrZMN4fQEXd9/zYuQa
	6GpT/u+KiUPa2oQalMpuhsk18/s6ENfHGBM4ef9YyPUVFHchsM0dBWI3SFHM+KPRsuC91wfEq6C
	R3tGg4ZGBiDVOqiG+tgY3r4zZbtZEWvnpTqwY86MHUdQW2IgMFDdtSIyf+3YZEVbxgSA2AvCwDl
	KctlC+vl36jA9VRyLErwyd4NHGWXCqgLcOG0UxhxBHOidgGQla59VdlXMserV8P3ij23m5BRCI2
	SkdSXKBsVvQU8Mjv59+s+iALP2O+2lDwhY99IABhKgefBZGFt1L+Kip3/lbGYKaDAj3aYZ7DxrY
	C5kFsYtsdwGHl8hJTIkGFU3TWnUl0ueeUdg4=
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr11869723a91.15.1787737896067;
        Wed, 26 Aug 2026 02:51:36 -0700 (PDT)
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr11869645a91.15.1787737895607;
        Wed, 26 Aug 2026 02:51:35 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm7249738eec.23.2026.08.26.02.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:51:35 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH 0/3] i2c: qcom-geni: Add I2C bus recovery support
Date: Wed, 26 Aug 2026 15:21:21 +0530
Message-Id: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABm3jmoC/yWNywqDMBBFf0Vm3UCM4KO/UorUcdTpwpQZDRXJv
 5u0y/s69wQlYVK4FycIBVb2axLlrQBcXutMhsekwVlX28bWhh32w669EPpAcph2spjSthq7DtL
 sIzTx94d8QCjh+fd0H96EW2bl1sK6eTnyb4zxAgzgmweHAAAA
X-Change-ID: 20260706-i2c_bus_recovery-8f0c20283d99
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787737891; l=1718;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=5pCdhqBVog5lmnEpDifngttIyyUpwkdB9WQKZlEV+9E=;
 b=C2ZxEr7tlgDy8WEUGiTyyvp8nAe0qA8t7VEGsf3WqAvt0qKf5kgwNK5PcDpET0j6R38L/n5lz
 oEVTZ5acDtwAdLMGq0INO7+9HRqSLJeyeeLmJzyXDAoYyb7EneckkeI
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8eb728 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5oILYQuN4UfxayToDyAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX0BfeTkP06caP
 5msWZtaQuMgfkapeAK9nX10BhKeBTWqSZOCoSl3+vky3j584J7cbxTLqrG+PoGEyCQI0ODCMWbi
 xKGKv3UIeOYa0osbTCA6MisMqYFI83U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX2RVIddzhdUec
 hj+Fo9yFNr99jhaC9eBkd0ddCxWYpwdBmnNB2Kr5VUNnFj4Mh7t7avSq2zS6fOoBSsJfuW2SQnj
 Gb55hn+gaUos2CNxCoHCGan/ur5rkon7q9zwEyiCjNu/ks5edQ+KmsRw2muaqktdMsKi3k5jmZE
 gUkmsQiu261MA9OJZ/g9XDCYK3hTr3HpoOhk9gpjmS1MwnLbW/gRCdVYd6Di/78uGoIrpD7+Rfz
 zPo7vEJf6+Ro9cCXa8krSUZDB/nDgPHKi74PkZqoOy0/I49ssHwnghAxgPp/7RZYFmC84qVvtXY
 WfYEuz/Od6VdSBR2eqIzoXb8E0V6PDSGNcJNZRGkRLrcDTpdTsl4MsqoKSxxVxSwzdBtxXr+c9v
 RAjcpcWlw7V5QKi8qR6RsF1GtbmDEmC/dm41xfxsOJ1zBvVHKwf3ehtTI1H+WSUrXSZXU8YDvaf
 FJO0+zCOZoeanRCqIPw==
X-Proofpoint-ORIG-GUID: W1CWvHFQJdFpMNJDCN0O5fQbESbwvg5h
X-Proofpoint-GUID: W1CWvHFQJdFpMNJDCN0O5fQbESbwvg5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260081

An I2C target that gets interrupted during a transaction can hold SDA low,
leaving the bus stuck and preventing further transfers.

This series adds bus recovery support to the Qualcomm GENI I2C driver using
the hardware native I2C_BUS_CLEAR and I2C_STOP_ON_BUS M_CMD opcodes. These
commands generate up to nine SCL pulses, which is the standard I2C bus
recovery sequence, and then issue a STOP condition to release the bus
without requiring GPIO based recovery.

Recovery is triggered automatically from geni_i2c_xfer() when a transfer
fails and the SE_GENI_IOS register indicates that SDA remains low. The
recovery callback is also registered through i2c_bus_recovery_info, allowing
recovery to be initiated through the I2C core i2c_recover_bus() API.

The patches are organized as follows:

  [1/3] dmaengine: qcom: gpi: Add I2C_BUS_CLEAR and I2C_STOP_ON_BUS opcodes
  [2/3] i2c: qcom-geni: Add bus recovery support for FIFO mode
  [3/3] i2c: qcom-geni: Add bus recovery support for GPI DMA mode

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
Aniket Randive (3):
      dmaengine: qcom: gpi: Add I2C bus recovery opcode support
      i2c: qcom-geni: Add bus recovery support for FIFO mode
      i2c: qcom-geni: Add bus recovery support for GPI DMA mode

 drivers/dma/qcom/gpi.c             |  30 ++++++
 drivers/i2c/busses/i2c-qcom-geni.c | 185 ++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h   |   2 +
 3 files changed, 215 insertions(+), 2 deletions(-)
---
base-commit: a8406e6c0b793ce0788019683837c40855b55995
change-id: 20260706-i2c_bus_recovery-8f0c20283d99

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

