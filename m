Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA84204E
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499522; cv=none; b=LZYAdge6vNUevfe5b3n4dcYP+Z26tQdlD5Tt5+amFlYtO4o7NhkbVKZG+NJhLggyzzeBfRwlKRgrREsF1wc2AZYrv9OkMINr+G5NyB9z00WyetfFxGPzZ9tu3P6SAo2XntyfF22UOyeKof5+jsfq9OTsb+B/xnh2q5LE9mk0VFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499522; c=relaxed/simple;
	bh=NpFXvrYh3Fb7+pGlr/Z61Pb78xmA51Vjq3Rxx3qOVtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=npg+ILDuWh0z22AS7tJKYDilR0xzo6y6XvAEHIzdK/TkCXegUD3g8guCo+bBm6O5JH5OS4vA8wImYO/KAUfntnrfRe5vvoz+X/ZTWy7q0KKdc/B74BtbYcAbuaEjlqVWMFIyi9hlmM8BDKDZ3336fwFdLvtXEhfvzHYSliM5Fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hKKR2OBd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jRKyNcVa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKKR2OBd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jRKyNcVa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PMIFsw3070099
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 04:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jJRKMt5STVkyb1Y7d1ZgMO
	1sueYs1DgBavRo6QS64AI=; b=hKKR2OBdmKOqiTdbZ33hIuMhZ7JhUlOiO93CcH
	DiZtkKn4ZzwolbcR/CwQhTILnreUv0fRddHGSqh7q0cmXbE/A7mxKhFV+R1ogc80
	lhHH8vDCGt17uqM3QSpcv6tfZtbD+MICx7s++bLr/jcSBgS1AnRDFwtNXLG+6ayz
	hRWyuph9K6ZJv/lP6CNm2H2/ExRSupTSt7/cu0Tzu76LkaQFFCyPBepQ2M3/WvIc
	J9xuBcB+qkvEhxejPXgEff/oU7iMB3As+oCu9W/mvN0R5oXzMczXpQY23wX84u+o
	IHBEI8tJUF7r/+BXEfR4A/GWj8EKWFS9KP2gol5WElMqucsg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4rcn0wta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 04:31:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so1810541a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774499518; x=1775104318; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJRKMt5STVkyb1Y7d1ZgMO1sueYs1DgBavRo6QS64AI=;
        b=jRKyNcVafX97FOVAMt+S3IOON6nCEo9Jleezk5AV390i/NVCtz+W7/H2QNtl1mvtk4
         BCA9NIThhWn11oIW6A8xIXcrGfk+cXNOFRdoMC+h3eJ1vGPfbDKPafQUYqzUsLL+Hl96
         1n182en5lJcOtuJN6QKpYpRhjNXUc3Yg4x+G3SMDloWi7ZzO2bLRyD0nPmysgEA0QtkO
         s+4JjVOkN51Hm3pvtpF+JkxSbd+YHiKg9GlmG05EzPy/820ZP2B/o8SEit44inozA2n3
         sVu62DslbD4onrjmUO21sO9AXoiuXbxoleaJzUXLBeKrW020rxS+8FuJvzxKVVOGkR/q
         4bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499518; x=1775104318;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJRKMt5STVkyb1Y7d1ZgMO1sueYs1DgBavRo6QS64AI=;
        b=SnYtJyEVaydgCUOUFBd6D+Mm+ETQVghdojipNLIBSc5H1+Z4P4WN65IMZ1SQ1wGKrg
         emu+dO4ErLcxL4tTn1IBJmRLZO8zuH8Lgn6f4YmGQni2pCr54OPtTr1ZNzeXj/iFsl6p
         QQjQv2n2+bGvJdUJ5SNTr+b21ReJZii73lvwAt+qE568d7fh56ofRw6Ye1+bHvC+Mmwf
         Qh40AZ0jX7kQa9IOGotLCoLBzdmnIegktI7rph/bc3FSQGmjQlx4Ky6wvGd4Z5410583
         BlSHa9qcjcD3EgWAyQE9dOAdA0U9Pqi6hvN4FowV4u0m+ytiag06lLrugUxHFJH9dCMc
         U+9A==
X-Gm-Message-State: AOJu0Yyx7dGtTloL7nMn3ioenSNMEBegoezPfGf7BAGkqxyzzjt3eYNq
	JjPm1Mq3uz/+R+7PY/gIW21p4Gj8fvfsjydvmwT04xqriR0eR4H8aPso6+4l1Al/j30qbr/4KqB
	TqhOguH+FAz0ZF91dgBaoNGBHpqe/EwJEUtld3IIW8SfZySKtwplRT+L9HpWNU+g=
X-Gm-Gg: ATEYQzz730XARqNEWl6wpVCksHsdj06OFFbkS2GK8HcdaTknUtSDTELhkvcA6tAvbSP
	bRc6tz8R5LIVk2Xsn1mQxxBYJFl2JEnZwdXKoTuunPNjddlbJ6iw7jAyBESGmhMSYntXQPJ/+dj
	IKAb0a6hba0oui6CTPYLf6fImJsjgPhz/6hQvj9h6dviVq8jcfAglMUyOl3wRbQQB+Q+mB8V/dC
	oPqH0NATj8UFflTTQi/3ZfqrisR8tE69ZS5GZmZCLeRsV4LtY7VHvjiTrMaMjCiNh2s5ScsRP6T
	lmNABYGrAZYEKjF7KRMaCiQeUG1+TnQR8OybP6U5ojQ8lOQdbeyqzPQ/0gzK+REAUbeyB14e346
	mozbHWTAyUo/nYP4N4KpIK1cVkNBxUTgyMNI/iODFmYVi/bJD0kI3k8F2
X-Received: by 2002:a05:6a00:4b0a:b0:829:809e:8981 with SMTP id d2e1a72fcca58-82c6e0e616dmr6256922b3a.31.1774499517596;
        Wed, 25 Mar 2026 21:31:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0a:b0:829:809e:8981 with SMTP id d2e1a72fcca58-82c6e0e616dmr6256897b3a.31.1774499517105;
        Wed, 25 Mar 2026 21:31:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d22c8e8sm1177396b3a.24.2026.03.25.21.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:31:56 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:01:48 +0530
Subject: [PATCH v1] i2c: qcom-geni: Skip extra TX DMA TRE for single read
 message in GPI mode
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-skip_extra_dma_tre-v1-1-deef018895dc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALO2xGkC/yWM0QqDMAwAf0XyvIKNOLb9yhiltqnLxpwkVQTx3
 +3m4x3craAkTAq3agWhmZW/QwF7qiA8/dCT4VgYsMZz3WBr9M2joyWLd/HjXRYyvgkJMV1svHZ
 QwlEo8fKf3mG28DicTt2LQv7dYNt26Um64XoAAAA=
X-Change-ID: 20260325-skip_extra_dma_tre-a3cf22f81d9b
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774499512; l=2657;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=NpFXvrYh3Fb7+pGlr/Z61Pb78xmA51Vjq3Rxx3qOVtg=;
 b=F4oCSfY3o5eliC5a/9PowUrf5FxpGtSwz/W4vzzQWSTjf14iwuzX8WrayFTCnK9XM9yo9kEL2
 Iw5BwmRKNyMAZKpj1OK+i5GLjGWoi4vXfVo03bhtCg3FGxQGx7hFxXK
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=Vdr6/Vp9 c=1 sm=1 tr=0 ts=69c4b6be cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QTaY6CSZEmO6sGPGzGoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: wixJuHoT9BxSz3wfbUmmaJZSBgDe9b3B
X-Proofpoint-GUID: wixJuHoT9BxSz3wfbUmmaJZSBgDe9b3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzMiBTYWx0ZWRfXz0aRYbpLQbRT
 xCKzHBTmcTsLYog05zyEzkogull5djMa4lI35zs26EJUZmf38PKN2sKO9Xc8H2BEqNfrJ4lkVl9
 4aPU/RLRtN4C8EvHUl2yfWhiwL2QxavF16Ur1XCLWYqX7C54FMIbwANpZCSXPM3r9ZbLyKxfL+2
 PbmU8LZ+zUS30lkIQCWEJZWIhzEyQDb+Jc+lJNlWhgpIIc0Brpn/FlItN6ja9LNviY+96c3fiG0
 87vMlF80JxRqk41yBL3nGejaUe4oOC+/4v5CbpSXY05AyT4jbhLw4aogDHzKfbqAw7W4yzIVtvl
 3W5CQVaPwuC8UoI6J8z/o7LGcuMXlircKZp4O0nHL9kroEitiDS6Ele7BM31lpL6cdn7Pggo0Qm
 8LEoEo3aUj7SZje949IWoOpDEr3bUysYdfFUL9Y7G86I3VeB0XTL0TfnlcJ/ByFQcPbEUd1qd9D
 Fkkn6MHsM2p36wh/xmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260032

In GPI mode, the I2C GENI driver incorrectly generates an extra TX DMA
TRE on the TX channel during single read message transfer. This results
in an unnecessary write operation on the I2C bus, which is not required.

Update the logic to avoid generating the extra TX DMA TRE for single
read message, ensuring correct behavior and preventing redundant
transfers.

Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
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

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260325-skip_extra_dma_tre-a3cf22f81d9b

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

