Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756743;
	b=ochyqgzf6uhZfzshqKu2taqR9KM5Zrg3e9QY2II47IIc2fwecHIjvD073SlnuVg86EHP
	 1sYi/YqxZ7hKrEKP4XwFgamA5Yyp5ZeJGntdMThvjv0nSJ3ufurjXBK1F8jilZDx8sepK
	 crH+b7i8tBz5yoqa8SM0/I65g1BSrzHI8UFMPBwA5GyKC3xtvRLz+KeYEC8KuxwyEIZsh
	 wX/6FC5fiK0H+4VfKscsI5dN98qW76jRlyBfmzHTb9KfoAELUHnc1tJMiCfh1H/1hHjMf
	 C6qXhTg+tPA1Bd2Ye1XkIu+Y1PuuEb14V1by6Wf4Jcx+vRoyG19jG2CTIkzWMr8wUXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756743;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2bw9E17RXi+krJiTDPyGtQPi52S/lX069ydJNo7pBSY=;
	b=yZkpLUXWz+/OG8B/lS0NPVjiDAANX6gMZ0Zr4BvugkwQcM6PG/FMxyzDECrqDWoJR1dC
	 n+7z+0Wsn0YpwInMkjLMNnVsT3sRdvurGoyZrcsezRy1O/gZfe0Z+QVZDArk2UI0HAlsY
	 4+ksEhY/WtCHtzsy6r0LT7TmwBq1OjL2m2WnNyIbH6lFpcclA9XEv9nBz55LqfIDtH4k1
	 K6YOL8iGdBvixnLO1VyfLlBF3x7Vxwi28AayAb1LrvbITf7Uh9S+zcx1nwZXgXfcWS/aJ
	 D2Etk6Z5sVzTHIRTMRj86V6vBd2IWhCScdJ3G4T8WtONhc3PaNRCvXNptHBFmTvJkPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3wfenE2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jo65iNhT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83953606A322
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83953606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3wfenE2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jo65iNhT
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAWSb2164292
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2bw9E17RXi+krJiTDPyGtQ
	Pi52S/lX069ydJNo7pBSY=; b=l3wfenE2ZHB60CPyIma8/VkDkD7J+qYUwMli2w
	frXoKqLyTiIByg4qLJyEZ+iYf/uJErnM63B/V7qDmJYkzYJC1oOvGRkPMG30iBzz
	OcEDvUQtsd17psLytKADqiIMFJQ4Sb4ceJbRbESEtkjO22ljBqSn5ZifvawquF0M
	kJMpSpMkAhDi0SUBjBCzvL3cNiRUTFaX6AG+TWkiEFXGZICDOOkrixEi9nvhbbf0
	I46LwY11VUTX9qbWR+rYvE2HVoMXAbZ6Q58YXNhZFuQRWtCW/skcbTU2V5xc2QFW
	66GNldT5z7FTCLhXh+7Im5HPUQVQV5ealMOMvddKXTM3HTjg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahuyx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1665200f4c2so1063630c88.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792756740; x=1793361540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bw9E17RXi+krJiTDPyGtQPi52S/lX069ydJNo7pBSY=;
        b=Jo65iNhTn/zYFm/xYxmvcjShWFzKZpIefghGhTA41xUlU1qPwKOE2GS9WVOyq1WmPx
         ZnWG3Kfp5VMa4GR8aP3F5ku9yIpQxlJVUCclDNSSpoYCc7PpM1D8Al6qmxO8DoJQ2iIb
         GpqrSDXyRQzWyCvUCRn1/O2HrUZycs5J2HlPVx0kga2+yEd1BvZQN/mBckKIrT2v2wpr
         7NuaVpHa04+G6ig5poxgQi+TKFBW1hazn4xqryEtRqriSbxQywrO8dSbF81lhjgn9l+4
         CWkv//hoN5Mlc4WDZv53nSUirATixTEyaTFpyc0NL94J01/x8nG5iVU5nvrEHJJHGLU0
         Mucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756740; x=1793361540;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2bw9E17RXi+krJiTDPyGtQPi52S/lX069ydJNo7pBSY=;
        b=mg2sshhRvjPrEGZfA34picDzsflZ7HSR6jXKyVx7sXkoJ5WhtFBlXePjtzI6P0yP1v
         x8ctyxZfIZ1yS2dtpDn50Ru6qEMNfo4NsMBLSLTwdDI7l80jNTBVIZMVbzvsRz9aFbyq
         IaadV+/6pJbpzeVhNgviumbLCveLUQq920u3o3DkvrW0PvTUtPUoHnmlHi841dSf0zr0
         AwOzA+lhVgidT7DkZ/IMLKx1c5GWKfigHZTbH8n2dmw20TnQ88Bq2f0ZX7SuKRDDV378
         T+83Sk8Tm192WQSu9+qGCu3p5bRvhmVf1/QfibaXg0VT9P7Z8NTBN0qwXe7Rl9un6yME
         JkvA==
X-Forwarded-Encrypted: i=1; AKwUvBwfsyFdhCz6WAvlADTwkMqa8mu4NBClMv/6D0ska8Pm/ZufSsSpTyFE1LKG8fwccCPKgoWI2zwgqtQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmtTAvQl5lK29dWuk0ErkGYuUvMvux/2srtGo46Kk3CqWmXaxX
	JLawdRVevWEzMEYaPRZGPoWBlaM8pvsTOCXlck/gpzpoRn+lJ3zTL9Oo3NJXwkLOc/4JTfABsfg
	GgYmL/8nUa2ioKxveOZhiRNe9IOSvyegzS3IJ4vqznL24RJHoT+ZE90UqN+lq7bs=
X-Gm-Gg: AYBFou1x3Yg1dDUREit3as/Q2ndLe7291r+3Saq4XTzf6v7YlXUUdB9SugOQ8MYZR2B
	ecvuLlSwVSTgePPLqdcM9cnuIn2uAhodo82girGc4eWKMSczzlguGDA+4jQT6uqK0APug8A3J7u
	oPXtHBH8fgks8XyKJGYrhP91hTHzr8f4U9EEjHAAvUmjL9A8ejYFLFSvUvE4qgIP6W7eps5rCQ9
	Z42qQD52y1TYO8EOForVTsXJDQEfh5G4GNAycjNH7djNqSbsKkec717fobqBP9GcOiYjsVNNi15
	fwq3FWNCgi9YBs1rX12RLEvPWFTirD/XeU8/owEJnStwwyfcS6/3wlVqX84c7l+h1xLwa2LwVyP
	3SKOeMWaXX80PBGtVxliW0ltuNNR8SMDBcg==
X-Received: by 2002:a05:7022:3c8c:b0:195:33be:15af with SMTP id a92af1059eb24-195c77a5924mr2026552c88.40.1792756740063;
        Fri, 23 Oct 2026 04:59:00 -0700 (PDT)
X-Received: by 2002:a05:7022:3c8c:b0:195:33be:15af with SMTP id a92af1059eb24-195c77a5924mr2026513c88.40.1792756739414;
        Fri, 23 Oct 2026 04:58:59 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm8786134eec.5.2026.10.23.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:58:58 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v2 0/3] i2c: qcom-geni: Add I2C bus recovery support
Date: Fri, 23 Oct 2026 17:27:56 +0530
Message-Id: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMVL22oC/zWOTQqDMBSEryJZNxLjT6Wr3qNIiPGlvrYmbaKhI
 t690eJmmIFh5luIB4fgySVZiIOAHq2JgZ8Sonpp7kCxi5lwxquMsZpuhtW8EtLgE0bhpOkwgLD
 ei88kX8oOg4hC60KXusyrnPGOxLm3A43f/erW/LOf2geocdvfGj360bp5ZwnZ1iPHG0WuRDt54
 UDZAG6mIaMswuSagTpXui6ukSA9CNIopFnX9QdCRrzm4QAAAA==
X-Change-ID: 20261008-20260826_aniket_randive_oss_qualcomm_com-84f5f536302d
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792756735; l=2244;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=NmJjBHDfXQz62IkV9SBv65bKmP9Q1LBo7h4nvQNn7oA=;
 b=+NBv1W2TilmwVmT33/qPxlpLi4rZUaDAKzGTntjNTDeSkbsS3gR96OtBtECoYIXQjJnVOjDOs
 /1Bh+N+mxK3BPH4Mg9AKbkoq4MWXVlAntyCorflikJBfTGwixQaEaPh
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX9S8oPgI7+NTi
 aYntW2elJObEdjOxbDwke5H+sFF7ZJQa53V+3d2OCi85hci0r46Z/MMAaSIoNl0lp+jUfpckGDQ
 pIqYQrXzE7Qa6B+UXVqix3M3Lwy5aLs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX2Gb6fkdrpOLA
 owvvRbznTwuUakgUk7TGy1vgtJE/XBSC0c3yEMsRVdGnaYYHCIlvFr+tadpLqlqPX1oamg/woro
 kL5/QIKH4PLnreilv2gRxzwd62nezJoupvIhKLTSQ/TPVIGAikCQ+crUhtYO8T2WJ04oLlFr3Aa
 lx3u8d3pOdkqhdFFaA7oeHHUSoylvey76IDAEc1lLmaC1hSpjT2XBSAX6xqRbipmskKu3SYybge
 X+om9RusGvGQfhZ9I5CCBZ+5fRJU8OzesuLpCMGSeid7Kk1XIkQSaQdPEN2dB7HrnbRfy/7sPkU
 0/bOUQZxB4lFaAqIWmFAev1KE6+px2qRZoMic8gOtvsv0zB/Pj6YBOsVGOHBBm5rKPY6OuDNNu/
 UP6tyejr6enJUhes2scia67X9HVSV/FzBe1pde+6zp6MP4AuR5F3B7iSK7ZZbcopeoHFuHx2XLi
 f8sq/mLGqGpmAqFmX3w==
X-Proofpoint-GUID: 0NqQUC6dNnwctFkJIYXmH-aIHKuHi3Iu
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb4c05 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5qjwvz7LsgNgZhFB2CoA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 0NqQUC6dNnwctFkJIYXmH-aIHKuHi3Iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230046

An interrupted I2C transaction can leave a target holding SDA low and
prevent subsequent transfers. Add recovery using the GENI I2C_BUS_CLEAR
and I2C_STOP_ON_BUS opcodes in both FIFO and GPI DMA modes.

The series adds zero-payload recovery opcode support to the GPI DMA
driver, registers an I2C bus recovery callback, and triggers recovery
following relevant transfer errors when the bus is not free. Recovery
checks both SDA and SCL and preserves the original transfer error.

---
Changes in v2:
- Rebase onto next-20261006.
- Move the recovery opcode macro removal into the DMA opcode patch.
- Check both SDA and SCL for bus idle and reject recovery with SCL low.
- Share the bus-state and recovery-trigger checks between both modes.
- Guard the current message pointer when checking data NACK status.
- Reuse the FIFO transfer abort helper for recovery command timeouts.
- Use the adapter timeout for FIFO and GPI recovery commands.
- Preserve the DMA configuration error code in GPI recovery.
- Link to v1: https://lore.kernel.org/r/20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com

To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

---
Aniket Randive (3):
      dmaengine: qcom: gpi: Add I2C bus recovery opcode support
      i2c: qcom-geni: Add bus recovery support for FIFO mode
      i2c: qcom-geni: Add bus recovery support for GPI DMA mode

 drivers/dma/qcom/gpi.c             |  30 ++++++
 drivers/i2c/busses/i2c-qcom-geni.c | 197 ++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h   |   2 +
 3 files changed, 226 insertions(+), 3 deletions(-)
---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20261008-20260826_aniket_randive_oss_qualcomm_com-84f5f536302d

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

