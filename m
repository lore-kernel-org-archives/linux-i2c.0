Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC2397923
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570778; cv=none; b=HU+6VMDnvMe7KOGiSWB3tzsKLYA4aaNjZAhRg5Z0Ok1JHXJIi/aUs96dmbFB4frbGM5bgsqeRIPhwcOcBfC3477yYD5M7LVaPMN/A4Rv1e1neL15+c+l+LkQgOGQxgZSkeJUOlHacw07SKT22RKboz0OBl7ZYrGBhavgMplMSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570778; c=relaxed/simple;
	bh=cLkJLX+H69tkE3/m3/QggjlzGba7oXv/ShCNu9i/mfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=prHWiHcog33XMk//dQxf8FcLt3lITr7i8wWu3euTlGaNxJq8aGQXPFxj1nqDcXNZwiqd9C3RrK6tdrYNlGUu429RMaGDV+BxRUdXhgnm/dlBeOj69/463OsiyB+DSpEzS3+8ALT3bO+VfyQgml80ukJ+knIUSmarEMiFWzQHx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdsqGeQX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLSdckN0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdsqGeQX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLSdckN0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMiRN1673456
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UAVPp94T/5SaNTTaQXVK8f
	eOqhgiEdfM1yPy3gJVPb8=; b=JdsqGeQXYj5cXIZBtSkum6YDHOuFcYZKzaVTdO
	QeWC0CPC6gyM2w/X/VRUDuszVHHg3HHielQ15fBfUVVWepewtNiXFtqE0mFcM6tq
	wv4zh+7vGIIWKTwGfX8LBBuar9sust572a2zU0DzNT+BtDimE+cbB3ZKIx0SXtGq
	inIJHHtw0SStq3gvla5rrzy+evtjmbktbqBKK7UQc0nFofL7VbN6ZZefY3P5odqD
	nEY4kSfTXSRUET9oGNMD8eSCdBUQpLgwaR6+DXdepAJ/RwiemZf4zo8wUPxxNNzY
	MoJpH6Kt/8OLVaaU9h4Ymcs2CxpBbloT19QRXKlW4J74ztwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0x83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so8420376a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787570774; x=1788175574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UAVPp94T/5SaNTTaQXVK8feOqhgiEdfM1yPy3gJVPb8=;
        b=bLSdckN0BEajvW8HhE9u2/dbcR0TtcqhRjHB/D7tMwn9Vtl1Yw+D9OKURoN/YdgIRO
         aRdEXxRya+F3jDexHo5baysy3yyIJPLAOITmZr6f2i4Ni0AMHP2Y1xReFQEndB7XIqQU
         NfITcXX9XdWstCjSVEtrxfDGnn6uGYsPHkD9uTDHjODWUmomzGv+TzV0IC912EGYF9ao
         SJfCYJA3xQd2tE/KouciyjxuHxXbNd5q9esP/Rlo5B/ZJ1CZ3F/zUf5oLM1KCNrNGuhP
         ATMt83nHuEQwsLo/pW1hOUiwwEUngYbN+VhcLxYZVUibXQKTwYiWEKu32w96PaHsb7nN
         LKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570774; x=1788175574;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UAVPp94T/5SaNTTaQXVK8feOqhgiEdfM1yPy3gJVPb8=;
        b=aZ5mzxUQETrKzTmVID8ZEWIaUwrPi8Ap7ZllW1hxLgd0mNVMRf2aH11XBw5pNEtmUo
         Sdv+6zi/i/VL7ABICG2vm/aT1EYrA//j478gcGv/9g8hNjHKNAyoKFmXKxzcLpk2aely
         B8TsRRhvkSDgroNLPZhhY7FEeNg9Kqe+/4zn+HF1Z7QWjp7987j84pbCQc/kIYeZGx3D
         dGcfZ7V6tictZuhIGRsifaIpD8Myz6C693RFJSx36fnUSErF0g9NvtoD2zHX4nRlYmwE
         806eDZ8asC5NhX8rwghay0K28Vg5AJ+RKDpgbPDu+BxX7flwpfuXmfvOO4B2fjoyE7jP
         39QA==
X-Forwarded-Encrypted: i=1; AHgh+RqFO7Efx2cBJIEZqjcKYKaIY0r71vPDpcTq8slaHi4iNOr9wueLsfXIH/wDQh9cf9NGA8gsPvHpdOA=@vger.kernel.org
X-Gm-Message-State: AFuF++mBPdYH+QLpkbgIy68a/kNtZRBTaEcZCO/j5uWmltIZlWvP3NM/
	G4ZmPLOimSJ6MIgosEQbxqlRvMNkQFQYAMAlOL3PuBcFAsKUCDpoLVZntVzxk3P1nz9AstLIiiY
	15pFbba95HiNxaROD5W4ceDlqdPfvl2tsjiFU5I+j13w0Mr5LEyDGcZntmJDqMT8=
X-Gm-Gg: AR+sD11df7OYGJI5hSVzbapiFrEjf7k9qUcNvEJJvo+eeFzjA/rqCc+DalowzARb2SK
	FLRZ2g+8OfCzxde470zcOkljLE0j/zd/ARm/q3XA6/Uv3SLDOB9cstO+qZRpB59zafv9PZh7ZpU
	84cbj6nO3gPoXH997w4OhxNwbi0uc+FHMIZOJ2hEVrAOqfkPkFVMmwDeYjORqTAURMaIKkuxA4F
	Rc8Fa0DD9gqvQOZAGi3SyG9evD5TnWg+iYjoht/0kWjVaY7PAlKp5Aw5yd6nA/NO/kWatrUitrA
	KuR0JbfsWZY5lWrnbHlGRyHkWqXesx6iR8KOCE8JUUQ4K3LfS8ocKWgJU0rXrRePBZXZjTniQqq
	sQTc+8h1Rtgg7HmmcvLMKxG6IDpOWfkDXGFo=
X-Received: by 2002:a17:90b:5347:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-395c3a4bd22mr49999921a91.14.1787570773835;
        Mon, 24 Aug 2026 04:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5347:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-395c3a4bd22mr49999852a91.14.1787570773410;
        Mon, 24 Aug 2026 04:26:13 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a1597csm9767137a91.13.2026.08.24.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:26:13 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: [PATCH 0/2] i2c: Add I2C High-Speed mode support for qcom-geni
Date: Mon, 24 Aug 2026 16:55:47 +0530
Message-Id: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsqjGoC/yXMQQ5AMBCF4avIrDWphipXEQtq6FggHUTSuLti+
 SX/ewEYPSFDnQTweBLTukRkaQLWdcuEgoZoUFJpaVQmSFnhWOTSlNoUsjK6gBhvHke6vqOm/c1
 HP6Pd3zXc9wNf4xhEagAAAA==
X-Change-ID: 20260821-i2c-hs-408768509865
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570769; l=1599;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=cLkJLX+H69tkE3/m3/QggjlzGba7oXv/ShCNu9i/mfA=;
 b=oLX1iowxS4Wmt2opkT74s3VIjIFLSoTXBB+pJPFvPwPxzghoRi5exrfkRyWEPlUt1uuHaPfmC
 wQjXshkPXX1C5O1B8+zBPjUWyPVo0lSLphxuzpmeI/cHOUqfNO53dKK
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NSBTYWx0ZWRfX4KjIPRRKepgl
 viUvH1F3zhjKDR5CmkfDvIenrGW9dcoY4r9T46ikwjOfDolpB9AW3IT4W9tqjB9Qc9EUfdrulz2
 SkRKINK+Wqb+mUvOrtZLkKSNgt6dukw=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c2a56 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DYxQ9-Bz8KIyXcFcPm8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: oudwljuR66vL3sJ04c0DQEmfahQfcJ6e
X-Proofpoint-GUID: oudwljuR66vL3sJ04c0DQEmfahQfcJ6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NSBTYWx0ZWRfX3h0Efg/VoPOT
 bJwoEU9pSCbvrW/k01EVaJ2EqjDdehqfgC0tOlIafq6JrLyIPSIOeuuPvTDipduCcvFCv6t5DqC
 ZcYw62bX+53abeCzjfQEsA/bItCd8eVz4haFIbOF9AZRnhLhSVue7iyxOYPgiuJei9ehLhDMWKf
 zfEpndKqQOe0oJD45hMvIrLx6WYvra6o7YCdzo7gg85fwYx0WSRpB1qcVc0eeJq2tg+zC4XqIgZ
 VWziqmtgE8DTw6BHh9kuy854GTVJcwdKVdUXYSHoHeDMfyGjjFMz63kM8simIn1ZHcOzXIZRFYO
 c1iwaSgbdR4fBctP4dcd0/vpVq+q9XMem9ZiXBayoEFNtGXmZak2/11K3N6d24Fzsb4RxCme6Ua
 M1CBjGAko2cAkgGviAwSh1DpggUrpvyMsx/FsXRouMWtnH14O2zkl4HbYF4zU2xXqu5BWPrjEZ3
 4BjTTrZjqCFnhPxwVug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240095

Add I2C High-Speed (HS) mode support for the Qualcomm GENI I2C
controller, detecting HS mode requests based on a 3.4 MHz bus
frequency.

I2C HS mode is supported by the underlying QUP hardware starting with
QUPv3 core version 4.3 (per the GENI/QUP Hardware Programming Guide).
This series adds the driver support to detect that capability and
enable HS-mode transfers on SoCs whose QUP core version meets that
requirement, rather than tying HS mode to any specific peripheral.

Patch 1 (dmaengine: qcom-gpi) is for GPI DMA transfers and adds
a CONFIG1 TRE to the GPI DMA engine to convey HS-specific timing
parameters (tcycle_cnt/tlow_cnt) to the hardware.

Patch 2 (i2c: qcom-geni) handles FIFO/SE-DMA transfers; It configures
the GENI controller's source clock and timing accordingly, and adds
the HS-specific FIFO/SE-DMA opcodes and master-code preamble needed
to switch the bus from Fast Mode Plus to HS speed.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
Jyothi Kumar Seerapu (2):
      dmaengine: qcom-gpi: Add I2C High-Speed mode configuration support
      i2c: qcom-geni: Add support for I2C High-Speed mode

 drivers/dma/qcom/gpi.c             |  54 +++++++++++++--
 drivers/i2c/busses/i2c-qcom-geni.c | 133 +++++++++++++++++++++++++++++++++----
 include/linux/dma/qcom-gpi-dma.h   |  28 +++++++-
 3 files changed, 196 insertions(+), 19 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260821-i2c-hs-408768509865

Best regards,
--  
Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

