Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947861;
	b=Mxzlgbkn3JSWTF957K/5Ty82ihu6WmmARuQyMqiYEaanX3QoajuKcOqUec6O696nVKNt
	 121z4jztquEuls/z4X7PyNgr7aOL1qYVMJc1dho4Yq310rvdCIxtIJ+Eu2Z3RLCJhuZ5g
	 AkffMJjoupOVG+s2725AjjqzP7D29axJjgp9B4MIz6ezgRmGJtXmOghTBiHXCGGR+i51T
	 fHUkRy25apXh63kRHSxem0nQ3drqqXxEAgVmzJ3awS5pwRq8W4EN+ji9Vlvj9dCHQZwuw
	 gSnDxAWrvQoBjYZx5i7p70FLAI4cku5GBM7AxxdIAvAtVkzHfUt9Su6x1IPdqunZTFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947861;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FgTaumbkJseV8Cy+AMTmURdrUUaRe7Y1v1tbBJFyumQ=;
	b=v8NlN/LnBNk/MJ1XzjPOf95xaJ61J7JxIQXvGCh9cR88pD5eZlqfot1kaO88JfhjdaKa
	 pFku+woYZlmqKY7M3JozYlkiiK4f2w2z3GqFo1LXQXTwuxql2JHUkoK79wLNsle/+5ew+
	 WHLuzrZKxGLHoSXa5QHshB5XfZSc1rmKTLKTYroGsrcUKvD1bTUnOTNsWlFdGmN41RV/e
	 9JxRe6RmnqZh7jMfoEu5y5Jfzv3vAP6bKBMShCyHNeC4dV0wcUCuauza144QC34ZkRZIM
	 6a5jCQc0+YjjJUbnLPnBVvKY8sduGwpzf0UPF+ptggF3lHVtYLjnbHs3KY+lUq7/Jww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaD9UBMA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="OXHBAo/n";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41D606A330
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 06:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD41D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaD9UBMA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OXHBAo/n
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A63xwoM1866673
	for <linux-i2c@vger.kernel.org>; Fri, 6 Nov 2026 06:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FgTaumbkJseV8Cy+AMTmURdrUUaRe7Y1v1tbBJFyumQ=; b=eaD9UBMAJSVOeRHv
	67OKVKTURwH+iv7egpQZoCg5G3IHE7svYA9zTwuWAMBk2L8ieDGEQnyNDBRieRT8
	e/0L7AvJgHxui7qK/WTCwNpYQfYw9ZwBPBJlfnY2cLYjujLqQuYEi7zvubKFvEPY
	U66nqGI4vlO/vEwfZXqM1N3U8Ak8obddu3W1Ol7EjBHZyF/l7P74qh8BfeTpVJzY
	bGP90fmouxQCKsUedjwT3THlU+b1RiqUE2GLgh/9EFfBvRzet5e2W3BCSz+LMJUS
	r07rfw5NJTBIRRd8QG66cI89PIXu0evuHwVfS4tEwMOWRbR5wO9uhZa+28HihK2p
	SepOiw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p99h0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 06:51:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so260853a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 22:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793947859; x=1794552659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgTaumbkJseV8Cy+AMTmURdrUUaRe7Y1v1tbBJFyumQ=;
        b=OXHBAo/nMVK2RWzgd3FivT7QEhJoS5LlQP7BrPyVEs7sNY1gj9q0J4tdNdXTweANbC
         8DWzW/HGClaiELMQCuCWLdJrMmb0gr9+Vpe0TKJWejFRnlD0I0x/0JPsA/AzQREzVbj8
         l8l6tKtLjjtPbevRc6TKCon3pGSXE4IpSqEsl3gBLQfpwa45Clk3sB0lImkEH3woehyj
         i273VTee5Gnm3hfU+dub66cWbF/Te4XK7D2hs/hyDA7BKpW6K1b3fNz6O+xJ2UQOOyAe
         MIzbfk4LNQw2e/8DZQkWxvSOVBl+0XxGIW7YMrLZLoyDMtA20MfoIpzgs1xTMBXr0gnq
         DEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793947859; x=1794552659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgTaumbkJseV8Cy+AMTmURdrUUaRe7Y1v1tbBJFyumQ=;
        b=cpEGZN32DaAx8HS7+MHNXp5JlZCCThgiylOXdanfEKnA6QnPtdK5Yk1uH6HoV0UQ+1
         YhrD3JP455j5k72YHEcmmcLuwLHJqjCcHm6NdHHNpOI9o9XMcJAvsA1yQr3PB0YPU3Zo
         JDm0ZhGmE8qpAwe+zrbpQm3FfqPGSXKl/Yn51CXgxXuoe1fhIo9OBX4vCXXYBS8CED8F
         +yHj6LFp6iFtb8mrcUHeoNRd2fuwOTGdAk+IAqQ6JCtoskkycgopSwIa86D9EoFDG6tf
         puIQxDSuPtDM6c3i+yhxkRJ5XOlbGzsnriylfbf5IofN1B29muN4/PlYwCsxiyiTs66g
         AQ7Q==
X-Forwarded-Encrypted: i=1; AL+hErHXgxHM0Ss0den0zF+tk8uvbsK4drS9IOXYAD6LKNWQHw9vWzRqsofTM3Aba70NYeJvjH4CAinP2DY=@vger.kernel.org
X-Gm-Message-State: APuU4Z96xPhxn61erNQLrPxSwG8OkU8mIVVyoY9oJ6U6m0gIU9hM/s4u
	cCgOj21mNcovHYqeG5E6LboKeusN8OP5EenwjikegcxzovDm82+IsZh0xgafnv9Q8Mi9HZBqcdU
	2YxGu8gtQYgGKBVqwyO8BZWNCy6Coe5KGUxPlpQh+7OQh7W/Nt27DIqQqWqjq3sg=
X-Gm-Gg: AYBFou0UeAZJ0bl7hAnIEEu70j66+kSNrOYQrl/4lwQY8BdoG6C8eE+AFfvlOazkrUI
	FP70AMWuIk0ax7j6T0zqKofHnHsI7YJFifmaXjmvqhnGC6al4nItsaqnsmcS1+IkWnbS3lb1ntu
	U1eLw65OPZ3gbyZM6Kr5YAsHkWRbMKOpNIYwliEaexqiGIItEAo7CTZe/aVY7GvX3f4G9KsO7cs
	oGo1WopqP0ieZZMFSMt1NjyNdrvf5c6cKKdUaplBAJ59z/XnZXUbTVywQPeTt9EXYgyfTnlpsUw
	Jw/FgvRxmshTaZNlILClLHJFmCqu9MzXGGdBRwIZVucnv45AzQIeuS4K7ClPcawEg2uVWTrYJdX
	4rK4yiRxw/lMSDkZ5GZvAQ2/ens/BTKwUnx63zjRLRjKAd3lflcLMoVtHr5dr1toMRixtx4wMKP
	sHiWg+
X-Received: by 2002:a17:90b:48c6:b0:3ad:47ce:3876 with SMTP id 98e67ed59e1d1-3b0db71a865mr1318363a91.61.1793947859401;
        Thu, 05 Nov 2026 22:50:59 -0800 (PST)
X-Received: by 2002:a17:90b:48c6:b0:3ad:47ce:3876 with SMTP id 98e67ed59e1d1-3b0db71a865mr1318343a91.61.1793947858870;
        Thu, 05 Nov 2026 22:50:58 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm6597274a91.1.2026.11.05.22.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:50:58 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:20:42 +0530
Subject: [PATCH v4 1/6] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
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
Message-Id: <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
In-Reply-To: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
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
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793947844; l=1414;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=Of5la7TwZQ/Mgddi78WKNJ7A1AYscECPq7KHX0+sZaY=;
 b=oc0WJiOjPuecbdNW1PjeNotzAGfBEPLfXzNtndxTCk2cf10DpBvORLSkKxuww98qe+zxAI9A8
 lfekXCGU7PsCp9YWcgzQ1PxbW4ejGV5eowPCbBGqQ/1I2hpLJV7nV60
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: Ss4NRTo0kcErKySo30QnWnXsYEg0-i-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX61vAISC1G0Oj
 akOTwsbHt5s5hLnmZv5x5768tYVqJQzSSI2F9pAYKfYdwlnnIOmGJ8jbN4TKccRC/3SelbGYHHj
 nMEgpYfvOd8iT9bpE+CDM/LVVeX6qDi4xF1WqgclrhwyXc5iLKv/RItzRqQIPPyun6J8z2SHxP1
 Y1+uqPohUzYr1iGWVcykSGfqBt0aGk7c88O4n/lNzrRep3NxtZbf5Z9Z+VQKSGxaQ0oCupM81AD
 hZWxZxNsnK0l+oFKdgj54JKtclRUzxAqKDSYqMdcJbD4iRlW0KF3USqF0t8pm8RtHhCPVMPrUFu
 cdYmslIyxGHJxX/OaYI2Nihcu1UPVWhF6AxZIQmGrDfl24IGnFFE5ACJUeI9zaR4oWYKbAmjAlA
 t1aEocXyuani+Xs094zarPewIgqEXxkUyml0WnNxSmbZf9FrEwAKik0IKj4+VWVoBf+pCETRHqO
 67qioSNu2WQlXFsO6Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX20k5imCbQpwU
 6VSo1mAUXlM0c/yx+2vqeFFNREBC4PwlvHXgI9cjdYxwhJLZWNjSvwJ4ASZ4He5+d7bl8QEeZxt
 e57gj7RjZBRnrH7HJZHBlkLGsKS9PHo=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed78d4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=AartCDbB9JJyHY4DVtoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Ss4NRTo0kcErKySo30QnWnXsYEg0-i-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060027

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Document the Camera Control Interface (CCI) compatible for the Qualcomm
Hawi platform. Like other recent platforms it requires two clocks, so
add it to the corresponding clocks constraint as well.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

