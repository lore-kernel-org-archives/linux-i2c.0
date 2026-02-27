Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70F3603C2
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172985; cv=none; b=UY+D4xd3Zd+wIN+GoSBIf3hcsvdwikT+1zWrhpiKD2ya3FNTnshlGu0DbrAty/2dOgv35hgy/UosddAd1lG8G5mIes7Wh8UFxnVpWAAHmhoCJUeEOXhSs898p998t6gMJVOzR3XKyvSd9CNf5LjfgBjhVXkUw352JbDQaX/nrpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172985; c=relaxed/simple;
	bh=vinpJK3AdlE6QuECVjsA4xyKYusB2fCdpA1B0h1Sv7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X95OncwjE1JvZETf1x8yNfdwwmnQf0n2bnDSdDBfIsMUVMbo78+2ZSY96jm4mfzRQ25FCK/W6DkyAe6fTvhWTuYMu8r1uetM8XUIvw1NHrSut6BSsz+fN/3JLrkDvwUlW46BEvG4hqWaJwFffz7VEJQEewC9IgjSdq2hPtkooBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TKVwr3PR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVq81ErH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TKVwr3PR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVq81ErH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K59t3185561
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iEGuO6CekKn
	dAjKBDhzD10xpNyXSXQXlYftFADS5L1E=; b=TKVwr3PR+4rYKrj9N375Qqj5Fvl
	7XFiw9n8j8lj+CsfA1NchYFEInJ+Ji5zUG3zp5rqyyYmKWLUOUEu96WP3H9yusyO
	p3lTQtUEeyHrPvJePux75XDNOO/Jzp911ymEPdWoVp9G6wIqMsFk7v39xPriraxD
	+OgJOHLxq+NqRt68Qfwok2VlyG46e5FPOyTkZWsbrUip/4mqUIeT2X83TGMNoEbS
	kwUZQj/iNQ/0IMU6tDQaz3Ap0Ce7WbM5eLxP+LYD/6p5068R3hprCXqiBEMXIxiI
	j79DY/cqhMCsVgt1ySy0PznwMJ901tnoAm+qB9AS/miDe8K1bS4I+AHT5Lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjmp63hd2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ab0b2e804cso15374715ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172982; x=1772777782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEGuO6CekKndAjKBDhzD10xpNyXSXQXlYftFADS5L1E=;
        b=OVq81ErH+rZSSv7Lr/CDZE7Bz0XHHJ+Q4y4uVBa0CnXOexTb2/OX53Vt35dkVZBWX0
         SAUiEzvGvdBKEh1RoNR8JsHURuJNHDDmHxXJNMC04gf7BXmAP5eG9lDp9ox6fCYeXAfA
         WK6gxlodGkQTBwyKM1+ruEh8gTdAYgBueROZLcQ3WbIjpvLfZFRBHpUXFmURyXPUT3Yg
         excwo+xouqVuAnBFBXuRDKIWykb4ildsWHtBLCE53+hd2Xr8tjjW9D/N6Y7SZ0oT4mKO
         hWncXdaO1i4el/WYVHlPobfoWJtQ7FbpeEvH4THDwZ1SMat5/1+MdhPBAENiKm3/nAR5
         IMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172982; x=1772777782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEGuO6CekKndAjKBDhzD10xpNyXSXQXlYftFADS5L1E=;
        b=BC6lFuI3efkbPIwavZRfjkV+uA6+P0eM0RMnUyRvv6+hkbTdRQTM50yakS4odrdsfK
         Vga2lrDXN0mWXzoMbKAdoJwFTrkjYML5TAiWLuzK5YQscDGOlBGQW2hWuyS2nA38IjMi
         VL/+ca+nBbuAA0N9p++f9ISHFsKC+OlCZmFSahy0u3G1ubsgMDX2kMuL176qbxjzA3NA
         NJVPYB+OJBdSF3XnoY8+LlScVV4AmsTechL4eDgEbTqxAPRnL4oyNciVMP8JQZnUxJKV
         YxzwmUTviAmKg4IK8M18O8POfhU4xOPtil11Qapu11PPIJe8SkgmfssmRh/GWQR2P3OH
         eSBw==
X-Forwarded-Encrypted: i=1; AJvYcCVm1YTI7kNXI6dSMCKmWcqlO9yahqvdub4kYy1VM67MiygxuwNsKOPxN50uAk2Z+nFmDSueCKxaipU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZHMmCfaNqGfyDNPOGs5DJki2/GSVex3EFckfTS+6R0porw1W
	3CcOpkEfRwS1iZ8cnf+cYhdCDx7hmqxrdSzI9CIJbu4PYPacDqJHZNv1VOKd3ScsATm5s2VhZ1H
	I7M6AIkq2tsSI0z7HBq9jztZYN3pq3ID8lWGHMY1V0QExM7z45BhR9acqjRqRq28=
X-Gm-Gg: ATEYQzwkHKXZ4ule69L3LyVFx0ScqHxkWv509N23JrkX3XMeMPUwskMKq2H44U7kkx9
	bQkUAYcpJnW9KSHtjLPzBBnJLMEpNPuwVkvFJm8KN124pQR1S45eKDxEhBz4LXKwis6TG4KeZqU
	KZ8XMWM/02IffCtXNol6BjMwZ0HrfwLz1iBqEbGldFJ9/EnVKgB96wjNQHMCSaXnYugLvZ+ufWW
	UfzC+wjE/Bh/VBZ/w34w2q6xlVUUnBWdmGCGo13IxJSU7Up1lQaQDQqBEf0zXNt8lGWyPXHgDy0
	+RoER2UGGMwvDMmQKtjofvcXcpKCrN7M3rVPw6a7la7NgsVunKUV/UenocrOYF7XAv6GKdQYJ2y
	bnUbnwekbBk2qdAu9h8UQGhyI95hDrhX+HIe7xNwi6rhuDlYwOln2eEE=
X-Received: by 2002:a17:902:db04:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2ae2e496c4dmr14976555ad.30.1772172982161;
        Thu, 26 Feb 2026 22:16:22 -0800 (PST)
X-Received: by 2002:a17:902:db04:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2ae2e496c4dmr14976225ad.30.1772172981546;
        Thu, 26 Feb 2026 22:16:21 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:21 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
Subject: [PATCH v6 04/13] soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and geni_se_clks_on()
Date: Fri, 27 Feb 2026 11:45:35 +0530
Message-Id: <20260227061544.1785978-5-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YCWvJAhYJJ9mgT6nv5-8AH9XgAQQAuGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX4Dc8tystiFzt
 y2SEQU/Phly4ddT8gYno/Z9P1tyNW89yVWzReOSQGadG0jp2lR7XkdHAslnK3Rj4cIZ3fmUA0iX
 jJzMILJQLxc+12FY4huKfNM5AX8BUEAfW6BLmws8HPl6iAF9D9se3QlYuK8OZel2G40DNlvA867
 qEI0PvNAKiyxpXcMI8HvfPq24CnsFXnksRVtBNaKVNbwk+fAP+AWPP02bc1mP2+iKtxRTm515K2
 ZtX0CH4YfgZ5zuS/AZwwO1Oogq9bLYVsC4Bip2FASswBY2PgflAVqfJmTOYq3uNhOmeYnK1V7/y
 +gxa5XFptxztbPMTVp6t65MbEtZwIf5I51QDzs97ulmUaVFmKM1PB8EG84tYBG3rD5WFfCoM7JL
 yZZHEuviTboLkjeObBwQ2wrzkFLcOJv4XUX5YNsazZ7yfuaWJa26FnVLyvAIpxl6WLtgAZmYM9a
 TvdJy9sDW9lGOz9ceGA==
X-Authority-Analysis: v=2.4 cv=daaNHHXe c=1 sm=1 tr=0 ts=69a136b7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fzsqq50RfsZR9heXkngA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: YCWvJAhYJJ9mgT6nv5-8AH9XgAQQAuGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

Currently, core clk is handled individually in protocol drivers like
the I2C driver. Move this clock management to the common clock APIs
(geni_se_clks_on/off) that are already present in the common GENI SE
driver to maintain consistency across all protocol drivers.

Core clk is now properly managed alongside the other clocks (se->clk
and wrapper clocks) in the fundamental clock control functions,
eliminating the need for individual protocol drivers to handle this
clock separately.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5
- Added a Reviewed-by tag
---
 drivers/soc/qcom/qcom-geni-se.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 75e722cd1a94..2e41595ff912 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -583,6 +583,7 @@ static void geni_se_clks_off(struct geni_se *se)
 
 	clk_disable_unprepare(se->clk);
 	clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
+	clk_disable_unprepare(se->core_clk);
 }
 
 /**
@@ -619,7 +620,18 @@ static int geni_se_clks_on(struct geni_se *se)
 
 	ret = clk_prepare_enable(se->clk);
 	if (ret)
-		clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
+		goto err_bulk_clks;
+
+	ret = clk_prepare_enable(se->core_clk);
+	if (ret)
+		goto err_se_clk;
+
+	return 0;
+
+err_se_clk:
+	clk_disable_unprepare(se->clk);
+err_bulk_clks:
+	clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
 	return ret;
 }
 
-- 
2.34.1

