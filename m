Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682372;
	b=umgddH9MuntXZcTgdBhGhpJmKyv+Z9n1XxAZFxlCEkX5VtD/PdNEjkTm1Ki85Y8Cn/+n
	 iGokMB+ZPQej07okoZ3QHYY2HPeBToZlc9PLyFZlT9yOJ8Me1utpm7B3Mm8Hr0IBj7CJN
	 rfSTxNjciOXy9Tqn26bUygcFqqgXQBiMtM+KmWE1sOImimRm7XerqBz+Ic6LINsih7Cmm
	 IkHTU/tmAaL3u3w6l9hlh7Fjt7pGUeeXnfC4qE4e6DnjD+T1omrbi0YcXMOu5PVnqhfJ/
	 pHgrikJAes9RiuqV0CHRKdMlrILee5CecTflkUiEQYA2I+gXAEJGaZETTS+FuSlT7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682372;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6vmCyk1wHKXw+7g14mItgN1PaoGOIgGRCupW0b+o84s=;
	b=ZZb49NX6EVTiyd7PZUJqZlmnUUv2hchpXGXPaMpgLqZt/9CYclVC0ownbDUnfm16TF76
	 FVeQ65G6+KHFPZi/Irsxlnu8bLBwNxIEALYz4fHocWSwbKznJfCRVSUgcCUNXBob84592
	 o9ofDuCFxDaVOB79i4zfwiAK4+Sln0PW3Z8ouvrORsshUPvKaWSul3FM7BYCOuXS0K++K
	 z7p+7ssoLJj1mbkmHOxnV6mRfcxCYrADVNsyzT9Gg5Bg5FxYJ95ZB4OhP+pFhkhdE4tch
	 QomEfXFRsmPBIEJOHKub1hAtoEEkmi8cADbr7D5cdRPK8+SIAgz82DLTmwxsxaZvd8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVKvlDz4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OHlkShL4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA68606A31C
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 08:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVKvlDz4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OHlkShL4
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B38s1682482
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 08:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6vmCyk1wHKXw+7g14mItgN
	1PaoGOIgGRCupW0b+o84s=; b=mVKvlDz4XAVNBUEKwW4wVsXdf77lI2zegcMA0v
	odQOxTr8Y2p6P5V4p181Afc0dWBY6KzdvsJLPyOU/Z4wOyyO33USBCOpLHHxSGrH
	OXe2Mp+rt0uOKPgbvJ9x7tZeJZ0rx4YFlzfwuCqEYBoLVaZI2qAUkEFI1IOzvbOq
	eWqBm0W/lyCgewIAadmaRVGWLn0hO34DPmudo90GH+ZGC3rjOoITzbfywQiVu+9A
	DKilelZ8PamXv37PxARNNKtTeu31T4Qg+2iPtobLbWVii4cILVGOWVliwnF/N/bJ
	YhYPQ9dvp7O/qYsBlqlLzkImJx3WYNt2ZQlT1u4GE2dt2aNQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aek867-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 08:39:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-382af5cfc58so2805776eec.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795682370; x=1796287170; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6vmCyk1wHKXw+7g14mItgN1PaoGOIgGRCupW0b+o84s=;
        b=OHlkShL4stRj23ESt0R3+DoYudU+HShE9AZeskIQnQuwJR1RitOzzf6VszspDdreFQ
         BVE5QFEBdMzjEBsp/BfIwEXtuxwjHKsBL6pfZycFGM0zff1kZja2TzuWcKWQlVY5Q0mf
         WagcHZjeNt8QRKCoA2xshcmN7NrMowCSFcKRFpG4VRTOXUqSoj3bgzBrP2hCxl8OH6DF
         WKqEte/txB4gItFUti1FuoCYeDgRnnlL4f+ktcyfTz3vbKhoywg4beObCI70kTgd512V
         Se6ih7a+TbYDhAVIgT+SoCSIfAQzpvaXVwQm59lbakJ+ptcTNyuVpZLvCw9TRVV6hm4i
         B0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682370; x=1796287170;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6vmCyk1wHKXw+7g14mItgN1PaoGOIgGRCupW0b+o84s=;
        b=a3TNZqZeLB95Cqbz/RxzjsVq6IVx3nXakXMlz+UV5rekjwavZ92qs7HESQde6SusFM
         2J0/RC+CzGbsS9jqPAPvF+K2KDrIer+GXj7vdLdUoYGatktmRsGsjNJYAERl5FYSX7c6
         1Ri1Mkq4E8rmToTKwWB63P7/TX3Me9gauimOReQl3ysXTLYBCx521dR7C1avuFwjArMq
         e/JZmiNuiR9HoHJk1nwsdTOjtjDUfp4SP8/sZZFke0C/0T6UQIPW2w3YxRE4HnFr1SUt
         8JLWC1GstsvbZ6UXDWF7uEi2IwgrjwhTrGVuRZ/HtGu0eKhGpINirXRCnUtWi3MGUHg2
         FVxg==
X-Gm-Message-State: APuU4Z+9VQExCrGlsVaKvTgFZS3XosMHP8R5bK7Sh4RgBI+q8xp7STvr
	cX5iFqaVF3JjcEm3LCfMUO8n5oLnLyywjmg5RXPi1v9ut5c4WbeYwk0eq09CMt3zmm6F0iWMLKC
	FoxZ9xZei4mwmFrlDfXn0MudMpXfLWVWmF4h5Lm4rhOPVuf/Blhq42qZQXEZMWVg=
X-Gm-Gg: AZFdTZem2wMwQHSOmcEcn91YLpvNBBSx52X3QMgci80raQ5V7mostGMtEye+pEDUrab
	ukvyv2uglh5PLCrkYCe9Gwww/6kFFXWzVkzOLxQCYhRP1pGSCTwQvXAjyS23pF6gNjw8LDrdVdg
	YPDmWuFXAWCTM8BhvNEWw/Kjzn9SJNsuWs9tbYnqlqrEff7LzixPwTyIVLhmLxooqWr5GpvvBOP
	y4w+dbnUa67rIW2hnm2iJNzX0i1Ox+ckSQiopsC8jB+RrqwemmHs5LY8hf/bl0UO+ku5W6Cooeo
	pj9DoYXjjlgPzd+GT4J5XbjeT5JtZE7kbCwbOyhPTZc5Krp3Wt/0EeICrZtNENjuHQcNngSrD1s
	VbZEkYqpPF06/5q2w85AP7ej2H28njpDbe/5/vJbMYS4Q6T9aLAbrhi+j8HpIflYVxmVVnOiQtH
	H6X6l0cooWNJpvvAfRcqHcfKqz6guLF0mGh1TrZQ5keMmDEu8wn95OxCGzDirvx3r3Uwko2bdk1
	yHVLrY=
X-Received: by 2002:a05:7300:7a21:b0:384:b001:4350 with SMTP id 5a478bee46e88-3856f04b191mr24366944eec.24.1795682370191;
        Thu, 26 Nov 2026 00:39:30 -0800 (PST)
X-Received: by 2002:a05:7300:7a21:b0:384:b001:4350 with SMTP id 5a478bee46e88-3856f04b191mr24366933eec.24.1795682369733;
        Thu, 26 Nov 2026 00:39:29 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm107946003eec.3.2026.11.26.00.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:39:29 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:09:13 +0530
Subject: [PATCH] i2c: qcom-geni: Allow minor deviation in clock rate for
 clock map selection
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
Message-Id: <20261126-i2c-rate-v1-1-6b8c5731077d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADDwB2sC/y3MQQqDMBCF4auEWXfAGWgWXqW4SOKoszC2k7QI4
 t0bapf/4/EdUMRUCvTuAJOPFt1yC7o5SEvIs6COrYE79kTsUTmhhSo4BqIYpePoJ2j3p8mk+49
 6DFebvN5NrNcIMRTBtK2r1t5l2Sv+1TsM5/kF3ITrLIsAAAA=
X-Change-ID: 20261126-i2c-rate-da11bbe02b6f
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX8/b7rKDNbSyH
 gkxlRqXbDC9lo2G9h7IwcrqGVtc7ddbUMKWccaZIynSyTdTIEvTQa2uRAb/C1CWMdtjz2Oy7WYs
 IoyfQ5KFisOBIMOVD/zNfhK3+4s9pC5+m9DeL97jPZT1GoN1/pubFU1CdsGwwCXB1Stb8eSqACj
 DCxykr/N89UnYq6pb1lobEIGkpjmyfZ32pcyLy8rPjRZVb3mMYB0sqrx+xKAzY0cP21JC5ZwNdi
 PgKUH5VUEPib8SLEeuEErJtaC5MRFpl0qIsU/QNd5nUDJ9Us95wjkg+5K5Pcr506/oFzfmQnp5r
 2AZh4UOmwFdXYYnJzfa3kuU0yyNTQJ6fEhjtVRF03P244rdDJHMs7DY05MVcdlcC9ruNV5hnlNU
 f3pXMObJHWpu3+Dd/cL1+Cy5XypJpJQJnZ1iWwIjDw5/5Z+jpVtIl45uVMJ3fACFWHHKQLXmp4z
 iGjjQ9Tlh3k4dmjhtDg==
X-Proofpoint-GUID: JetWkBBKmPyruX0yN0d0cRZiqoEZYtgI
X-Proofpoint-ORIG-GUID: JetWkBBKmPyruX0yN0d0cRZiqoEZYtgI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX8DluT4rB6TFJ
 c6sAKupbdLtJ4LdD1IzjzACyGmHdw1zznHD9kui05HZU3ue4r6/2NkG0aCbcjlF+Stv9BLIULS2
 6bRYJ49e9F/ggKOEcnu+8FA6Tz3tySM=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b07f043 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=z4ZaAWoGcyzahfyhXEUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260033

gi2c->se.clk rate is set to a value of 32MHz +/- delta by calc_rate().
This results in the clock rate comparison against GENI_SE_CLK_32MHZ to
fail, and the requested frequency is assumed as 19.2MHz.

To avoid this allow for a +/- delta in the rate comparison.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ef48ab3e8b94..88b5b9aa4667 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -207,14 +207,19 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
 	unsigned long req_freq, res_freq;
+	unsigned long rate;
 	int ret;
 
 	/*
 	 * Use 32 MHz only if already selected, otherwise use 19.2 MHz.
 	 * Preferring 32 MHz merely because DFS supports it breaks I2C
 	 * transfers on X1E80100 CRD.
+	 * The clock's rate may not exactly match 32 MHz. It is slightly off
+	 * due to the calculation in mult_frac() in clk-rcg2.c:calc_rate().
 	 */
-	if (clk_get_rate(gi2c->se.clk) == GENI_SE_CLK_32MHZ) {
+	rate = clk_get_rate(gi2c->se.clk);
+
+	if (abs_diff(rate, GENI_SE_CLK_32MHZ) <= HZ_PER_KHZ) {
 		req_freq = GENI_SE_CLK_32MHZ;
 		itr = geni_i2c_clk_map_32mhz;
 	} else {
@@ -222,6 +227,8 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 		itr = geni_i2c_clk_map_19p2mhz;
 	}
 
+	dev_dbg(gi2c->se.dev, "rate: %lu req_freq: %lu\n", rate, req_freq);
+
 	ret = geni_se_clk_freq_match(&gi2c->se, req_freq, &gi2c->clk_idx,
 				     &res_freq, true);
 	if (ret)

---
base-commit: 47588e4c16d8876d3058bcec030ed8a016794b9e
change-id: 20261126-i2c-rate-da11bbe02b6f

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

