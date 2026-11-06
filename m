Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975375;
	b=tQuFF7ITcD7B+kxqZQTN4sMzgwJfJZJD4fIFELTXj/VzY0kxwTwSUBV7s8OkvBnP9eky
	 X0EQ67voOhlTNVkfFqCiWyzkPP6YJ//brMhZlebkbOJwpGM+07U/9PnRDLNofbS2aM8EE
	 R9AEuQHj6rJV+wpEt2DM2PXIdCi29V9CvZonUIAKyXCuuv/eMTwfLqnjBJTTfKHAhpWAa
	 eJwvd3Jp1TEbeBjzqwC1z6DMVggfugfvWyOjdIpuVtWmU8AnCfJBfm+xMR+It7HDCad1k
	 vFbB2M9YrJ7O83z0+C9WZgFpUHoYN769qiZVyM3Q5Alz8v681dfXGg9Jwq9sacj0PGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lSRVU7RUuxh6puB6b5i6bOTbwTzK785NvXxbRg2foaM=;
	b=Qdn4v7GOGyQmX4lFMnNv2gE/K8adghLaTnChyhlWCcTkKaK6c+cQbOMfngDb+fF95wY1
	 VjlJwxwCqHXssRV8tQYCZD3sJwGVo8BQ9bzjfGyaK5jNXeEVzQfEQxCsy1LgA/kSKoklN
	 oKQCyFQuUiG/OCkjbqYMjR67YobkAS8N5f6aC/jMlJANAesGqsYB/HBgTs0wzNrMAM6hw
	 EP8P3ki3lq7XqHRLyLee+DDWHJ0aHRU41GF3ZpaW08dORQh1ETUySKSdwLObHmeL9zBDJ
	 nDHFjFIvgdX/1Mx9HhIbYI3jOXfdkOT3oH0/UVFbKToXtXFbWJOF8A+fFVGz6lodtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWQBit+A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NiuANmX4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C11606A335
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 14:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C11606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWQBit+A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NiuANmX4
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EPw0b3647414
	for <linux-i2c@vger.kernel.org>; Fri, 6 Nov 2026 14:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSRVU7RUuxh6puB6b5i6bOTbwTzK785NvXxbRg2foaM=; b=YWQBit+ArHsWuZId
	kUEzcqzG4QNF1fIC0/VMFdTjAuAAen8EgfGw8DAOsC4SpuaMyx7KjdPPZRavtpxS
	MSQkWCjKF1VyUYPKVAazDJ2V601Tw8ytrJEcrHIe5d/vz2s4Pq2cUjD7TwvSxWHX
	aChA0k2oWVAydjxyeXxqXy0XY+QDOXPyfZNm4G5TSjIWcoXHrvHDqmeJpLNqJmYS
	Vixkm3ErADLZ9D9ess4fbF0qOiLTVNwRY5lWUgNeSXOfsCjsHnarsuyPIhbD6bw0
	ficbzblHf7ht+Nk8no8GFxOPZjN3ZsLs1GRww5rwAGIVZfxKcistKIZP/MM4Z8Pa
	cPRpeA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9k3ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 14:29:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b1ae61c87aso575130b3a.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 06:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793975373; x=1794580173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSRVU7RUuxh6puB6b5i6bOTbwTzK785NvXxbRg2foaM=;
        b=NiuANmX4PIhci/hbJRjwpuDg/HPkRcMKXbQdol3YHU8fhb1Aq8F9BpTZGLkSzVrSZr
         2+V3LNoTKmn1ztUYw20VWRZ7t20Qq7hqdVuN2wo9cLx3WBGIJ+MAXZIRbt8ikyYTu5uy
         EBJvnXPE+I6xCwV07GvlTFzPLBXkVPooVTMkbIVPYYP0YaRRgg1dol1njBOJ0VLV54Gf
         gP6y26C+Eih/HE8qPvmjbvnptlSlg5JOiA4TsEdRfxyqVmCrXRgo4oh+2gaVRrKRnlBK
         EOKxRoMOMMDkyq0n91hfIzgwn6+iHMJ6FDdytKVrc2VJR4QJmIYyeftCzU5GZi19DRsF
         sUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975373; x=1794580173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSRVU7RUuxh6puB6b5i6bOTbwTzK785NvXxbRg2foaM=;
        b=H+nxEl99G0v+T6w+AXAL4fVe89lzty56KGvJG2Uxfx8CmUMRF33e1K/L35LyVb+C02
         CfD3/x//sZoz0lbWbhPF5onhFDEUVxPXHxQeAMjxDnQYB5bbzXFYn5XO0e1dwW+u/bpz
         hI7ATFPwe5wynhIPxPUJqpl5pACjqNoU0G521D9Tov2wQ58KnxdGKVCLj+BPQ4DXpDkh
         oOnqgefWproGInoRAixTcEv5bV9k8yuQNDvDrpBsWS+iwqgfmMOosvgMbiraijcPcGN2
         h4AZnjkXTKUyB47s+dWcsO2ttq66Ku54M0PFe+kPaZ1pQdKrAolovNJz9Ipo9BX10JQb
         wfXw==
X-Forwarded-Encrypted: i=1; AKwUvBw15/w/eq2QBV3vsLxw7EZamPrAEUuT2E/Oex8osmFgWJXgUYQBmkHNBPCGNYfzfHGUqFEet5WCBgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gAVbWjxjWrzsurS9XEBqcWix/65IGLu2ewsg2IfeFty3HDLmT
	tl2ZEYWyGGZ+DFEcmoIZGd6ZIaq29BqtuS+PCO2eZC2mEVCyOMEj0BVQ7K/t2CyV+rcB7shGQ00
	+htKePsGppFjzESy4mcZUF8m0SwAYACVPqdll+IZZ0TwqhUROeZQyGY5+YzT4yM4=
X-Gm-Gg: AYBFou37uX/TwZeYcK+pIZpTTcK1dVZZNK5SdgpV9Xtd0F/Jmmkp88T6oxSmO+XhBSR
	r5YclroR4P8oKumx+sV79+u21PbG64j6EjpuySYj+ihRKkB0y+zwSfPXJ7iebq+mEFxy6cYBj4v
	bF5bxMvfbjRAqJSFYq5HQ3nkgzO/GbNJy1BE4XMpoIwmSFsK0uu+JKSyptgNaqXw+BFXiOgIcpj
	LNeoHhfkwoZVT3BHmOq1me/MVwDCWN6e7Mmn52R9UNRC3Anq3WCrmVdBWWXi/RAs411bhgGN7MK
	domI8wY0P55txrVehSLKgxc3fixrPEA1TSj00mVef7Z/vud8842VKnt08pACi2ti8cGxNh8o122
	TZ4h+zNLT/PFmb7pul0kKJ49BTgbUSrb9I69N2SB4Pjua47qFujQirM0LKiAIy4tRGvfV3QfiDs
	ggMKiUng==
X-Received: by 2002:a05:6a00:809:b0:8a0:2344:c44b with SMTP id d2e1a72fcca58-8b37b8694a8mr2601830b3a.40.1793975373218;
        Fri, 06 Nov 2026 06:29:33 -0800 (PST)
X-Received: by 2002:a05:6a00:809:b0:8a0:2344:c44b with SMTP id d2e1a72fcca58-8b37b8694a8mr2601802b3a.40.1793975372600;
        Fri, 06 Nov 2026 06:29:32 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0161sm690244b3a.26.2026.11.06.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:29:30 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 19:59:17 +0530
Subject: [PATCH v2 2/2] i2c: qcom-geni: Add panic notifier to prevent
 transfers during panic
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
Message-Id: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-2-d3011344fee8@oss.qualcomm.com>
References: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-0-d3011344fee8@oss.qualcomm.com>
In-Reply-To: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-0-d3011344fee8@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793975360; l=2868;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=z8OTmYoOW68Wr7bPMyY6C22t8YZnlBJl/0+EpX2cz9k=;
 b=n1Byg/UlMz833cQsKM8f3PbKdih2Pil67dVLYQL1TcyWewpIu3Ww1CCw/EEi95skq3mf8sk0u
 dTwBQJnFuX3DtLPJ9K+CjVddaFD2Km3W0o4uVaQQjly3ExRsGCdthEp
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: DHGWyNfocGEf-TYXg-5iOiBA9p6SF2uh
X-Proofpoint-GUID: DHGWyNfocGEf-TYXg-5iOiBA9p6SF2uh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX7IDPUdeGdrb0
 9LO6Fdh/NfRgDYpbqlMXE5tbOvXZX23WDRxzJBHVLq75/e1Nw/lrb+B3Ms+jDlwBECuBMWaVWTc
 oWb2RQ5lQElZIRvodVjXxtNoFsiR+tU=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aede44d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0wxbfleT6UKSQBY2OSAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX985hdK1JjkjO
 PnIl0vB6BBoamC34RaMN8sy/4ePBDqFTsiIBMqLDALdU1MmBdqUR7YtpMNNd7g506FbW7E1MOli
 SrSl2BEahGaMj7le0JIy8pSwYm8It//y88XsWZgd3DrUltHDvathJS0gEO8Edzkq6h8LxvsEgXO
 OOdhbGYjvQnSGk9jKhY3h/qgaOy4WIWOD3e7mWIYAbukonF7+89rdcvyc0ReBrLnBum895qOtBV
 l4Hm+XKV0KQ82Cfb+SV5BxhnCuIpvjgPK2osa74bnRyx+VFCxxKqcQsfJ4PLcc/Pk3/OXK1Bfub
 N7eB+QGN1kupaPnyBUPK08vHKqnpzqTLHAvDaisCCMINmauuClUYR4pjbrxuefsm3+7SG0ynMUx
 ilz/EF1QC/pFZePiA25EOQ/lhiZzwTDXzKPatZqmT7OBLuXMnuFiLIdaYQMjjCzhyXzhMdJozch
 QDkK3I3+rvFJ/+N5Lxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060057

When a VM crashes with an active I2C DMA transfer in progress, the
SMMU raises context faults as the DMA engine continues to access IOVAs
that are invalidated when the VM's memory context is torn down. These
faults can affect other VMs sharing the same SMMU instance.

Register a panic notifier that calls the same geni_i2c_quiesce()
helper used by the shutdown path. This marks the I2C adapter
suspended, preventing new transfers from being initiated, and
cancels/aborts any transfer already in flight, limiting the window
during which the DMA engine can access IOVAs that are about to be
invalidated.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 79707095bbbd..6897cad0ddc0 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -16,6 +16,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/geni-se.h>
@@ -139,6 +140,7 @@ struct geni_i2c_dev {
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
 	const struct geni_i2c_desc *dev_data;
+	struct notifier_block panic_nb;
 };
 
 struct geni_i2c_err_log {
@@ -1087,6 +1089,16 @@ static void geni_i2c_quiesce(struct geni_i2c_dev *gi2c)
 	}
 }
 
+static int geni_i2c_panic_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct geni_i2c_dev *gi2c = container_of(nb, struct geni_i2c_dev, panic_nb);
+
+	geni_i2c_quiesce(gi2c);
+
+	return NOTIFY_OK;
+}
+
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
 	u32 proto, tx_depth;
@@ -1241,9 +1253,16 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_add_adapter(&gi2c->adap);
+	gi2c->panic_nb.notifier_call = geni_i2c_panic_notifier;
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &gi2c->panic_nb);
 	if (ret)
+		return dev_err_probe(dev, ret, "Error registering panic notifier\n");
+
+	ret = i2c_add_adapter(&gi2c->adap);
+	if (ret) {
+		atomic_notifier_chain_unregister(&panic_notifier_list, &gi2c->panic_nb);
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
+	}
 
 	dev_dbg(dev, "Geni-I2C adaptor successfully added\n");
 
@@ -1254,6 +1273,8 @@ static void geni_i2c_remove(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
 
+	atomic_notifier_chain_unregister(&panic_notifier_list, &gi2c->panic_nb);
+
 	i2c_del_adapter(&gi2c->adap);
 	release_gpi_dma(gi2c);
 }

-- 
2.34.1

