Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756746;
	b=G2hytoxSM0ryEmLkg2RdYJjszQ3pvGMx7k/PCuIqXFXGlAFRVehl4f2TnUyDYVc9HGlV
	 yiVUabbrkonkuw16c0VrHlwNe8URmBxtMP0yOaGQMnb0hHvlTgYrd3k0+bGXZUcdvjFly
	 1KlbEuIEU+kQoZIJ02Wi8mXW3befnZ6BiskPQHJY6QjQ38IBieiu53Pgd++/rj2sRyq/k
	 EwOTaM++/Bn8tXkcDdVkgKVgEBJiVIETb/mKLPax4FQtGpMjDUQPJWldl43/lLZ3Z0338
	 dl0ft9MgCvcdR1LTaXEyuZqNH5qsxjpXniAtS0aI1nD5EiU3xEsiKy8Ky1tp8dPt/cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
	b=bRVOkFvnnG5pkF177nGvjFQ2PCJXF7r9QwyLmdXFxAlcFEGM+UEdTTFpkUGUDHD4A90+
	 sm55WSYFcXTUhlb5ykacSM70VE5lrLU2QSYlmy7lHYrrwlgMBCPYWibgZ9yGzM6CXli8h
	 58GV5KHnVtY1jNZguRrEl546qpcPHu6GlHwBDUHU32IuGSsbux/SBXUqG7GbZ23M+8nfg
	 Pbolpc2AykD2Jy5qFmtXpYgv/QTybC25D/snvtflcKnnoxNNVn8078Hc/AhHclLb04A+L
	 6lc6jZnuhYR6ngLmdmJ+mmnCVZ7gAHHLVES3RguWR7zPSJg0Ox1xFylEVIkhv4rhpkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKH2JYuL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dl3qYVK5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A57606A31F
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A57606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKH2JYuL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dl3qYVK5
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAZ721948506
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=; b=eKH2JYuL8vVAOhTe
	EcoKGbCgLCKN3DiGqlfrYPLTKRtWNvrJJBwqV/uOQMdg5ErLJQVenDE85CMtHD12
	As5qVQMIjkByp4QI720JNVUT8CSpS3L+hgoX5GGHR19zbVCTZ5NDOKOO1nAn+ere
	wUn7IjSg3frFL8I9RuGWw8j2bkEpGP2ZH+Xx4BQbxrqiAch1tREnNPDjt3EoOBND
	2KD4griMj0hRV0iJ5D7cvbkey/JnRmuW1kYYRnFXwSs3uBr0KS6Vl35SPAdurUpt
	UVH2S3x1vY0BdJuM48KPa57obMNvLpnn8iwjSXcuy2FJSjXbT5u2FZWm999Vu/Ed
	OS5lng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtujae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so1289109eec.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792756744; x=1793361544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
        b=dl3qYVK5M9pOXYNGvRZdeao/OB1oyoCTgzPO03hdHDLIMjF/FnFoHXga+4QAbh7hl4
         une4OVS42Jczi4nU5ZV7iD8pJGNLM0HYf3LDfELV9O1GzbkairwxHzePtn3wdUVeBcUj
         5s0EbAI4O0/IIU0hAvL/hcwX1f3lCanzfBXUo0yXIjhuxUIesTqR8Q04/JNZeySmBAAH
         B+yR6QUrdTu5EFyv76mzD0RvwtIkxr7vg0us4EyS36i+RUe6FbLX8sYitjq8BDTZkQxU
         y4mr6lXR2WX1LJfZhytBP1+NcFbVX2oHKoZcxDM3WHb9VoO3hMTjUUJgxAUBHuTkUgj3
         Yz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756744; x=1793361544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1RgB/u4FYOFJ9I2v8cUNm1qwVXOej45AdlSUJ7c9/o=;
        b=j8j8qSIDavlvTY7ZRroj8r/BAx+fGze75BfriPuLDBhreZLKAlDpXPFccyYKzW+x2p
         8yAQ2dl09e168DiaDgN5CZDwpf9HJ5E4fXf0r/65DVXKxE18MetXbMBER/QWa0CKzB16
         q/Nono6o66GctzrNRCO8mGVz2gCjDhrFZO4M6ft4GxjykRNda9yHIhCqU+G15KxLomrC
         i7fAZwxBpoSI4UswZbNviHT4q11gBxeAcjch37ug7Tdu8uiXLBWfVeLActqPHUJHkosR
         k8yfYP9IrOIq4GToX/vOqArokKiZR2bqewO/FKggryl9tmlYuaJESJF9DJteYY63QNRU
         rifw==
X-Forwarded-Encrypted: i=1; AKwUvBzktrAGDEP+AUamcWk1KzxqHVCIoFF/0gJxs/bjYpsbX9bvR9YczgcPrdXunPkm8bJF8Y75AywDHc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeAAYjvOfYh4qt4/4nEq/Xmx9qANP6ElA3OiMZPBUNus52SN9p
	DyvQqHHHdF1T6NhKPVuGSk0+1d4fBbm4w4N+R9AHOv07aumwisHNp2q74RgI5ht3gwlD2YeUC7z
	SdzU+sU4AB10MqfIZNhwPNpNCSyjwoOSYt5lbm+mjGceT1K3MD9F4j38oyIZTebg=
X-Gm-Gg: AYBFou2dajiGCybDCjBTj625YW8Bt0i1mQI2sCoYirZcR6UL6yZOTANJvU2z2vhcKMw
	IV6yQr2zISTGavWXQH6ufduqHEvswuJOIUn2cyLucpdVZKvFZQuMuZJTYxSF2pQDAFTVO0yEm6W
	GM7sXwDUgrpnDgwXlBMPbPGVPoc82awEw6yxP+rP7YyPKDGOx/bccKl+6wAD9zqib/tA7blnTv1
	QUQZdXtZKoprwjzxK+YcHklaxZP+gZj/stFaRW5MTQiui9JEgzXcb8VnCcNf2c1DuxPGQJWEs9W
	0ZPKUTZzpLZ2xmUNUC7sVRgOIheoNLOKynQdQn3cVjKZsHDfx6xdGYw3rRjEkyWRh8w4Sh6sD/H
	Qh7O+zJXpEpGIPeDlyqAxwcra8LadPK8jBA==
X-Received: by 2002:a05:693c:83cc:20b0:366:703c:5f0e with SMTP id 5a478bee46e88-369d98cf32cmr3125607eec.35.1792756744228;
        Fri, 23 Oct 2026 04:59:04 -0700 (PDT)
X-Received: by 2002:a05:693c:83cc:20b0:366:703c:5f0e with SMTP id 5a478bee46e88-369d98cf32cmr3125553eec.35.1792756743505;
        Fri, 23 Oct 2026 04:59:03 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm8786134eec.5.2026.10.23.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:03 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:27:57 +0530
Subject: [PATCH v2 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
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
Message-Id: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-1-93572b453d6f@oss.qualcomm.com>
References: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
In-Reply-To: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792756735; l=3967;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=PKo2E5lKF0uiNOiX1SRbwpsFnqDtSbzKLjXeWX31X+U=;
 b=brNNiZEDteQb4CFP7id0C5NhBneYvT2iQpHW1zf9NMsf6TrevSuuWss+WiONX9IDVOASzd1y8
 SG/khm7i2iEBgep/hlN+zjnGSgpJSZ+3ASHoTzh646TEM5Okxy2N7ec
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb4c09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6qpgm5iOkbbos6gE2JIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: RpPZcKY-VTKdrFc3Y2wnA1DSxqmXSvpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX7gVVFXwPqGsy
 IsOZV6rouMOLGWt7oUsDUWCay4zO+ZQkdljcZyhc90BSMTOesQBCYFD5sZ+bnASaJWZCJR/n4oB
 hJbd+dAQ6IJ2vdjc82/NMNI+Y4Wm4AAwGIEwr52lsa6CM33L1zPyq0lSqB7/VPVwHj90qX0+uHZ
 xEyDYZfhUJgSRFMhq+xG9Vco3I0Ly/TIwS0tyf0eFkA5tqv2NdU8RJr4wgSX+9bp0zBhUL8UUan
 OHAt+yhlv/Kq3Qb07SYZDXATgXAP3oNha0QGTG2oL2JfmO5SnwpnWgrLLqOUTymgXC3j16/s0Ny
 SjxEMT4noigagwXeK1DgYLELPipXoRUoeXjKAu4769FRytD2tT2V7kI9JGB+DUSBIV8yDvWVpAj
 owfnfoCQMavquEH7F7h8UfmVlDKpq/NXZ/ls51MQZJ5DMLEZ2hXMWQJA1bYggy0rVEx+tTzLV5U
 Iw7RZr0S/CKzJaRKXLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX3fMDJmH2wduT
 1+P5bl1oVluTm28U2gdxD8ozLvhK9U5BMFxQ/xYXXn+XDh8lEyuWtN1ib4JxefDCmBctv6Z8Rmv
 OCdWMADSmogzl38FOHfiHpc53r3U59k=
X-Proofpoint-ORIG-GUID: RpPZcKY-VTKdrFc3Y2wnA1DSxqmXSvpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230046

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

