Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE413C0623
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740287; cv=none; b=O/GgH11zShnbAWHdiIp0dox9hOj72HFmv0J/0GAljvFy55oXfsgJQtb8pxVIN4iiKhR1PLUzEbdzLcYBStaLSN/oDcioPtM6nN7U8DDIb0Hzw8jquwhOc1GAMEL/WGIS9NtXMnUvY+JGwbxfxfR2QSTBPznSiV6PBgotWDU4wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740287; c=relaxed/simple;
	bh=2OYBYuITn3psg6Z1HtkzObrYTcYJqG6jhXiaM9WxoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2RL3bgUdK35RXc4BH7D50KKHYfld5drqNvr4xHC82ZEK1dMpbuEreQpcAQ+Mcm9svHn733DEsJcL2Z/xW6lWTA2rt8AK5fSYAhETlSICV20uTKHnBmQ6uRm5bkXOQOgvPBJqFgVy547OwvzYEXjg146XECKjR1oRDHX1iIchVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VOt/TWOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ARptbYhB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOt/TWOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ARptbYhB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAH1fP518137
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 10:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1G5/5gYVXEXCPKHHHcZdLaqGYg9k7UTUSZA
	0KKz4mo0=; b=VOt/TWOfyobZ56aTJLApPpTPwkJ5qjPBQRsCRDuCZDx7SgsXdc7
	/ke8ZTUPJ/xdv0cYF9Jhw3zrwbT1k3Nz+RlhI0wVG7TRDyWWMqtCCuohJw20+iCW
	z77kJtx0TYXtNpiahz3HX1LWu50czvXggxwla6eRkSEfmXJ74tI30hYg+BgQoIF/
	wvVluIQsUxmeKQBjsEax7iC/H3sutYNFhLM2n0IyLvDoVdmojYdLYhR47mEOmd+D
	j+Uq1FGvG78S9Mc2MtD4VQsShb09aoumshlWuh1ftP2Yc90d0wzCYugIuYUQ25G8
	tu+1Qukht53SuhoLRLSeXq7KmHKpiTwrIXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n03g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 10:31:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso11031081cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787740283; x=1788345083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1G5/5gYVXEXCPKHHHcZdLaqGYg9k7UTUSZA0KKz4mo0=;
        b=ARptbYhBiZU7B7PnEXPplm1poMqw3a7UlsPdDN6rmjEg1hagSEz30niXP2P1Wu1wpi
         mZTn9XldiHb0l4JTkRwHSrP8iVTmjUS9rsKe9+BMGmSoU0+uczF2R0GbT8xXRM1Li7aw
         Rorlil5mZW44jmdKyj7ZIpTziYrG8bCKi1R4oEJvJsz2+fZ3CSiBoB0l7BNf4DNr5GEd
         kkkpuiUxm4MNHUcQIgMmaQPYC1i5MQ6aYFahPRCXXb0zSeglxlhnEYlTB/O9/fVBhRIt
         SbCe+8uC/xn5UtN/eHwZTp2ipOxks+NsY+ICvkxpYqQVRju9rj0vf4QGLUh2RbsNkxXG
         9ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740283; x=1788345083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1G5/5gYVXEXCPKHHHcZdLaqGYg9k7UTUSZA0KKz4mo0=;
        b=rKt7/Na6kHeOJ18UlCrC3Osd0c6IFStxWdV88a0uVQH2FHQgHYLRhdddbOKuFKQqNY
         rDyDtJ5ZdjTSpAuf6ZRo0gESgD7bJNILiMjsSHX/awXVwAk9zXSH280UR75GxaZ9ifaM
         PGgrvpE2F9Mt0fGCyFNCAaEI5O6ieew1ue/Z4F+R0YuwMu3FwGzqhDfklSDFjYpfKWpp
         +oFS772lHf81kfAcMA8DjxlBgKfaFS246QVSHuSQHcSBzmSkUyk1zbVaZ8EyUrnzj25R
         GEoxrOm770CxzjStU96GjH6jIVgkvoDWiMvNpHH0jJSfE9vInpSrL8cUuNDZrKonae/E
         H03Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq51ni5mkvDuLaN7f/ovWq49qnqNDOIlXai14iVdv/2bNSWA1K+nJUSpq27vhSFCI6eIoOzJNZiQeU=@vger.kernel.org
X-Gm-Message-State: AFuF++n4qm9JJ0lgTMf8DElR2lRhSRF+xH8J/z3K0aohvipu60Yoe/YI
	k14YUeJURRf644TK/4PFLzCZqszTI8iK7YaGQkutf1ZIKhig3aSHD7bU7HXlkISi82KrOf/ws3y
	l4/OG4qFJO4Svyw6/LlvtcdH2JZhj55MutNTtCwfTjuuP9v8MU0v0AbxP0j/h62o=
X-Gm-Gg: AR+sD12hGt5Ne8NCYrkXFDZLosYIRz96BeGNZcs6ljsI1GVaTe8h+rfq56glX7MwQrI
	17jhFaVbqUbI6esIrVBqp0bcslV26Gdn70EPBheAGV6jBlLf39c7BFPJW6eCjMXKtLfyKdJAvnt
	2pbaNgHD1Lc5nLzheEw+xMgwLFBKQM6fR/cgkfe0lPuPyMqWZowcZhPtX0c7g8ZFCfDhc3b9H2W
	dMTD/jiyUdUEwQDfuxp6wdubCVIpag/88itY2PUmtHUJh5ZcPJNf/RfG103kUALoOCWhvYfi1QM
	JBl4EF4F8XEv3S8X4Pnk04fwjMX4w77OQqEsQgPnsgXS/3xkE/bnEQ+WqwLwoZ26kZRcp3dt/pm
	Ah9rGAj8XwUJsrN8=
X-Received: by 2002:a05:622a:1194:b0:51b:cdc2:fb99 with SMTP id d75a77b69052e-52e423221cbmr49163961cf.24.1787740282717;
        Wed, 26 Aug 2026 03:31:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1194:b0:51b:cdc2:fb99 with SMTP id d75a77b69052e-52e423221cbmr49163321cf.24.1787740282195;
        Wed, 26 Aug 2026 03:31:22 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ac46sm468967166b.29.2026.08.26.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:31:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: i2c: xlnx,xps-iic-2.00.a: Drop bouncing mocean-labs.com
Date: Wed, 26 Aug 2026 12:30:43 +0200
Message-ID: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=2OYBYuITn3psg6Z1HtkzObrYTcYJqG6jhXiaM9WxoEE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqjsBS70xtCJ33tyNoF8tp1JvgWm9eIpjfeILnp
 NS8EYq0S9aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCao7AUgAKCRDBN2bmhouD
 1+O5EACSTM2gnMIwQuOlA0YIdHhC5/Z+dk6m2aO1ApbctozEXP9FbIgmhVfdd2ekGf2+wYnzzI+
 D5lrYd3yf41lg7C+fAugiwx6ogmMgtt9niUXMaJq38OZgpmc/cW8bNK9Ppg3PTFRLa1JWauAOhT
 IZQaZDibVkaOyiGdUFI0cpwEm/n9BX2+5d37Z87JAkLa+OtUzWYEshw2NX86BRyP7wrcEuIOKCP
 WCQf9s14tzGaC2PVYcfpU5QqxHc9xVzJGISaGCX31fjMTDeKR9woimFPAVsT5dfLHJ3FJg5HTWk
 /Pp4rfRjDwtSfcVsOO1cPldW7PAayZZEqmzUp9mam/qMVnYzJ8H84bCNUSBCNJJZ8JRPcUficaQ
 QJpzUCvnFpehthymqfblKLwZjebNZhkyxBDr/uHMCuFgQi7i15hXZh0Z2HhZESgNz7+nhbgxai+
 YfRmCEwwVdomGTEh7KEKgawd3oNmiFoBY9KUDlXyBXDzQLkQ5zlt+F7Nl8lLfmFw5Sb6RS9EVQn
 RP1DkRnvv6IBP9r3abpaJJ/rcjpSKOqE69Ok+F+dDDb0fae8WQmmyYsFAZm59R+RkaEFZSmQa8u
 Iex/9Uy95SDFvxY7KgKbfqucJq9th1iov9jK/eDJVw/uZdi/My7BR2wuTWy7RBzAVBKt2/4hT8L OnC7XGeV7BisYpA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 80rsr2FoICh3qkWkgrZkrabuDEXwBHVi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX0OROIDjVZDFD
 QEIUdnhXa51rz9WgvGMiRmbbNVWxnlUQ+dNSK3jKTp/w60W0k9Z6Ag5PeyyCO7jzH/lslUfUOYD
 /1gUrIPFYYmarC66QuzX9Znyis8qaSU=
X-Proofpoint-GUID: 80rsr2FoICh3qkWkgrZkrabuDEXwBHVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX+M1f6NHi0wHw
 LUhWYXsTZ6jOgG+8YEHc8D3nod5xPY3SFaBD4HSGqQi/mthDy1deNmgfLh5ayTOuIXePrXkCSJb
 Vce+VSu3bFDvVvMgPmka72ug0u8RywrNOFF8p14z2dJ6GcmUZhCk9ff33UjrZe/jYrJ5T2cYzxK
 YWj4oUsa4xY8xgK8F6IHCOyKPEARQ/LKeElr0AfPJGEadu6q8NBVKfzS+K+NMrAFt/0Vg4dH7Oa
 oV1rTCHe1GaT0tiATTrhpK8Jr86hGSJqliITa5qxMGsttYpoTnwqucJjV/ye6K5zQF780+2Txwn
 lGwSjSsam/dDphlajzh/6tm1YZ+2tWMD+U8Fx4S93HM8mMTpj7pf9C+O5dWeMqyd6JXhVkV8Y67
 8ikRFGM/LL3WOdFbmU/JbxyzEogO0e6YUCuQUZNj5ILvscJhi8C++e+nPKDZU7wynyF8EA5pxaR
 vRdsptt8AWn4qbGm7wg==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8ec07b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17 a=ByJN7JjbAAAA:8
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=3T8SOkedFoCXeTbM18YA:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ruIbMKh5GUt7Tw4v482g:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260087

Address info@mocean-labs.com bounces permanently (reason: 550 Host
unknown), so switch the maintainer to Michal Simek.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
index edd561d9733a..57caebe7af35 100644
--- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx IIC controller
 
 maintainers:
-  - info@mocean-labs.com
+  - Michal Simek <michal.simek@amd.com>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
-- 
2.53.0

