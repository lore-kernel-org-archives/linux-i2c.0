Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587965;
	b=o6ObJL114f+HFwg9NOCNgJVCwmMqRpQvKZywZ27F2Dq9tedbQwiQh+SDp2WWZq0/BA+P
	 nWYLvoYMtw2zlXWoSOCo7D7LHBT8wRRNDgGsjFlHOhG15TN0AQK6QaYhQnF3P3bT2CDif
	 qKFea0CXLwwFbNcHo3m7YzQplk3XVXHza48ZTyITZPDt9npdwOBR5hL/LZ/auhcVCAwVM
	 XBE8zteMgY4ITk5LJCCW/fX/Dx2RqZbW/gwrsIkltYhpDTN+UTmUmTq51aDprzanNHjtA
	 TFFRnez2rLqXMme1gLCAbP3ZuYdxH4RuXAsFZVkkxp2sfUjk/LkI55iwk2+Q1e5HRiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
	b=0W4fAbraPaif1TID1ipLHYoL3O3Ln3YvgA4M+lhOVMw0FqDP/a6FMh35Iibhw/Y2mLjB
	 FCTvKjAxzbzrmcGEfXRZiUDUDTJyVKDVlRrFOmcEgxIPGi0ZcWQZU+AgrksOpuNgOCo7D
	 LaZpsy17onnauECeQDNHpQHlH127vXi8Yp9uPNCaMhojTUUwIdueTJuc5WLk8GsfEtXgD
	 3j2WEtwzoTzge+PGZ0ys+nrmVc4eyN8K4mv2AyUPW08mCKIDTLmAujUWWrg82d6B/hp+S
	 maA1994t9UTKufVM9T/npgShsLtUScYtgDBKh4m9veWr3OEq7HpfF9LKvaaet2Fx55Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="k9k/1y9/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PZltZnwe;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AE606A32C
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 129AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k9k/1y9/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PZltZnwe
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68bdH2629440
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=; b=k9k/1y9/scGSD5jT
	3WN+RtahfOXWzDXTqjN2A8K6ArnqV2qejClx7c7yThaRV6T3bPacjxj7S4GTxUwk
	/IEedcfwm17JhioUL6GBT2y2BwVFGLpNEQVk+Vl4RP1Q4DNrk3jwBvwRBrhHePEs
	yaUVVhHvLcDV044yf2b+C3UODQIjufitYttABSM6CGW1GoqPCIRxh2GjZXAPkj/9
	H36BJbvzrPioox5jHi7ugTHEZ/wv5MUoS1zNHGt3hgctjhUdvJWwlhcNv6jGEZHS
	KFBH7kMo8yfFpHCwBAwKsHh8Lgs+ZiZ/0sYnTC9EqgWxFDCfOvDj9O/dmtkMDOXB
	zENvjw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydak1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:26:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a073778890so4245900b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 22:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795587963; x=1796192763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
        b=PZltZnwenFPle/3ZeYb+xLZuSFHVK5rPZHh0wTugriQCllDMg9cRfgoFoNIsay7hec
         flB/KYwSdNt/H8upEQM/PaQresTSOBrK7W+h6h2XDtqerRdxAUYUy2IOsfYJC4S7Kwf7
         onLh2OYxmbmKidw69tVs0KQJM+EpS7gRjIVm0A0ojfd2DU9XeHbkFtwNYEKxk9OyWyQm
         +gijsLRbUQph+RHyRWpMiUERqgMrJgF8ZW4e7B2TnTp0x84yGO3YWrE+FXR//F9W3Rh7
         s2kP0HTy9hW8AtxmcgSFXWQZRcwGB4ktyOYh0BT0IjsDu/uOe8UGevk3ZzyQl4heSeCG
         0BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587963; x=1796192763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJPyYpIYmrR4ZHeGVfNDne7NhRPR7qG67vM1M/zaXQw=;
        b=Xds5ZnMZvaH03h+WF1C4C2hhPBNziIUOCXo9FRgLmp6rEwEQV05DXI22XGqwRMYxnZ
         roAvuvHieHtG/Xvt+8sRZcw5E4abGJSC0UgOKMKhWNEc/aYAofQqjhQ/PQLbc1aYHEPo
         AEUiOQfiAZ46bO3GjnSYXv7pO17SDOpTkZwwSnuzTp9C98Ki/lIs/IDkobs+zWU/h4m7
         nhRlvVA3hqv84k9OjitlXl9n+Uvgl6epUKjyoUv3TubVTIvZFaVmHi7enkCpNfBxP2vz
         cHrL2cq/s3SDeB/I474i2W9da4arXjmHVy9PNkSHB/DFylV+CA2XFrplbZoqnbMeK14q
         2ZPA==
X-Forwarded-Encrypted: i=1; AL+hErGRahTHUXWcErKq1o8B3YKRCIfKkpCt6PsDnUmBtePTfvm9+5qNddK55Z1gYgUFTMiS1vGDOjR5PgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CMze8OuQJDRaM93XjDvPgT2ll1/vuuiOdDVEcPLbMltjqD3Wq
	he5DuKt24BbejDNkYZ8zJVAn3d8yS/gWf+nlO5WhXYXY6+pIJT9GyDPw8E98W6D7DGSdslm2lNm
	GSFCSZt2jCvviwwfyeLw+On99BlTfEC5y0xdvD6tm7CNMQcjwam2vrUzLzldsyzM=
X-Gm-Gg: AZFdTZem3Uw/3ly9IqTLreqZkFTbvlrf5H9DaiRIW5s8g9SZgjWPCXBmh3RPoNWz3LI
	P7Z6Wg6I+TP7mY5/0LlNQEtPFnn/7x0FfSM4tEQcOAsHokWd3hVuDtOn/IIUEn/fB0e3M5FeMja
	iSiUWb21kOtVfTw5znSYqmlnyPji6YyFiB/FyDjVXXVhJwGP2GwMJ5wiP8MpzGR372a76nnZlko
	XDIwFcQh+MONOn7hGT6R7tnsGJKRYWH60qSfma9OqoRervt/f0agZJ8JUGUrA7yUYV4PjonTJV0
	1P2ctLoaCuhUOtfRVp1wwKHvHe+PUfVt/tI3eZtm5vVXTQvQ7rBlVpha/SMqwc9KXnECUIyYzgb
	PtLT3XRcbhNlXVd9xk0wKkes6boFZeXWdJRPUHjeuxu41ZRRSasETqKbbGEACc81q3y6HZoGyCS
	DuS4hz
X-Received: by 2002:a05:6a20:244f:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-4014c253b58mr17766997637.56.1795587962752;
        Tue, 24 Nov 2026 22:26:02 -0800 (PST)
X-Received: by 2002:a05:6a20:244f:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-4014c253b58mr17766970637.56.1795587962325;
        Tue, 24 Nov 2026 22:26:02 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm8385066b3a.2.2026.11.24.22.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:26:02 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:55:42 +0530
Subject: [PATCH v5 2/3] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi
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
Message-Id: <20261125-hawi-maili-camss-v5-2-1483b7f68dce@oss.qualcomm.com>
References: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
In-Reply-To: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795587942; l=1527;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=VrCho42XU53GTqUrn16AUx0FovtMl7rE/ickbc+QQAU=;
 b=z0AQLIDcrEmb0ZyhtN/DXrU7OlKamWSznS3tZAfWhcgeGbzMYpkrP6UHnd1TOfgA7nIQd6dgp
 +tkoDTZa8nBDptYhxqQy+JOmHu0E16q0Wl05A/mRlpvZIx4w2iBj/+J
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfX54TfXZZPHHet
 ryUjsFLS0AuBcspK0sooJTiF1w94asfGFgSaOT4NttmEoXjR4gfVNb/xCf8W+oV68b5tnQdhrdr
 mLEUcN7luUJCEiyjAGz1qJFQCeaFllQ=
X-Proofpoint-ORIG-GUID: agXp2MPTtrX7ED6DxFM89Z4GkqFs3HcS
X-Proofpoint-GUID: agXp2MPTtrX7ED6DxFM89Z4GkqFs3HcS
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b067f7b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Qbo-v1IXpRF52dvEqNcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfX9IGJnrKUgTAH
 BcfmPLSliToiSIyvC5Qky3ewQ49tkMVVNaoSpP7/XgV3bGqrmDPA0RxXFpPR8CZcMX2eUrUKsGm
 UzgX2UyTxijGr4V+Bv66yVKKlgC7g10kNVP0sJBWWQX35kXW8BoA/8fbMjX1davTLt7jmN5Dt1V
 JO23yFhf6Yj9sWYQUNrBweCetqaU8QlGQdvcJ4c/OKv8F9HfUQeIFt4mxQX09kLn3wWykEqEFVT
 2AVqoqXPnwfHUsqeE5Ewu2isZDKK8qRpE/UNzGK0rawtVVVwSy6g2Cvh9ita+eb1WAj1cfL8Kat
 HECt3Xl/QsQYRz7pilG9Uww1bEwgcNLSdi1+MziSDCPPgHXNqumPbICKLkanuCrLF/Ck8zXFxVT
 3jNtJg/lJD4QK9zGFNVAIOp6OoTP2vzxmDDPY+T1RMpb0l7Dy+E32i2xbzLcjZC3S7awB9Mluda
 9BORk5f8YM9SXsyNU8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250025

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

