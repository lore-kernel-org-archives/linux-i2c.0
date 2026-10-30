Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364210;
	b=X/Je1oGs/njO6hkIY1h4ODkYa1m+D7duyV3BM44d/8QVokIwG84iFVbQdpeMoME2UGQo
	 0l6bZjVp51zRnf5ovHPuSE+9Yv7FT4ILGlrBvsxtBbZ3VjIheSvLRqVDhlGWd4wUynjdi
	 pf37XggFzjmAHSC5oVRSzztFRBRqzFMGDdxrufWsTqJJEV8292Au/lM1RnSsCkpuOxswU
	 JpJwILnSmmpOVXHA4omvMxtdr/uyc4ZKpsy3argkHC+oDuGviecFQOJbkAZPrUHvsPHIk
	 UkuLiBLl3oCn+2B04/MqhqLrgkSypF/8L1Dt+uWw3nlGrWjXiYSGQduU9sNZvnMDZpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6OK3ZDmTnhLeioTQJQ1NAvYXYvXdPEZkiIm0BydC/O8=;
	b=ilFDkFPKDgu+sPXvi9bpBuLaK37oqXr4v9q16MvV6X6tTv4xUQIw+sf9+euo2UZivY6q
	 VtT3lveMUEk04qlwEonIvto+ltETVp7glZxP+kjo7O/YH0HYUMmqSyRezoKyP3nYzJ3+r
	 ymYNNqczZCagICVyPlwquzC2KZ5SJzc1j+G4ue8JQvs/d+mlXzKp7GmYI1xx18cXM9lZO
	 nM0bnP65tu65FGw/UmE8ZeLbH+2LC+VhL/lvZiH6eV/VEW9AyR5BPA9U/oJXZ+3bgNqY9
	 koohvYBBP/cI2Qq1xVssQKY69C7iaN96K6J6gMcB1SKKkiSYAi35VzY2Sa9j26s26mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6gj7HQG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnRfjBSv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB8606A31D
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6gj7HQG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnRfjBSv
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGDlQ4144837
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6OK3ZDmTnhLeioTQJQ1NAvYXYvXdPEZkiIm0BydC/O8=; b=W6gj7HQGhDXp+iG7
	4V/LGVwlaJPU8X0isqrWeqcDf2mGwKFBxnhoJ/HcvsjrANqd8rQDEY+d8I+nDAE8
	P1P6nUPSsfO3DJe7APIFi92tkM/W7oMI0ShSPrSJQIzcm8raY6k6x7bQ3cvkoJ1u
	A6z+3/OBfxLUy6e+McQYDJIZB3U8EtBSjPZ+8oDhRHQoSQQ2vJIRbasGxToEiYtJ
	RtySHqm8kd7s+DkTwIwhdGv6tIVbkPmuXEj8lvPykq+xCEsXNNtekCg0n3S0Ku+9
	PgIwpJqKxLHYaqP/BqKK0IVMcr8jBgtUxKdrmRFl9i1dHwmf+2GYo+8jnHkLhubu
	8K7E8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7531hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93f67358eso8705435ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793364208; x=1793969008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OK3ZDmTnhLeioTQJQ1NAvYXYvXdPEZkiIm0BydC/O8=;
        b=cnRfjBSvvjPJz/9kBPn2anfFh/+Q2iyZ5Dj8C3Viye1Gwp2pC0IuLvKWGBAovG6pPN
         GfugOArVMvbOT/HmluJ8b8qUhjFyWkaRW0en2VmBFoEP685gq2oks1BrackWlUxwSlxi
         v1JcxJTJbi51aHhWWlcFpYIJnS0v7SBdq/fC/VSAQASEUs+D6ppMnrBSEZpkxke9TFEW
         hH+hbCGw1oEsalOH/FYykUMh0stQ/R9Z8v9kyacDtQH4WNtftuDuKOGua8XlvssMSLQU
         r48+rSVN2jXBJHTp6immlpFBBPP8Jb0Fv88i++rSPTCXTKox70RnehBUUy3qC22W87eP
         Fr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364208; x=1793969008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OK3ZDmTnhLeioTQJQ1NAvYXYvXdPEZkiIm0BydC/O8=;
        b=xs00uvENTu5o2B/BMKwAv1rvbVUzA6YjYZnPOnz6YVbqoOHpzVjC4uyUYZC52xX4IC
         uUSPSz9ey96hTu7U+i+m9LaN5ZZfVJOz7vdca7+wnZ71Q1dXmc+527ZVy5V+fotij4Vj
         EgrLFnB8BUPPORzUvmFwNyETEieROKXpJpShHfmB0nv2hMqBm1qPY5ewy9vEC0NKWlPL
         1H/yBY3UR/iUctEhjVtLhXJwupP8nihrE3k9+mzrrorZxC+29tE5AKUi2VbU2MNXYDvY
         Mj3NZNjWGEcOxTX3s7fRzcRW1BojJF8DeUxC1d52VXVwAXSRVgtEvrmrjL9UoPKCGcs2
         ODUA==
X-Forwarded-Encrypted: i=1; AKwUvBy8rkKq6MUVkoev7rZJdewFJXRhlmNFmgyH0AtEQK5G2x8K1dJupzt9Dn7t2O8P4D1gtYNkOBPUNQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJId3KbW37lDHuAk1VEqg17xSJblrIN9FEmcc4KYQTz8irfT08Y
	MmLG9EF+PwLfSspF4p1oMhNgnVtymr++Kedwrn/P23FII9eK8HMV4noeJRb6pqb8ggHxSq1mBLr
	dPhFuTBiZO5FEcLecQgqI8m5f2tjChzRSKpBC7mGiaRWIQEs7Drs3DkyuMkhP9dU=
X-Gm-Gg: AYBFou0IFFOyDzCpMjG7a89mysqIw6NWlesqqUudx7aPc6NCuTW6jzzvoDPq3fb3/NI
	lfQM9qb4dZ20bnBGK6WudUqTLaR4V0uS0uCYnGJpbebjEjlsJkKYn9mdJfnHFuMQMHAgHMDQ/so
	eYcuJP7xyHRvkMT0Ag8QAfOU9jHJtqTxvbvOZiZtkjALqBH/qq8LQAhr4jiuK+GkYBOsQlhRSLN
	LakwWzypwbKqZlpD5Y7aCUtQSTEUL+E3hwwirUmmZ6yXVM1KTqWqQ4iDNYnSiD92lQGOy5wjHXU
	/tzsgxLluiBybvWj9+8vMOozc9HBqYm0IL0pLq3EeF4FbqUVfQHWzfrotmMYEOM4XDoYr6WwBlN
	9WzfZSd4vcx7xQxTSAQXWpR2jzR3NoRAQSfqyYndYepMns4S/4QiszYSC5TVmvakm4+1PaxYxeH
	JLYfM=
X-Received: by 2002:a17:903:3b84:b0:2e9:3dd2:a8fe with SMTP id d9443c01a7336-2eb3648b9fcmr24829615ad.21.1793364208176;
        Fri, 30 Oct 2026 05:43:28 -0700 (PDT)
X-Received: by 2002:a17:903:3b84:b0:2e9:3dd2:a8fe with SMTP id d9443c01a7336-2eb3648b9fcmr24829325ad.21.1793364207726;
        Fri, 30 Oct 2026 05:43:27 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f5dasm6450075ad.25.2026.10.30.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:43:27 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 18:13:01 +0530
Subject: [PATCH v3 1/5] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
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
Message-Id: <20261030-hawi-maili-camss-v3-1-9742bca8cef2@oss.qualcomm.com>
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
In-Reply-To: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793364192; l=1341;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=dX6MizZIA1isQ45cxUBsZgjrz8paPsRmmoOT/a2mOUA=;
 b=Goh1WlR0jf3fQOa50V3RiuKdBhpRNJIYT9f0lf6o9kErrJURx/R22pq/QSA0hNNZQXuLu61u+
 0vJJ+wrFvk4B5FV65gAwLZK0YrGFNAfIBqv5N7RItutaBxCQK+0/fx/
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: Uk8c9QCBW1Gc6dQZutytC1oAfQ-njBW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX7/amXxztkXyB
 w2wLoxIOhzhkzFx8zOGjcSdG67QYjTDH11hDm8cGl+NBwpqiXO9zsQeMjs7ArTlcokqwwGDBXnu
 EZEYTbUkzX3UVJVB8e0VJa4S5yClz5tJFiibzLEDLKYe9hDcZe5oenqxmkHDu+Wn9fSYEQbQINP
 NjNW0uidD+1fzCdMyR/upHxgjgO46AGGwOC1KNCdTMVfi0fl4/dTsrZTbsUv9J4nZFAEDDIYum+
 FvGrWlYa7DhY+kmoLuFm3YBbZ64ffLTi+l8le1fP3ztLP8raw2CSE0U0tK1kxxt9GU1/wLVBFzc
 UKPeCVp83uP8ReoiKeO0BYaWzq2TOY/iSoyqguLK3gJ3gKymnjWHkZp9mYQrj/NSqTCvB8Ux9sW
 fPGkUJIfiRXD5g7Yk6kq6mSEWgT/TVX8bW/QhhjJ1HtdzMe+dRM1X4TiNXkK7cAq5mBWeSEx3so
 b5nt5+KZFsIsnshKQug==
X-Proofpoint-ORIG-GUID: Uk8c9QCBW1Gc6dQZutytC1oAfQ-njBW8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX6Vfl80aYs5rC
 VHR4MOcw4xI1BowdIY2s12B/ZRDm6eZaHYO6zsnK4d0s5stzYM4S1FKZ2qM+x6EELMFJFw/gYYz
 2mJNAYvZTG9i7UJjvVUGskIiNb/v1tI=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae490f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=EFwTI_IBlkk_uzUYZfIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300050

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Document the Camera Control Interface (CCI) compatible for the Qualcomm
Hawi platform. Like other recent platforms it requires two clocks, so
add it to the corresponding clocks constraint as well.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..b2b4d4bcf780792515ec153c873bace1764fb3e3 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,milos-cci
               - qcom,qcm2290-cci
@@ -137,6 +138,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci

-- 
2.34.1

