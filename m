Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AC4014AA
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815594; cv=none; b=HxNR8wZPZ+UCTQoDsx1QbqmuiU4YM81NVT9W34342LI3k0HH47lJx8NYSSAU1XZyjUbd/vDlX7s9F2jpxc9Leat0763++0FsjKnd68kCdhPymWXrIyutrvUdJo/UlAUtEd8IP/mncoS2QYaRRZCA1vDwgub3j/Ig3AUUJzZMxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815594; c=relaxed/simple;
	bh=uac65xjlQks8nBNaxDifvO7AVmUW4BX94tfMWeRps9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxtchpFjFVt9RoxgRzzZ5/9HBLoyTcE3sD/7HVbXiYlLLVnAzH+QAC77zUOghw71iykThZjf3XN+c7ekSwPjbJjpa3xZrd8SAJpKDEW2B6kA2PviWmIONlupbxUqf+CB8025q5jnTw8E7DPuEDcoXFAKOIJMGbHj7FuuRqUqv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fP85kTQw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DENqIQUg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fP85kTQw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DENqIQUg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH1fqN069574
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myApPVC79MUKSl1wI2Gc0zirfHAtnCQO6eIvLGQumqo=; b=fP85kTQwAjLmK8j4
	Bt/s9gGVLLQ/MLsVdLGS3ORhK3gKJcWIahzQeokIqZvMK0hye2ZrxAO2J/DOOkw2
	nU6Pchy7qH2n9CHEDOnbIryC6yk6NNEzllAJxoHB4t5O078E9QVpRCJBLS0U2flD
	iNZFW9U2Bzh/0dJv9hfw8gDLh/KAISaVS2Fr9KR63wxsozGbb2UktqHF1f6wMw/A
	QoC+vx0JqIjzuOITbfA9TmjYbJDks0JXkmIpby/XIIxFxvPKFLVCe9JTPeSkJOab
	w6PTPnUKm3JTU8UTtT7WplL8MQO2mfzklkmBuqjPRYYQbmpBkn+llp5tZLDzu/Zi
	s4XK7A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2yha5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso4805192b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815592; x=1780420392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myApPVC79MUKSl1wI2Gc0zirfHAtnCQO6eIvLGQumqo=;
        b=DENqIQUgNvH3CSorwoDgeKN3Jz8/BO+B/9okJGrQyuUWAX7f8dAp0VM4QDQkvAqONf
         br8q8nChJwpcBcq60tCL2mhHzQvjqBsLZAHXAk1fXVfIcBzrqBFpGCD0JQN+D5R9ZFRs
         06cMK6JD0b8mKrJFu8qIaWVCnUBiEaSZ1ZTktZwlBlaYLQBna/AQYo6g6Mjo3U7UsSVT
         LqC5B/5m3lhAmuQBYLmSI0YPfj4B/p6/F0utB345fRP9xlZ22gd+9eBBdhBmjEQnSmzx
         FCm6AlaMsaDy4kdbDegAGZugLeWUOwvYEtdhaTJE/IXn1aDJi7CCZpxZIRDRRwXvaili
         qeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815592; x=1780420392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=myApPVC79MUKSl1wI2Gc0zirfHAtnCQO6eIvLGQumqo=;
        b=VBDoXvXjEBNvPsoOyoGdy/WL0DNHN7l+LnvUUGCf5yaLv6Rsgl2RGzxQrLwh2WnadS
         83YLP6Pux7DIzlpJSTspjKwRK8ygVBQG+IvHm3qTEKLYsm7X9AaWuBsUV+1JrtlATzJx
         6tm+etKBpPzVckWBd7XSg4dx4ERosS9ETIFBBmh5Qu/W87xqDUeg9d3S9/kOhnQ8Z8H5
         3dP8OuPBloD/oIcEMXj9g3lRD0Nh4DdtRZN/+UKl75CHBdz9EuMDqQmpQpTXMClGoCSQ
         VSyFF+CbwI8CQteN+tJA9YsNUZ2RYBPYk7KAXto6L1hRFmI5c3RsVJu+nPqIq4T1Kddt
         r7tA==
X-Forwarded-Encrypted: i=1; AFNElJ/7fhjHSL77yfTYFDTrJfxT9QzAcZkhJIs2eXVErL/Q+MuNcHg3zg/KIJU7YyiwGMblEOyjiusBgSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyyltyly1wpOzAGVrG3wSn9ZUgrlLyf0q2UibtFpa/DldcPpbx
	vUQRWweTSUHwByWIWVIyQoGMVhNOsfT/iKv3XGIDa89Fok+D/Jk0yUwa0VB5rW1zRE9JChYmpwH
	S544p9r3cSuUDj1K4qcGoieWSUU0QNZlrw7ySj/1zkiiT+wrFPEy0Ks3P4IMqYbEHl1stMCrMpQ
	==
X-Gm-Gg: Acq92OFfDKrHcaULpkMbX8iFR7HBDYUXRxrj0ph60VNogpsiEj20R5t+aG9/v3OZclJ
	exF4XcVoq8pCzB4XGc04sVEMynmiWI2S5A/92jD33olheWh/et0OV48UPvHoKbfDxSMX030kjKJ
	53GDfM5xs4C4ktC5z2hACpf3Zw/u6tGAIQkbVNcW6Ap21VhM9sLK9Qv6/4pRmAlmfHsSiLPZqhC
	tnApvXSrwGOwC8cObsJVV8L7ZmN9/OcZRz7m9hH/yaLAB0CgypSqeLZV96dKCHckNbJbdwx2xq7
	ADa2sNTTS1rY/TlPKri+ZwgNniIyrcYxBCmqvlnJK2VW2qxEknh7tEy3IzPsJ74ogK2iATogbtk
	N/8Jx84Vt2OQWAOg9Qj1pLT6/RRVpCKprl+LgQtJOeRLKb4qW3bCd
X-Received: by 2002:a05:6a00:2da4:b0:82f:85c8:fc19 with SMTP id d2e1a72fcca58-8415f314ba2mr17283048b3a.11.1779815591530;
        Tue, 26 May 2026 10:13:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da4:b0:82f:85c8:fc19 with SMTP id d2e1a72fcca58-8415f314ba2mr17282999b3a.11.1779815590996;
        Tue, 26 May 2026 10:13:10 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:10 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:46 +0530
Subject: [PATCH 2/8] dt-bindings: i2c: qcom-cci: Document Shikra compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-2-645d2c8c75a7@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: -J6uC71-Kox8xXZWeW8_QQa9cNh9LLty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfXzzrIg+nmD9sM
 +FwGbiFQg2vY2mmlZXR2K/qdCIxH+p64yCZBnC48tyiP8O0LXGZvvUjGVA4sWy101rjr0PKa63I
 1VlUkiAcv7QP+24SXB/hZxPKNLE2qfeYuOS40RMAL4y9baYZQR0RLphdTCyzmU9OgAhiEHrpo9L
 qySNW+B9OeHNpmU9Jmjz0rXLI0CkNQkLh9JYg7BlER7T44dElfk9fh47Ne1KDxaO4MBa4xCZm0R
 esjQZSmYfi1GlH0imFyV3+Fq+W76o69w3KaNyIJj98Rd50NUwe26PKQ907kEreZG9On5ywmCMl0
 KfHIOFQ6yfn0dDdwIvRk9wXoJOuuDhhTlEkbXnU131gVbvCg87wmrLR9E0evTdKH2AX133ftB9F
 hZBRqRPgxkUJ8yancVIuSargQNGNnc67ePw50KkOfDGvDvL2VRMo0UT3t3Jkij/LG+tFr8VFaJ9
 SxC0HobAFNRU1IxiFOA==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15d4a8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=phzA4CzYhpZqrDFsW3YA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: -J6uC71-Kox8xXZWeW8_QQa9cNh9LLty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260149

Add Shikra compatible consistent with CAMSS CCI interfaces.
It requires only two clocks.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 7c497a358e1dc8cec8b31c17bfedf315e4e00606..c94069afd8d06dbb08ddd6b49e2de7dc7acdc29a 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sc8280xp-cci
               - qcom,sdm670-cci
               - qcom,sdm845-cci
+              - qcom,shikra-cci
               - qcom,sm6150-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
@@ -137,6 +138,7 @@ allOf:
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci
+              - qcom,shikra-cci
               - qcom,sm8750-cci
     then:
       properties:

-- 
2.34.1

