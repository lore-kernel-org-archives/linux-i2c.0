Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D9284B37
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816400; cv=none; b=kNOah0Ug7psiTPQvMbMzYVpRcd7W1KroO11X+miGksy+Ao6zWD5ws6zN6gSnZWZpL3lm2BTkV9WWV5iUp8Rt666Nhb2bOAGR2mrBrxYQ84yue7HhD5mWaptaM0gXCib7XMmB5h5MwBEXMooaJSXDasWtp3ShRrbLsk2PqC2rfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816400; c=relaxed/simple;
	bh=U9lnarrase4jaY5q287H+b4eiN/j85K2bs3ZiGD/sKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNgbp0qFINOS+tEmfPTfG2o7jtbb9Y0/P2TNdSclJ/dKrVf82Vuy2zDmhkBal99kals4JFx1am7kehKRlECvrfNSX+bFR5s7QGVz5kn8XOBUKchR7t3JWDR8YgRqtoo/q7Ki+tyiOEiJvzWoC2YSOj0P+G+NrWhqE+6xU/uJTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ndPdVVLn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S4AFAO13; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndPdVVLn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S4AFAO13"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A5oW994148785
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fa
	kGuy+ODE=; b=ndPdVVLnGPt32e2MEzl7sTuz9/zVb7Sk84BklOIbc/rtOnMHJEL
	6J+fQmw38SM2WVmQRhoUZxq1JPCnytnNgArI2MVnT+7H+9+tsq0JMpTHzF/xgKAd
	a6IH4gcMXW9TISx4eJ1JpoF5ESDjtT6gjEquabdsRmduxNHxtVD2uEzbJ34suXz+
	WqwbGrj4lFSE8uqFuyLx/qQcmXTS266MnkSJSXqfy9tCcrS367sBehXCLdq20vlc
	pGC7/r0GVnkNCxZoLcI5VUv4xZkN/l7EaEOGEsMf8cdLCmtyafGpMMA7qSNJr7Va
	QApP0LKWRTcmc5d/DwrpEJSBJgRAMzDg6jA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudggyav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:19:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b23c909256so21455155ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775816398; x=1776421198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fakGuy+ODE=;
        b=S4AFAO13j9CjWAb90zPY+HckegWhCoh41NLZb1ULgjpWV/8MXkr/PAyYbyV69bcmJ8
         nyHuZK1vULNQbpG+xNRqhA0g/xIXdS3vW5LlPNMSp3y8ChN5zrzX0ELSkaEMER8/ZR15
         8rwRZ79PhJyjmz8pD55Wjl+EhJEoKw22eLXF+1qxKgo22J26iZRXOWBD1qGJ9XO7lhdU
         UfSsq+tYM6aXr3dLx3V3uQf3a1YW2X0yNIgCnhJyqfGFtuAqnMsIhwhK08RPjBc3ydhn
         Nqc9M0gjnquVaZww9g+XZiUwg/dG702u9OtidmUPLlgKuPTqiLfDEepyJHaqj1rqkvZB
         QMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816398; x=1776421198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fakGuy+ODE=;
        b=dOVgrwrqml4iRnyJEGoik+2cfgvW1JGugMl9Vix4CKeieaRc+tbtiVVkCbcURsQyXa
         uYJ8UsKNPJhPTBR7dzFDRHbIY5QAgdD2YMHaqsTST/d+lVHwmNe1asnyYVHeRxoLi5kD
         +pNP5EHlqJ3gtSC9UJKEc45TWrNItf+6mrMaZJhsxVXmVT3OixpU7dS4Q5Wqx7C11T1O
         8OxYEhfJySzKaFMMIJNSQhVUMOs8Wcp2pRF+KkuMqEP65J/TxyV6NDHEcE5TCGjoy8Ca
         rqHKzn8xLHuRW7osgvCvCht1j0rrbGOahV0Iv5HlormFb2sewNLqc6nUgYNuvODF9Qhl
         b3Lg==
X-Gm-Message-State: AOJu0YxdCBbuJbPz22pDgeJh10hrbudEmDEUH2gagBtMglejzyg4WC8S
	UaNdLcWK/7l7hBJdWnooJFRhYiqCmlyKEsIM+cwn4RJ0ZjFufQnxdffPoACOiwVp31Kt/svNMP1
	PgUt225zdun7N8aMvYxPh7xhSHuxD7vPkqY2LIN3xUMM6UTtwIkdjBHEmSfM9Im4=
X-Gm-Gg: AeBDieus4QVB/1aH2dV4scs0RvDyG6Bsx7iRn18nWQjcdaqzCqVClKSIyx3ijYduuU7
	jBXgQwfd7X8JK87VrpA6Bj56CrP5MLMxb9w7vg1Qosehx+IVfbrcALBzmZ5jtjpluH7F8xM8POv
	eJT9FKhP6KgnkyF5pIzEZ952vMbmJy1mU8sz2VEijrAqLJNE0bpE9ToS3dj4LzpxApG9e0WwYEk
	Vgvtz2vhGt6/1wWfk0xAdhYrNZ2xsqklJOKkndKhxLTVJGz0RF/P3TXn3H6gyBCOIq6kj0PdhDL
	YN7F8BwJFKvxY66zUMfN9HvV/pO9ytXImKhFk9WMZh6DfQFZ7WtBmG67FplpvnyvSrYSi22S46n
	jTN0CW7dxefbypiXarjp14wNxYxLRQFG9GtFA3/U4kJ6wDZ5fwSIBabwb
X-Received: by 2002:a05:6a20:9389:b0:398:7855:1596 with SMTP id adf61e73a8af0-39fe3c64b7amr3091116637.10.1775816397570;
        Fri, 10 Apr 2026 03:19:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:9389:b0:398:7855:1596 with SMTP id adf61e73a8af0-39fe3c64b7amr3091085637.10.1775816397075;
        Fri, 10 Apr 2026 03:19:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219c618asm2024362a12.18.2026.04.10.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:19:56 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V4] i2c: qcom-geni: Avoid extra TX DMA TRE for single read message in GPI mode
Date: Fri, 10 Apr 2026 15:49:49 +0530
Message-Id: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 04DOcJhaLwRg3hn6mrs4RELY4KjBsILE
X-Proofpoint-GUID: 04DOcJhaLwRg3hn6mrs4RELY4KjBsILE
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8cece cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=g-2Moo4YgOi5Nr3pVm0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX98H4RZA4X9iG
 xKZn/8doy+SREB7HemZ13z1lVdsyGB6DGMYjvqCSj0ydoVKk3OZ9lYGzwoVR5w1ftij3C5WG4+f
 dxrMHvks+i90ZVw5aOlou2bjvejb3HZwjajbgkC064VB40VFZtknumikJqJR4scVrK5Mio6xx5W
 W3s9TW9Qp2EpMmXrtyJ1JAPFWvFSjnRDfS8zTLBz2s3tPa4QVFsfSDpW9swimxqX2Aoy+6zzS1Q
 143N/4c0jxt9XTkeQM5FzJhMLrCe10Qr+Wxv7bPBzoMxmSvda4flitT/TCvIkjrxYR1O8DYVKir
 a/oNltiOfal23sIwYOZtsKYkO1y0llOl4NsWMQyCPfsc2jw/VulNsqRIcMeCQFrLg4Nq/Qb46Vv
 vRcK40dVAUGkfBc6tpgkSagHllncxqFjy1As576clY7BJk60/dzXBH7H0El7+drld3T3m41nU6n
 qy54FFDvjLiVfXdwT3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100095

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

Changes in v4:
  - Added some more description in comment and changed the label name.
Changes in v3:
  - Added comment in the driver for better readability and changed the
    position of 'skip_dma' label to allow dma engine configuration.
Changes in v2:
  - Updated the commit message.

 drivers/i2c/busses/i2c-qcom-geni.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..a482a4c60744 100644
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
@@ -639,6 +639,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
 	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
+	/*
+	 * Skip TX DMA mapping for a read message (I2C_M_RD) to avoid
+	 * programming an extra TX DMA TRE that would cause an unintended
+	 * write cycle on the I2C bus before the actual read operation.
+	 */
+	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
+		peripheral->multi_msg = true;
+		goto skip_tx_dma_map;
+	}
+
 	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
 	if (!dma_buf) {
 		ret = -ENOMEM;
@@ -658,6 +668,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		goto out;
 	}
 
+skip_tx_dma_map:
 	if (gi2c->is_tx_multi_desc_xfer) {
 		flags = DMA_CTRL_ACK;
 
@@ -740,9 +751,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	return 0;
 
 err_config:
-	dma_unmap_single(gi2c->se.dev->parent, addr,
-			 msgs[msg_idx].len, map_dirn);
-	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	/* Avoid DMA unmap as the write operation skipped DMA mapping */
+	if (dma_buf) {
+		dma_unmap_single(gi2c->se.dev->parent, addr,
+				 msgs[msg_idx].len, map_dirn);
+		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	}
 
 out:
 	gi2c->err = ret;
-- 
2.34.1

