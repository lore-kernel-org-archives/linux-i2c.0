Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E032E743
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029293; cv=none; b=A8fIDVcelx8Qjx4RpNzp1YOly+srmjP+/VNVxBRYxw4KgseAo/sgKd/T48oXq1hBOu5bYwINpGCPLe5RMHirybCdWpPl+8kOY+8os8RBtJuqZ7+fd8o/4ZJve/PObn24c7yYBQ+78InUsx8OuwyM3chpg1OwiF9kZSCzvklrxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029293; c=relaxed/simple;
	bh=nWVWXo8PeGEpgHZRaEwwycO9V5CYo0ghXOEjdfrH9GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjw7EyHec1PyZezGyxgz5b5T5zkjwyOgvh3BQmz4CCz9GAXRyxSrcOWFB0LKenPRPQ0DOS1RZJRsfut0vXpKght1sDqppyDyPJErBErjs+IdZJJCTv9KGt6KGdpzpKdKw4XML+GbSZhMx7jEajvJcuRQpGdFOLTWHx7ptMQNOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y0u9Znq7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmw/qbqX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0u9Znq7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmw/qbqX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I45mli4187022
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUvixyY9G/lT9AeLA6BxhhEw+FAfIWOYlEArceVOqRc=; b=Y0u9Znq7GI9C6nS1
	qYy9nlISszDbGq0eSjPmMw1GBRJVmBcYdbn/RqKywQAswy5zCUMa+1DCJWIx5bi6
	70VPmezBUmsIKbCeMF2Q9MPAjax2sV12jawNPcxYgH9HVwxiMJf0JP9g3PhxTdjX
	uAG3GD4qUz5JDANcAAEWOiyzpSPZ/RGZGE9kz4Jg2JV/7k7QT7SAw8eyW9tdp7tY
	uqdZrqNlyDzl4h/3f0CsXiguIru+poJqzTU1cvBXCgJlQmT7uK7ElY5s95R2Z4BE
	/aWCZgN1Rs5/KhshLPa2pJn+o51avxAD4hjIw/lonLhWEZvS32Kdh0AY7e/hMN5o
	7CmArg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p075v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso3547050a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 22:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029289; x=1787634089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUvixyY9G/lT9AeLA6BxhhEw+FAfIWOYlEArceVOqRc=;
        b=hmw/qbqX8pu/ngBcNq3js4/J5WB+uJbjOPfiGohoDMRa7R3ItYl81S3mdFM634/gj5
         GL/NYrie3jy37kylhJdXFEuBBRDzVOmPWkk6LdeTydXT1YRXt8jyzdU9Wxjx98LHLEMA
         mxlB24Vv7HaGxdVpHBCUgKE+T7ldUFOu7sVVHMCi9Ksl4zXpvAF6p6J5QPLL2MYwyHPu
         5cl3DiSNToDpt5Dpii8AIUKCeyrhkydN3gGRMHMq0+17r1k3c8AkNWdSfM+AdKkE0clK
         ePchjfZuNfDl8lj57nhJcswfNoSojV3k11YKnD32XTRYFjMOK2OYQio6bZe/vadl5dH7
         tpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029289; x=1787634089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUvixyY9G/lT9AeLA6BxhhEw+FAfIWOYlEArceVOqRc=;
        b=RLpdfAXoI7vn3TZuXiYXUrGUdySi7zrKE3JK2mJtrAttXQIByW0Pt8AX14h8Zdz446
         l/sGsrmuTKjOgtsPhRk9hizLLqIeWFZlaurvkEGVHreks+qKlynUnmEIAewc8VkI8adc
         dYSiUVkNcCnJ4dZByzrrWP/7Rv8ZSFBKDFQlRoihVhGr/1jJwnCaHV3WbwHw9jfUyHfM
         2KGo7UJQxxLV7JTJpNii1LfKx+AIaX7MgENnF/3ABvBp3cq3QNm4OSIssQAeE1Ukssie
         Mg22ja6MGUmfsAzmdI4u2Xjpp7gN0YblGjkBdVNQGOKvfHtnth4wRd2kaETHoKNSbDEu
         98UA==
X-Forwarded-Encrypted: i=1; AHgh+RohUCPkgXpG3YOEAOfcHDt4ToIxTysydFiPxbPvKpZJbhNsYvL9PeF2A3NQ9e38Su7flRiZG+zl8lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbnPl79eAQwiO58a9WJOWR9FEB2LKT9hhBIufndmTM26BSjI1
	2BCSKIwiSMxsUnHbUnbnHDsNK+F9Mt1vucWhmEa27CagehmgsCL8WEkPPNKn1U6KTIUU70O9pOM
	QKZKIrgczJJos0unb6K4+wWD5tbvcFTzE0AxV/N2TdzMUcHWOFudT6+bQOK3SIvqrMmogW3E=
X-Gm-Gg: AR+sD11z8fSEccFTXwZQaE3AgzdSJwnl8Wuj09b+D3W3GMf9apBFUuf+nG7a/cxFKjc
	o+H3QpChPfqVfLwu2bMJlRXYkT0oLzHRX9rw3dFy25AcgKZXohOm806w7TbdtUpZvT4twC1ONGR
	DOSFzj48lq/LuD8i9ejkS0fKp39Cs/foc5NYr14eGwdd2yA5Vu/Jubctb8TB2Qs7+tw/l+VY/dK
	YaSu8unjI/X+MKFOX6ahCjYK3aMx3nNkqgY+wrpMhq8sIGsmdmvcuvc0IcIIhzNuHdQnH14aZAS
	G/mLzcuGcz90nz3jyKQ8RDZ83Tq6sM2eV0NhRLSMz4KZtjEzuYlypmMrlvdC33JEgCUKk20JR+W
	k/oIYoLmhwWXhFu3HbM25xfXkw0LZOT0nsA==
X-Received: by 2002:a05:6a00:2446:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-84fde13bf81mr28327332b3a.17.1787029289357;
        Mon, 17 Aug 2026 22:01:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:2446:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-84fde13bf81mr28327216b3a.17.1787029288810;
        Mon, 17 Aug 2026 22:01:28 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0158sm1028876b3a.40.2026.08.17.22.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:01:28 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:31:18 +0530
Subject: [PATCH 2/2] i2c: qcom-geni: Add panic notifier to prevent
 transfers during panic
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-2-9f31b5fae5f6@oss.qualcomm.com>
References: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029278; l=2967;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=nWVWXo8PeGEpgHZRaEwwycO9V5CYo0ghXOEjdfrH9GU=;
 b=kkAOSSChSPsRli6fSAY7aHJoXw+gU5iaIqRTDtnKirCM68KsPd9obx16vItbDAhwi47TTWE9i
 wOFWPk+nLqWCmy7OY1TDXHpV34uTgi9PkxUdhrbgP5EfERhEg2djduO
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: PJpdOx1Au7pHjgvBJaxF9FUvYCnpYg0c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfXz4iCkp+m018g
 bQtMMljk66eKsLN6JF30UAr9YS3YH4tAlA05vwbcI9Qqt21RcrM6YnGpfi2lPxL6we0VDctIpfK
 rIk8ucrqxq8CFvwl778tPXLeqc8Bt4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfX/cWccA8mu2e+
 uF9tHh8SaQej5loN7iC0zFKw5xPfrw2/ZVzq4PZkZYiQpfYROWO8P+Krb4fFtAlcOIDWSl7AGMQ
 X2usE10ux0hFtxbRUyEHOrpmVwSudP5LinqreKjZ3UbYpKsQhj0i7unYJZAcU8thPqR0OpGa6iE
 f894z7tv+SMT2UQ300WcYhTZH6GNeZQ1xI1K1VgL3bdRTTyrMETHv11omAs1WlzcWVHq/1F+UTS
 cRoeJDVjQsLd+h+8XV4GPkoeSnhCEP9pNOMYvsVD1POVk0PwQC76hh0cXwbh6O1FEAUShYDSSAd
 uCPGxNfY4TAJSIhM91jkTY0hwKJT2IcT8iEtMJmxi0/5ZPyQs8Jg6SOy6vs6p+zIohrnIWj8Oev
 j6JK0pG7v7zde54R1+zNmePivBBLQyOZpXs2dDmWuhKmlFlvD99pZaOSo78QWm7sifBtWkNr0tH
 Gm/tiSSIl3C1xoQKHyw==
X-Proofpoint-ORIG-GUID: PJpdOx1Au7pHjgvBJaxF9FUvYCnpYg0c
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a83e72a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0wxbfleT6UKSQBY2OSAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180035

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
 drivers/i2c/busses/i2c-qcom-geni.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 10c6a4b0b825..2f8237c232e1 100644
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
@@ -1082,6 +1084,19 @@ static void geni_i2c_quiesce(struct geni_i2c_dev *gi2c)
 	}
 }
 
+static int geni_i2c_panic_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct geni_i2c_dev *gi2c = container_of(nb, struct geni_i2c_dev, panic_nb);
+
+	/* Make client i2c transfers start failing */
+	i2c_mark_adapter_suspended(&gi2c->adap);
+
+	geni_i2c_quiesce(gi2c);
+
+	return NOTIFY_OK;
+}
+
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
 	u32 proto, tx_depth;
@@ -1236,9 +1251,16 @@ static int geni_i2c_probe(struct platform_device *pdev)
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
 
@@ -1249,6 +1271,8 @@ static void geni_i2c_remove(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
 
+	atomic_notifier_chain_unregister(&panic_notifier_list, &gi2c->panic_nb);
+
 	i2c_del_adapter(&gi2c->adap);
 	release_gpi_dma(gi2c);
 }

-- 
2.34.1

