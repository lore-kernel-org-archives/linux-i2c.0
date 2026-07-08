Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C953BB111
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491332; cv=none; b=jxbIPXd53ZuO7EVW/hGjd/wAiuIRfFIvMS8jx3kooxhKYJVDW/G22LJEtTVGyoXBF3t4kFTtuytqIiGhSlnwfocKvxV+hs3A2zjyU5w4YHbUsY6MN1BJTuef3nSVroq8IRqfLBjhCBMz23LlcKh+IT6r6nfy82ZAy9nvAlI6TMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491332; c=relaxed/simple;
	bh=9K6vfVzhKCXdUq4d+j4awQs9fiw6bDpb1vMBeRfWLJs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NOFmL872kGHEEmrbB/Im/CN/tc5RYFDgzwTrAGiIbmIzUUTS3Zf38C6Cv1sMzdkebzVXZZJwq1hxpDY1hZxOTWRS2LA6sQ1QZnwXOhNRu/ZAgvW1ulEmj8tCXAlMghmQvnEJvNi9AuFDbwSYvHy1ML++lJN11ANH0vQT537EC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afY/+KNc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HhqLMZxP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afY/+KNc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhqLMZxP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842XV71447584
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 06:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lSi54AxqGvoG4nwsPTGBrX
	UBt+OSewX4NiNqyYTnmXk=; b=afY/+KNcy+RHl29RzvqTkbr0Bq9Uohd+AlyT9R
	rCl0ei/p0nsDqOc2yeIUfuVNEUXLb34W3ISjULqZGnMuA46RGqjNZXuzydwBYqUi
	Bs6IYVkOcAIV9CxcZv6SxcpOP6H459CWl4cyY17FmzAaP9iZ1xfM+5PYlLtWR1eZ
	78wouj2UYGiuoxS+IahvpvO9sB6kDTWY1E4J6W5GsLNT35fTDaGIIMUBHpvu3IWa
	eSem5Sapbli8OSOTLeEfu1NUQv0RV+8Kr2SllZk5MuSSkf4XbA0dzy7/ruBr9XXN
	mbngoo4G0Rc/FxwBKkjY9SUZIb+WbZG3l8DIPKd+jnYNl7Uw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11ybb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 06:15:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so9771965ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491327; x=1784096127; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSi54AxqGvoG4nwsPTGBrXUBt+OSewX4NiNqyYTnmXk=;
        b=HhqLMZxPoS71k2s2o7Rr6pNGTgpuBKBHcj7HKnmKTnUf+5gOEkI93NdWvwU2RQCCiL
         RJVfhfV+nEMCRVMp2w3kTIaMs7kDAPaXB/E7PSm3Z3UNKz8WZHSUesFH+CcRwgtl48E4
         NsDg4dEIsznEejZ4yQRWYz2QhoUoTfcu9G6p13PyIuRPqIS2c1B3sAhp5SUkyixSpMXt
         mrmC6whsdjHJUd8xVx3HLtxVvBUk6yAjdKKrGtD4DsN7CMGywTBSKav7eJ6rrg+IUFBy
         d28JqLi9TzUdXOcPLM7F4tvV68zMs5NH2bqu82k1OzlI2q2Z3t/Oa5apoZDJ6BbAqCiX
         MmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491327; x=1784096127;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSi54AxqGvoG4nwsPTGBrXUBt+OSewX4NiNqyYTnmXk=;
        b=Me2raTrqoEg/svmZpeeodsfhPOf5dcm4bZDIzUNAQm9mwqAHFl/gpByuru4VJO0Bmk
         w6GSe8mAdhIFuz37xgnpckYvQIaVSVFVv8XFMzmPdmItx7ZTOGgCnAEy1y3+ZkdFvjID
         vEOufoX8O2StKb+2BHcPLT5E6vB1Ux3+ER8dfldcnlkQvBL+0SStrC8S7r0rX3oubvNg
         n1gIzrLPJWFt/iL7/2zsfxHZH3czVwUfrsaTmDnF727p8Oiq5P4HuViYtOeYcSig747V
         26H6kMeMCkC43czG0kqQAL+35yeXDLq8CqbLB6FmTY8X96dLBOve2UXyjeApTP0sAb5t
         o5Eg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ1Z+A05nkD/kYNJUVw7S34ZZcpkZS+ydYJIEvp2bx2beVUJG2MfOAjQIrXfet1E8JWXcM/hE+dJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8ZxB52S2SgbVjxR3fNpFKwyKvnuE8srKgAUh/3lZ9NHZRESz
	WpucdfTWyNG1iTCYLw0FHWze+fx3pFyozuaajv8CRQpxZMc88O74xGeHlviXXA+KckRN1ZaDioj
	5FWbBp26cUZrnpWV3wo+Bkqxyrh+oxsGIvgC9Q5wC1UaRoYtJ7Zy3+y98mzgYJ0k=
X-Gm-Gg: AfdE7clTzoSjTl5ogHevns9O8Cglw54GeDL416x6ZDNeH6xAwOHObSNaB/u7NU8JDnT
	C5mcq8gWEU2y5hwEr0cUhF+mAubdnhs0UlSBuy/SW0QMBNHmz7ZHutEvSgcN8mmentpD0J6NRZ/
	/GPiml0tte1TipIoTW9kQCnsnkngZyHq+9Biq2wiFy+uFnotElOLKxx1uyftb/FqYlJ/BFFVx/T
	BkThC+Ml5rAVR/J5ykZDA98a6BkJe5jONyydRaOVXj6Ud5+u2hmUoz5B0jN1qI1z4uOcrp7a1kW
	HdaGQzXQEPbabUpB2mhA7iAe7lE6smzZJaHOuTfof1Hrg+91W4z3Nxaquo4vpEmDG1f6YyAb+HY
	2CtKTJCwFKxdensZENfwR6srO30Y01Pa/6eSDOD2fWJVM
X-Received: by 2002:a17:902:f544:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2ccea45a730mr13677395ad.34.1783491326950;
        Tue, 07 Jul 2026 23:15:26 -0700 (PDT)
X-Received: by 2002:a17:902:f544:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2ccea45a730mr13676965ad.34.1783491326340;
        Tue, 07 Jul 2026 23:15:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm23011555ad.4.2026.07.07.23.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:15:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/3] i2c: qcom-geni: improve transfer error recovery and
 synchronization
Date: Wed, 08 Jul 2026 11:45:20 +0530
Message-Id: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjqTWoC/yWNQQrCMBREr1L+2kAaaVO8isgnjRP9UhJNjAild
 zfqbt5i3lupIAsKHbqVMl5SJMUG/a4jf3XxAiXnxmS0GbXVexXkzd5Fj4ULHhVtcYocnCw1g0P
 KLMYrN43TYPtgLTQ12T2jPX+h4+nPpc43+OfXTtv2AUPV7NSKAAAA
X-Change-ID: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491323; l=1250;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=9K6vfVzhKCXdUq4d+j4awQs9fiw6bDpb1vMBeRfWLJs=;
 b=ByQSfggJAKnfZGu99/vRYzT8lR2KjfeA/l3UmxBvKRlsx4kcWYm3MTbHzzrlBEpwTHn53s7y1
 qNF0KANZxkjA4Kq2ZyrCx9Cnu+bQYx6c0OaHxka8ToyX54ucpgV2bY8
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: 269gZNV54uaFMW0sPaieVs0l45taX58X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX4DwjWIoFpMxP
 G0C1Xm+VdmUY+mVYGgzw7UcqqQSh5o0FhYtA58j9Y+au5CWj8Y49F+H8FikzqD0YYbB09Q6msjM
 cQKv6Lst9dohxhBODnmGMTfdeIHQJIw=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4deaff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=88dMlJQ2g5BURVayAFUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 269gZNV54uaFMW0sPaieVs0l45taX58X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfXzZdQ255HN2A4
 X1baaX2PmjEP29NcQ/OngZZ5qJS1+/3NJencz5WrKlyoTHvs4Wooj6LrsOwbN063auKhf8Bzwv0
 sInisl3CE6pIFp5a7f/AT2k4v3ocYksC+Oyc05BcnfzW3XrAq9l0DO95uoUE2rhm9BIc2KbTkrJ
 NemMmjr4DIu2icLIcBZ3UyJ+OK9CCqiCtFX3ybz5UaErj4OXaa//7Dj546Btg1+rm/LHtyxlJ4s
 HzuSd8AGC/dIzT9tZ+DlzzS2RzXYgFK4iNbGsjsLt6jwy1uOMDDDndu5h1OX7oeaGneEHyEPWQR
 Aolq/Dkg/JKuBbBAwca2ma7pNnen7GyNtZ9UULkg+BftskGQmcn4j/VmB0X6yCw4yi5F/vhUbAR
 /PCPLqVrMcAqoddgxumdSmNrOEWsIWDV/nx1TkbOY/OeN1llr+Kfj2XbdEu2Evrb1mA8gf7Y1Rc
 uJosOfHANEFDkfrT/TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056

The GENI I2C driver currently has a few issues in its transfer recovery
and completion handling paths.

The timeout recovery flow directly aborts outstanding commands, while
GENI hardware requires command cancellation to be attempted before
issuing an abort. In addition, multiple operations share a common
completion object, which can allow unrelated events to wake waiters
prematurely and lead to incorrect synchronization.

Address NACK handling can also trigger unnecessary cancel and reset
operations even though the transfer has already terminated during the
address phase.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (3):
      i2c: qcom-geni: use cancel command before abort on transfer timeout
      i2c: qcom-geni: use dedicated completions for abort and reset events
      i2c: qcom-geni: Avoid unnecessary transfer cancel on address NACK

 drivers/i2c/busses/i2c-qcom-geni.c | 100 ++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 34 deletions(-)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

