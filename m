Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779864;
	b=B+EQyJJVyw/L/95gEBM2/dEF+pXVpA5JVhnIRxDuULrvZ6FXICFYkc+QUi9UQ6OeWtwr
	 E5yo/OWRmWgbyomscZilgY7liVUsMrBxfANJOFLoroWP4UBd7QkKIb6uc99gkLS8btxVO
	 ege9egPOqkZezB+JB/BeliVyN6UiZV9mv/8PgLY3Ve9jiU1OhV9s1cQUq7HpGcQELqoHk
	 2Oi9nZbfUNt/U7PhGP+sX/qNYcoGVbbNE+rZBYuAU1kY8QeEox2BPEQPSrzHFY91zbi6G
	 F3O4fFRAk1iUPeK+NSXLp5zfpauDJnkL0EI2Rmw5WFiQ5DiNcFBJsKYKxXnK+npERMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
	b=A/yBNLOfzpgDVuP9+Es7ML6iDY/DRzjb7s1vQmndlxHk9Ac2+nfGTblya37gcZZmVUrL
	 6DK2xwkrf7K5ZoeHDoOUmz7tlM2e0/NbfJ/SZbLNnsB9S3pVUlTy8JmWSmn0c18V8mzrY
	 vBngdu/wFFcuXeNS+1QInGdgFqAylhc7elqnF/T70auIXXBFHpopKquqEmviGbbnqr12c
	 FgMhAXCt7vnLhV7oZLIeyYUpva30bJnNer1FKYsShH2Y83SZ5NBvUUpkeZymX4RWUoGX9
	 hNyTLbupT6Q0mk3aI2p5l6BlGy7dd/8hUP9fGWxV16sbgPH0u/7ZpLr04uHmQYPnXDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FI6tTpRr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ONbZeZ0H;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7C606A31F
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D7C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FI6tTpRr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ONbZeZ0H
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp8Ex1376861
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=; b=FI6tTpRrl2APtsrf
	FWwkmMW5FBuOJ2srE0EuzaMzp1Hi+ZjfR5yNKUdUUmvriG/AC3BEuLbd4Irc6JvA
	ntJXUMxympMhGdUmCkxuSPtLb7duDa0+1ZhZqBoye1SIbrh4jqUwkboXutDoj0nR
	v7Lsgsu2Ep0C5zfxQvcaW80Ev66Hqyn9eo0JRDGMGvggKQzBZVR5SJzM9vd3nIyQ
	Phh48k5jSd5dNQWhmV5q5eCL7qg1Srv6NLo4aZXnM+Px5OoFtnZS9ErfxxYbBbLa
	GaYkjwhidqaLjBDhA7zsajZ7YEXDzwZzM0zTdaxoYEDIFGp/sMFGJlleBXjmbJgf
	UqSt/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3abs0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b45655b428so7106240a91.0
        for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 03:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779863; x=1796384663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
        b=ONbZeZ0Hd57Wg2h3dlKF1qYNUpjpfvEigTgIhKNmCxt88+K67fNUApAyzoto4n7wqU
         cgxcPMu8qf7uSW3H9AIULjJQ3spM6y06MC7u9UZa2wQFXHzzUucDkmMtIYuFhv0zHFJO
         Qe1v8pSHXk8Dnp+xtN/43AGgLTz5uoCKcCZB/zNeVw6M7MwZJr43mSqfVRFGcC9DLARm
         djatmEF2p806rYvu6UvoqZSNAkrR2C58/WQXcWZIg8Ol5yA4by86waF0y5jrT9ecZ34S
         GPv0+WRdIa04m82WblVbjEuODCIrwXBLf3c+vfPzdWTZva9rLcplm8hNmlJCNWVjQXxT
         XRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779863; x=1796384663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
        b=ezOX1sn9TavMcP6tNEi8PFmjFVqQYLG4gDJocV8N97GMEwQHMDIYBb3WA1PotHqpTD
         2en9mkk3Rpr+hIbvVF18yGRBrWmJHWDMeXamEzRtDSsKT+inW8BqECG6UqGcdgWrakSq
         nUl5oGzZruGaKNuxA9ceJdmOaDvWhSpvFALxSYPJrK+gOaI/A9otuWTnleJ5+0X9tq0c
         OW8DTtvLSZkH4QUwJdNvnMoHbFpSaLsjvULf4Md1sJu44OpFoPgSop2QtOSBvJZZfiF2
         y4C5S7rk9bY06d1/gK16M3J5jzhoJ/e4hzYSFJSPmBKFeQ7F2ZHXTcP6CV9x+L+h4i0M
         38Nw==
X-Forwarded-Encrypted: i=1; AL+hErH7wVpRV2H+YbFin6FGo0wQD9vvt/PK/ZP0PBhKWGbSZnLE93UBO6boarK8USya3rF1nYHy4l/kOgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kGMeGCwjeanLmD7rNNyhgCJACPhXKoWC6rSGieKKBUsTxQ3LS
	XR+z7RRtYGDoZ6AEDitdC75udaHcg6EHKbftB4+VGvAgy9sXjOzVAPoHpeQUtfD3sn6EZ9UpSVQ
	QC6yIcqwXecy8m4pfBEybOinh2VglLtfwcpfaLHQ3+CQfjSGLpDXwxczCcyeT7pvTxemwoRk=
X-Gm-Gg: AZFdTZc0rzhBqMopUv56sZiYs33+cN8nGRIdRZ9o9k+M/PcxDtqsbtqQOxOtCrP0pwQ
	WnKGsCakONY3RNolSPUvW41mSPrBSdlVYQO3KFqBjD/MgPb8uh+kqojyOoUy/Khl5amKelKwoFk
	P8Jp7A+AdpPCTdiuvF5JbuC3ZxU7fkk8Gp2TPWZGns5KG5C1ohdzQBxXPF78eioPGEKYeEDcc+W
	/DBjncT22ohGkkQQGyr49naFk7TPV4OWCSFoPqXheMgnKjPQFABanJJ0+pBZj6pihE+WjQ+6re4
	DeLqIC66xzcDSVjPFggHFyDPtPPTvclBq2IuC/tcwUpk+BXyUdZX4Sehx2nXz/4/RKxK30KViqO
	IVmRXMxvve7nDkwCjvBQziXLhrpHzewdNg/Iw+BC5+tk8eqybEpMBt8AMuEQM3lrBPxWCIs2Wjr
	Ln+uZ/
X-Received: by 2002:a17:90b:1802:b0:3b4:e19:e127 with SMTP id 98e67ed59e1d1-3b41cb5009emr23189364a91.63.1795779863095;
        Fri, 27 Nov 2026 03:44:23 -0800 (PST)
X-Received: by 2002:a17:90b:1802:b0:3b4:e19:e127 with SMTP id 98e67ed59e1d1-3b41cb5009emr23189329a91.63.1795779862628;
        Fri, 27 Nov 2026 03:44:22 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm40480933a91.16.2026.11.27.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:44:22 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 17:14:02 +0530
Subject: [PATCH v6 2/3] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi
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
Message-Id: <20261127-hawi-maili-camss-v6-2-0f4844eb63b3@oss.qualcomm.com>
References: <20261127-hawi-maili-camss-v6-0-0f4844eb63b3@oss.qualcomm.com>
In-Reply-To: <20261127-hawi-maili-camss-v6-0-0f4844eb63b3@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795779843; l=1527;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=VrCho42XU53GTqUrn16AUx0FovtMl7rE/ickbc+QQAU=;
 b=W5uq9E750RzUKhnaGzYYrCYRSi1zcSdV41r8VtcB9zOLrSDHmR229EBNX0VaZHK74x3ZUv/YG
 H/qLd+NcDIiByN4CvMriKujttm9KK3BN5LrjdhPHnwZU7c+Bx915XLv
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b096d17 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Qbo-v1IXpRF52dvEqNcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gUd_aVcpQfNn_nENDT2Zr3I4A8P_WFv2
X-Proofpoint-ORIG-GUID: gUd_aVcpQfNn_nENDT2Zr3I4A8P_WFv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXyIFt8pUd6eRj
 7pI1PRXCuJn1FCuC4/Zkmk3zr3nIB14uX3v/7ZV5zAHCNw+3hj1U2eZjnlCGanhRCvhhh1H50gJ
 GHSdEXUwrhYSxJ4lPeCV5kXJstqr5S4udY25jeLsfMbiaXAaQGNj++dSmmg4aZiqLlKQQGbT51R
 A9c9+qWybWWAy26he+a/pBHpL/rs6Lgf52VSSB0YdJ+UxE1wmUStDc2zlm5POHyXR4A2aWOXdn7
 /jyni7R4J7/gItHxH5jwScUdPcxkNUIVHBGRu1XtW6/ykCUWMIC4b9+hmxdL/vaQMCCqx8sHbRR
 H32yJaljjCCzaLl6UpGcbiiyoyTGssxz2RAu15BIEok2T60WppFfWNUtnvtgGJ1conx/7t6HF03
 nDRXDV59icrUFMtJIC0pmvxUTlVFQDn/of7bWnlVzL1PMQKS9fOb8QvK5IsXuYu2UBWb+7S/3Po
 edt9MQQMLN3uQvSHFRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX/MkysuMjyh/u
 AZ7ucbTcVWpCd1hGwMLUpKKigdwmmIehNd7bfBgo/9F6fykL/kJ/+YFsWCRKUlhxDvkEiv329c7
 vS6YZBlNhqFXQ3Eg4yqwHZCrGzOGQcs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
identical register interface. Add qcom,hawi-csi2-phy and
qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.

Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
index 0dc8b7859447f378282732813aa6886bdb1ea4b5..40e9a1725d57644e480c2d25a5f1c0ee7e1f5dd3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,hawi-csi2-phy
           - qcom,kaanapali-csi2-phy
           - qcom,x1e80100-csi2-phy
       - items:
@@ -25,6 +26,10 @@ properties:
               - qcom,glymur-csi2-phy
               - qcom,sm8450-csi2-phy
           - const: qcom,x1e80100-csi2-phy
+      - items:
+          - enum:
+              - qcom,maili-csi2-phy
+          - const: qcom,hawi-csi2-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

