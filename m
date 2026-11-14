Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655822;
	b=n+EFyvzZI8KDozAjndhZABgptPpjLlajKvU1i0WeBqSe36z+itbzRzHd0K1/8V6qZcGq
	 WWi8m0v7GPxtldf9TfwmGEr2shCRBxWWq+3NgTu/caYc657WT7y7n0I8qqeAxvAMzcPDc
	 2mf22FC+K1PiZO5DOAKUirfyIV/fdZemILOss9q7UZfycAHa/Oq1S3OFY9EyUdfKqyu3s
	 PCAXduaVa1puNm2bwbsi29l1SmGk0bVOBrfvw62jO2DqXHWHw78+dYPN7lZY+2ozVKB0b
	 nWclFLY1UqgAHM2WhF+p9JXXIxg0TBPqwhlL9hgqiVQwUzmyqJd1jTp5O+cSXZweLOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655822;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0VLhsygCS1Olo/ZViAlUiziD8BIUpbLiKISOnmtdtZc=;
	b=E1RV4J69sRIPP6W+b/qgtjcA0FueV4qdSsLzQ7CLCZWg1Mt3WcxcHuBdTGlwmO/IXLS6
	 k/8ajg0xFFY1410n2/xEOvPg0UGcGbnTtexwWCh2BrH735nOUxbxbw9Br0LImR8Grk/9t
	 s2NnDdvwA1O/XnZAvUXdjK11kgPZ8Ggv/tw2J1g+Ei+q5YCCMVaC7X63rVw6+duy14HWx
	 wb1jRpooB7wBCHD6r/l7F5/2GxZHWQLAZ8FryJPiSnc/E7TQz+fe1qr7S2uwgGXGQGOK0
	 dO/PFq6JyG81KDctHPHBP3HR8aDolAaMDVDyRB84t473HhtYqKSlOr1p5q7LGA1Vi1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hrUqSBNx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPrzJt6l;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00154606A893
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00154606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hrUqSBNx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPrzJt6l
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wX0s174146
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0VLhsygCS1Olo/ZViAlUiziD8BIUpbLiKISOnmtdtZc=; b=hrUqSBNxl0OhVcVu
	ZMUuKtyuuc+Nz3/z3hx1n77m1AdqYrwqK0IjQwnWQ6NUOAmw40/8PGIPozFJjdWU
	AsimbXLs/4kWwEB1F3VaMxVIKAzLH/3cq55/oOkHQaZN87DIKZuQoIHPabEPlUpt
	u+sP84SyodFOzrBe9HeKiRSSlHtU0jAMe8o10IiW8JZtGOq+elhhAH5klKovUCC9
	aAXxVaafS5D+n6Xo1NuAapGrL4EpXqQy9s6LthQj2xauLw/k13RwHm9IxKVpsm16
	oFUWL0nzwAbaSqtYnIeaNILIbR9j1i+QCrf3VNmee/S9eheSq07XUPrd+E/u6fFd
	FYgSwQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmagkey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91eb556c8a0so38576406d6.2
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655820; x=1795260620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VLhsygCS1Olo/ZViAlUiziD8BIUpbLiKISOnmtdtZc=;
        b=jPrzJt6l/s5UHbGb8s71B2xr74KxJeaAKfqj4xLklQ3uCC73SEnCVfUlEv1cWhoZJo
         vnrMXMd5enTAOM6PkTADcAStPZEoyG/+8f3P7ZzsYreCDSzl7OpdNFjRLA5Ea/75yX96
         XxWR6Nf49nmwGH5MoBr4uYu+F4GDhiIcpgh1GHYhUy9ZYPgJo/l4DKC+2Gcvbudhkm6/
         hgJ5mUlgsjGkXo9cM4QSYq7jvGwp222wzwMhuO0ccUcoaIJ6ow7x1FwSKHFpEZGdM6uO
         69q+2YP9x4b4UUc+fwQQG9pO4aLlYJWcJabSJxeQcsKacyjRisCWbKLc4NmTkRqPICyY
         gvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655820; x=1795260620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VLhsygCS1Olo/ZViAlUiziD8BIUpbLiKISOnmtdtZc=;
        b=S3bRREJOq8PWMeLEGTZwk2Gbol9o0HWk5IyvoRD7wDcXvmbzfh+1Q/UmNIRMWYVMZh
         koKQjcjevygTOsVc79NE65XkHFrPNW4RF2LKWsIYJ0CWHf09jD19nu4xvb32wl+S1eqc
         eNdkWtSfu5UiUfkddprjfQmdc3uV1OiqPHgj8KacEp0hSDEJM/s8DFMt+4QMemMp3GDW
         hBR8AzTRb+bT1QhO+6XkrzYDg6d27mLYl4X5gPdGq38xphybWjfzvu+nX62xIIPJHTlQ
         oPCIPyrZsfIoSBGBbfm1sMFHV0iE4bJB30rePwqInFn1bLpX4A5Y27it2eJi7qRJ5qSX
         nDlw==
X-Forwarded-Encrypted: i=1; AL+hErEnIRKmbQGQUifooxPYJgUv+KOKAy4B30Q9vzwzrKdHao1/vRYZQLlSnXNYnWuIIMiKkZo2389bZck=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qQf80YJV+3KD3/qCaXs8nyQU+y4/KHZzRo++ql4xrkXs6Fk/m
	q+9e6NrhUSVqGBJU9tmrbJF+QPFBHcsS101iBO3fp6U2nRZG/3tFKkR2mn4hvG7sFZbodfC47WW
	xdhvzaHJX10bKUC8Y/n3IFsV5dSQRn29/GooY5MU9F4UTavIfA4l09+i0UESyQKA=
X-Gm-Gg: AYBFou3faDQ15mOhZbVg6NJMaDDvJmkdQGtorhzhKQTvrh6hhItcuzbBJQgRi+Yq3OZ
	r1TrJpkQfYZ257o/2Nm+CKccaLsBtTNVr3rui3oT/cXNvAqsb0EoZl8xV9bkFfxFGDvBW/zO3MJ
	cqyGpWpYmxmC4Z0HZDJQrYBqNDjptVlUUaLd4IF3FHwFcetkihk4NyzGJO16kXYVm7idRmgps2d
	zzYAtj3sh7pgErFYLSoZgz2Ooq5FdAWRzIsgPon/7AV8UwCoak50FL4LaVgSKJCfuOkVipdYiMO
	i0yE94PDNx8e5twVOLSfqvkJdG7HpfbVu4IZmFvnFtyeHESMao8efF5VQ8OS1MZjOdTziXeJnJx
	X5ZjvNj8t4HbZOFUqHw1ztkUwqWpd6TgqsFs9MnwfOnP+pAoxRy+EiIVFvZDYWElG8+x1j7Sdu3
	yS7Nm7ZOac+zmg3V+BrvLlGFuDV8mWPxPMfYEsVLQt
X-Received: by 2002:ad4:5def:0:b0:91f:1de9:97c9 with SMTP id 6a1803df08f44-91f24213187mr87461096d6.44.1794655820043;
        Sat, 14 Nov 2026 03:30:20 -0800 (PST)
X-Received: by 2002:ad4:5def:0:b0:91f:1de9:97c9 with SMTP id 6a1803df08f44-91f24213187mr87460236d6.44.1794655819313;
        Sat, 14 Nov 2026 03:30:19 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:18 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:21 +0800
Subject: [PATCH v7 04/23] dt-bindings: media: qcom,eliza-camss: Add Eliza
 CAMSS
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-4-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=10168;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=cF6VOsiourzLT1KEbZyHYZ5zkrOhPR4Jmv9rF5Vw16Q=;
 b=dFHopXgu5lBP1B3akNl/HEjkhcgLP0KmbXNe8F5mooo9axzeq4RpdiNQXbjEXcJ1anGCvD/f8
 vyLIfuTJ2yCC46WaIyEVe+omLkkiR4GuXOWknzXd/W3UdXs1L7veEoT
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: eSEkqzNdW_ltL24TM-Tlc01BPkr1ONMn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX2YmIMGGKejS7
 xr2HNnYtdEXSAwN92mUMxadQSQVibWEzujdNdh9/3f1BW5+i2N2XspJiSPUtiDYsd8wqGvF/uwq
 AEyBl1ahA7PWxbsG9vwFlYqbLKGnFtFKb8LvYl7nvV/hrQOq/y48jwOLZqvmhkbeVR3dziTunMm
 4LDQjKng7Eze+EA5kBguRHbCEFqI9L+Jn6uE3hMcI3XQdcrshs3lFGqcdjHVn0SnqQFH1M+hv3z
 zhI6iDayfV4g9WbUr9HTT7ZHK6mUwUhCuNmD7fha01G8VKEmZvUrkNXWpyiOTJgbyJa7Nnaphf0
 866b/dqSXTBuYWWc1I1HTOITFymc54JUtfpWgCPVopE24x5AZUKyKU5KhSPeiOQ9iIlChFeCQo9
 HtjLF6cx9r5mvmVC4YYaT87nKZhDIzbJZYXMoT9H1JFTa0to5rj6SbLKFEL2NOZo4vNgRJUEbYu
 TbLKdXADkLGKwD2xm2A==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af8464c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=nzTIdK0Ps9Aro55Xt-wA:9
 a=CwEh93l9g52l-ZXh:21 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: eSEkqzNdW_ltL24TM-Tlc01BPkr1ONMn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX4rlkiMUOSu4c
 6PP35e7ey2RDceUxUZzcCEYPpRuW7QNfSkApCiEjDuoxQIAa43NV0NcK34f9WwTjGbh/fEu8w96
 dGOeanek1eAvMeTRclQcXj5UV7ybmhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

Add bindings for Camera Subsystem (CAMSS) on the Qualcomm Eliza platform.

The Eliza platform provides:
- 3 x CSID (CSI Decoder, version 970)
- 1 x CSID Lite
- 3 x VFE (Video Front End, version 970), 4 RDI per VFE
- 1 x VFE Lite, 4 RDI per VFE Lite
- 2 x TPG (Test Pattern Generator, version 2.3.0)

The CSIPHYs are standalone PHY devices connected to CAMSS through the OF
graph, so they are not described here.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 .../bindings/media/qcom,eliza-camss.yaml           | 282 +++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,eliza-camss.yaml b/Documentation/devicetree/bindings/media/qcom,eliza-camss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8775ec6a2f69bad38bbc3e91c6fe285ede98c219
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,eliza-camss.yaml
@@ -0,0 +1,282 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,eliza-camss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Eliza Camera Subsystem (CAMSS)
+
+maintainers:
+  - Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
+
+description:
+  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,eliza-camss
+
+  reg:
+    maxItems: 11
+
+  reg-names:
+    items:
+      - const: top
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: tpg0
+      - const: tpg1
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+
+  clocks:
+    maxItems: 21
+
+  clock-names:
+    items:
+      - const: camnoc_rt_axi
+      - const: cpas_ahb
+      - const: cpas_fast_ahb
+      - const: cpas_vfe0
+      - const: cpas_vfe1
+      - const: cpas_vfe2
+      - const: cpas_vfe_lite
+      - const: csid
+      - const: csiphy_rx
+      - const: gcc_axi_hf
+      - const: vfe0
+      - const: vfe0_fast_ahb
+      - const: vfe1
+      - const: vfe1_fast_ahb
+      - const: vfe2
+      - const: vfe2_fast_ahb
+      - const: vfe_lite
+      - const: vfe_lite_ahb
+      - const: vfe_lite_cphy_rx
+      - const: vfe_lite_csid
+      - const: qdss_debug_xo
+
+  interrupts:
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ahb
+      - const: hf_mnoc
+
+  iommus:
+    items:
+      - description: S1 HLOS IFE and IFE_LITE non-protected stream
+
+  power-domains:
+    items:
+      - description: IFE0 GDSC - Global Distributed Switch Controller for IFE0.
+      - description: IFE1 GDSC - Global Distributed Switch Controller for IFE1.
+      - description: IFE2 GDSC - Global Distributed Switch Controller for IFE2.
+      - description: Titan GDSC - Global Distributed Switch Controller for the entire camss.
+
+  power-domain-names:
+    items:
+      - const: ife0
+      - const: ife1
+      - const: ife2
+      - const: top
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    description:
+      CSI input ports.
+
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input ports for receiving CSI data on CSIPHY 0-3.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - interconnects
+  - interconnect-names
+  - iommus
+  - power-domains
+  - power-domain-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,eliza-gcc.h>
+    #include <dt-bindings/clock/qcom,eliza-camcc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,eliza-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        isp@ac04000 {
+            compatible = "qcom,eliza-camss";
+
+            reg = <0x0 0x0ac04000 0x0 0x1000>,
+                  <0x0 0x0ad27000 0x0 0x2b00>,
+                  <0x0 0x0ad2a000 0x0 0x2b00>,
+                  <0x0 0x0ad2d000 0x0 0x2b00>,
+                  <0x0 0x0ad6d000 0x0 0xa00>,
+                  <0x0 0x0ad8b000 0x0 0x400>,
+                  <0x0 0x0ad8c000 0x0 0x400>,
+                  <0x0 0x0ac86000 0x0 0x10000>,
+                  <0x0 0x0ac96000 0x0 0x10000>,
+                  <0x0 0x0aca6000 0x0 0x10000>,
+                  <0x0 0x0ad6e000 0x0 0x3000>;
+            reg-names = "top",
+                        "csid0",
+                        "csid1",
+                        "csid2",
+                        "csid_lite0",
+                        "tpg0",
+                        "tpg1",
+                        "vfe0",
+                        "vfe1",
+                        "vfe2",
+                        "vfe_lite0";
+
+            clocks = <&camcc CAM_CC_CAMNOC_RT_AXI_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_CSID_CLK>,
+                     <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
+                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CSID_CLK>,
+                     <&camcc CAM_CC_QDSS_DEBUG_XO_CLK>;
+            clock-names = "camnoc_rt_axi",
+                          "cpas_ahb",
+                          "cpas_fast_ahb",
+                          "cpas_vfe0",
+                          "cpas_vfe1",
+                          "cpas_vfe2",
+                          "cpas_vfe_lite",
+                          "csid",
+                          "csiphy_rx",
+                          "gcc_axi_hf",
+                          "vfe0",
+                          "vfe0_fast_ahb",
+                          "vfe1",
+                          "vfe1_fast_ahb",
+                          "vfe2",
+                          "vfe2_fast_ahb",
+                          "vfe_lite",
+                          "vfe_lite_ahb",
+                          "vfe_lite_cphy_rx",
+                          "vfe_lite_csid",
+                          "qdss_debug_xo";
+
+            interrupts = <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 603 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 605 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 606 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "csid0",
+                              "csid1",
+                              "csid2",
+                              "csid_lite0",
+                              "vfe0",
+                              "vfe1",
+                              "vfe2",
+                              "vfe_lite0";
+
+            interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+                            <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+            interconnect-names = "ahb",
+                                 "hf_mnoc";
+
+            iommus = <&apps_smmu 0x1c00 0x00>;
+
+            power-domains = <&camcc CAM_CC_TFE_0_GDSC>,
+                            <&camcc CAM_CC_TFE_1_GDSC>,
+                            <&camcc CAM_CC_TFE_2_GDSC>,
+                            <&camcc CAM_CC_TITAN_TOP_GDSC>;
+            power-domain-names = "ife0",
+                                 "ife1",
+                                 "ife2",
+                                 "top";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    camss_csiphy0_ep: endpoint {
+                        data-lanes = <0 1 2 3>;
+                        remote-endpoint = <&csiphy0_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1

