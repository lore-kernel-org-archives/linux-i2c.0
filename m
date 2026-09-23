Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9947140A
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161430; cv=none; b=HjZ15k1h4mCgEka0JlhTwe6U4DZRTO7Gv3cEAWt69puAk2u3knT6FeiFKCpnsKMx7OKPYJMXM3lM2T18BSm0I8Syd5AzT22TSJK34261iKnRKtU09IW7zzcl6Fk8NiB8wq71NgZjQKWjGk3tiRxVYG69QC6rUuog1pgzxjGVlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161430; c=relaxed/simple;
	bh=ZVrZiKjn5eoj1xYotO2X6Aa3N+e6mbg9W7+53FVPuhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XalIkTP8EzKrctxLAix0571fAxe8xOVnoqmsXqccvshwA4TcAuxeBm5n8j7c2tgFOZAP6588lG1pIq5bD2YiL4WADtwgvhxqngEh3zRlU9jdCi1BKOSm9mt/KhiCTtdwWZLJw/zjJJVDVBXZETV50en2oN0jQYCG93TKNtZw43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8X/scC/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJTf8AoM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8X/scC/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJTf8AoM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA31cj3936261
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=; b=P8X/scC/vmfSaejV
	rACCHxfhlMr97yDf681xl9cjaOJnmvLfZdX+ewFxD34kEwL9sU2J4oRK+SUcQnoK
	EUMM0tu90dqcbPvfp44AVRAtLPocj+bBNw/ZHpz42edrQBdJk3Wuc0Pg1RdNIrvO
	UoBgS5ZjaWSwjLeP52sRA5gY41Q35HAUj0eBskVf6Is5kRfEdLZd5J1++lS9Z98G
	Zp4UOcM4FJ7uXm7J+XyuF6ZJptH68vjGM7asphS5fr6yazG93yPOGsGJPZEzcYSz
	3Mews/TmpCQx1JGRM7KpLRq0mifKe+9syMRHFZIZDJI2i4lvsxT+VOgh6HUserJ1
	Af+C3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428td3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:03:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1077892eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161421; x=1790766221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=;
        b=DJTf8AoMZzUnrAnPbBFUq5SX0xE7IF+10vNQzsBoGBtWq5CUWt21+1X++hS8p6u4v5
         7rOyBIXGhl7NtVSsL9/31d8ofVyYjUZ5+Z7mExs1I0799t1823lpKOIGF6tKaql0XqQo
         HC41m9GghVR0o/hGQGJTx/EqeIBj5XoM3so8HKrsjiJfEOOmTANGWDuUsB9Iz8qMjS8R
         Kr8L1m/FWCXOvWdB23oaAr4vwh/rXOS5F+6abmRl9i45eiMQDa6lFNHz6swf2qVyJfD+
         WgJl9TVTKqa5isPhvrTFuXlaY1Cp1/Y2tcBKPAHeUMilx3Igmf2K2uGw9IKJN/K4AiIw
         XCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161421; x=1790766221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=;
        b=CIYvjGWTYUdZvSbwxFQu5Im5xPnilKNxfvlksViBBu1qqgaysh89Rg6gRxm1bgsHT2
         YZXuyBAFSCV5Twu+C9w0+vldgcJWhvs2yAEsiADsEWtbj3t+gLFKmLruTaC41KD+TS9N
         eXqkIk4rvL3ZgQC4hoWZjRNghAwt+8gTu2v3mPdXM27E8okriJULDFLltoq8XCSM87fq
         Una9GV/smx/dRS3fRdtlN0O1W8SI3mlPtdWx8eFylxUOMhiPCxiIMFBFUOg/RieA7DAB
         jY8Frp7l6bQyWHq6fKy+5dofraes0ZTrX6E/Ud4uOZFH9tj2yUS8df1picI4AtZVEO2Z
         7uOg==
X-Forwarded-Encrypted: i=1; AKwUvBzuEIGgztBAHqt1HYELnAFVKC7KAL38+Ymhyielfz2NjH3L7dQ9y+dCO8HiJRvzIov7VRajSJQuA3E=@vger.kernel.org
X-Gm-Message-State: AFuF++n7h9Hr/fNxj37VASPGXStonAM/YLrTvl4/itx1PMqtyG3pbbbR
	x70CUpwiV69lpKULZxem069EFrMjLbjlbl7JS65skosGh2HpMTa/L47lzb+hMcohPGTa8/xEFhL
	lX2RbpA51ECThjAb16oHhftxfNM6SwqOR9PqByw+LZtWI/qFnwPvG6E3XBWYEFvQ=
X-Gm-Gg: AYBFou2cyIfWRnVYzMwJYAoVIrBxgplLEcdMP7Wbiu/vN9ZGH7D2kW4h0ppXqM25ob0
	nHJtVhDwPjLrHEm/fEYv9RcRdL0IHUZgfQmH1ticvAOAxd26vUPIjtgAVFUfVS61vJiYzP1ZCzd
	hWtuhIlE+pXdMaic3ALbhGB3r8X3IRwZR5EdHKa1K9V7R/HR/LzX22AeXLXNgC212OZVQ/zQeVs
	gboP3YysvPHcixvdPjqCbpRVDnEzQHEblPeVkhz14pmPpnIhpIU++YG5SeG4o9foOtsioHZ7Nvh
	h/ZUdzAvJ3OOjxLB4vcHNNlARuhWVdJntzlMKJwKkEkRywn83jZWzc1YQyfBIR3Z6l+xuP97MWy
	QsIPQMnbxruL3VLihRbtugArF8j2Qpw==
X-Received: by 2002:a05:7301:1522:b0:33a:f8c8:1d47 with SMTP id 5a478bee46e88-33e8dcc7016mr1919819eec.28.1790161420836;
        Wed, 23 Sep 2026 04:03:40 -0700 (PDT)
X-Received: by 2002:a05:7301:1522:b0:33a:f8c8:1d47 with SMTP id 5a478bee46e88-33e8dcc7016mr1919785eec.28.1790161419862;
        Wed, 23 Sep 2026 04:03:39 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:03:39 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:35 +0530
Subject: [PATCH RFC 04/15] dt-bindings: media: Add CAMSS device for Maili
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-4-cbbb42e534ef@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=1384;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=ZVrZiKjn5eoj1xYotO2X6Aa3N+e6mbg9W7+53FVPuhY=;
 b=XgfpDbwxEhYVPrCXzedL0NvRcCeMqUcz8sI5/ThQLFZiYoTZSMbfy3IS1zHz5MKRzsYuC9eLT
 0weZf5uIW+yDe4YERjzmPVqDcELD7jbxt+j3RsgR7nvJiFAC8AC5dwi
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab3b20d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=lEnWAUz5esA3NO-HxloA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: ckAUEK0xpzMLgCtkoJMu7Xpa5FtAmuEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX6O5GlFxxOhyE
 FEiKmgpliIO0kL6k8npVeCTz69OR9M0Ja4tn6feoJO7ZEwWD15cdPU4vQM52Cy+As5cOmWpjx4k
 mKmxe1rnAM0G1E4Ts4TlHGyO78QTkr9gzy/EG+DhwxNJInHq9LBjTEYZUmYmeAWNJasmFs4qYsH
 Yo4ZCLzg+EVLJ1shUn65UCp/BX0CwTBqclE2HlWIS07QMww4Rd/rggJSfU+D2uWkmULgxoje70f
 df9IoHA78VEoA49kD7P3TJ49jkh/2bDf1ISYnJAlWYGcFPC0fMVgAqI2GOXAUkPkODqIlpDPte8
 WVxatRPnlO9+IDm0oxCwnHddryRDVHSQgd4eS5QJFMUC8QPrRlZgmuStuFDmq/o01S7HzGsyVCd
 K/aSDYh/kUE3cW2bFpoYdbkMA4TZGRTLua7pTXNyfa2/Pwz5Mp8R4lZakaswapjznCdqRyu1wDi
 OiTd4Ldc/LCgCD4CHZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX1v/61Ex2C2CT
 1Io9/ynAs7IgPGJ9AikdpPA7TFyw2NNZUmv3cdVPArULhx258+UQgwb+L6lo4nPN2M15UbEgvyH
 aB3Y3+zqYkZX1X8KZfUpPuUGdBgW5Gk=
X-Proofpoint-GUID: ckAUEK0xpzMLgCtkoJMu7Xpa5FtAmuEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230043

Maili shares the same IP as Hawi. The only difference is
Hawi has six CSIPHY while Maili has five.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
index 5bf0dca3d24621bfc4a09feb8e5037a925869751..d1d53d6f024cbf7d2a0f2525aa4040260353b200 100644
--- a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
@@ -4,17 +4,22 @@
 $id: http://devicetree.org/schemas/media/qcom,hawi-camss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Hawi Camera Subsystem (CAMSS)
+title: Qualcomm Hawi and Maili Camera Subsystem (CAMSS)
 
 maintainers:
   - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
+  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
 
 description:
   The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
 
 properties:
   compatible:
-    const: qcom,hawi-camss
+    oneOf:
+      - const: qcom,hawi-camss
+      - items:
+          - const: qcom,maili-camss
+          - const: qcom,hawi-camss
 
   reg:
     maxItems: 13

-- 
2.34.1

