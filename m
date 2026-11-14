Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655848;
	b=LQRw63HMKX9kAYQ4zg2DwbCesBmHUVi1cogDaLfWT02ahlbkwJExVM3+hhUN6D1K720k
	 yWtV9XtJRPywYUNWF5TinsDbhdQqaUpvuj7p6xb0HVDDUexm5UbgnTseq+ZkkdDiSdMAR
	 3HEWdU3ZgSXi0pHahLWRMRuI+J9t1W4FUE0d4DosYk/5OjcB52c48os9KZTJqeAdamiGs
	 ZmUufBItOIxzrP7RKSwf4yFBWudBeAfzfTs4OBVJu07hFTSo+ICK1pfj9nsmIn9OKisha
	 lhE4DiegZ32JfIetZll2rqmL5JDmWj4q1G8/o0fNrjvKd7lk/rUnS/dHa5fUUVUBsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655848;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F6vcBhELVI44DwyuNxTZrVH7X6TGjBEQZ7lsC0zR6tA=;
	b=yD9RgEPfQHAJzes70F0Z6CbpzPreiqD6vBCAZYXTGnSANPqBcCFFItrM/f2xCLIxYlwG
	 DFiRQzVLqmpxe9s8/YFzoVo85UMNf6+Qdw8taFvtIFGopqp05hghvsunLbl+fi8cFZcUS
	 3PBG2LnPtzhZKCrfa70xbsydy+wb6+2/Ht4hlh2AZFuTNWv8P6Tioj6kukgUOA6reLqV/
	 YSwF+4I1+79tNc4ueGi1QtLIBP92Fwin1ILyPaUZuHfmMoKiMUGXEjYWcz79bXEJ6f/J4
	 1oxe5/u5EYls0kv/rpiY1lLQdT/+bHW6BjuLkJ+6cNFqh7CF9X6m9ysccqfZTdvnryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DUsKaoMQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HFHBLuNj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E0606A335
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4E0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DUsKaoMQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HFHBLuNj
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wakZ174221
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F6vcBhELVI44DwyuNxTZrVH7X6TGjBEQZ7lsC0zR6tA=; b=DUsKaoMQqwLjn3CP
	GmkBwFw7dlMT9bJbPsmxeLuooMsJdVh3ap9iL23QewWIGSfO+ccKdPLk9haA+AG8
	2NqJTURa05MlevM3l+JTFF+wqmlLk4PkYc52qur4yEVIRKXeaxKJGc2gG32AzJPc
	t/7xHn/5Lptq73QI9syquxkA8ukFmhOObKPX9pN0WMUU/ADvx7vg9jU8W40DxkG5
	kPeK43Y32gDQArSqdfRly1wyUBlIEXiRrFLDvEzZeQyZJFPqsKz1MLbN9M4azXc5
	0FH/IGmONlnisGFps4OYDJndtDNMWxystIgSr3Nb9/xbArVjBgiUPL1t/abbtWo/
	b67ElQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmagkgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c6c1e082bso51077186d6.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655846; x=1795260646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6vcBhELVI44DwyuNxTZrVH7X6TGjBEQZ7lsC0zR6tA=;
        b=HFHBLuNjAvfEHNQh1A/f4sm4IQoalfDgOZhEQjByaiRBE+b8McEE57m03oeItpTV/1
         LU0jrOzCOSQ4ve5PotziMN/UA5bhhCm5mKMiHKJ0aYNL8d+Xb+KM8asukvl+M3LF6dzQ
         EEjyvzkONmvrqIaNSjlCq764vJbRRSunrFKjNmOrwVj5x3oaMdXL4g7elayWAR46ov79
         y02UdX5Bq4/DBF6cZFX10tMV+jmjqxoBzXdaA0OJTkqOZQ1hJ1J6iTwGsOfOM0PR9Ijo
         nhcjYKUr3Zgm4HA2gT0oDMdZ7HCqUMEameSPvm6obKD9uCalzcbhMxZ2A1tj00HqW15z
         3yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655846; x=1795260646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6vcBhELVI44DwyuNxTZrVH7X6TGjBEQZ7lsC0zR6tA=;
        b=EVDOxIb6T2cyswhDpw7ZZ/Zrmlq3CYEjOAbg0Xa2h9sHlBr2sJ+C+TZPqzlS3m//gT
         OScXsuyAI2LuNWAl8yk7fISCBuMNJTAaYYCNR4eA4ZIN80yVA5AyaGpoGYXbkexSfu8T
         eypFgtK05gIuEeX5tXl3bKdbaUAA1bH3819QJoBehfp3frVId1E2/Vi+RT6HoduGzc8C
         ldMPmpIjv5jb0zSL8XGoTTqLUn4JG1FsGYwrF7u+ZMzTE03N1RF6VgdhTA3+VVlXFaRP
         ZSpM5RaOxoblynAPrQaDnUoaBDcqkpAisoLBAjMWtNPecpPvkc1Ir22xNtxv/8cDyKUG
         ejMA==
X-Forwarded-Encrypted: i=1; AL+hErFPbvRe5CWTPpF5zOGHYiF3DSMMTysaFnEb3mfd1LCmafB21yEDT+krmMCS1tr9LMMOC8dCb8Fosys=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B7SJAf1MPyyR6N9M2d5ZlpCQRIV4BIAXA54vmoXx8AM6elf5q
	oBEHVB5HYvuZj8/yKdM4baFG/RUymJX7InG8ATJXl2mDX7gbSuZPs0dd1iBOEMc7hvX7L31LqiM
	34g9WHkprtk4Cy+t53vAR9kJ/8ttD9tav6rAxOFaX7R7IZfnycInNdCwkmzaXktw=
X-Gm-Gg: AYBFou0cBqcObsdod0nC0EWXBs3vnaXiGvX+X94SAZdtsmnUvd6pcWwahh1BMLKN4BK
	7x3mnbOtWHUlE6og5g8gkBlfy4gcOPXagCSc/0y6lN8SdpPw3R7VVEp68EvVlE+E9AtPbb0gMI8
	l8ONBDeyMtd7aQfxj0kw6tdIEtYda2sUBN8porzsqBni8n/BsFeYZ7HwSYtQtTF0Ch86jwMvol/
	qDHMiteMEUnJLieDj4gxmW++jCc2t8SzKeYYsKYfEufMDkF+pRbhyCwfKQhvpRI0PZXo7zyuX3w
	O/2rN6A6DYPbXM8poUdZzT02qkkT44tq6ExQp4bfHH2gEeOMjtSXnEB9kEc9W4u3Gzkllwt0VPN
	7GEFyH6iiKpzxnfKV8afsZzNAF+XpuCtP1dCl80urh4IKiLJ6VCzICvoKwbo2DFfICam1cL0+hH
	vg0nKLvDJWk9j3QPd8fNSiytDYdYYmAoJi2BdWmfHD
X-Received: by 2002:a05:6214:8450:b0:91c:73cd:1bf8 with SMTP id 6a1803df08f44-91f24221a44mr66777196d6.21.1794655846150;
        Sat, 14 Nov 2026 03:30:46 -0800 (PST)
X-Received: by 2002:a05:6214:8450:b0:91c:73cd:1bf8 with SMTP id 6a1803df08f44-91f24221a44mr66776816d6.21.1794655845679;
        Sat, 14 Nov 2026 03:30:45 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:45 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:24 +0800
Subject: [PATCH v7 07/23] media: qcom: camss: Add SM8750 compatible
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-7-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=2778;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=gsNJ0bz9+/X/AkRkdNGY061gEk+2K0yTWnojGIi/oiQ=;
 b=iYfQBfOxerbVvRBNep3yoSplTsIkkpQ9MjVaFAqYYy2Z6KPAXHcu0YBprzXSGPgERlBHoKn1J
 SCez2ZmCgyeDnqljKkP4mskMeghbM60yGLEH3W42JrWg9XFrt2g1DLn
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: Uu4Uiz43FvmTtgL7y62IFb7IRjRer0rn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX4eD3XcFOnm5l
 MWbEZSxORR4KpLB7nwN5JM1odqGc7Agik8ESJBkK+NYFPf1awZ9tsWkR4bEmQqx1UvJo1lQXx9v
 iVQSO4cquNmF2lPs7b7wkyDfmUYtjq1DfeBjT/GiqO9KP0fBnMo8ZfJ29RtW42jnpmSDxe2QW2i
 fq7Y/NlsHNWfzenl7ITdu/LLrpvwXmkStkf50mrXsWJ6xtQ5Q6VYK2QUv8fVoIW+hlURZGM3hax
 zZRY1psbqVgmD/kUSXJ2b3FALlOse4YhOw6LAI0S88eSwIlsvEeT9t6b2o1boFcGOA0MRKhgZz2
 JRSZuf1ZBWLGuNm4+ECmL1/RBEL57hlHYixGPKCfimJjUE3hW+40xsQBwo2AUa3IqoN5pR+2rTn
 Es6/ldEM0M0gbdJJMEJl1p4i1esISzxNQNExmzu0O0vNIjPMLOgvi3Nv2NlXeDanKSBGV6cD5rG
 Fw24JMJ6ZP/9ezjm5lA==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af84667 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=gE60Ov1lhapgyOv8Ur0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Uu4Uiz43FvmTtgL7y62IFb7IRjRer0rn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX6afQpXGNoNPs
 OC1bxxWDb2ahzfiA+nyPhMfDWaCgWePTRdgoyVzbAfC0UvyBlNJzJRvZGV8mky4iApNr9SVo+t/
 3tb1Hsl9OtJzK5qTQGDuwkqkzQjgUQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add support for SM8750 in the camss driver. Add high level resource
information along with the bus bandwidth votes. Module level detailed
resource information will be enumerated in the following patches of the
series.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 23 +++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 73b3850bbc08e857390330032d27bea38b8a10d3..3f9dd3a2ec088fa87a9ea90d25c906d14b9a1896 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4308,6 +4308,20 @@ static const struct resources_icc icc_res_sa8775p[] = {
 	},
 };
 
+static const struct resources_icc icc_res_sm8750[] = {
+	{
+		.name = "ahb",
+		.icc_bw_tbl.avg = 150000,
+		.icc_bw_tbl.peak = 300000,
+	},
+	/* Based on 4096 x 3072 30 FPS 2496 Mbps mode */
+	{
+		.name = "hf_mnoc",
+		.icc_bw_tbl.avg = 471860,
+		.icc_bw_tbl.peak = 925857,
+	},
+};
+
 static const struct camss_subdev_resources csiphy_res_x1e80100[] = {
 	/* CSIPHY0 */
 	{
@@ -6026,6 +6040,14 @@ static const struct camss_resources sm8650_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_sm8650),
 };
 
+static const struct camss_resources sm8750_resources = {
+	.version = CAMSS_8750,
+	.pd_name = "top",
+	.icc_res = icc_res_sm8750,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8750),
+	.csiphy_num = 6,
+};
+
 static const struct camss_resources x1e80100_resources = {
 	.version = CAMSS_X1E80100,
 	.pd_name = "top",
@@ -6061,6 +6083,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
 	{ .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
+	{ .compatible = "qcom,sm8750-camss", .data = &sm8750_resources },
 	{ .compatible = "qcom,x1e80100-camss", .data = &x1e80100_resources },
 	{ .compatible = "qcom,glymur-camss", .data = &x1e80100_resources },
 	{ }
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 97fec24e680461a477add23bf5fb0b486903ba5b..3da970d251e728d339d13fdaef23ea5dfa46dd3b 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -95,6 +95,7 @@ enum camss_version {
 	CAMSS_845,
 	CAMSS_8550,
 	CAMSS_8650,
+	CAMSS_8750,
 	CAMSS_8775P,
 	CAMSS_KAANAPALI,
 	CAMSS_X1E80100,

-- 
2.34.1

