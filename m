Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42A3431F8
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827280; cv=none; b=JgAvPvSkhnz0n9m8GhDsNvNUjncOH/mLS+mELp1tH96GiYe4s+/wqYRjE5n3P3etefPUZV6ajw0jZzES8g25EvqSMphJz5xP76SgnuO49vCjS4Ct50NbxEPlesnmbvt1BChCwCj98gkZNM+j8hiwbbYpSYFj4udC8ptKDaXBy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827280; c=relaxed/simple;
	bh=Q5L6F3y5YYrpJvuR8h1skYv9DtKr1aU1rVKze+Cw4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE2C73lzW4hNJCjGxIlmKZ6IOdczRkX4ItkfLdUMjonKcwnKJEhxepte6L1kgO6I1KQRXQR8F/5R4VEf/J8qVhMFcAxcDQAZ74ekNrTxGfD4ARIx6fXerZU5kowpaECehR0/Fr3b0N1U7b7n4kun9M3I8vKkXwTdLP3wgYp64ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCo6XeDu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4MnvpuJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCo6XeDu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4MnvpuJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JDJogV3063592
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 14:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vg1Pxt23ysh+GHQlArRexPb5cSwK0994P+V
	BXsKz6SM=; b=gCo6XeDuZQHxCDSA+HEJga/uYD2G5VsrJalhgvZ/9/YhJRMmBOq
	NKqb0avNbFLQUHGMEUD/Pgyflp82dr0ZuMAY69hKonr6dXZWoTGs6dT1FEDuemAw
	sjvh1iKIHqtclvMFuJ3VXVtmxb9SAlTn2yCELNg7T53fgrjW5wreplZ/FD3lDp2L
	zL9aG4HVHD7g7MMfAF5jlkfbLlshBKXwLZm4wbwkHY5NsuyGmJR8K9NXjAYeZsrS
	V5Itp1hEOV7aZjKH6fQbojfR8nkEtqb3HXaudlxQXz/Mzc2VU/WoxmJUatdrHxEr
	9rhASFePuVt4IYfy7pFQrc22w4hNNMli2vg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskp9rvqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 14:14:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f248907fso169922985a.3
        for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789827277; x=1790432077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vg1Pxt23ysh+GHQlArRexPb5cSwK0994P+VBXsKz6SM=;
        b=R4MnvpuJgK103WZ3ka5OWmJDHEgDXymvyQuIfXeMdZszGaH/FasiVQX+IfbIH2B5z4
         HZ8xI/spHoMdsB0VMUyxccKFGvMAkiBkDZzGGV+SHM0ffP37X6ZCvqRIBmcocx1FV60W
         fzHxbmmF2wQV+lj3jUQomCpXyOchHnCgUctJUsM2C0TLkdEIyL12ktQ3nWH6ihdWuWhT
         XzdffEQFq2+zYAY9rWsmL4vICQvsXLdgy+CvQl464V2qTWa4sKV/RJKMzXZ60Kt6u8HL
         8MCQLLMMSHPrxerI3hAZeGj17ZQSCplBt92WbTjIp5kTXsm6Uk7sB1+vNWX+OM/6JlwI
         /EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789827277; x=1790432077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vg1Pxt23ysh+GHQlArRexPb5cSwK0994P+VBXsKz6SM=;
        b=eKc/Ch8htnzvo+TTI/ZxDU0Y/eZdeGk/M5YNPN/+niKOVahyOrUdOxqTm/eDkuvkmd
         VhXQoCZd98kJIDRiHnAldKhlFsjXQa+GosiNxmqWYO+xWuBJeI1Z8SSxkV3BWwZyS2Qt
         IkulhPGkTaEO+6YA6tFQN3wfQLjXkYjPCuXoIRli0mbDUSFE+zbFfDavlFhvBELAP2rz
         KyZBMmpfBPutPiffT4q0+5x8rfku0PRjMWrztSgjiDQqyQEzvOuz7oSTzz2iECaUoMeA
         gv6bYgR88XtWbKSnitI4YM9BWNRLEnzOv6ng20Uor+miLkArku8xVq1lJmA+4iL52KEB
         5+qg==
X-Forwarded-Encrypted: i=1; AKwUvBzpIu032x12KG/+6n3ata+XQPAP7w0jj96BZbc7qebO8ZxGO3CTaunLbfSakS9y3FWVKngvJH2iTDo=@vger.kernel.org
X-Gm-Message-State: AFuF++lnaUvH1ngTuOddgMtQ3Frmdi9v2Jb9kqEToVxL2JZfWTNVCY25
	cFUgB6/SLfBw94a3iz+rzS9h8dMGums93WdStWqP+ya/tY4FdWR0bkdg3JiUlCRHd5Zn9pGBjPy
	y3VS+2173ZhYr6YhRpVkDcQi9zwxrhLwbpgS17+PlyfbARTFEmD+JhdrXxPIRCv/EOEgE9qI=
X-Gm-Gg: AYBFou1ok3D4QsjbVOeO+a1N9u8MmSNCighXvzBmR4bJktFkW37YiwdaZWtGCQm9hmL
	Y2i99l8a9myKszkdpKy7AAVeQPqbzUje35RRNItUkflcxgUX+BFQYVp363+ZVFIAWdM364WZPtU
	B6myBNaJrTY1tzclQvb8ylK4m6DDDac2Z2WeQind5741hOiG0tr8o3gTqocrSbchgfQUntjKfGp
	QSeXcK16gksIDrfQArdH1lxAdaRUor71hpTx++Ikf41zSLDFtSBBCU/iPvVXYhr/+C2XgBUJgFZ
	fWAfWIbosxg5FS33eugKw04vq7mLx78jPZpJFHbmnlDxr1iYe8aPejVTq9fUkINhMz4dvLEKYTd
	leIU/B9IfPjXfIjPnelzaea3EZ0di0PvAQ5/nm6eOwiDNLBNjjJ5FtlvjXg0thjgYsv43J7xXcw
	NvBn0d1zNe2llnRKE=
X-Received: by 2002:a05:620a:a0cb:20b0:93b:fae3:7fdc with SMTP id af79cd13be357-93bfae38002mr16672285a.71.1789827276472;
        Sat, 19 Sep 2026 07:14:36 -0700 (PDT)
X-Received: by 2002:a05:620a:a0cb:20b0:93b:fae3:7fdc with SMTP id af79cd13be357-93bfae38002mr16669585a.71.1789827275781;
        Sat, 19 Sep 2026 07:14:35 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358e31fcsm84307866b.59.2026.09.19.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:14:34 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH resend] i2c: qcom-geni: Use device_set_node() helper
Date: Sat, 19 Sep 2026 16:14:34 +0200
Message-ID: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 08EbPjWuDMmHH6QZ9ru0MJjpx41Dkeme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDIwNyBTYWx0ZWRfX1jBdC+D53V7T
 G5E+WTkvCTeQmybcpXENH6GIT69oVMAKLepsqe44yW1nR6Ine2HN/UvAEDnp8fOj1vCrY3sVmGR
 /OSmCkbOV6UrxwCg/yznGp8b4GP1F2kYETAS+PFM0DQ0L7KmZAnyaGOIlAln3uW9L3n+mxSyhet
 0a/ANgDYqbmr+3HzyFxxCDT3L2U3y8IeGejZymqEMQsA7K1XSxgASD53RqlOptDOhYTnd89WwRA
 LUe+Ich3iJZnn//hG8yz8muWIOpy1HtnYhsouFgWCRYgvmneV3fbs2bsNN5JXvULch2o0JDDOd3
 3LL5s+3eN3NK/WH74QmZfs04GGX5oXowrkaiO6QLxSWz2+TwYCk+plJ6Q2wNgBx8EXHM+P3CSt8
 /ZwCXa72uy3BkXy3jC2L+Jy3g8hVzpUZRVzNShjO3rXR7x25tJ/4nAPgYQ2PPqlcqD0QhSEo5Ly
 bEOf3jPe2nbywu0Qa8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDIwNyBTYWx0ZWRfX8ImWZ+d3KIjo
 GlSEQ5oh9ibzy7mWZt5ggcNrGfEfkBjr5VDgrXnytB9X8wCafsZ6BB5QfDYeq+l1hpkB/G0g0Fu
 OsoV3DU/fNlgTntJGdRHo/AxAqwKmZQ=
X-Authority-Analysis: v=2.4 cv=BKAmP1QG c=1 sm=1 tr=0 ts=6aae98cd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=2VF4tGTWRqxSFCeSHQ8A:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 08EbPjWuDMmHH6QZ9ru0MJjpx41Dkeme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190207

Use the device_set_node() helper instead of manually setting
adap.dev.of_node, this:

1. Ensures that in if he parent has an of_node adap.dev.fwnode also
gets set to point to the parent of_node, rather then leaving it NULL.

2. Removes the need the specially handle the parent having an ACPI
fwnode, since the generic helpers take care of this too.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 00013b41a6f5..50d3a48a4644 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1145,9 +1145,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
-	if (has_acpi_companion(dev))
-		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
-
 	gi2c->irq = platform_get_irq(pdev, 0);
 	if (gi2c->irq < 0)
 		return gi2c->irq;
@@ -1173,7 +1170,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(&gi2c->adap, gi2c);
 	gi2c->adap.dev.parent = dev;
-	gi2c->adap.dev.of_node = dev->of_node;
+	device_set_node(&gi2c->adap.dev, dev_fwnode(dev));
 	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
 	pm_runtime_set_suspended(dev);
-- 
2.55.0

