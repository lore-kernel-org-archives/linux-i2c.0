Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078005;
	b=lqCgOG7A8HIOkTOzMAf+F/OQiEuozIb7xtV3l6v1dR3cc7mdkWWVnuDiNALf1gpUgDdI
	 G/AfjqnovsRUsAJBGBF7+VZzY9+sJhgeBCAMGI+wgHx+3N1ioBIc2JgTWelQ9RV7ESTXZ
	 Ibx9F2kTyiz1k1X1pWxltKrEkjpAEdBTnZndb4nI1mcP9kUNa29Z3z1FXGXsi2xNLLsnh
	 fGwJ93xjBUy//hjhWmUhEZmPPMu1qJdC1FAjLZz5b7snQKCi20OeKy/Xjh5p2LgW0tG90
	 v9FLBqq0Ii1v1RmqoFLqWTpTyA00IoCGth3Sm2qZXcblettBfCrKOFRe3rV2xvWe4Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078005;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MarEIKFbQwA9h6Hy1ZNcr17QnNWznQahW2ON7TrWhXM=;
	b=ccq/tAhMhU0giQooP22ZaaX50qx3UqUMqLotXUQeGgyr+t3RtuSE/QhOiHZ/C3SpjLPD
	 /5udrOeFd7Fj65Wr/HtufACPvn13oVjbBUNRBF9Af0O2ooXh2hLgcOyr5yJCr6TS4wnR2
	 TBN3RjfYxJwNCFXIkCd7b4Auc/H94Q029CqJKtlGkdqr+g3D8U/UTFRuQOYhI2Qna/poM
	 L2TlH/ixjbXamQFXUsCNss1yTDOLbauGCJy/wukPq0Fw0+KZQ/NVCz/1Hd1S23NjWo0DY
	 leFHjN8+6IHsASkNKZxNyAM8LyRwb9ftzOLQbZtrMF8PHHLKdKIQZuEUiatCGxRdbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXInQVsc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BVdbmptb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D200606A31B
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D200606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXInQVsc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BVdbmptb
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2FClH322798
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MarEIKFbQwA9h6Hy1ZNcr1
	7QnNWznQahW2ON7TrWhXM=; b=GXInQVscNUjoLeyZ0knax1ZMh01UEqjcmjclZB
	Ij9qQYKae5YoeymMqN6TycwNwBxYeyrzGZ/GMnWWUvqYP6XKa/0yszUba8L1oHJ0
	6/NrtlWButpp82x9LDk2znEZu/XBISZBpQRsJ+PNA7iTMzOOM20WUkqQ2Z4eJ2HI
	Bg7TXGpoKe/0LFJZSo8LsgchSlshyUPPCJM98yiujHc33n7yowxCwP4OZ8absyh5
	hOeQ2bNP7MfAz3GiRF1howedSn3P0J8pBzjgs+6OTE/EtP7D8FrlAHCa8s8CPKu9
	twG8n2/7hejuuy6Nx/3G1kHJBAN7nF7Ep3j+zG65b+a0QxmQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmma0hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so10175484eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793078003; x=1793682803; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MarEIKFbQwA9h6Hy1ZNcr17QnNWznQahW2ON7TrWhXM=;
        b=BVdbmptbIDBnxzcw47989D+U/lURQvLS59KIqnf2H8b2uzBYJisXzn0oNXzBrUq+XV
         K3OMBULA5nd2yOS2gmYgaUh/y9way32ODsEPpWk0dqITij9AC10zsWW7psD+C3Fll0c0
         awpQC3W/D+IBfTlz76eE1h5DIijBLGJD0wicW7tRTM4reAEvljcr/DRYlw3/7ZSIeL8c
         p9c4Qk0CqUfeuQg40poJSpOox1gVitx7mbZBbgxDR3gQn1/8wgXCW9r3S+DMBcO2JlWq
         /yHNsWq3yp7SRWlVfGgCkgHsJ8za++iKjoBlt/sMZeY1Wy0aE7s5ENqtRry+5+xEAOJj
         HCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078003; x=1793682803;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MarEIKFbQwA9h6Hy1ZNcr17QnNWznQahW2ON7TrWhXM=;
        b=KUJ86qM9fSk90dYOCY3VFi94UFIzCKxdtHPT7YEljh35lNEL9UbvaOL4L5GH/h0pDA
         4Z6VT9AXw4Byy92ZK0NxL38JjHFOhsByDICMpLF5nA0PzaZ3X6NPwDa7KLa4G8yCFOQw
         KLkaUc61u95CwyYSgAF/wC7S3/G4UP14g9YB9vGGTuqKlfjgwFKWHeV+sPjmG+TlHeVN
         jV+5/DPxo7nyAj5IHFQDpQykznKsYT4JDB6nvmyPFvZ/JQV9HEyj5M4klNjV6dQFGWHD
         dwC01k0CppSEv7oxfLyL8yBcHXbKsi1iUjO9wYY26K+SOJBIWVKu6q9XfOxg0DNvz1mt
         4Ghw==
X-Forwarded-Encrypted: i=1; AKwUvBwHBpzWRODZ04nC59UDAODLNbluMAJkY+UCz4jxcYNaxGnZRpn9F60/6ziN76lrHMt3/9Tkh1Wq06U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/l6tG2lZiRhjKv6gzEghN+CZarrakER3btstYwTLxMzAUTtdy
	axlo0cm9lFY1n+ueFqJW4M0HSENvqqHkuG/R2SGJAmIci2IdLCYX5P0rdCjG9GTkdIQpZEYAjqA
	G+8mj/OHdj1rRvv3fWNoIkVQoQ+WQmp1q4yss9R6aFGDMe7RHSXVBc5xThB3eBtY=
X-Gm-Gg: AYBFou34LnyEuxwapvkYmHq0VttWEWSXuLuzjjODJrb3vnlEppqwPBYNUSB6LuHQqwX
	9jolJQw7FcvwWdT/5mJ67IQlPnN8k1dTmYQPBHjK1GfjNuW5RFqpUT6wgcn3ZeKVzaO/M8wLbgN
	kuJmqVwFiB0Y9v5mXVygLFGPRyYyOM6zHA4tUpkVe++2pd/msppjOplPpf+xTNLSsi5fRd7urZh
	OWOb+ZqrBWZFhoWtw4ToCkwyK08fMzQYwVDhWD37AekLdm7vpRYQTo5/QBy2BQbgDFygvww7aMe
	IWZlSm9R5/uBaBeVGEmfqZLn+ER0T8uuU4yIVHLDZxoNgZuoggRebANwVym2lvP/m4muLobk1rR
	VTfr0qnbntARHFbBz4lqXwedfYCT/Lt/++A==
X-Received: by 2002:a05:7022:b0d4:b0:14d:3c0c:79e8 with SMTP id a92af1059eb24-19934e7166bmr10591556c88.10.1793078002853;
        Mon, 26 Oct 2026 22:13:22 -0700 (PDT)
X-Received: by 2002:a05:7022:b0d4:b0:14d:3c0c:79e8 with SMTP id a92af1059eb24-19934e7166bmr10591519c88.10.1793078002146;
        Mon, 26 Oct 2026 22:13:22 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm62298866c88.17.2026.10.26.22.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:13:21 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v3 0/3] i2c: qcom-geni: Add I2C bus recovery support
Date: Tue, 27 Oct 2026 10:43:14 +0530
Message-Id: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAOoy4GoC/42Owa7CIBBFf8WwFkOHFqur9x8vhrR00FFb3oOWa
 Ez/XdDoyoWbydzk5txzYwE9YWDbxY15jBTIDSnI5YKZQzPskVOXMgMBqhCi5vkRNSjdDHTCUft
 m6CiidiHo/6k5G9f3Oh1el7aylVRSQMcS7s+jpctj6nf3zGFqj2jGzM+NA4XR+evDJRa5x15rn
 MDodgrao3ER/ZXHgoskI61As1a2Ln+SweplsEqH5ZUIb04hQH6vHyHxN7JaQ1tWslP2A3+e5zt
 LuSdIQQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793077998; l=2681;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=o1kpDOqfPBPXbo5TDZm+ulJUUJzq8+gQRhql7a3zJW4=;
 b=HwCvHxL9FSP0kbvMu/177jOQ2MKmoI/8ttmgetmO2QYu+emxG4q/hH1eyBOB0jSuQTQ21OirI
 aoQ8v1Bwh5jBgHBZBdjeFfFFMNr+opJSzWtZ/oT7MYolW8o0tHQjtNO
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX8tNmitWMcvfn
 b1uxlvCKWZtJOxXgvl56UXye6pw/fe9kA+qts34kZ3ATenNF3pBUJuqivuvrhTkFucK8kfbNxlj
 ytYf/0z5W045nDZqXlCBYT7StcUx8Po=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX5QhPy90YN0c/
 L66LU5xl68Nu82NS7CdjFlYKc6+mhWohLeJPNzrU6CYQ5B6NyPofObGADOz3NDDJbPg4fOK5crb
 fEuA4aAgbf9BQvMFuV0ckSyoEYT2a1QY1iztbfBs/mNU+ndL/uNo75OdwSrzlJS6+6gZi3dCdhc
 djHWnrUQupM5s1OnliHl3C/eF3zybG8DPBH1CXIxcYidCCAJWq3bde1YmNpDIH87UFJrVXBExI4
 FZormq6NaW6QAGoZVpwJUgnR4yeWCSFTtYyefvY9kEQi+FL+3iniZgue+RoMmhI7Y5Qn67KWJdl
 hdyIjMqgk76kfa72vsgD2oPkTlF8GECQAPY+6h0gxh6mwIm6DXell9qQgqpR4etVm7Zuhgm6qdy
 sjw2ps1spRb51CxSYRQKoHOAa5kc2ebnx1LQFomWUl/iI4wx2wuOslZBXXHG+n74DExGbAbcL7E
 YqV3ozQDtYtlNRyVlZQ==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae032f3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5qjwvz7LsgNgZhFB2CoA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: EkkZxzcU-OSK-vlGcg02PvYjzADck2cG
X-Proofpoint-GUID: EkkZxzcU-OSK-vlGcg02PvYjzADck2cG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270020

An interrupted I2C transaction can leave a target holding SDA low and
prevent subsequent transfers. Add recovery using the GENI I2C_BUS_CLEAR
and I2C_STOP_ON_BUS opcodes in both FIFO and GPI DMA modes.

The series adds zero-payload recovery opcode support to the GPI DMA
driver, registers an I2C bus recovery callback, and triggers recovery
following relevant transfer errors when the bus is not free. Recovery
checks both SDA and SCL and preserves the original transfer error.

---
Changes in v3:
- Use the adapter timeout from the FIFO recovery patch onward.
- Configure clocks and timing before recovery, with PM cleanup on failure.
- Remove unreachable GPI error checks.
- Log DMA termination failures during GPI recovery.
- Preserve GPI timeouts and stop further recovery commands.
- Link to v2: https://patch.msgid.link/20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com

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
 drivers/i2c/busses/i2c-qcom-geni.c | 210 ++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h   |   2 +
 3 files changed, 239 insertions(+), 3 deletions(-)
---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20261008-20260826_aniket_randive_oss_qualcomm_com-84f5f536302d

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

