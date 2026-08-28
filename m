Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C9411A12
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912995; cv=none; b=SvXrEAzer5+g+Nkyvax3tHi7SxgOTRb3DmrvYvb0D1Gx+8LOrs3n65Etph86H/PLzVNNeidF39CA7E7ouMKourHoJfR1GG7XeI2KhbzJ4gl/ztLyiA7Sf9C6Oaq/ADyx6qQRgWNeZSRZBASAhdWYfSCnDOqfYCDcusB5XvDfymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912995; c=relaxed/simple;
	bh=I7wMMzUOTxXy59XXrAAdXEH/cY4Bv2uQCN82eMYlt3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gDEA0M8lI8H5DgFJMTSGkN7MgJLKtEUxYst0EC2TD/WVP203gjDugiYg4avNGhsbIYGl9hMGqWwVkQ8I0LXxbzLKFsjkQu4gfNb0FmCLeJ7QFVkSouJW3to7w2dVbS4QvSU07JwoSR8QKVYw6oiDxQ/TMic+83ph6nJikjgvCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Whj49Yq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mcisa7MK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Whj49Yq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mcisa7MK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA81fv3750817
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 10:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6AZ4KHj4RIWnDS4nK6Js8M
	IOlqKDXq/pyeIEXZbRqBE=; b=Whj49Yq3jIAE0BX6cHJ4erISo00PeGlSUujgwT
	TX9KRNnOqmCB0qau0p/T9Kom2C4KeBiBy+A3ROCQel4jIq6lgUe4dL2oV2v7m2fz
	VARlgjHdRdwhCA4qfD2xckCUvQPEUCEqIof1XeNcgac+nsFrDzfYcXkRWx+hgzpu
	qpwAA4mMISg4MoFxHQFIDGfr2gcIR12DvGO29TgmtRZ4MLhwkjo4CTBLZBhz+DWp
	SE5gXfDdtl9T3lDmGHNIpOV38OYZQAMGvwJRuxN6V6PPEbgVt8ntRXevcPIVVSK7
	0QalaDhYRFRRCCFhn/QvWNlgug7J6hYEVKZBjKIn2bcCdOsg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afg2ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 10:29:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso989085a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787912988; x=1788517788; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6AZ4KHj4RIWnDS4nK6Js8MIOlqKDXq/pyeIEXZbRqBE=;
        b=Mcisa7MKcPRcDDah75mEcs7CeVEvx1EepdF6B15PAPYYvEqCVcEToHVEUwj83Cbex8
         HZoyLP7GaO61HEHFFNcYDe60i5E0VdrMOv1TeYMmqv+jCs0MTKJxKlBKM3eE80cw+m8p
         1iCFWCelL3Kl1TXBUATEfSaJco/4/kGJucThccUibmghFjc+s1RYXelKWzv3dXVj3H6/
         YVoHCaNtL1vgqzqZMMF1tBVA66NL9ctcZiY1kGwTDkxG3YVKdRO6f6bsh7UYLZpC1l6g
         eD45TZsT8DLAna7Xg+dPCze6IhPkZ97Ts28WMC5qoZwSnFs/s535au+NuexfkWTmf7gG
         71Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912988; x=1788517788;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6AZ4KHj4RIWnDS4nK6Js8MIOlqKDXq/pyeIEXZbRqBE=;
        b=hqHzg3/8KIW89nB6Rk6AY4MHivn9Idl3dqpYs9iA7aZ3fGZgq6fRZXTtn7jo56RRuM
         TjY5YnPKtSw66buq8ffwciQQrNO1i8Xh58FfAKV5UXmX0vX5hPafgdMewbXl1RCKHlYl
         vMqGcEZgY7IdlJGoDucYcvZRWVcBm8m9TwVNxwc6RlJOlZwS0lE/iqCCJvKLEg+vHMBL
         wZaaIhmtZYY3JrYMFsqwXc8jcs8U33kTjGwLgp1OaTfO3Dy8b/kcH8/59z8HVkrt0rhP
         8n8oqiSL6iUzt/QmIwQLx5iZguoayGfzqTP9+qi2GjQ1A/NzuphYjrg7SUF5u89y6aGw
         UhEw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2m0GM5rGoH1PtCbsBDiOVGFRrKtCL9eUPOwxq7Sf2UwzeaXyYDL3zGCqsIp28Y+SA+KI0OU8Zjg8=@vger.kernel.org
X-Gm-Message-State: AFuF++k3jTTOydkLx4h/GP51gh4PvCIj68oBDC8lKmkvRAMm2z1oeZ+q
	OA0Y4f2Ps0xO8UPBy+oUkQrZNtTpN13z9FBpGdJU/BoFNhVoLH/M69i8r4cWaLdc07legopgYs5
	848fNo82qD8miUW5uw71XD/6FWb7kYSpr3gdxNrDn1yu6oiNkIcccC7Q5ZJgLFVs=
X-Gm-Gg: AR+sD13CXMoDK/vuXvDVqEmHmiitKSqi0CwZe4ZpQ6T7giYUU6RpHtMkKwM/OmahsNI
	zylS2UjQ+BQcG+DQsIrmqYzX+vjjhslicdqDlG29p+LbREKJK6OpQGxbOKTP6SZx7SY0/ykC5I6
	hrxXab9H+dxNjkrljHyoREWFHAMax11OGmCNtL8/bIMH9E6cg8j9H2urHGclZeZ03D3rX2ahXN2
	zGpcCdfpaNJpLrZQYirQUw6W9EK8SgJhMQGnn9W2yjil/MJoR5zrwx4MYNe2fudLWjYCA4siO8/
	zcWIOWFtKdzBlgr/2YyA6lWMgz1+G+zDm6e3IVJrwloR8V9IGUxVHwiM+OpUi58iO5Akj3BY7zb
	3n33AqeGJkB2nIw4fZIJkyXhZl9UaUR7ellk2
X-Received: by 2002:a17:90b:440d:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-396d0e5e891mr11062393a91.2.1787912988099;
        Fri, 28 Aug 2026 03:29:48 -0700 (PDT)
X-Received: by 2002:a17:90b:440d:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-396d0e5e891mr11062322a91.2.1787912987665;
        Fri, 28 Aug 2026 03:29:47 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c57sm5267301eec.4.2026.08.28.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:29:47 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:59:32 +0530
Subject: [PATCH] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAxjkWoC/yXMywqDQAyF4VeRrA2MI3h7leJCY0ajMpZJKwXx3
 Tvq8oNz/gOUg7BCkxwQeBeVzUdkaQI0dX5klCEarLGFqUyJYgmd/FAZaV2QNu+wql3hajvkZd5
 BfL4Dx8ldfbWP9dvPTJ8rBef5BxS9ICJ3AAAA
X-Change-ID: 20260807-i2c-fix-se-clk-conf-89f6f92d373a
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787912983; l=4220;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=I7wMMzUOTxXy59XXrAAdXEH/cY4Bv2uQCN82eMYlt3I=;
 b=ullmR2ZMP/fubY++Q5rSlO4oCU7BktzJl0erJgJQFGdI8C6Gphm50UBLmKgrNi0FY2YsQQ9po
 vMCMO3C/RafAfGPNSHu22kvWLZ3ZPYBHww8X+LjJiALWLviBoQhz6Hn
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: x4C57uRq6bh2opdlT0jW9_xI7J8sx_wE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OSBTYWx0ZWRfX4xz/0bWeg1z8
 GMjNsmfPvT+q37gvRpD329J2lMpuuFnUdtGRpj6RnhCuUfMWNRzavyXGutP84xFRTSbOzLzebjx
 qkSXBZXBS2vOkDxbnzXBYNW11rhlFk4=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a91631c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JoU330fbb_3TrnOeRF4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OSBTYWx0ZWRfX8NU5l4NvM+x/
 +fI8k9NcTGaGZxAd6GQmlzmPXpY5miWmkDMzsJOJOLDElukolmDIJzBZUmupxMRzDeSu/nopGen
 DjjFIzDfN8LsishJVC3Yj8Y4/xS4FtPaVLcr4E5D9stHtLXENaWj85XzqoHV9l+odxwa3h9KUEa
 TsynsjwIJEvboi/uew5H9h0YsPSRK6OkZwlKjV6YWsr+tyN1g7P1RMvgz3+fGxmU80hl/W8UEW0
 HLWhGFe/+Nj0SdfAJB5kXpskDhbU41gG+UiDcwMueOaw2cNaihqPXtQFv08Ci6VNFV+8JYogeS5
 SNHNtUn+liWyXk58oZS7BHpmyqJwhlIZ0rJ6DCHJN+4+HXNDeFihIbHBIOi26qtfHdor5lmUkeu
 k0uaRIiPM1R80oEjzALK64/jZ5Ie2ThLytOXooRH/RLo0JRtbomtKzNTk9mnX7DPPQogt9pEuBb
 Lh7HHK8C2lY0l1OyNpw==
X-Proofpoint-ORIG-GUID: x4C57uRq6bh2opdlT0jW9_xI7J8sx_wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280089

qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
selects an index from the hardware clock performance table. This always
picks the first table entry regardless of the actual source clock
configuration. On platforms where the matching entry is not at index 0,
the wrong source clock divider is active and the I2C bus runs at an
incorrect frequency.

Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
performance table index for the source clock (32 MHz or 19.2 MHz). Store
the resolved index in a new clk_idx field in geni_i2c_dev and write it
to SE_GENI_CLK_SEL instead of the hardcoded 0.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..a83297b5fb0a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -82,6 +82,9 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define GENI_SE_CLK_32MHZ	(32 * HZ_PER_MHZ)
+#define GENI_SE_CLK_19P2MHZ	19200000UL
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -127,6 +130,7 @@ struct geni_i2c_dev {
 	spinlock_t lock;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	u32 clk_idx;
 	void *dma_buf;
 	size_t xfer_len;
 	dma_addr_t dma_addr;
@@ -197,19 +201,42 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
+	unsigned long res_freq;
 
-	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
+	/*
+	 * Counter tables are calibrated for a specific source clock frequency
+	 * and are not valid for any multiple of it (e.g. 64 MHz, 128 MHz).
+	 * Use exact=true and verify res_freq matches req_freq literally to
+	 * reject harmonics: a 64 MHz clock that divides evenly to 32 MHz
+	 * would pass exact matching but produce double the intended I2C
+	 * frequency with these counter values.
+	 */
+	if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
+				    &gi2c->clk_idx, &res_freq, true) &&
+	    res_freq == GENI_SE_CLK_32MHZ) {
 		itr = geni_i2c_clk_map_32mhz;
-	else
+	} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
+					   &gi2c->clk_idx, &res_freq, true) &&
+		   res_freq == GENI_SE_CLK_19P2MHZ) {
 		itr = geni_i2c_clk_map_19p2mhz;
+	} else {
+		dev_err(gi2c->se.dev,
+			"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
+		return -EINVAL;
+	}
 
 	while (itr->clk_freq_out != 0) {
 		if (itr->clk_freq_out == gi2c->clk_freq_out) {
 			gi2c->clk_fld = itr;
+			dev_dbg(gi2c->se.dev,
+				"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
+				gi2c->clk_freq_out, gi2c->clk_idx);
 			return 0;
 		}
 		itr++;
 	}
+
+	dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);
 	return -EINVAL;
 }
 
@@ -219,7 +246,7 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -1111,8 +1138,7 @@ static int geni_i2c_resources_init(struct geni_se *se)
 
 	ret = geni_i2c_clk_map_idx(gi2c);
 	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
+		return ret;
 
 	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 				  Bps_to_icc(gi2c->clk_freq_out));

---
base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
change-id: 20260807-i2c-fix-se-clk-conf-89f6f92d373a

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

