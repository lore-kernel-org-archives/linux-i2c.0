Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2053D6473
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737905; cv=none; b=d5nA5ne0slf7BLySBwtJvRqOdQoon7yq/V5f+I+gO4ZTkKo6MEHLwcfa8KjhOWWQNLTcrMw/sLUAxJ4aryZ47/9Tl308woTxQaCJUawikc3GdOsHBuLByk4hjN1BuSa/Ul9BEe8ldrcAWkXcuS2r6Me0rGCDvzqhzZbCNsWpvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737905; c=relaxed/simple;
	bh=q6lnsY3bEIeljUOjeWLcxQADTc6XmvxdsLsC9iNl46Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQwPXbkkoQzZNvgWYa6PuNf3UO4XBGCGQ2cFtC3hf5dlWjGb65CmaO9s3AN/BdD+Wpbj/bwRJlLCSgTgT+jlvtYvg34vM88v938hmZXcxs+c4/yywPCLsJkhjb1NhaZMX704md3u/COGSvBvwYqZg0P4CMsBHeLli1IkjAOCazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j1sQ1Txe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RyTK3mZZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1sQ1Txe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RyTK3mZZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9Cetg4065774
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0v2IFC/8lEKzJob5TL4TVUywpLxhBRcIX0pAWlcuyR8=; b=j1sQ1TxejlHTvZyW
	zSnbaoPSaESIZ+G7RO5Ebe+2H41He0wb9adEJg/oJ3QKy7Jg7QR//jG9Sa4UcJfN
	fHAXNrzjTTB+i7d1VOcS5+WyFfkyJc+EzCh+/x9n67tV1lrMbio/c5p7jIPwFqBn
	Q+Le+/NYYD8XWfcoC1uKpAWMdcsrtCJvq9sOwGLrR/zBW7/bVYu4j0atdYMR/FMN
	mUiERTBAR+eavw5MPx0yQvwtJZuEuw+p8Fvr9Ruyxqkv9o0OICSNBi/JeODF0H2r
	qjAhh6jBAbDMKB0EM/Tx8TFhwm901JVbwSfc/KeFdIrEErfBD6RWHaIsTJEupp/r
	S/ilmA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn395p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b6f19bb3so1205716a12.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787737900; x=1788342700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0v2IFC/8lEKzJob5TL4TVUywpLxhBRcIX0pAWlcuyR8=;
        b=RyTK3mZZHYl7kdrJW5/fjkaO9E6HW0xOg4bocbOsEOfcMQ9LgI8Glyzs50rzeE44Rg
         G6MJAW7/iCKK4O+LXFMtRYUU0yBNOGz//Ut828/s2ytQqBzcyvKtfWF4vkui8ytaneDn
         fLedTkvjJ9GZZEjbQ32m4CZo0cSqXPesIblznQxgmTWUhIytyNYFzHNyhiLFLpb50s/F
         DeQ/hd8g4fe3WDNwillc19HOINa9+2YHGagfrK1tJQxPGqjlMxWP/4WfN8M942Pf2SRV
         EsriKDz56Tq98RYFiVTX8K6CXRP1YL+qv9RygmebH41E8LOACjMnNvqZRARkgGhCaPel
         VStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737900; x=1788342700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0v2IFC/8lEKzJob5TL4TVUywpLxhBRcIX0pAWlcuyR8=;
        b=LPoB+W1Zuxu+PgMW3d2//+wyXZjbKdUZJs8qmomkil16NR5Iargcrw1pZl2VPb0kWH
         I+eSnFi0aQqPyNMOu2Q2dsIm4efpi1OPsDyjQJT6nwdPgyllwPt31LBPHMPJEW0+Ejb1
         mE+ErUAnGOiVVhYAPd8VLeg4BiqL1X9FDoBBUpqIVx2xbCjLZ/UiwpTwhuT2kRgWKloQ
         3ioRTB2uEzm3ZHyyGwN0Xx5N09geCyf5/tGIOG5PXaLTkJyp/CeXQOvI2u6Hc+hDUfx0
         o/OQufLhZy+fHMxNSBfzRYP8lWEn5plj69NoqPvx3+jPb4TCbb1U0JP+j+sqc2WgkfgT
         JTjg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5lZH1v+GeW77Sl05NMU50riCZqFZrJ3k0CuS0NhTIfo0nRb36olQtka5szspgc84rk5T8x2OFuM8=@vger.kernel.org
X-Gm-Message-State: AFuF++kLbMF/3/O3qzgQX4t583F/eSnvVHKdXFh9aw4pbBybP08RZwYa
	hiSpV/3w6SiIM8jyO2bxGKEMOsgGLAmkXfMuLpOlK6aC25rOecGR+AfZlb3bBbbpXIh6dkbXqY6
	kkOjOp1LbA5Ci5abJEs5BJCJFdpPNVLxOVjSatMqqVtf+SeYjcc0d6aO8OCu1UuM=
X-Gm-Gg: AR+sD11mS4WMXQUdp0f+xxfWR12xedHVIVeGMyTqWHk5lJKUGqWk6hvvKBPzdjJqLXc
	7p/XtImLT6JRwD9UYevnfUbi/sXqMQgOA5k3LywckeRBmuVj7vQ0BOpUtLrVNZSrV7yGnbj7C7g
	QBAYob2Dj0EsZVuMXLOMSO9G0ybqb0a8eHv0KBzm0IXBxIy1d0zs2+kNAYZDMDV2U6VNSYTSOd8
	bVAxhHRd3AyZTlpxR7WpY+JXjLQY/g5huUYyAVWfIlcOkexKqCYOueYW03TbTRKtKXrEYMq55xv
	GvUejeqJPQpOgToYPS8Sc5bQhs42FJKOJRpZH3+PdOnObzYL0XkFrP0vk0iygi0sF06E5OVtjzj
	xAjH3uzC9CjHacYLMGmQNJ3BKI9RaF2r3Wgs=
X-Received: by 2002:a05:6a20:c786:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3cf84c5a493mr12527258637.12.1787737899824;
        Wed, 26 Aug 2026 02:51:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:c786:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3cf84c5a493mr12527171637.12.1787737899416;
        Wed, 26 Aug 2026 02:51:39 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm7249738eec.23.2026.08.26.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:51:38 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:21:22 +0530
Subject: [PATCH v1 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
 support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-i2c_bus_recovery-v1-1-203f0ec76f84@oss.qualcomm.com>
References: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
In-Reply-To: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787737891; l=3434;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=q6lnsY3bEIeljUOjeWLcxQADTc6XmvxdsLsC9iNl46Q=;
 b=5w6OCYdxBkdnA/Vfk6+SF0rNAOMSGJ7ci5lTeen32UHILV4bOZD6Ou9Wrwq2mxwPaq4Qp5Tks
 eOIaDGWrWbfD0zmdIX82fCBLN0RZ0TOmnlNDvD99I3ssCe6xRiLXdBt
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: KL3mmeqIfQRKvsPh2slow-wo8lcBnMN9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX46YQspA1qmA5
 uq96ViTOGUVQKC37WxPYslWYKTuMD/jEKhhZWJi1jABRSKoSTluX6KuhtNJwY3YlGIYAdediJUF
 Ve1Cexh/JGijzN8kwe7JXEkdEXnuMfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX8iwnnFmW3pbI
 9HO5BHkQnK/gTlx7sWau3QSks8Y5kswZIety+mVHaRt/EMgT0Hf/OTM2oY9wTBkFx2jlByDuoNG
 cGlInZUOAnLj+KAcl/iyXLBCx80eegrODb6Q87DLn/X66AqPOKnoCpXktiO2UYitaekiKoHWnMc
 p/T5iub2PBGkwe3HMax/WLT8RdFeSKPh/kd6D1h2VE4Og1yWRTDZT3plIgxvRhQHmViMXzOqMiS
 l9+7kXp3w7DtytYH6iSV67YLwmt0v15o90If2cmckYw8sedCAmAv58xFO1I9AcsdqLFnxryCFxP
 y6t8q+Iz1Bcu6Morrgwv18NzIZUjyE9bFhegRXoED59AHX7OF6DMNMnsW8Ei220GntL/0QXZDzl
 JrNYTz0RuMltFf+2+B++/cbhSZaVbMzf/160lIVWd6QlMaUr0+cJIPB8lm1+63sr98togixavVy
 9NaEM//NrOBhQgmMQIg==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8eb72c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CbeJ011b9i7gwIzP_X4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: KL3mmeqIfQRKvsPh2slow-wo8lcBnMN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260081

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
 drivers/dma/qcom/gpi.c           | 30 ++++++++++++++++++++++++++++++
 include/linux/dma/qcom-gpi-dma.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..14a74f0a602d 100644
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

