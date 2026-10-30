Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364219;
	b=Spp6T5oAefhofKOE0Lv1/rAYgo8pFSiegB5Tep5MLWi1FA7ZeC6k1VSy4rrx/HLzWRi4
	 13I+SnjNZPpLIlS9000mdYakNNyvd/LZKDoaEG5esqWGrazdYH7yCO01KuAv1VKgiVxuN
	 PkDCLDMykYSjrcWFku1kXY1io4Wl8LeZPtWL2E2kTKqP7BMEBCW8p0kJ0V4KgbSyS1gw/
	 tnOQ1g64EQY4hvW9G2YqzXkfHeym/GFn2ZAYBaMXHPza6lT/QeLthRdHQ/B5NwosU5jE/
	 UH0dIu8oerfwvDY+wJ5kftu6vDDQUThShZE7vla4WCDcZiCxPRys6Sx2M1NLzHAKftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364219;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
	b=SE6erCGf7sF2FcPwVyMZwQIghb4VYVDwmyfYE67tlXBkyBDWR0I4pErItAuPJqTzQyvW
	 FZqtiDNyaXrIqLn4Ui41IqW+k/0Zw/sm9pwwL9CmVWWWhfYtvPMCHaKqFB6D3MR9BZlLh
	 RT6A4iQTYXt9mEryONvSoEeWMIKxEKb1xjddYS/DrY6pZfwmxUk+tSM5Xt63T0vZ0HW1L
	 dH3i+07V4BNG4V9VPbRZ+W/PVrIp64bU88eMkknyZRgSwLzjDIrixTQZzRY/R6Ey9jWb2
	 2UFQ4vD0MwQfzfSbWZudk2wLwpibT+Jr/pvf45KwqOhd603mIPq9DPEdw3aGTn9CfCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aA9iACs4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT6f40vE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E4606A31E
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F8E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aA9iACs4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT6f40vE
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBFw7c4116372
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=; b=aA9iACs4OIHPhKAx
	z3tAtDDkGHfnj0GwoaR/slfHPfGvqOuHHRebmCPc0vKZEmRLfCL/kkd2mYx7yypf
	mesFwnqXeolYDZbXWyw/2WJjzZkxDcivijWVA++Mw8Kc5Okcsd27AgNxMT3BV2gY
	foM4Gw5Y4Pm/oOzO+AaEpUt6VN3nUyG/s2+1PpwxmsmWbTRPH9ouxdMYB8gQ+P4C
	y43RHRj3CDalDugNjW3SGsw3hANONVoRAf4evoN5NA+pddkVW5N+yacfjWiLVdKZ
	RjC5uy6qBeyo7JPIvNfKdebTPOl7dQz/pGAaA1PSeMWoQq04xPyi3HRiVUXdGvIf
	yX3C9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rk4uc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9572e892dso5402375ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793364217; x=1793969017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
        b=MT6f40vE9No5RHTEIrzbyLe18caae6v1PI5eYbcp0c13AIhzo2HAn0prZ7dIn7nUYi
         KugvKwv8OLcGnsRTTcbZitX5K0+rnG98YONIsOGEOPg3pUAzNhjPNlMN7XYncgoQhvEF
         6bA3WC7l8TLPLYWWP6/LQpiG4o4TNIBagzq1u1tQQ38nBLt4UPsu4kHYRbNsmvCQc7LB
         gU/1kC8KWMguEAXnmnFUBc56m+OsqIml4+G85NkCsxtqwpa7zT4U+qXVbwKVkzJXZSb8
         Op7O4vfwCunprQ6aIOXIcFZ9RMseMQta/8QnilIf8ZQ+iBLmb+qCxGhQqEGhqwxCrSmb
         q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364217; x=1793969017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
        b=FglG2ObOubkTZbRPhfrvhqqqXpKx1Z5szAzyjVXZ513EX+8SWBB1XIB4UZATNvYsIL
         pyIe4vnsqmwfExqkvZdd+imdqO3iFrEJVl1ozRKDzGp3rczWsKpMsEtMib1DtrovLORA
         plrSfHqIAgW1ZBeBOTq1RZPKherzgt4MWX5i/ltZMUq/Z3dk7kkSvEaXTaEj78/XDZqw
         CLnOPqq+90HoodhGYL+vLhu7nFOntFS+MYeTtG2XblaQ8arvyNbU2vV8Rdi6PwiOqput
         HzeIjoI0CmxrBIfdMbTq50jUAEFaJKNpBk+3b6jWRCi3mrc0aa3tOFU1pVG+h4Nw0TuY
         o3Pw==
X-Forwarded-Encrypted: i=1; AKwUvBxU3sxTCcxsgXxNc0mlVQQL6cDAANcG8OmiI9IlaujRgCE3YKYK6LftpHV+Ii5MeGUTdZU8dw0Ox+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOxqOE1fSITyoG1BHOjGm6LRb+ZG4+EnvxMmS8TuG28F9InxLm
	W6sHMvv72MRpgb0UaBKXSRWFwqf1bVKtBQ57VstIgyEncsYX5QeolFDBwkA3wqRU0VWhT9UUH0L
	HtFD0iOJvc+vxwH5B7N++41IpoUUTwdPxaQ7Z2wFy8aIMsgwwzZr/90NVkSeQDOo=
X-Gm-Gg: AYBFou0r3xoOHTs5I3RJzq9A/DjgC0FLyol0FYWvKKxftivfrKZaSuM0P6U9wvnWhv5
	b8/s3FsBpqFRhCOrxryohOVIOYqmfH1ck/6Y/2RwFFRIu8VXEjo6JjywEsz2EAmYNCHkXNyb8oK
	3/vryhZs11DGOzQOUqMPcXps7uFxT8H4KFC+f5Od+/uoB3cafHVUm0gu5XRe3ytUtFItJYymsTi
	op3m1zU2kdhPHjH2T/zYGrxYFoYXrUYfai6T3IYp/RcogQGAXHKBKhZkW9e2Cek0o2L+7DOLi3U
	tQPdJdaGg436uQcKEl15UhmtQElx/zIEY1MkULOs76PszgyKOMMGszN5y/xIPss1bSPf0Pzf5Gl
	3g4ga0WG1VX0wq5GyKOKEjqOMNgabAfopA8wFVwI35OucRnEJOyP91dvT2yspoMhpPMzyPuPN+A
	iy52U=
X-Received: by 2002:a17:902:e5c1:b0:2e8:1929:c8e4 with SMTP id d9443c01a7336-2eb36527d99mr22525505ad.60.1793364216738;
        Fri, 30 Oct 2026 05:43:36 -0700 (PDT)
X-Received: by 2002:a17:902:e5c1:b0:2e8:1929:c8e4 with SMTP id d9443c01a7336-2eb36527d99mr22525265ad.60.1793364216294;
        Fri, 30 Oct 2026 05:43:36 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f5dasm6450075ad.25.2026.10.30.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:43:35 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 18:13:02 +0530
Subject: [PATCH v3 2/5] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi
 and Maili compatibles
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
Message-Id: <20261030-hawi-maili-camss-v3-2-9742bca8cef2@oss.qualcomm.com>
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
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793364192; l=1461;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=O6JOHgjWCf6k0+eXloLMxj3S4Nm7SEUIMrYIjwRLIus=;
 b=3q6SA79to3LhfP25KLgv4CM/jRHI+Eaug863piJVxiwfuCDVLNdBFSp3qPp+LcZTmyL2pUt1c
 Wpi0ylH0f72AaZBoTsPa+f9i/u7hEkQPP2ONknjq1ttyu4rISfN1TDl
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: pmzZyFoxK0KpE65b9auMRCxfXstxxCzF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXwbRGSRDFwnOA
 kggEo3oKBCuvEYLfwc3ni7sa8I1B4nwwiii301PKEHX5tB0WC6RzIUqeNrKURIq0B+AX4LTR1rt
 iwnKb5xYoCPUUTfmfFS+A0uxbnonScA=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae490f9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Qbo-v1IXpRF52dvEqNcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX6q1vsALym/Uj
 ENtR7arsGuUSkZ7hxQRSDI3R2TVJthdF/5zdI96cCn/DLrsQ071pqKYNNxe2tc/X5fSQhckVaRs
 jNd4ztwDBdP4Iao/XUQPuQy1SsJvabsNZNUqKMn/nYRGqhJzTfQO7LQyBVJw6okpdTUuU9Y11ww
 y6bx1yF+anF60PH9FBxwvyxoJHmeV3ci9xPMGv7FRRsW91kY7olIDc2oe42BoOaAG7fai6YMTmy
 LLekYh5diRf2DgrAtUBH9aZRFdHMTOqopJJUxIpWpwt0XxoLCxhuSfh7DukGMsjZcB6Qjqmm7B5
 RuH1wt5Ly2Z6nNEgxCVPh0Fak4yyGtqey5xPmXGVlfg9wczMBleJbPYOBExa0SgLoAd8dtQDE5l
 FWzasBFXN/nV/pblJ0n/4lKfrTo8ah3l2t4D0jL8N83Qqk2jExFc2RuOLcq1H8nwXF+5nFA2Amf
 WLBE4gCCKfZx3Dr5OgQ==
X-Proofpoint-GUID: pmzZyFoxK0KpE65b9auMRCxfXstxxCzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300050

Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
identical register interface. Add qcom,hawi-csi2-phy and
qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
index 6e9eb8e265df93b631101ae13f31f6365b6239b6..627aebc7cd9b7ca313457d3f70f72796e9671e8a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
@@ -18,11 +18,16 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,hawi-csi2-phy
           - qcom,kaanapali-csi2-phy
           - qcom,x1e80100-csi2-phy
       - items:
           - const: qcom,glymur-csi2-phy
           - const: qcom,x1e80100-csi2-phy
+      - items:
+          - enum:
+              - qcom,maili-csi2-phy
+          - const: qcom,hawi-csi2-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

