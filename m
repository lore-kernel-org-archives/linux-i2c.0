Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F83D955B
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418248; cv=none; b=oJYk5f9ws6puAEdJoB5FeTmQ+DFFoqGjxwZDQfvXGImI2qbRRSXdmn/3EqVw4Ly6wSqJIBaL2pw5zA5z5MNIqTBb1z7Fv9mg0sBsC/u/x+K0jsmnjeANphwdHP43x0BXV4In2g+2yG4s1tsYTkfEdaz8vryLQgYta8k+KDOCifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418248; c=relaxed/simple;
	bh=NWAiJr0rfz/CSlJBzoM7GvuQ0Xss6HkxQc9ZecRc2yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cceVONwvLCSslWIV8PSCTxBX5DmlHuDnaqo1m+4udulWtnazWh4D3d3vBkhSj4uirKhc3xXo0ol/ZWAYV2Lyl6wYNt9niUn8bSmCch+YvaYQ2dK1JxlWvLG0Hp2x6DO6LP5SF60ff/9l+1c7nzIyEZTuNH/2B/xF7UM80I7JXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZusxU2y4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gkrJcjid; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZusxU2y4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gkrJcjid"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678DnQV3205866
	for <linux-i2c@vger.kernel.org>; Tue, 7 Jul 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fGlgyW9VIAd1BpCUXidFVG55zNfYKYnlnAq
	51lL5tyg=; b=ZusxU2y4upi5qPMiq+wS0e63gEuc7Z0Cq2LreO9MAP+x55LvO8p
	+RO4H2zrBd0JjNSkKLpKol88MIvJOeuoReZHrj2p3MwDWjdUqLg7IhdcSuvhXnYI
	60af1Doa+NQQi0J94h7RbvdgbH6BdVa9afFzPlicOLgikJuaEygqXc9ihOqt3+sL
	78bwOAU8swYdKWkHkbFsFzOnd8xNybocn9jPNBeDzFnV+9C5UuWHtCL2+gjqf/ig
	02uPW2CvX9Qd0gSvvD+ggtcHuKl+3/dgFyeh2VOMaEozWgA7T5Vxp5Wogp1+K6G9
	CV31klI+VEWe6k4orYrRiN/IFaKKlCEOGCg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw3rc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 09:57:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38827cee19eso466298a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783418245; x=1784023045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGlgyW9VIAd1BpCUXidFVG55zNfYKYnlnAq51lL5tyg=;
        b=gkrJcjidUk1oQ6gATum20SyPqu+y173LhVHclG37MrDSZjjY4mLFGZyETR0qPmvqP4
         p9eiga9dXGsVTK83h5wQgiXLJtHXrztX2yrNSCdp2deaox0cnPRWyTrC8ayZBd5KgIHp
         W3eZxgVdYl2f+h41ziFetxReA75S+QKRhmt+ugsL1HIXOI8OIdQwXv58kkr0ozkQlZ8i
         n/8LkqjxIlEpOlypxPmZam+f16Jy/S2w+vNVMcmG4rBinpF2n1KwdJJKUvD2TjBJHvbV
         VSMYhZmpTSMaDVuVXykPlY4ybR8qPRuyNko6EKiuyucnQfLJpXVcLKYPdfQZ3Hnf3Crn
         0oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418245; x=1784023045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGlgyW9VIAd1BpCUXidFVG55zNfYKYnlnAq51lL5tyg=;
        b=jUZOXNWTdtSKBEVzdaSL2pHGSJS2HFfbK20LeX3mh4pq260ZYz4jbNOfuYxqM7aeP0
         PJkRFwPFhx/LXsznqxLOE+9P5b49YtQqgLR2aOo0/pkt392Gih/77VFXXxvw1IP5b+SO
         yHfzCi8kMAGPkTs15dWBPcJddGtrv00U2Ow4kXkxFJARRremTPFQDFHwOLZeN9lcDsLt
         tmO52PgIZHb3S3vbBWPiM5MHKYl5Y1IwKeEnQ3641Pr+52CBt0Hg/1xZNe1qKmjWlL85
         eb3fE7au+SkCva93tA1+rYdOr0l46EnnCpabUTI7wGEQp3VsTNG4nnqgYgWxeeYyrMS6
         FjnA==
X-Forwarded-Encrypted: i=1; AHgh+RqiJxcPaZQgaKPiBx17pRTJC3t4u6cOyC+qgt/hYdOjPdPn+ITOdZBlBQqjBBj6m5OKJ8ntGq+rHCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSOIidKm6NVMPM5TBhOvEqGEIwNQaPp2wMooR8w/T4LXdm4fi
	Y4VYv5V7fMcLmZyQMNGcsvJkQAHSOdDCl8U7Wg1BJmT1GyddfFAZ5iwQ1+7XdDHbf1F6Dx0LGMF
	7f54q0SlapqeLpTDOgMSAuJyxBxA+DlJAjYFWPPfjvEkHYHUJw74Nu52tidGRWTA=
X-Gm-Gg: AfdE7cmgnfu+j7pXfWUPsdT5OcK9vkIGBtgSL5Xu9pg6yrbQex8BMUdGTmUmwJWz5vw
	lu5Wve1bZoK9dQ/L76oz+j/wk0q3rV3r+PnsvrZpmCPUKo/yWlNy7sFGQwhRkLmCXQBdDGeZvAn
	c8QuDplc8Pvu6PRVT5o5crVqk/c70qs2oidu/qXgXg5sLhYC/45dxzIPVi+z3dGUPpZchb9NXPx
	n/bqGU3mKytV/EbP+8XXos5vSpGn1x1EZgKMvRDQk/07a272cSVFL01tgw59FkRr3PKokvItdb2
	e0zVi2mviKwUFCbAcvkDXpFGwFv1DzyNSzigwhYS6dWyB1FBTbrBosyjB2/Zyda9BTB/lYon6M8
	6wjo94lzWj5wUrZnfl9ywxPHgW68jvgZYEkiRl3gVgt8eqWXtf3DOjrxgmHRbQc3IpwYp5lk=
X-Received: by 2002:a17:90b:2805:b0:387:e0cb:c8df with SMTP id 98e67ed59e1d1-387e0cbcac7mr2011578a91.40.1783418245309;
        Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2805:b0:387:e0cb:c8df with SMTP id 98e67ed59e1d1-387e0cbcac7mr2011550a91.40.1783418244867;
        Tue, 07 Jul 2026 02:57:24 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387a83f99e4sm574350a91.1.2026.07.07.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:57:24 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: i2c: qcom,sa8255p-geni-i2c: Add compatible for Nord SA8797P
Date: Tue,  7 Jul 2026 17:57:08 +0800
Message-ID: <20260707095708.3801043-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX30+CpnOrswPb
 k8uknRzYejOhXTx+sJKcHWwqB9/tVdbIjQ0Bm/ZTzD2DMFarmTqYkG8eBOGuj61J31dDxWs1ODP
 XNAfRq2b7khmdvhnpfqAZF8jhEd1wRE=
X-Proofpoint-ORIG-GUID: 97s1kvQ_f1x0g5Vm3E0eKC_aNay4ZuhJ
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4ccd85 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=dHqo4WMNoFrl8pwT4n0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX36vD9yFLj15k
 yekzkKlxfiJ8XQu15K/azCCCz5RUYg1p8aC/nQWbKsQBcEbACfR6Yp3k7XeVen3t1Mpvd9xQk0f
 M/qvI7ZcHQoQXot+1H08nrnJk1IEDtAsetqn7dK6r7Du07n/MpFieBOFpe/2Ipr6BJ8r6SaNLtl
 O1QFUq9s7hmDfXiKlrJTq6r78/Kr/cduMcq/fVwQV2P/kIs9U1jNoia6fiQNflmZ73WOk/I7VxV
 UpSOgZXA4RqCYMNAWYXkLCWwKYgnbhZYHvzx6n0wsSgSrtlZRHc90zESRqexZsXE/84u2wAPAag
 R2pY5ZJqmE2pSlBMfj/sKiLBmgtMFABsVzI116oSKQ9yUAZvr3AF4xvvTwf9rkd7iQd+O+smxjH
 DIoY2Wj+fbJX3TG6D73+QXdkx4o+FfEkDRfsLcIl85KBfgExeV/p72U8oLGSKhDL9QQVtu72FSg
 HMxQfXuZVFgNshCOtWA==
X-Proofpoint-GUID: 97s1kvQ_f1x0g5Vm3E0eKC_aNay4ZuhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070095

Add compatible for Nord SA8797P QUP GENI I2C controller, which is
compatible with SA8255P controller.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 .../devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
index a61e40b5cbc1..04caf622b3ba 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
@@ -11,7 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,sa8255p-geni-i2c
+    oneOf:
+      - const: qcom,sa8255p-geni-i2c
+      - items:
+          - const: qcom,sa8797p-geni-i2c
+          - const: qcom,sa8255p-geni-i2c
 
   reg:
     maxItems: 1
-- 
2.43.0

