Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587959;
	b=BmJw3m+34xL6FLFgyrGJBuJcD0Oa6eVtOzDy30QZnbB2Ad4S91imKhdlu571o1G+L6Qt
	 gEuyUllV6dK8NRkS1cbLN7IfPF3JubZ4wDf8V6ddJOaae6UPo3LhQzXtej2Ps8hcyK2oe
	 bf4bkYaXG9NmtBvsg8wTTLza9oJsQ+If9z/ovk9Z7trv4FXjhictuFPNn3gt6BaYKVbRJ
	 Viuk7piCy9oaZuZpE4dydlZM1lNL8Sxnzq6tARNBtvquCdiXH0SsThyK28i6Fy0IPbS7Y
	 RIcXRp2OWm9tQxJMvhTIKDgkq/7ZYgFy5moD9yy+3qMqHqIf7KOzqcQI9vKTG8mH2Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
	b=T1yTmBIU/FVm/gycexFqWvY3sFYmam8dY4bHKdHXuMPiZfDw3dQc5V1iHDJRfC7uxD+T
	 GhQTtqO2YYeDN3GcmdaicZ/cTzCezxOOUoqjnTFaRHpG5uRqtFe5KUPa91oHz14JIJ72i
	 9ibZP6q1ESmpT1rqHBVQ5jDQEXten0hY04Fx4Cgltzb5aMWMSOnjfnXHCoWcpjA9M/Tx/
	 qLgJKwJ5PkhVxm5+zXlE1nJr7YzP6k2qniTXANI7Z0uvijMlbWE0xINaRrlh+63crx2re
	 PseWLpRE/N2Fmof2BcZ9QJh80dWeI+L6VJgu6lRxKLC39E+JNlFlYhDisuQnzDGWtwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpZ7ykoS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jZySGB+T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011A606A684
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8011A606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpZ7ykoS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jZySGB+T
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68buQ3630235
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=; b=MpZ7ykoSA7/sjKor
	fhs3LtxAA4aCOH/GysYC2AxowpPRmlTm5zMFGhEF1UsE1+LDAJ4cPAaORCe8hTTj
	3jLRSUFAT8A0WYN4NrBTqGkq3XQdsAXSpb5NcWzWc+kkVB3FcyW4JHNsP/J26k88
	LwbhHlCylKB2n0njRhvHioNEN5TvPfxe9MsTy++GkI0PUXJaP2MnKrwzMedg23mS
	pniWcsd7+8+Ox0/sgvARTLo70rR/5gVoy3epBzj5Q4kEboPai8vuJC0kbBCQfUJK
	rQ7+fWYJmu3Xi3MPf0DRx2Du9gBCbRSe7H4PhkyABjiZny23Xpzxlyl2XFDlw2AP
	auk/tA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b803v62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a06750c74fso3909532b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 22:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795587956; x=1796192756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
        b=jZySGB+TmT/P0rELUQthBGfT0SDgiZlB3vTkpwgZui/DHvnXNuRZ/5KVAA6v1p8aBE
         jYizTgRM2sbrD1RszvY2U2mnq0S8hOfe2zM4koMzvXsyjjLP7U5EbRll6Xv6V0JjP1lh
         ktkrcrijoBuoIooIO41zYfUNy5iqc9uhYLGwBZhJKUqDpu0wNDd+beuhDF5Gj4ffciXL
         QgXCVm5ppZrJfgggpAHY3MXVoUyzWZE/G4ogCxeFxeYp6cANDSOrH5x27DD5ehfjR6Iu
         UKj6hxtBVx3iCFVGdW3HxacHngkhnoLK8ZXs4ndbvO2AWEguWYwmTbAPWbfA9l/m0BiC
         p/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587956; x=1796192756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
        b=VJSRkscZXFZcl5cWuhL1m4n+1yFRoKiHlCek57deA6RGP7ZWdmi2HJcE1y74z9WQGP
         Q7nxMHcifeFZX7oS2px5pFcHy4lXSMQPvVHmrL9RZFcA7uNv7pryy7csZUU2+hpzib5I
         24mzIWytvBbBE92p0zbO83HntrVrJ6hT1Fz5b/Fn9CkEMvRL0JdU0/epUER1muPJZOac
         FVl28EV0BWFOZJpl26kwJIkPA9GjOrwIJ9wwbyArAtxurXc8mDzzCyTwJBDXKSSLPLyH
         HMDnG8eNlsgATBB+CNuDz77/O0A20YQims8xKtmuC9Lp/+k31DOGb0aFtHuQMBSYJqcb
         LhXg==
X-Forwarded-Encrypted: i=1; AL+hErGUh+UCLiSoEv52oh0Rex12faD8tzxp9miHPCPg547uIf3NyTzKsMiud//TEuOCtiQUPmlQT3wB+Vs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L8ue8dmqqoyWa8P5lI+GQyDo6LDYlZm2+3R21wE3ZgO+BdgCu
	rdG2tzN1uTAqHXJH1eXCpspBK6k+Q5FD8cPS8LlRT7YXgSdSgNQ3dx9QuY3Nh3dNW7RwRA+65LE
	9DmFt+vUz4CJ1HMZQfUdI4xigfOYw3vQ/MmTkYpDdet0qhrMkQBnuCCcE+DZpowg=
X-Gm-Gg: AZFdTZdkDMU5BFHYIJLDeZ9pRTuw+PBtHgn+5lSsrarIksbAcEB91YNrgd0Y8NweyyD
	4DGpRX5xhU98BczEvkXFEtlMlvxZN3KorvO8fINxdgdj+eg/T7H/oD6voC5vIznfrAR8d6yKaZ7
	M5T/VavY00TI0NMAo1EQ57lEajv8SPIdb4WZLpT5vvyXbZB9ElecTaE4Xq6RCmdEfVzTMq9qupW
	O/H8Y1/v3J2P6qFlD5Gne2UgC26QBIHdWFI/8dyUkN0qTbUrzHHXeoz/0aINskBvG9TrabFuzIa
	FWZA2+ruyzlOeAJaHydn6/E4HfXn/bjH5AgPpJQFK+NMyR8C2iukK4f3gluo9JiQzjt8CrbxrQC
	fnRGIzigmEfN79LHiTtxF/fURBxZa8jVci0kBEErMOBtuPyElHCQfhrhxWMQcQdpzoyhrUN2GEt
	7W5CkM
X-Received: by 2002:a05:6a00:94f4:b0:89f:c441:580a with SMTP id d2e1a72fcca58-8c87ca522a0mr14601719b3a.36.1795587956364;
        Tue, 24 Nov 2026 22:25:56 -0800 (PST)
X-Received: by 2002:a05:6a00:94f4:b0:89f:c441:580a with SMTP id d2e1a72fcca58-8c87ca522a0mr14601682b3a.36.1795587955918;
        Tue, 24 Nov 2026 22:25:55 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm8385066b3a.2.2026.11.24.22.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:25:55 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:55:41 +0530
Subject: [PATCH v5 1/3] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
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
Message-Id: <20261125-hawi-maili-camss-v5-1-1483b7f68dce@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795587942; l=1476;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=BTDhy4Hj9RCXelLYOtQYezLS7KR1Rsj0YchhEiP5678=;
 b=JJ7++Y37/ybPg6xYkSO8GXSgnBGrAyv+rXXF2osM/rznJEoenCuk1M+2TlUaPQdogEIt3/ino
 hdkz2L+nvH6CnKCXfVEbGONlEbDBOzbv3PQo0TSb82cLrdMDuKHn3vP
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfX5qZhNJMYIyD4
 HYx1NLRuLLe70E7vE+JBPm/5ssIvI4indAHSUi/jWozZrefujWuk/6dYTuPahk7A5AUTN7XKU1V
 XoZLOJlSfyZ2BNVWxfgjHG4kKgsjl1ZpJbYY8/oLSZPOkqq6VLsnJ2ooEzZwffhvYPqswbvjmec
 kE+SUcuJdTqMmMhyCGG+g6vI7cXX3yf0kX+iHtH3Y4u79aMlsSqwOBb6PTOyqii42kiCYZeW+R/
 Hz9J8IXQY5guf7th4NGbuRkGOBIEsd2WyrozmaZB2yjPLOCbMUttvhwPnBM2VnDas0xXMc+SeOA
 WD7mv4HsiBZ1UbWPHpGmSym5bqA7wpRCyqJfpnF/MsDth9IxWcRiHk+RNPhCDvX6kXTQGguvEHc
 9dkqJy/vwz0q6bgnLFUIol/7srXH+gOF87Jzqx2VTKnVK4AVGvPLJhbuVo/AD/mcW7UTLJ2X/Jp
 Bp4+QoAhyU10qWMX3Jg==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b067f75 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LDBv8-xUAAAA:8 a=AartCDbB9JJyHY4DVtoA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-ORIG-GUID: uAkWmuMCRHVcFc6k3yfZ4tgFamOSFRYF
X-Proofpoint-GUID: uAkWmuMCRHVcFc6k3yfZ4tgFamOSFRYF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfX7l1IUGqC8K5z
 BmvIiS+9UYYSLneFvpVHDBwvm3Tngd2zDFYNcBeeHedD80kC0nQOPE2hE4rlUftl3mEIks9f1vP
 2dge8qCgBuJPhpCZzAw7L1Ffvz36LqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250025

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Document the Camera Control Interface (CCI) compatible for the Qualcomm
Hawi platform. Like other recent platforms it requires two clocks, so
add it to the corresponding clocks constraint as well.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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

