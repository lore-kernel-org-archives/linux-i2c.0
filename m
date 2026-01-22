Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397E40FDB4
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078484; cv=none; b=C/xl9fuNU6XQwv+Q9qfgGEoX6EBzKNN8eiWlh1lR8z/o3v28R8Q5edTXwpI9+PAaNACKN9g5BSA2buKnqHI59B15IlJtXB1hinbf5OKz2afO8TjR2oeSvfGaONaXjhxJG1dMlrhC95JTp11cQCSZS+n2mUxKfdaGwm/v+5jn7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078484; c=relaxed/simple;
	bh=05p3WSQeINtZKVSYvGmsEKNVBC0B9Jn9M3IpPDE6QNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJ8Tg/Q7WBSV0ifFi+lvv8BpplSpXSCDqes2J8PaPsS8HBfltEg8WIrkR12kuFz6YPiE+2REkmbb5T0weAdQ0I4UeMLOSB7XGmzspNoiJSz2F+EydzCqnjqtMbBZYdH8wmaU3tmeJh8aQqCfGAWor43rmCZyIKvN9GUfR9ybVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nh1XT9t7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zkv7AnYv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nh1XT9t7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zkv7AnYv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7Ol82788779
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KwC9/5DR/xlDmwacOOm4dJ0IPWsgd23ip9EROve8gMY=; b=nh1XT9t75VOthVRX
	HMtTxcv8+fy7GpWb5N7uCpSHEyd1Y/aSEqbNLDJSjAqoXDAn2YgViv+zHUfyfxsH
	qemzZ4c9sJjaGYMdZRKy3RuT00v+irO9T31lICxXr+F4xjWibNhqwlQK2xzAaevB
	r8o+rR//5jG4v92nwiMj3vKXnqYlFFvfEOVjn9Q6NxIv/nCpNf7n5Y+zuzb8Slsz
	p48GytUmOoWEYg9Rqbuz6CS9R+rRTFrKdvvk9utR5YOrofAcyrwatKkD0g3RV3LY
	rDMRuCxCpLRnLczuFuLa9y45978+/NDVZg9UemE8QuAFn9TPDUCXJcuUBjATYYbl
	EzkSdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6p1j3uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a341ac9fso223579485a.3
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078479; x=1769683279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwC9/5DR/xlDmwacOOm4dJ0IPWsgd23ip9EROve8gMY=;
        b=Zkv7AnYvYAXZKAIei6Xib3pZ5oE2rTp7l4OyX9/VEfHEE7FmZ9M+5gRnusBCGqlaJz
         58etqA820AjxRsYZ/i1OmiuhAwBpXRiBnVL7LhItK/THxRWi9VlmOoXqigYzGIMtx7/j
         EN8HWLiHjeRQjF6u146/k9ziZW+2CaK4TuYVpmUl8DrESjTrIPBu94EULqmAlAfOEAzV
         t739H+ImGE/JTaZQAj+d4/bzsRMry7OgiFDIJQ8pX96CCmQkjW1SRiLZdDzmZcdeOqqF
         xjS54k/Pci9n4GIklgLhb/oOwSxdiDS38Kob1DijaQrtTLZu9SVNNpo6KOpG79VHvAad
         uCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078479; x=1769683279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KwC9/5DR/xlDmwacOOm4dJ0IPWsgd23ip9EROve8gMY=;
        b=B1gEqwzg3ky/zIHItY1p1QCk5WkDUhfnnpfiigBNPr+RXAN0Q3tLnW68Gi09W50z4Z
         voaz6JD/ptIn5jE8CuaeMqEq+d7/TpnS+3TNLcd7B1Hqgyj5BWOgQNQhhBpKtGlHyUpY
         VujXQVkTQm4CmnL3mtGr6/q9rwEfnAvPaQoNlFdrOfM0jr6SZs8sxrPEmrcytM6YevOu
         skqUjO9K/55Heh3Tj9J3gFe+bdlKF0hf//JqIDK/CGPDnDyJ1R15OTnGVywrEYZNGMAA
         DPu64BACA0KQVzC0vn+yvgV1jfS8Al9nxKOyJtZFxnWA+YzxYSs2mZ1Cf4ur4Rk/9Sap
         RwJA==
X-Gm-Message-State: AOJu0YyyMa6jgBCwKFe+0WikNKCw8e5NAKbDi/GNQvgZusQjLKuomsia
	b92b9DVYcKpHJRj/tc4aHvx2JccPNjcsiKIvtkxbupS+xL00FfDb1YFaG3vlMQmyTXC1kY/cfK3
	2HO+Vjkgtrm78PpQVMm0PxEIRmE4FlgimapJhKfH4bEhR98tfBKIPklYnrUsws34=
X-Gm-Gg: AZuq6aIyECCA/POUH/UWIChotvWNVipC7nPZoCAap0qUaJmyO8v/Q9Lgb2ZZj22Ttck
	yFyGFPuKDqb6Nt5sz5kOtosLXUWUx8o5Qhv7u7Vt1Jf14ubSy9ePK91S9rkVwfvVZTmS1iDiAND
	yeT0qzB0/eWGNsBy6q81/Nbb+4lC0MgYAgSBKvvrKOeaLq+C1rOHsithljRA/ujUGzqBWTU7Snb
	XvdLdI5MshePrg8BOR/NFxsS6qerVYN9znsWkt0nItWtVv46kbFbltExbo57rXK0MWivDikGTIY
	JOyw4/FFhhucNjz94BpTHeyHiak00HfXEP8Vuo87kwv4c4Btor1wwqo3shQCm50DqTBwKCLp0oG
	TQd1roSYcko8FLs/fj+M2IoS2h7KmdeCU/4yiQT7061JexONY7v93HZT2HLJoe0B6rExyA95JJu
	28
X-Received: by 2002:a05:620a:19a3:b0:8b2:77aa:73c8 with SMTP id af79cd13be357-8c6ccd9b1b2mr1001003885a.16.1769078479445;
        Thu, 22 Jan 2026 02:41:19 -0800 (PST)
X-Received: by 2002:a05:620a:19a3:b0:8b2:77aa:73c8 with SMTP id af79cd13be357-8c6ccd9b1b2mr1001001485a.16.1769078478975;
        Thu, 22 Jan 2026 02:41:18 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7260229sm1387868685a.42.2026.01.22.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:41:18 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:40:47 +0800
Subject: [PATCH v4 2/5] dt-bindings: i2c: qcom-cci: Document sm6150
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v4-2-a908d49892e7@oss.qualcomm.com>
References: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078453; l=1338;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=05p3WSQeINtZKVSYvGmsEKNVBC0B9Jn9M3IpPDE6QNA=;
 b=rD2dN5adAIxAGRJ8S8E2CUYLxHGTa+3f/kXvrE4lm6mRaajo/bEdkmlR06eYX6tVWEgBumgqK
 LPdNEc+/gziA0P09lKs9ONVb95cxLTNqqoMB5/nwLd9f5NiVaVkzyhj
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: wQUoEfdCAl8v2_U-rkJ3XQou8S5d-7oD
X-Authority-Analysis: v=2.4 cv=N7ck1m9B c=1 sm=1 tr=0 ts=6971fed0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=E-b4n2RehmlEprTZI_0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wQUoEfdCAl8v2_U-rkJ3XQou8S5d-7oD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NiBTYWx0ZWRfX+A4t02jRdiP4
 2uTTfIFZSaKOB5O3dp+6HTm9Hbp8nYCCiDwWUrNBQYgwY4GQtuiPY0g2io468XtcD50EFNz4I7G
 gjQ8+qQJkk6f6etbdugM/rGoIAmnemhGMrkfp9904oLr1kFwLVV5aktmYOuAot2F8LvyTd6deRP
 qA/1puPbVdcJFsIC/rSmxXK9eU6cs3MnGiuBjXLfGzbrXfv0Pr6mGpgfEMp3qRf0Hkqef8DCE7Q
 EFw0c5fcxPmbW0Wng+EpnzFl5mPMGNBphE6CDAQMzHBjbJFyFHqq0TUZaTixjRPgrri5hk9QHP3
 HRU3FIHVQgU9hy18dMk2FOZRJzMAGMWG9/d76lhCqAKCrDKTHgOS9TYEeR9PWXqiH39g4fN+MdV
 mpRegWAf8eVeQAgNrgNoaJwIEBZf7Ocah90npswPBgODCw03NcvZiCrkEJSPrvBkTUFtzr/Zcyy
 rpaSizjl9MHdYwWhvBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220076

Add the sm6150 CCI device string compatible.

SM6150 include three clock:
bus: Bus clock responsible for data transfer.
iface: Interface clock responsible for register read and write.
cci: Clock for CCI core operations.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index a3fe1eea6aece9685674feaa5ec53765c1ce23d8..d3f87da54fcc14a8f808f34c94551583d8deaabc 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sc8280xp-cci
               - qcom,sdm670-cci
               - qcom,sdm845-cci
+              - qcom,sm6150-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
               - qcom,sm8450-cci
@@ -249,6 +250,7 @@ allOf:
           contains:
             enum:
               - qcom,sa8775p-cci
+              - qcom,sm6150-cci
               - qcom,sm8550-cci
               - qcom,sm8650-cci
               - qcom,x1e80100-cci

-- 
2.34.1

