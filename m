Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975370;
	b=y372IxNX5SA1tbpf5M8k43/swzmPBacQJ7jvvxC9my3ErrmbwLs7eF25IMi1NEi6wWl7
	 RdFMR2tXCrswcZ3amDXP/nd4l60qX9OATt0wObDcAzNAQt7+4HD1k/MQ7j9dCuiqbVI0H
	 d9JUP03mLziiZZR0yzX6PuglxpB7hN3BHNrY/rusEkH5s+alFX3ojn8ZI7XKxWGSbbYFx
	 g8b6gUrklEL5ewmD2LSKN4fd/LKlGuaetIborApdgXo5y9zQMzIiHcrZOXMV2WRKZwkOX
	 AOD7IIhWtuMsjNjCLHkIWwaxsFO6SXuT/EZ44miLM1HMICNRSWv3wo6zqAW9/aKk3iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7vmHHHIhGLLZArBpIpsBA+MrbOxXbqqJ8LMqN1WNGoQ=;
	b=a9r6Y+XAccRYWBUooHMkjBH1KwC1dg2aJGvIql6LvMm90cy//EhVcHmcfi5Ik/9bSxBA
	 H94+3js7aX5Nw1ktoi/yyc1BU3kS95rLA8AJn0qsvWxDVtyxguP8m7fTGq9ArXbPt2QRL
	 HXN0g4zGbhZvG2IAOHU/98iSToZ1YR4EMQ+uX3NsTG6LLkNOK1n6i8IL8gpDb3Giu3uxq
	 xAV/K7K6T4GQdjlvQsJ1VdCO6n2Ycng2zO9oV3zTs/fKV+62fxW8sdKqGfM34NHccZ0lk
	 kyHdrfwyXlvJchv0UXSv3JS/hVNtD7kYgvR8RBlmGr//cGpJ0FVDOmB029Xm8D6c/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eEDpkHpT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MTxI33Zy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C89606D81B
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 14:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C89606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eEDpkHpT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MTxI33Zy
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EQPMi030052
	for <linux-i2c@vger.kernel.org>; Fri, 6 Nov 2026 14:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7vmHHHIhGLLZArBpIpsBA+MrbOxXbqqJ8LMqN1WNGoQ=; b=eEDpkHpT49QTAIFi
	IHpOeC6yO7P0M2r/iExGAYcj7vzw13WUBwmH2Soc+w2rTLJpR5pWxlHmiJjqnCkb
	/n7jcp3R/7+efyrUoyXdluIvKEhUZg1U07+VaRitJJ99NSB0Osj2ZQXrm2OuuD7+
	rOpAQL/1krZGyVRxq5NZIVgW7gIClQXMGLI4YOhWq5UiGogCh+B2zS1iIn+fj3YP
	dIn+9KSVbr1ZVUJQV1Ghr8uezy2Xgv5j/g4BW7xioDmei4E8TRUrLTW9dFk8fXsU
	XiLszCtJbJk9fvpovu6KbhjgTbHVxI/EpC9wCaGReNBtlPBJbYhHfScVrk1cijmu
	+NarqQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa36c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 14:29:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a065d0e9deso775647b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 06:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793975368; x=1794580168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7vmHHHIhGLLZArBpIpsBA+MrbOxXbqqJ8LMqN1WNGoQ=;
        b=MTxI33ZyUj2miqSjkwnriAQj2iDcDQ3yptODCLwtM7gZT4yIlIF40w6+qgPLwAFK+R
         s+E/UNEA/F5kewvc5wk6lh4UzsPGJzGDarC4GgBA/Tg7QpmL+0jACwotO/zCTvO0I0Q3
         NEAe+ha57AlokWrSptgH/yYwBEnPFaJ0NfS7MvFHfwWo5Qatn4s0ndonhxEWuIufL2qh
         cQI1JaNr9pyWcNTtW7RWkpjB6WxJZ+e/URe2W2MhVmAvJhZNT78/qzte1teswWeyIiUg
         FtuWckgX3ehDVjHGjkk/aFulmNd8u5opDzyscNdYgrdPRWiycmAirBDF6XCk2gEslFb2
         5aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975368; x=1794580168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vmHHHIhGLLZArBpIpsBA+MrbOxXbqqJ8LMqN1WNGoQ=;
        b=XZwI0V2t6S3Dzf6+YzKrdSmtsJRHu9KrOtqsrD4g0aVYKlWvzERB4CQwUt700dWTPm
         HgFwtB+LWsGjKKEq2g7pBtHGfup8nu41AghbvxUBgiW0WkSLavWiLaIJ71QjWFoBcSFW
         DHdfPgO26C1GUMZE1MVlFNtO9a1eXQ2AplinQUcwuYyfgFghSX9WBlQrfoSnYV7I3B22
         vo+x44+UEWuHe+j0wRJwuQ5HZZrjZ2jPAZWY7oDa9OD/VhSW2S2vOqLuWCcA69Jniua/
         Ka5WPKGEl02dM6vTOZsFEYODVd/CuQpbd/x/mC3dtizSjmjwaXy979R2gOQUHRUy1OX2
         auIg==
X-Forwarded-Encrypted: i=1; AKwUvBxt+hxJojZKqiHia+/vp6fmN5wXL2rSprvZJczrk9o+smGbBWSPYG7AY6McFdbzvz+CCDlHcHpODQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IvwjYlg29VUVDhMCSH70wFD5UaiCaZ81V+zv8ZDQvs5C4KvJq
	qw2CunEpnON4x3qeq9KlwXAhtYZg3NZ1Qnyuo2LiJkEV/L/KnRGbzrsT9yKcScAYfdbicx+KAed
	Z2kF9BsygxG1UCsaRebIlzNVCxCDCWTn7gV3AUhOc/OsNOfAhvxywmcUVCRN4Bp8=
X-Gm-Gg: AYBFou12ZFH5xplYCWj7m99SxCxJv5a570R769Br1o9QoHxZ4BvT9+XCzoOoRGVztaT
	AwazJ/dpanP9pb/wqZuL7T01lvczsP+1erd76H1DcEbSZKBTrUHYdn7Pgw0ukn4N6anZVWrXm9r
	F4G36wlqQYLPe0taLWFI/iELMsWK2k0g8j61p7JivXFRz57UHpZtS7qfhRdkitxP3rHvR35TIxJ
	JW8OBTAHk9FwnMi/miMlGF1YNzN2EiEzlaF8lgcSC2WmaVUXxipEEX0Agloww8MLBhVVnIVEh0Q
	Arq/vTuqkBDOaCdQVYOjYyWrHdsD/9FnIZQCgiGpuXaw7wjYOdkPShccIe3d5aFdLXw7zCUlQk1
	eW82kS1Fjzj0E9gyDL8FrzCQa4Ko5D7LeG+1HdQLtYZrtc6IvkhlHlV4vEwE2Osmh5WBtaf9uZO
	CcsCD1nA==
X-Received: by 2002:a05:6a00:a226:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8b37ac9e896mr1857686b3a.8.1793975367694;
        Fri, 06 Nov 2026 06:29:27 -0800 (PST)
X-Received: by 2002:a05:6a00:a226:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8b37ac9e896mr1857668b3a.8.1793975367052;
        Fri, 06 Nov 2026 06:29:27 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0161sm690244b3a.26.2026.11.06.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:29:26 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 19:59:16 +0530
Subject: [PATCH v2 1/2] i2c: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
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
Message-Id: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-1-d3011344fee8@oss.qualcomm.com>
References: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-0-d3011344fee8@oss.qualcomm.com>
In-Reply-To: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-0-d3011344fee8@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793975360; l=3516;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=hRy4QXtTf2tMCZvfoq+ui5IjC6XD/IxzXIrA2TDPPZY=;
 b=Sl0GfULmLBGOhXk/jGilqw1s4SmGQJyqlOiznx84U8i/gtsWmM4C6+ZIexx8EgxkygSg5hr81
 9GgwxnuX8+sDshWQwUCEvlUOWHY3H7SVE8mTxxTTiU1CN++oo+FJRtk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfXy8tn6pYJu3Jq
 /bg1UBMW+Mya09xT0Nraa619zDeUnOwf/5KUKilMraKIcB6qifGy9KtZPQ0huHn67+7db2GZ2dP
 BhitVNlAEwKuHSot6VqxkVcwQKkyORDztr2ALLEwY0veSjsCMs+tN8NuZGf17FhJfyPJ80rucU9
 G76Yn0iMP2//AmNRavSbcwxFVLTyrQ7/4eO4AWntcBCXQvYshhWtP5gctkM2rD+KeK1bTSCWKKv
 RedbVOnsYIjHujqUjB4DSD4YUckAWNSXuQNuUtXEwhdAljS6xSw8Wys9HZ3K/qN+Ldfj9cQp864
 4irHvA7G4dTjFtLD1dU46WcSye4hVuFIpKUGZGGeHgxnInpisZT2Wwv5n1vPOmwX8a/5lhMpiae
 Wy1MiT5S0RzfKjdQF2SvkvT5jkogKi5oo4Vxk4IpnS6Et4N5C0xtw+H90takguyOA+BHD1DbcSp
 yJ0mZzAlFOuoBlHITUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX70qZ+9nlSTzb
 lKJ+SwMzJ9X+tIMIO41GOyDdNDTv2wNK/20kz5x/s9Kv0DzjhDbWMChTHrxVlH/JD4rxwLoK5hm
 V5rBUYWQJT7jPeYXqJv70ym97MhoXDw=
X-Proofpoint-ORIG-GUID: ffpEkQWytCWeLO6N5f7xwh25a7vazSg4
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aede448 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jy3MxQloX0jDNi3JzIsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: ffpEkQWytCWeLO6N5f7xwh25a7vazSg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060057

During system reboot, an active I2C transfer can leave the GENI Serial
Engine in an indeterminate state. On VM-based platforms, if a DMA
transfer is in progress when the VM is shut down, the SMMU can raise
context faults as the DMA engine continues to access IOVAs that have
already been invalidated during VM teardown.

Add a geni_i2c_quiesce() helper that cancels/aborts any in-progress
GENI or GPI DMA transfer and resets the TX/RX FSMs, and call it from a
new shutdown callback before the system resets. This prevents both
hardware state corruption on reboot and SMMU faults during VM
shutdown. dmaengine_terminate_async() is used unconditionally so the
helper is also safe to call from atomic contexts such as a panic
notifier.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 56 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..79707095bbbd 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -1034,6 +1035,58 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
+static void geni_i2c_quiesce(struct geni_i2c_dev *gi2c)
+{
+	void __iomem *base = gi2c->se.base;
+	u32 val;
+	int ret;
+
+	/* Make client i2c transfers start failing */
+	i2c_mark_adapter_suspended(&gi2c->adap);
+
+	if (!pm_runtime_active(gi2c->se.dev))
+		return;
+
+	if (gi2c->gpi_mode) {
+		dmaengine_terminate_async(gi2c->tx_c);
+		dmaengine_terminate_async(gi2c->rx_c);
+		return;
+	}
+
+	if (!(readl_relaxed(base + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE))
+		return;
+
+	geni_se_cancel_m_cmd(&gi2c->se);
+
+	if (!readl_poll_timeout_atomic(base + SE_GENI_M_IRQ_STATUS, val,
+				       val & M_CMD_CANCEL_EN, 10, 200000)) {
+		writel_relaxed(M_CMD_CANCEL_EN, base + SE_GENI_M_IRQ_CLEAR);
+		return;
+	}
+
+	geni_se_abort_m_cmd(&gi2c->se);
+
+	if (!readl_poll_timeout_atomic(base + SE_GENI_M_IRQ_STATUS, val,
+				       val & M_CMD_ABORT_EN, 10, 200000))
+		writel_relaxed(M_CMD_ABORT_EN, base + SE_GENI_M_IRQ_CLEAR);
+
+	if (readl_relaxed(base + SE_GENI_DMA_MODE_EN)) {
+		writel_relaxed(1, base + SE_DMA_TX_FSM_RST);
+		ret = readl_poll_timeout_atomic(base + SE_DMA_TX_IRQ_STAT, val,
+						val & TX_RESET_DONE, 10, 50000);
+		if (ret)
+			dev_err(gi2c->se.dev, "Timeout resetting TX DMA FSM\n");
+		writel_relaxed(val, base + SE_DMA_TX_IRQ_CLR);
+
+		writel_relaxed(1, base + SE_DMA_RX_FSM_RST);
+		ret = readl_poll_timeout_atomic(base + SE_DMA_RX_IRQ_STAT, val,
+						val & RX_RESET_DONE, 10, 50000);
+		if (ret)
+			dev_err(gi2c->se.dev, "Timeout resetting RX DMA FSM\n");
+		writel_relaxed(val, base + SE_DMA_RX_IRQ_CLR);
+	}
+}
+
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
 	u32 proto, tx_depth;
@@ -1209,8 +1262,7 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
 
-	/* Make client i2c transfers start failing */
-	i2c_mark_adapter_suspended(&gi2c->adap);
+	geni_i2c_quiesce(gi2c);
 }
 
 static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)

-- 
2.34.1

