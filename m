Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037A4ED1B1
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889428; cv=none; b=jZ6h+l2XgsielU0KQ1PJ40Fw886gMaJelXAUHinNs/zZM40OYMk+RyvcLqLnRDGGVP5VSIeKPMK83kLWHBza/ox96JKLLqPEwzhzrPBK19cv0iG4SSLZhF8rsntehAWvKGR5CJ2+Rwy1LQcHwNTf4wa6ISLQnYmtvaLB2jF8X9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889428; c=relaxed/simple;
	bh=ZVrZiKjn5eoj1xYotO2X6Aa3N+e6mbg9W7+53FVPuhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sD8GkG2gz2ZF8aCqftfrsgNePqsQUirfKI894IsWi0/QJIFN9KC11vmJ0ik7Yk20TT42Kh0bS3qyAHUbqG1s7CU2FC2IVhfUY3Z+jMorUnMgD+yYW8js8HY6Mp5pLjSDaH49+s1STDU3YQKOKjGcQuQDIzB6NjRdEpZcvj4ASSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBRxdqZp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GpQyW6we; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBRxdqZp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GpQyW6we"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8HCnn3908182
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=; b=KBRxdqZpIOP+jZak
	PJ8j6u8IIEOOrsWJm+/e2XNFUaLMxBVuCs25XQHvqng6em0oNxnzvUS9HRZsqGzF
	r8GwJZzZzVtR687j8Xax/dGGISN2iQXnDcX6l81ISinSgHW/o2ACZlhN3c3BTbFz
	1Xg9nv+KdSq6b0lrcfG+2pfSlvdij1vuJvshhxPuD5AcMCphlwg8bybNquWnHPs4
	7jWOlVUfbxweQ+ObvbNO9B3H0keKqnVqQvV62OflG64Tv9igrmfmo51dkLdxS43f
	I+qjC8ZPN1DOflojiYMKi/7GhFWkt0VVBnaSKO0vh3Wo/+gYSxVbtpbNVpdCsOx9
	2mUm6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqu6k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aaee1fc104so3861914a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791889424; x=1792494224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=;
        b=GpQyW6wewASmc0nDZOnvL6vb6Us32TKA4LxA68qgNoC+FoAcsQM+ZJn/nBvaM/ItXS
         54mZ7bssCw6gN4XBpNb9AL+MnNndUh3cOPwn/AdGRcsJlryTZd+HJYY+jAEhdyu5CUFh
         lZGAb1+a9q2EApWhSq6+xq6uXBCFvb6bcZn7BSFwE9o+Fjxzj/1EcueXW5KU768K4JAY
         I6uoTbobk6M+1jaV+jdgiMknfVrNEHH46FoJKhYFgDA/8TS3WMz4lf/rlcWQjesElaNm
         wBjjBc04fEA+UneUEMTJFI4MpKGwbHDFvBphOArJDyfSAUir11162yFa8MZwxaq2rUnM
         ug2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889424; x=1792494224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQyf6jcICM4FKao0weCOIsWtu0ZxaxxkK22IBq2EtCc=;
        b=KRhia3wYEoqlCNOcDmqfjMpIbzQ6Q5e3HwLP0wyXBE4n570V29/2O0hY3eb1W53NZj
         RvNVal2YbDyImNE/oSOI3Qn7wf5yIt687r2tY2f7NV02Tve4jxPrw+0LTqIx7cx9z/zI
         tpvtvvAihDl77KQ6/5Ubd7KFpPytJaAyNLKQ3Q8iy2ncSR+6nzWnhHkgkU5ffQYetwg7
         bxdP8cYZLYsfIzlFSgIjy+6MKUf7a8SGqjPm84ndX+5M7qQvQM1nUxkFLjhWCKc0lobF
         +NJv2mU6EbJxV/UQWKOK27xjBHQTpknc6cNgxpyoNuJyxmSx8iToK/Q4OkixCRSwemSX
         iG+g==
X-Forwarded-Encrypted: i=1; AKwUvBzd1+XChqoHfSs3ZEios9klIVXQyFrNGfYl6d3oB5dETbJSBIeFff2NDR4t0Vcwq420Cp82mSS4jfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSCvbW+zqgyVC4nHbXrYEjPwqkZOaxmRHokxO+hU7eYBp1omhb
	16H7NaxB3Vki0eusgjsqV2bFS5abahkciXchFGPBGwRIiLEUydXGu+7ZtUG9vrjdBV+qPi5hXt4
	1YIr1n5apEr/W6Ym+kY3itNNg+a9oJ2dBcw0PvOLk1YZmJ5A77g2BGY8WpOVaAYTvSa9yFZk=
X-Gm-Gg: AYBFou3pBbCmEbirTms6tnk6f69SjUO2d3nHjjkjEmyyi8StewlZiHhuWNu2a6V6Bzs
	me4DrwGb+0dfheB83guCGLUpKXa9kMmiYbRmJ0walZaHK0T9PNXuCukpd/3ebfpJdbO6LCX7kC0
	C0C0Sbt3+uLLNR91w0APNuiMt6zQKQII1mFjVp2YW7WfJdRuAlm/l+FKCx1GsbxQZ3wqKoNXfWZ
	0MuBa9dIo9w+JaqRYWGjrcD6gFMBynkUkOzA0vTWubV3FgKCfKqmfxyCfOTEf0HeorXHw105Grk
	K5lBmc3EriO8bj06tqwmBvkThGM2panliZcGh6j749+ErpU9YbMOaEa9c7l9yfOJct8DXG3VAz5
	hM8SwVECKd0VDZmdqg4DsFZ8hMtJLYBU=
X-Received: by 2002:a17:90b:3d92:b0:3a8:5cab:ff5 with SMTP id 98e67ed59e1d1-3ab3ab1fa22mr11534530a91.43.1791889423678;
        Tue, 13 Oct 2026 04:03:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3d92:b0:3a8:5cab:ff5 with SMTP id 98e67ed59e1d1-3ab3ab1fa22mr11534479a91.43.1791889423107;
        Tue, 13 Oct 2026 04:03:43 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm20808403a91.8.2026.10.13.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:03:42 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:32:46 +0530
Subject: [PATCH v2 4/8] dt-bindings: media: Add CAMSS device for Maili
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hawi-maili-camss-v2-4-fc93222da89c@oss.qualcomm.com>
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
In-Reply-To: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791889386; l=1384;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=ZVrZiKjn5eoj1xYotO2X6Aa3N+e6mbg9W7+53FVPuhY=;
 b=yjDWXo1cCMQNtBqrKN0bhNiXuURBQDjxrGWVNAyZ5bK8TfCfdbmbEf6tewJY2xyxX6oeHjCqj
 DSR6hpboLLRByu31a54l8wXXC0SQFO/VAiyVILZR76QxGGEfkG6TRpS
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX7IcaIKAIhLcW
 etZmN9YkpqXuo2fPnRvUyabN3x4NtKqOn6DRt+OznIWp0dDDdTBkypzFFRDSwvB6cZOzNoCYxCF
 4H6TBK1u7eUi+3jGZWhYJ+okxqm7K5I8gHxCn7bJOXcZ6mVolDVzAq3n0sXUdR/NmCyVjNfrS/X
 UpQe9ef1qlpOxTHSU6OP1XN6nFAVxblb3W/h93QVBwlUOcoBLlOzhTrYv/vP2ihrHI8ksYESp15
 x8adjG2Q9OyThXctNBBtyKK2heDoeqYPE/YZ1flOD9lywOXY/PTTGl0dF/6FBGstSZKytE/k1PB
 eFdNn4d8gJ6qnvnnolGlVXjsFvBZrQD6cZuQUuKq53eGs44URvkqMIvOtwWX6GO0NsMoKFIA564
 dgCriVSf8Bg4NAhhNbrrEAmdtVg1LdPKeqpFqXHSnn7NsxOaGBCJWWApKwWCS9bOcaQn/gccSIk
 KavciSIUj3Nhh8OHdeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX4W57aCt/W4QU
 gyh2nQTI8FN5le8FysjfPB2Cbf3rG53KSLatPrA7YLqQOJtl9VdwD4kUZ5GdckCI7xn29Pv9lUL
 eBM8E8HDjXHuSwI1cGODnFc228rUg0w=
X-Proofpoint-ORIG-GUID: vv0J056gmiwLpPUqUxwws3rxyYdo34Cn
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace1010 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=lEnWAUz5esA3NO-HxloA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: vv0J056gmiwLpPUqUxwws3rxyYdo34Cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130043

Maili shares the same IP as Hawi. The only difference is
Hawi has six CSIPHY while Maili has five.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
index 5bf0dca3d24621bfc4a09feb8e5037a925869751..d1d53d6f024cbf7d2a0f2525aa4040260353b200 100644
--- a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
@@ -4,17 +4,22 @@
 $id: http://devicetree.org/schemas/media/qcom,hawi-camss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Hawi Camera Subsystem (CAMSS)
+title: Qualcomm Hawi and Maili Camera Subsystem (CAMSS)
 
 maintainers:
   - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
+  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
 
 description:
   The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
 
 properties:
   compatible:
-    const: qcom,hawi-camss
+    oneOf:
+      - const: qcom,hawi-camss
+      - items:
+          - const: qcom,maili-camss
+          - const: qcom,hawi-camss
 
   reg:
     maxItems: 13

-- 
2.34.1

