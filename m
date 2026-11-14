Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655858;
	b=124d9pPY5rW+aRlL14G4wCr7R7sZa1KNr80bmqsxfpKLSDlXdPUB6FESa9QqAtXYFhWh
	 55+L/yu82jv7uN4mh6pwMAf/S9rhgHr7vBgmYwfCUAlmtEkpmDAlPyZe03vu+KXkFBRbH
	 8kwScCcIHGjQnYQDznFB7fc0dyMGsDKWTJdDrAnmyp7Vp3E+j1IuIQhS20xBzmWM+ows1
	 dfJT5xQ5WXrGRvecuwkYzpRi2BJH96yFjsnIgF+i+K3CjY+0OqcAkYQh3FRIVvOCFwa6J
	 WMXYFFyawI3X3S7atYL7inY7t1YZ/BNDfkHJEjVel6Z6kVHyXwZmdIcjT+Mc7azSt4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655858;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HvpnDcakWRnW3PYccxcSi7pSHHqf2SzUoRHYqMjmiUg=;
	b=uOOh1ZxZUU/68T4cY5UII/Kdsvdo458S1ElcGvbZXwkDpx+yp7IYs8t+Wsjc4lGv+I0F
	 Yyd8hx9aOQ/lQ/d5ROjvmzQergtk9P/hOoX3XkJ0aqe7q5kyBHOVmsWIEcz6PXPJ9Lx0k
	 zFfubbBueYp0PTJsvbauzOPM/MfUiQsjlrl9LdE/+NpMfgjWikE596g7LCqUFwQjcKUB/
	 2BvfQzkhhGewXOtQ6xG7fXxXpHke85ZlL4IzWi2crRDLv61Z5tv5cWzVy8WyQtm39V/lh
	 HJeIYg4nY9jzH9EuDD0b924KaiUeJT/SpFM8GKD4OamiA3WzhjCXWTI2hR0C9RVVQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=is+jw5w3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zo0tqJdW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FC606A339
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 063FC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=is+jw5w3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zo0tqJdW
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9w9f01750090
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HvpnDcakWRnW3PYccxcSi7pSHHqf2SzUoRHYqMjmiUg=; b=is+jw5w3FuItCwi6
	PB5nilGPbRX9RDS19eIHfUTmWjeWwtOiuzsjtMtiBzUhXYsXu0f6J9Gx5ufxZXca
	vRHBOCOydbv/BzFG1eo5U0cTLQsseAqR4CqZmJx7mkF39EYa60Yyq6bfKmWzNufl
	StTglC2ubE12WZDs3K7UGE7ahs6LhTygH7/ADGtZqe3rBfGXAzMCXP5VcWpO0Sev
	/z7b7aKFoTa/qysPoj5dyhOY7RKa+zBixU74Xfol2R4J0yZiEkbtlqUI3qjKnDpo
	fA1zU6JgKDwa59vbUE/slA0+7RslM6LNNQeV984stOJvpXWQ4zC0U4FFlRKRcdaZ
	+Ws2kA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj40mx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91e9a0eae11so28265996d6.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655856; x=1795260656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvpnDcakWRnW3PYccxcSi7pSHHqf2SzUoRHYqMjmiUg=;
        b=Zo0tqJdWroERepjzwpX0jDTKyvivB88pDMMdsw8Z/sR230mLN3XUHdefHLUo1pgHkV
         DPPgPsGysGhdyeTwUnpJgQUBp6Na2Sf89D1ks8y7g398828EqrmOzeuOzxQR6Iu/nleO
         pVFU/UHq40/6UHMyhE5DeFifBfvKGF0wqQ47/OYqPb79vAm/VUM9pOSbu3NwL9yhZrmo
         I9uJv+MCgxU7FYGL+5/lKfQcVO15iMeoQIbtKGM1AaKU32fCQ/4VbmvNOYWYoJvcRjjW
         w86V23gFf5jcYB/f/1tePgJQTF9qXLpcqFCoyQmTcDIUGL7JpXhkqNwJuMx1A5AjJ+a9
         aKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655856; x=1795260656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvpnDcakWRnW3PYccxcSi7pSHHqf2SzUoRHYqMjmiUg=;
        b=CrZ9mcQwl6gs8L2iz8UBrGwIJoKOk8FDkKMLs44Wwsk/GD9xOxGzxRq0RNWe9/eRwG
         CipSBvOjy9B5t/jEdZrQ8fAIIIjHnt4EicszV8ZwpuE6Izqwq6xrXrkI53aoYE3WTcTx
         nnXQOOsUya1K65QpxMA9F1h6vzeRvew25SlEbPKrQuDMq7zetCFlQ829ZxGZVoZWpgR6
         CN59ToSJ8wFjhm35zc9Nk7DqPnM8b/WpIpeqDiXe3HQKmrDGXCDO9pDdlG0zO/1o4Y3c
         7TKzqIVmhN8NHvmjDRLhgRl4mTDxq40GOw0x8aXtmM2Tzsz+2Y5h1K6+5n7aDM7dlQ/X
         xcfw==
X-Forwarded-Encrypted: i=1; AL+hErHBPZhx5NdNyqxk33MncsoOF2XjCJiywGe5NxlvRem5ju7VItFaeDV+o3/mSLvgabe1Ws3UpaJ3MVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C4nPVS/kFpYJbXR72tsVAx3/aYSHw+ptAeiICLsW5H87wmjEI
	etEkzJVFrvqpaHgpvxYC5+FMxnsc8l4Rn2FakVpkQBYbflBBdteDezw5mfFxECtPTplWVz1wXAx
	MD2WSYgHXp3eDvlHJSeLr+AVIzDezqmi7gSp3VVlD7LLRY6e7xVPvxTKlyx7dcwg=
X-Gm-Gg: AYBFou3DBo6uAS2F4sco2yVJPuDXsRj6BFkVMtvJIXdKBbM1do9bZq3d6YokPcXBl9K
	jJfdwyiiDr/XfvzSwWCzXmMW+cY9tyrPqv1FMyz69/y9TMv1ZMcc3+JUa7BXXsPkipBmUzkXySv
	WmFAMz0LEjXjifd9OsMhedSsol9c6hZRZhC9B7B2qe7LLAvqfHbEt2TAIAdBn4D3+D52MWT3P+Z
	ZsnPYTdxKKIMWjoHYkaVxHCimGhMFlVtQzRMCXGZwCoP6KNR5HXFWmbZc0EW2TK766Ngu9fdRew
	Ib4bz9DYvO0aDDUgKsI172T10U/o05X0zgVP761fY/7xupFIt+75deXALjP4K/b3LIxAG9aoAfB
	AXoT2Nebf6vh4XLio0CwJzwubCgrPBYAXHb1gHKDeP9HO5qCIQq0G3QfjIFBK+WTWRsPW3GWm1J
	v5p/MhCCoD7dpyMqOH5jrr4MBsN0Wq1F2ldJAV5AjJ
X-Received: by 2002:a05:6214:c64:b0:91e:7abb:a927 with SMTP id 6a1803df08f44-91f241c65c9mr86645576d6.21.1794655856215;
        Sat, 14 Nov 2026 03:30:56 -0800 (PST)
X-Received: by 2002:a05:6214:c64:b0:91e:7abb:a927 with SMTP id 6a1803df08f44-91f241c65c9mr86645216d6.21.1794655855778;
        Sat, 14 Nov 2026 03:30:55 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:53 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:25 +0800
Subject: [PATCH v7 08/23] media: qcom: camss: Add PM clock definitions for
 SM8750
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-8-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=1035;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=aRxMrdDtYyY97/huckpcHrUdtu8c4K3ZC3GA/RWZCDs=;
 b=vWhSMHcARnVI0vXB2VQvgOzisoN8ZRFT+BwfFUA3Ajfs/RhNvQmm+8FhnwOhPEPYq3FPs84El
 /6E37tDjOSZAaqDqFh+2KI8ArW+N1uCOjbs6QglI38hhbVXTFl71AJs
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX2yhE9Z0lULsy
 RJuS96EmLr1XWchCoU6tuRX1XeERZisdEgeOdWi1gn/cUWTSnk27swCx0J6Le5lZ9Ek46dRE0jo
 f7MWNt6ukwRDN5KDYSyPg/VW6T9dqzZbMKt1a+9pfuPJaCPbhgUf9tZpLMkfPU+Fi4RPm9Ix8AN
 pmo+Nc9Ig5VtzuMXS1n+biP+/PH/Hx8LFXP5gV7FvfAkxN5Y8+QMDcE8VZlwHsJClkkbAdQcFNm
 tbMwpPCVtXZXxMfVUpatMZcTzMH9Z2kgb87SOIzz5sQAQUR97V8pl3GTwvE+2DsgvTZ/867tiFV
 1Lg/hpy8Y3eRj6T1IxSXOATYNU5s4ay2VJsiTx/17bBiCHw3T5pZ0dCGxL3s0zJcPi3Y6faPORQ
 +Sqb15PPy5p7k9x9bVxz48y3G66lSKtSGUIwHaF3uXFXIVfTWvutEKf09Z42Gef+toLLTB8wLiy
 UjJbvi8SWWyYoF4FwlQ==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af84670 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MfOgH6a12QNS3LiSQs8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: d9NGE_1HAWCJTor4iURPM4NWHsEnKFES
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX9gKkL2+WjimL
 wbL5HEy1bXWsvXjduhjpqHyFEZVgBlDPucgaeDz7ViiBY3ZANMnChRW8VduEm98rIiQfMxsUiyf
 ifQ6DuP6AbqRxX/AN1E94Le6E+iIYlg=
X-Proofpoint-ORIG-GUID: d9NGE_1HAWCJTor4iURPM4NWHsEnKFES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add cpas_fast_ahb, cpas_ahb and gcc_axi_hf to the PM clock list for
SM8750. The CAMSS core enables them through the shared PM clock helper
when the device is probed.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 3f9dd3a2ec088fa87a9ea90d25c906d14b9a1896..196eebc2d7d118040319bcf967b91c4ca98a4833 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -6043,6 +6043,7 @@ static const struct camss_resources sm8650_resources = {
 static const struct camss_resources sm8750_resources = {
 	.version = CAMSS_8750,
 	.pd_name = "top",
+	.pm_clks = { "cpas_fast_ahb", "cpas_ahb", "gcc_axi_hf" },
 	.icc_res = icc_res_sm8750,
 	.icc_path_num = ARRAY_SIZE(icc_res_sm8750),
 	.csiphy_num = 6,

-- 
2.34.1

