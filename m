Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078009;
	b=ZlgXMKmS5jppD6L5oUzY+VFQ1Kz/ugN3K3CZn1PAYcwfkNOUNtEDMcCaGqxCMMwVpDF5
	 YAKqLlwhY+TEZQvf+9IQkXh4JohH0VSqX3DZ5YvlzWqXNx9WG0uG5YCyGd6cPIseCZjNI
	 naps4xcQrWzS7b8/PJB2Z7tvwGyF76byc6aXtK2V9zI5LvXEs+BEGJeQx2kYjGRKUKo/j
	 3gjhzTS1jPkEuJx8Y7PdJpnA5Be0QJM1nOrmPuzrvfBkbYcfeJ9K1PVnK4yDygqyCC5fc
	 a8din9oC79CISwThIZKiLbtghWbQt2sl99SRhiBTjaOb97hWmDB+cOmzdjQu6Ey1prA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078009;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
	b=xvBtyReRlclTBT9g/e5oMISjrU+BFnyH7CwAXTnYsyn+gSuZIvjnqIFtKIcwN0+OpbLz
	 uLILPZqt0IMDaRmYw23WkUGC/qAu9hX/GizlcMLLtaY+4rIQoyY74mJ7RFEfBotKsrVRE
	 3M7lL6rOXLVIFTZEvFsQjrDxked33LaaZj4p1A8C4wWR2skQci/XZIyGSKsnjXivOlYy6
	 g80uBRloo96dpKpK/zuT5In5LL6rsrtUNha3YXeztP7x79ENeBXUOPtkv43z0n7TB5V5w
	 Q41LzO4Px8yLFmtPcf/dP7h7/kUmR8uKBSsiZntcW+2Em3Yd1hLtcBEbEVHLjhSR7sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cBf5NdFK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HrWYTMmr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD6606A325
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FD6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cBf5NdFK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HrWYTMmr
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2F5ZN3521562
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=; b=cBf5NdFKJqPtHCRI
	2QMm7qTIYMMtChGj52nzJnJoCKEMnjN5gN3Wl9qlHnARTIWyDg68MaG4lT/maPwC
	InY8aWPRqQ8TizLEDskJGgQKfFfB4rzyDy8yWxRjWtXJnfilasTq4UsUsPRFLiGx
	uDxEkpHuPrdlNc8NvbA+SyCFcJ+t/fmhzDW/MrXGCmSRPpR8aroZtWfgd6uzeYaD
	DHU6nKQ/5utSqDJ3ONpmki2KdrqaWyYEmwM4FnZmjKWVIR+B3Du3HH9n6jpB/7VI
	zvGTihgsgrnpKt6gX7lINiP5Wmj/L4JxUNJp+XwcH4vqw+23LljXHd4MOIHNwZE5
	KBNdRw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54j5kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so2030302c88.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793078007; x=1793682807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
        b=HrWYTMmr9WAD/59zyj/ac9aU/XV7FbWhseT+hrVztsEUwKj6lNpFqXDkoreAJRbJ6d
         FsCIOxlvd6tjWWidj6nL/RgIRN1k793XrddSfDJkyqxmOtKPUbXRVtesNqfK1wHsvAJ1
         Z60p4XKh31pv2qKd0Jk5TPfhjDbYpQZiu10AqquVrmaSS0xhPYGhoIPM/q2eLiDzg5jo
         xwRq+smK/ImnWHts81KaqJwvwDfGGfcWFPz2C+8Cd+QulqTU7bom3pGV9nw+x6UNp2SB
         9QcDzOI2f02t/S0Z824MkO1F78MFJ3ZJKpE2M/dYnt7cakRjTxTdHKjhh+Vuilxf9+JA
         3/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078007; x=1793682807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
        b=lNqB/FU+ntTrDT5xVwODU/9kv1Zjhce5CPLL1qe9eV8fkQjbpsJzhPxpNsCKHVGqB7
         OZzlPTs8RZfU6KS86rde4I2fWUSL5ybe+k/8dAzjKEBiHL1N7YiGdODSLs+NG5gwQt8D
         nCSwZXXrLqfsRk4YhKWrpCsc0pmu5/PVR9kbsBFznZIoep+4KNDEO5r2tx11Nc3HUkDh
         Qh2165Khf0sX9niz+RWKebwXVgg8B+F9ENsWbUSIpDZW6b20ll4LNwh8PwPFb4lPVaSi
         VN7enBdV47tgG3E5IXrRPkoxRKnnYspWIMpRHoB9DVdmHLEYVhs0+J4cF/bBddhZk9ds
         XFFQ==
X-Forwarded-Encrypted: i=1; AKwUvByrPLvKeJ2R4H5OJqh5hR8EJEMJwj1iu9NxJ4DMuQAY4OwuDp82Cmwc9yIEGX0UyG8Ic2UsFwSAi2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZTsj5U3c3lZDX5nLY5pToAmh9GCbvHehQ4oqD8LnV4z65Wi5O
	vzU8BrWAD/GihZVVsdczE/agCuxnlDBnAzUPIPwYk777NnYiPrLtbgEwG4M2NFD+QZjXjSR6M8z
	KdMESArD2c2WwirI+rZXFlD6Qi5ZUN7OUhYDrQr3r8Evxv7zpthCo/QC16gx6EqU=
X-Gm-Gg: AYBFou0FXpDEkx0fjCXktTCooTWGBAF7sZ9l1O+v/cO3YI+9IyanaUBnFxJmAFguveB
	O1vHwtdznU3+7lWpGQQ4xe0+CRxQ4ue+neknEehbDHoiDAxwbA6Gq3adEqTH6e8RHClLptPvn9O
	ItSsR4sZiCinB2P+99ihT9d4Fodu5PzEFx0VO2IY9acWo95tCrNbpw3LTSueqZQ6Qw8ypTd0tsV
	PHS7G7uQi5nguGBUJOL43WSQCGLlQyUsfZaQkJWghJZN1n60drnGJ9AwmfH5u8oWQecnfRtMwBQ
	4Fc5eWtp6b7OFrUdgyH3CellcIiyrQCD2qb2coQVIREk+r33v15JY6qOxl0cLaYvcFjUB9R62JP
	YYRYNCFlkUnCH26YApufuwIzfzvrtNLi+3g==
X-Received: by 2002:a05:701b:464d:b0:18a:d7db:f76 with SMTP id a92af1059eb24-1993fe81371mr11833961c88.36.1793078006955;
        Mon, 26 Oct 2026 22:13:26 -0700 (PDT)
X-Received: by 2002:a05:701b:464d:b0:18a:d7db:f76 with SMTP id a92af1059eb24-1993fe81371mr11833917c88.36.1793078006320;
        Mon, 26 Oct 2026 22:13:26 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm62298866c88.17.2026.10.26.22.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:13:25 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:43:15 +0530
Subject: [PATCH v3 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
 support
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
Message-Id: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-1-7f2a6e572de9@oss.qualcomm.com>
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
In-Reply-To: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793077998; l=3967;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=PKo2E5lKF0uiNOiX1SRbwpsFnqDtSbzKLjXeWX31X+U=;
 b=s5i42SGaBa9JT/TpekblkrBwEAuM5eDOhpdZDGvzmQXh2cquMWsFEi6k0d/83X8LvZQna6eNM
 P5jmeKDIrFgC0NU3NLsAQ+wABLhCe8aKnrzqckNxTc6hMzEyReRoxp3
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX/gyNPLpLvCiD
 lB1LgN4X0R6iRQdy4AYFCt12T4FRIBxnPx0XeQS+EwNAKKkLARE9acIGnMYxIqNmCBmIN0vXWmS
 NVIbKxsbLXNDhXlWiQxFBb9+CMS02nI=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae032f7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6qpgm5iOkbbos6gE2JIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 5_rUyJWDf9fNih4CPH7PNHcQeebu-ZbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX4s7qrXe0yvGZ
 7vfo4B8BVqOhUXe3B+geqOJuQKfnjA7n964X6mgCVG9/ZZ8zWqD46lOEWbEz8ndoo+Ra+1UhyOY
 /Ud+nPR4YNOQbNU08fyUPjsmkKU+tYxXpsC5pvVIuzSsWK6rk1zmps3L2FL5qxhPG9eM33gdard
 NCCPlnZNjGOVCnVNZFi6EM+Am4y/VjU8Y/VHNzsSwkPpms6kB9ieeaBA/jWtSFFqDN9Aw5aQ7Yy
 N/2tziJ4gbKanlqn3KFUv7FJyZNG5eak/tIQDoqd/bh1kp3uZ0bg3R2Lm8rnDdBsO+8InCvgj9L
 hHQVvCOgx3RdP0wkveiqpIvMulHpfMIL+kYSdx4giiES/zPL8x6OMNdFxeNmtUnZUlI0SWdP68B
 tAKVudrZWTnoD9Y5QZK/X9QALg1z7uZMh/oyCtelOts0RYpjVIrWUmcjhJ9jPRxHWrfxszRlDbf
 //JpV2v78kZ4Q0iUXzA==
X-Proofpoint-GUID: 5_rUyJWDf9fNih4CPH7PNHcQeebu-ZbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270020

The I2C_BUS_CLEAR and I2C_STOP_ON_BUS GENI sequencer opcodes release a
stuck I2C bus, but the GPI DMA driver has no way to emit these
zero-payload control commands, so an I2C controller using GPI DMA
cannot recover the bus.

Add I2C_BUS_CLEAR and I2C_STOP_ON_BUS to enum i2c_op so I2C drivers can
request them through gpi_i2c_config.op. Handle them in
gpi_create_i2c_tre() by emitting a CONFIG TRE (when set_config is set)
followed by a GO TRE with IEOT set and no DMA TRE, and reserve the
matching number of ring entries in gpi_prep_slave_sg().

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c             | 30 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c |  2 --
 include/linux/dma/qcom-gpi-dma.h   |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..394e7287f6e9 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1620,6 +1620,17 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 	return 0;
 }
 
+static void gpi_create_i2c_go_recovery_tre(struct gpi_i2c_config *i2c,
+					   struct gpi_tre *tre)
+{
+	tre->dword[0] = u32_encode_bits(i2c->op, TRE_I2C_GO_CMD);
+	tre->dword[1] = 0;
+	tre->dword[2] = 0;
+
+	tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
+	tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+}
+
 static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 			      struct scatterlist *sgl, enum dma_transfer_direction direction,
 			      unsigned long flags)
@@ -1650,6 +1661,12 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
 	}
 
+	if (i2c->op == I2C_BUS_CLEAR || i2c->op == I2C_STOP_ON_BUS) {
+		gpi_create_i2c_go_recovery_tre(i2c, &desc->tre[tre_idx]);
+		tre_idx++;
+		goto log_tre;
+	}
+
 	/* create the GO tre for Tx */
 	if (i2c->op == I2C_WRITE) {
 		tre = &desc->tre[tre_idx];
@@ -1692,6 +1709,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
 	}
 
+log_tre:
 	for (i = 0; i < tre_idx; i++)
 		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
 			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
@@ -1825,6 +1843,18 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		nr_tre = 2;
 	if (direction == DMA_DEV_TO_MEM) /* rx */
 		nr_tre = 1;
+	/*
+	 * Recovery opcodes do not require DMA data TREs, only CONFIG
+	 * (for set_config) and GO TREs. Since gpi_prep_slave_sg() is
+	 * shared with SPI, verify the channel is I2C before accessing
+	 * the configuration data.
+	 */
+	if (gchan->protocol == QCOM_GPI_I2C) {
+		struct gpi_i2c_config *i2c = gchan->config;
+
+		if (i2c->op == I2C_BUS_CLEAR || i2c->op == I2C_STOP_ON_BUS)
+			nr_tre = set_config ? 2 : 1;
+	}
 
 	/* calculate # of elements required & available */
 	nr = gpi_ring_num_elements_avail(ch_ring);
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 5cc47b670bd1..60b6273f538c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -34,8 +34,6 @@
 #define I2C_READ		0x2
 #define I2C_WRITE_READ		0x3
 #define I2C_ADDR_ONLY		0x4
-#define I2C_BUS_CLEAR		0x6
-#define I2C_STOP_ON_BUS		0x7
 /* M_CMD params for I2C */
 #define PRE_CMD_DELAY		BIT(0)
 #define TIMESTAMP_BEFORE	BIT(1)
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 332be28427e4..b9b75c302825 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -52,6 +52,8 @@ struct gpi_spi_config {
 enum i2c_op {
 	I2C_WRITE = 1,
 	I2C_READ,
+	I2C_BUS_CLEAR = 6,
+	I2C_STOP_ON_BUS,
 };
 
 /**

-- 
2.34.1

