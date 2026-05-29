Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63173EA97A
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065483; cv=none; b=mRsPRdIszRxIfPkYSfij7hjOkp1b1iCJggH4xCei7B6SvZweFNGK9+eN+60DaeeGQeAXit66S5vIuSoS0tNbmRz+OKHB8K/qrX8dEqGeW4CqH7kvUhecbMwDzNKgyXn22SNvc8yPexiScM9qCAtswN/cAsWgbP05PzmkBQqB0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065483; c=relaxed/simple;
	bh=r2fiEN0lX6+xiJIlqbZ/NyYeWC2GmPUInxLRy8wHsQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9ZvebmuDZBhasJIiutTxuIMNgFdRbF5zxx7n131wRq+BjZrZ4jXyhSLi2oEQVaBDTf2TRNTQvh9Mj4n0afdR/AMdta8WwqchxV8Amh85eikj6qAqTjpj3HUXUqkgCMbHLZKNDeXBb0VKKL6g4o5ps7wxKrbsCbOX8n4zUTAuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MfPDRtQT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FI0OTkJ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfPDRtQT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FI0OTkJ9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKV6B4119145
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LQr2zjs1JPe9yT7Uy8X+YOKAaPC7uJOntVlRezY+ghc=; b=MfPDRtQTH/Xu604d
	ueoXSptQbqzX/KJh+1NR+JgpPbyRR3wC7Euf5/g1Eo/W2D9PT8MkhDcZ3RxlFLjm
	oAfk5JwCr2A4hP5M+jyMN8g3hB00QDB+fyYDnrAzjtQQxVv1qILn2iEmUm7u0dXk
	af4olwCmG1L0UjEIcV+hvGmiqPzWUO3M3SzibS2uowkTVtc9Bk3yNCnXm5+Ngh3l
	xynJWJnItlO3k6QNdj8eBQUOUT34wczj6/TGIJVIG0055tic4vtgbitJCTl6yMus
	n1KgIf151uXNGWYgMgbcK1neBLrxicDg7q+hM8Y0Nvr+P4QN1XdLpGcfxP4weB+q
	prCU3w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rch19h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc6899bfb1so151973085ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065481; x=1780670281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQr2zjs1JPe9yT7Uy8X+YOKAaPC7uJOntVlRezY+ghc=;
        b=FI0OTkJ9dB3fM1RHSHzN/eXvhrApsQTvdg4xrgCRjKLdXAwmyAcZBCn7o5qxZgF59a
         cMrDkKaPAuOuTWWrkG+TK0jetwGemEv3/AjbaxIrEMkPbFDYlWVh+gEcWFjScsN1fMc7
         jOkCwlqJi1ENl6lxkP9cgZUBeDP4DIsUHlUPZ833dyFxyfGkRbyeK708tZC3koodVZYQ
         xdko1mvXRj0G5ocq6sGR6bgZNu7IN1kIlAfcUrtJwMK97oa6YC9ZGm3v5pJbQCVcUf/r
         Gv7HJVB+gQ4/T1qY4ZXwA/CDd9Bq/hkvDfJFzPZRR3du/6cDTgbScswJCf20KM8X7XA/
         BeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065481; x=1780670281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQr2zjs1JPe9yT7Uy8X+YOKAaPC7uJOntVlRezY+ghc=;
        b=jviUal48NzUqrDNFUUQS0cfALZUr3r61EuvznHmO4vWTrMucBDzTTvblgi76pig4qq
         7AlWUCeNIVwCmLvoCRez+/5XA3lc5kbqoBY9VLZfOslK4bc3ppdLNKJ95Kzbvhzym2Xr
         0jq7uxdt53pKF1SDA7FYmGxT7iXeZ/pOlejb7TO5F0HjeqKuX5ROyFZHnMRxc0iTy+lL
         WmHqjMJHANsOt9jQzPdRMEIpSbkmByz252VSumFkwAInyHdvbkXQedrz21i4U7IgkCF5
         uHXwnzDltiz9idLl1Z3QXP11IE4nvOQD4t7Tj2OwAvqLBjkjrMikhOTVcsPHzWQ3WNj1
         1itw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZAENbqS8CDXe19VpnoQ4PlxsfiYwmBQBIRmvn3cjCXdUey9fzODoHWBJwn/wPV3G+zfNu1neI9KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxasYHpIz396V01JpfT1Zha7ZUVkRgJO5I7Gd8ME4i5PNDHCq
	D2PR++zjvuYyyoZrgCuBtnHtJZHJjoLKn3lFCaVBb4oM4SU4ZVqm5rRWk0U27M6EMQ8OlqcapEQ
	HuPdTWejwDgboLhYbmEkJFi9svrv2beHLkvf02bhiJE9BmJsvLmF3OCqklTTL1/k=
X-Gm-Gg: Acq92OGx/DBZ40Kz7acUCNJsGSy/uo/F0Yo1ok5+Leoq5g2O0QVSib/8t1DaYJ3kVYj
	iqb2298OhQte306EZ+f50nY/Q52Vja8VM0J0Qr5dAwYBF+J0nAfPnHBr1fcMC9SSQXnPJfB+5AJ
	d6i93WpkE1KAS2tdjKxYZrDvXEP4pqz+0lT+bHmMUIDh9WIUUUPwopvFX1Bz113ccv8NTEWe3y2
	8zqRiuqSgckhzz1veW6a3I7j8qDcDOO31AajUfbz5hthn4rXMJ5o3NCfWjYpwwolXyPBPt5wndr
	+plQQRFl7NNFx4SP/71Ws+2AwUnTv3EO/AUZkLI5JwsQ/ux43Vp34W1z+70GzNxOU/SoR0+7x0T
	d9UCh3qDrKnyF10+YssV1UWhkbjDn/LcEMWReTg1Nt0xFeRJCDrP5SQTedGUoaG4dLg==
X-Received: by 2002:a17:902:ce0a:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bf3682abd2mr790585ad.22.1780065481340;
        Fri, 29 May 2026 07:38:01 -0700 (PDT)
X-Received: by 2002:a17:902:ce0a:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bf3682abd2mr790235ad.22.1780065480858;
        Fri, 29 May 2026 07:38:00 -0700 (PDT)
Received: from hu-vikramsa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm2469394a12.15.2026.05.29.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:38:00 -0700 (PDT)
From: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Date: Fri, 29 May 2026 20:07:22 +0530
Subject: [PATCH 2/6] dt-bindings: i2c: qcom-cci: Document Glymur compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-glymur_camss-v1-2-bee535396d22@oss.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
In-Reply-To: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780065463; l=1050;
 i=vikram.sharma@oss.qualcomm.com; s=20240628; h=from:subject:message-id;
 bh=Kj0qls3u7hmCqRFLqXAWh/BtkU3k96MxexEBHy6KH/k=;
 b=4G196P5UMnVLRk6IVeIsblLJ7Iv0JI1avhJeXvy5MumHY5XqZFCWsSHS4jdJ5lwUrDTvk4h57
 XliJ3VwUzn9CLdi0zLcQugqmWdTBhUYBPauv31yda9wrKxYiCSgPa6B
X-Developer-Key: i=vikram.sharma@oss.qualcomm.com; a=ed25519;
 pk=vQBkwZr1Hv+VXogAyTAu7AEx8/6bvkOmgrzYFbNGCDI=
X-Proofpoint-GUID: YPx3JDewszkCCUExFbHXYFJRxs8TREW3
X-Proofpoint-ORIG-GUID: YPx3JDewszkCCUExFbHXYFJRxs8TREW3
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19a4ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=phzA4CzYhpZqrDFsW3YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NCBTYWx0ZWRfX+l31iOE1XC/3
 XJ0VAkXHqLYRFLYplAdoSMbQIdv7QKnEnBgbKyJSiDEWgbzB+RFK3p8hILMKRS3+kZNkqEQRxT/
 kXKwBDedibLbuYzD0QY0bo/vq7tpg88QU9jmodEiUjcP1QQqaXSOy1MmdzloMK2Rq/1KX3u8o4s
 eaYEJ/zm042yWdFe4P/cGvGxSfNUDRCli1/ykJAvmYfA0v/fEIyI2O5W4BiJtZV90qZi+h4l2T0
 nad+/jAmM+qW45I3+5eDRlpryuW/1IAvKOatO0Sc2y4bEHL8eHlaIWII4xElAACv1Y1HoLkINJz
 TLpVO8VW1ROG7iOWLeEcow9sAyGzZYX0urQB3k1ArXsu+uolD7or62t66xHwAn7u10JiyYIuXa/
 PKv9s4EXP/hJ7SLclBlRYIYsq8DNbfY9TTy0hb0/71EETGcr+k7xX8bqdPZk12HxwV3YRLajD5d
 iEjOh2SUA80x1e1V57A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290144

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add Glymur compatible consistent with CAMSS CCI interfaces.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 7c497a358e1d..53aefebc02bb 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,glymur-cci
               - qcom,kaanapali-cci
               - qcom,milos-cci
               - qcom,qcm2290-cci
@@ -134,6 +135,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-cci
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci

-- 
2.43.0

