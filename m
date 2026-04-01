Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02E3E0C62
	for <linux-i2c@vger.kernel.org>; Wed,  1 Apr 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038446; cv=none; b=IFLC33ItPB9lE+EXIA1JRITMLJ1kxZnxhgfYlZ7X1xxVXWB3Hee/akO4kUkqO/a95WQtEurG4AuLa+nDxTLLIkv69QSFKl4F6iqcKhFAXjwvzn5VxEmDIwQbP0c1myXhjwQwDZMbG8BrhOZ9gk2pt2B1r+2SWg3cylxjs7kYPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038446; c=relaxed/simple;
	bh=EEswu+6fbqBa08SHQjIIuTp3bMH1hK4CRlphTe6mLzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6cCPqDxYQEhuTwFy1bzOy20qrXt8f56OwMHaMt1qOPII8DNIf1g8m+jeyO5mxLBOxKLy1Ompytu4tWYqJNG1ztALWKwJlsQJScyp9P40yMa8cWYa7XQLqUDyRbfSYI6ldCcgOi/1mt77I3p70vN7ao+Uyw5D6tZu3Xu/qqPtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EcQjUpHd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E5dUNcsw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcQjUpHd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5dUNcsw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317AVOG1578381
	for <linux-i2c@vger.kernel.org>; Wed, 1 Apr 2026 10:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1
	Q5/kWemM=; b=EcQjUpHdFbEXKNQ/vGfUKZ1KOJKi+aE+2oC3k1CVSMeewo+2ORy
	20/hBfCvCAR0AsJf1BRHeHHeyU/6Q9FkUxS48BKl3Gs4WWFNeQDrUxbWyLeOjTjm
	w3GNLs5dSUtyNn66o4BOGO32CjS47lJQMZhphely4uU79bVwKxqy773iaqCSNrbv
	oIw1OVk5qLJlYrj29TXp9TvseLr5eAZvZYHpadqwpDeWOhM90dzssrl/BOxgrMbw
	8RLFkyR+p/KOuPkU29cD+zUzT891yXFOMeHS1iY56enkVPWOHJ8MpnHrbUgeNPaJ
	lZ7XG9Cgj7puJExfi8mPEhT8nibUZDvbeIQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8k6kuh0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 10:14:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2489af602so8914995ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775038443; x=1775643243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1Q5/kWemM=;
        b=E5dUNcswB0gDiEpgmyNjJPMO+QjCBuOy77C+HvV+uVIiHo9j8CFVBtqT559ztykr0F
         /h0CcKkn5Q0p2YwrCFfbyzwWdtc2saFt8CBea9XOBBtOg2UyQS0wQmXHzoo5la5E/NUt
         zBZpKeEKkokGMID4dcKgFX+M+XX4eEEPNOsbPXBVx7in0TJTdiTdM6gOXqmb3m5+rrXP
         WkDk5Do1vUmKurQPT9A7Oa3uxy8/mRYjURTkoMNkCdE3U7w6MKtTmwsNKbB12kbwW50x
         ZpYjpSheAUc27m5EG5MsV5wB7VdNSs1sNPHg6jl1z1Dov1iJX1x2i5vv68O1krOAKI+O
         owiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038443; x=1775643243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1Q5/kWemM=;
        b=ijjeF6l9E/vsh1eK9Cf8Kvi4wo13h2pw+KQJvlu8H/CZCkp0Zra6ftCw+zR+qmAAaF
         S6ucOhAMn3N7VRaMnvl9wOsNIFk6abSyugWsx1E4S+74GcO7+DO5v2lLHeOcjIQ+kAl8
         KQ1nY6O0MJdT7dPVe6oLONm6uAtYWXLa+TOSESJfqBBGQzmsqFlDXXcoI+3n7bJ9KzKl
         AsKRLbDl7TF04oEBwppzZdEFX9nmhtZCUPpjgQBA+YffrPU4A1y6ZktF7LA/gOuPH1oJ
         VBpX7/mfl5vC0W4ew0gzaDhbaRZTuoJZfLkeuJlhBg+C4vtjrBh9jMpwci3g5gBWAwVw
         LQSg==
X-Gm-Message-State: AOJu0Yweu4kqzDlB6eMcVqKFzI/w9UBdD9ab6+3oHOOVlbP5iQK3TiBp
	vsMpreq1QKjIFYhYJIqtPhDWmqZqb9y49AaoTSMrb6w4lxGVXUuHhtdSM6yNORy5N8gpjgZGFkJ
	CtA4gVCHcIv2GJ9bCsi92+wFTTUs2UKkfMKrW6tK1NIGdSnCyolD3WeoQHTZkhtE=
X-Gm-Gg: ATEYQzx0msv+zbI/NNjIhUt3Cj5k8o0+ypdXdBYtsu/Wz4FAlyTcTEfT7L1iP+EsAa9
	RP8WPaUCTkRyxZCeaHLbgBU81e3qUy6WOXxSYyFVkL++Wc6+lWHB+DSDzO7FjlROh4XzZwX+SNj
	YHrDk0sSVupSafRBbQb2hod7pFbI/iILEYSXVO7Jpz67UP4KjDxOfxQymR592yVvcC2i/dLnlxP
	Fc7QoucTdiVuO7lfOVa/mshZL+M0RNHajQhRBr5C8pml7CLWsr4SOWOFrRDKjiJyXJ79d4+euvx
	VXK8mPDd7TtRPOPVCJYdMRnWAZSKbJy+aiytg7CPiIPxceoLNRH4BH3QTqETtXlfBEQ5JM66ijS
	tgBdR863QdThjDBlfFLRWWJgYl+m5rX8oX+hGyZcHwC589letzshgSrWP
X-Received: by 2002:a17:903:1b6b:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b25efabff3mr60943195ad.28.1775038442608;
        Wed, 01 Apr 2026 03:14:02 -0700 (PDT)
X-Received: by 2002:a17:903:1b6b:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b25efabff3mr60942995ad.28.1775038442085;
        Wed, 01 Apr 2026 03:14:02 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5f5bsm148503885ad.82.2026.04.01.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 03:14:01 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V2] i2c: qcom-geni: Avoid extra TX DMA TRE for single read message in GPI mode
Date: Wed,  1 Apr 2026 15:43:52 +0530
Message-Id: <20260401101352.4065798-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfJmkePB c=1 sm=1 tr=0 ts=69ccefeb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qPv6kJ6rrmvbaMxWJaQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5MiBTYWx0ZWRfX1gi/ipkGGhzW
 sgDTFSZUSIIOBxwAC5rAG8WpXiabJ/WLMwD9J/kOGJ2uJwkVH3UDYddM/qBKzp0up32sOb37WDX
 KkS8ftR/OinGUbwqptiemIzMTazly3f0LV1gs3OY6S8X0j1ZBdn3YMm9i/gfSi7icoRnCV1CpcC
 1JWYD29YbDunuSxbgUOedbnm4XfxAs7Q48FJ8NFp0qVDItT14LeZUbjeq6eSxa7VvW2HHxRdarZ
 q/9hwI/arKYe73VUVUickCXbBgWdm/5GUoJ3sxF9bujpS6Ybig02mE7vvmE9Ktf+VKzp4qRe2uE
 DmNFT4m2Cr4WHNYcMfUI4WCzak/Gc4HF71bRM/h6sFiRUDzSMD4O3MKuobTTuWiTmL62qyUOALU
 noSvJWhdDeTjn8yi34Zw4cjqw/DNqWRs7jiwPjUb74XzzFcI//85gNKRWQL871Tqpv4LSvnXJxg
 oLReWCS6VjE6OT/5jjw==
X-Proofpoint-GUID: S9mF1jKoG8Uq_9nV0lF8jpTeh--yefHY
X-Proofpoint-ORIG-GUID: S9mF1jKoG8Uq_9nV0lF8jpTeh--yefHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010092

In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
descriptor (TRE) on the TX channel when handling a single read message.
This results in an unintended write phase being issued on the I2C bus,
even though a read transaction does not require any TX data.

For a single-byte read, the correct hardware sequence consists of the
CONFIG and GO commands followed by a single RX DMA TRE. Programming an
additional TX DMA TRE is redundant, causes unnecessary DMA buffer
mapping on the TX channel, and may lead to incorrect bus behavior.

Update the transfer logic to avoid programming a TX DMA TRE for single
read messages in GPI mode.

Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v2:
  - Updated the commit message.

 drivers/i2c/busses/i2c-qcom-geni.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..2706309bbebb 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 {
 	struct gpi_i2c_config *peripheral;
 	unsigned int flags;
-	void *dma_buf;
-	dma_addr_t addr;
+	void *dma_buf = NULL;
+	dma_addr_t addr = 0;
 	enum dma_data_direction map_dirn;
 	enum dma_transfer_direction dma_dirn;
 	struct dma_async_tx_descriptor *desc;
@@ -639,6 +639,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
 	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
+	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
+		peripheral->multi_msg = true;
+		goto skip_dma;
+	}
+
 	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
 	if (!dma_buf) {
 		ret = -ENOMEM;
@@ -668,6 +673,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	}
 
+skip_dma:
 	/* set the length as message for rx txn */
 	peripheral->rx_len = msgs[msg_idx].len;
 	peripheral->op = op;
@@ -740,9 +746,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	return 0;
 
 err_config:
-	dma_unmap_single(gi2c->se.dev->parent, addr,
-			 msgs[msg_idx].len, map_dirn);
-	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	if (op == I2C_WRITE && (msgs[msg_idx].flags & I2C_M_RD)) {
+		dma_unmap_single(gi2c->se.dev->parent, addr,
+				 msgs[msg_idx].len, map_dirn);
+		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	}
 
 out:
 	gi2c->err = ret;
-- 
2.34.1

