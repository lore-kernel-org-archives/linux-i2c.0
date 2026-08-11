Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E3426EDA
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440221; cv=none; b=NuFlsdZDkqs77LAWJvg/k1tvBGwfZCbqdAd6UAde1V+kWwEZJVuH5xzAcLGZRjPE1FwNOh6C3BmMu9856f0l60jLShCa1jo38cmt3IPw5fiTOv/gATySWxT9/9aAyJOKmWrxBb/EQa/Ovn6kCUQPSbn81Z2LZwSbQTwPrg904BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440221; c=relaxed/simple;
	bh=Dja56rSsJWymUw/Omdg2HDuTOFhSjr88PK7rUZ7ZjLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wqg8HfM9zQrmc5OH8rJYiceNabhhaSMHGMoml8fZx9pNtR55/IH7OOSbilD8bP3DK6wEPAs8v0V3qJLhaypc1gittNE2tGL3eMbAey8ZMo3UEAREy/YgExJA3+AwPuoXzR9Es5dSlxrNfdZ+CfFTVZKJiFEsNvUpP+dRqfwLp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clmgbVx7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/YNMxuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clmgbVx7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/YNMxuN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B78BAg3307941
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=; b=clmgbVx7554OB8pc
	G/Eqn5PlU2sklUehPIBBslc18mUqbknhcJKWwf1j2GEERzez4dCLE8g3ydZYosle
	Z4O8WtSuUT/HoOVPgDnewRUKzY1ITvlH5p00TuSaLJXZyJlqhMYVAe3HlRHzDbHr
	Hitc7/z6l9AXHTT1kxJMSeUWM+4v2eg3j/CnmNHIai170KVhMLN/J2/plEV1b242
	We1cEbXCMuQ/s4FqPyFc+bytUgF9pkJoLw4DI/yK5ElzeApRE5bFRuM17NUWwCZD
	O7kvkFT0yfln8t2kHgiJ91WjyJHd0Kq4nUwGWL0l0KUBzYg5zunCDsM2q2mwqymQ
	oSci4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfubcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4447322a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786440217; x=1787045017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=;
        b=A/YNMxuNtFfz5Xn2EeC8OgTU22eLNuPMHQ83FDvQWiOv5AzYJeaJP1UtgfscqrrmpU
         dDaf+utq7Neq1OORHL+XAYTgOgsQf8yq/cCKo35YmElkb+cST4jBwFI+G3jS2q6kVd9x
         ll1BNT2t+5/myKOu3fH0gY2Sc0Lm/+YlGPKfDEMFaO2EadLHF9/5JKVkUNRFHQhp6oVe
         iD/sg3wShMo2C78wrZevyijEtuRlFBxExaC+/7diEDZhe4hWZdxLVFgD7uWP+3gKo92Q
         Jz4NZlo3CKqewSmko2vOyqHZthMi3pXbutaBVCvkO5+3gcXEB9OpjSvE6X++QK6uU8i9
         fWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440217; x=1787045017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0E2fjjl2z413AgzHaMxdBXeMeM9rA+DTDDWPItpGYo=;
        b=DeT9sCrPJoI/Djm7uTSv7w+1CWv2gmSLKhljwpgXdC5oZNqTUOIxyxbHezAMCff5pe
         9q6QOj6crBpfieG1fhVNK9HopfdrRqmNnilKweIDh9m1tKJBQrDBU9s5JPCEQ86HZGfz
         z3JCLSylzVKs0wEtv1/sKuVVIe7E2WfHWq6E6Hn0UTVLymZ0vw48jQt1MTjpfpEUxTMu
         GDup3L+BVwq0IbyVoetvjXrMfmk29s8SMijTWsgYAPEXXvRDXJOuu4juDW7tq4HK7vyg
         t/9V2lwcH5xJIfhx8CUfpkmiaVSOAL1Aod7M5MNKTmHBnQSTbocAUwo0riGi8PlCyHGY
         WA9g==
X-Forwarded-Encrypted: i=1; AHgh+Rr//a4OmeyfPjgnBrSd5ZHOR/vDBzHcgFrgxtuCg8qAUXHwBD9u0Hp3b6YA2UQG/s2wRI07cTmnQEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJ4dhw/Wp2UcDN+X/bHVthXw3+vYYj3iuFcdkhz/BHGMHAlA+
	wlewP2IvHC1I5x6nic0PBWF82cSezQzDI/gO83ic+Ig2BSVucLXUnMTk3zIPCFQ5j2cY5RXhG30
	xfdxYRiAAqdrbSEGjpz91KSwxL5LYfYcTuSPXUGkJlTJWDXnuaMxsSa185Y448pmzyTOtub0=
X-Gm-Gg: AR+sD11svO0RHWIfPBnQteZ2C9OIkVCnABOjJSrq9HtScd57Y5rEBi+YhcwPzJmnbE8
	oblM9rOVgBAwucNUyupOl8qs9h8t4H3sHyKmRxKHiBbapjWP/LUiOpepJEiqGVuTifKdCLGnNET
	5Dj+PI7qWjE5/zh5R0o+tRC7vwT05BRAf3oUxyn4jv0I0hBxVWeIPxHSNueg8/ShCv7f0AhbsvG
	c9VTdmwXd+pjFbaRyd45dQFbR7DMkKl1BHWC/h8xigquXBIzlPk7XwlxtLcJk3LAmwbi4Le0pY/
	Qs+gb5/+Iv5GG+UhULJbp3Oms5XwtVq81Y3ZMffMivIGFvli8DZLCWBu2/yCgse55aNizARPDSu
	i2saET7Yj3pz3F8VGYCyvJhSMBgp+oH4uDPW+EG+S0zrDX39JPHj2S1722phm/a+Y/BVbIvZNIl
	U8G8H6KCZNcJGwEaP8TodYzR8lnLVXB3/qyMQ=
X-Received: by 2002:a17:90b:5486:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-392ec628202mr2004758a91.15.1786440217359;
        Tue, 11 Aug 2026 02:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5486:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-392ec628202mr2004717a91.15.1786440216887;
        Tue, 11 Aug 2026 02:23:36 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14120447d8esm3385004c88.14.2026.08.11.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:23:36 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 14:53:16 +0530
Subject: [PATCH 1/2] i2c: qcom-geni: update frequency table to fix timing
 parameters
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: llG6UPELC-18Br-IuCpotUVTHLcLOuHH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfX/gTpQuj4VtlY
 +OHaaW2ZiO1mf+/YUdbkn5MbSsE2rjE5cacPF2syGs0rWUjLXzF0KNFu4c6vYZn1ICFyNuLwxri
 vh6uqT+vr1+fk9kI4DsKHaTeawWaRRs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfX1MN9Ss6YwiBQ
 rVxJvrSRKuASyqVYGSShHkMxZicJRNAk/aeXq0BP+6+HCMc3YwArRQx1dFduc8hI7e83X8JCYs9
 Mg5NNg8zwMBvGibJ4PGMcM/lvW3nbzX3YnSIJ3t3D2Asdjh8GnlkXV09MC3oeLmKqtBRq6jcsbw
 gFq/oRQsSmDZaNUqNdxRCiq8NFI6eQqA1OvoQVNph3OwLgFHwEc9oH+MzEMsFiV3r7avpyXLI1f
 x7Yy2djMM/FKCUzwbTWfTPbrbpuQm6TD8e5BNrkS5cplJq+db5bRU3gxp1KppiSUjpFUOHR92Yg
 5Y7bSdWFpn7RP1jKmq9oQRsFgczMHly1k9oOeikFqz1JOHOITLD/Sv2uZdlyNZ3BHlUz7sDyuFR
 hiJQqBM1wXk9QjvQwQeqheGtZYYPsmdL6jrp6KFK/go6SMT1tLnUWrP7I9qA65yL+lD+KoQt5Od
 PfIwTgcz140nF7BaC5Q==
X-Proofpoint-GUID: llG6UPELC-18Br-IuCpotUVTHLcLOuHH
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7aea1a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GyXxqrRC-9zytgsE6zAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110077

In IPQ5424, to meet the setup and hold timing requirements in the
standard mode, update the frequency table with the values recommended by
HW design team.

Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.

Cc: <stable@vger.kernel.org>
Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..00013b41a6f5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -188,8 +188,8 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
 
 /* source_clock = 32 MHz */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
-	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
-	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
+	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
+	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
 	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
 	{}
 };

-- 
2.34.1

