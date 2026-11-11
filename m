Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388204;
	b=pBcKgftDu+R7r6gaLoNAGc9AgxbxkbYSjJ1kyeImoBx8GVJfdR1u7vL7CPcmZxR1fMBc
	 YZeXla7yFY4r1FlMjtPouIYz3gZJ8xhC/c11Fl3yjeSxU9b6YjUbDBsXl5PpfdXG37vHj
	 ys4NWPPf5ZdlfNh+Uyqh677ZnrOz/kFzBq358rRxS1L0ZiIIxdz04xOlRJz1w8tih3ycI
	 sub0Ml76kuH2YLG7PwSwJ8FKW5dflIFPWUrZMH+3e9xr/lYeTW/zMN10eGAhv2/qcd9I6
	 ZbrxYRJx0741BhHEtoWTAJW0fZ3rehbQ8KOMGKX/cv8AVT8Jirj5OfT91oEuIHigr8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388204;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XgLnzmBJ/52xSWR2u5GUX3lLfKIgiP3SuFOToBjszW8=;
	b=otWSFI2Q8od0cCFBxZrQ/bmvQBsgoPEf7bSR6RicOWUNFqe5HaxTPJ6OV4gCvR6GerSA
	 Gba1Ov5SlFIVhMEWcBMGshHFUq68K/QnRrSSvXq25KIu0y+a6QEwYGky2tXPciOW6Slh5
	 nSQYIC5wyfaanY47+XllmBfBswJm61G2nhBoGsgcwpjlJpPAWXk1vQNma3oz11e1RAx82
	 ORfx280qncg2HCWnmB1tRKWpXzvn29VyYLCW3S2RUVlTgE7vvqffcZcK75Bqb2wvdmoYW
	 aMREM4tWeU16RiOrMfrj/tsCVaOeTtpQNiy1wWcLqZicH65MWJ7iVQDD23HnBm+I7LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qti.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PcfMw3Ts;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47E60A2607;
	Wed, 11 Nov 2026 09:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE47E60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PcfMw3Ts
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KhYt300709;
	Wed, 11 Nov 2026 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XgLnzmBJ/52xSWR2u5GUX3lLfKIgiP3SuFO
	ToBjszW8=; b=PcfMw3TsqEWkNUoaQZhlF/5ciYmaOxkYES65CSwrrDw0hpdCbQQ
	qSiXPHuN8dwFM9+tUzXpN5XY4QTNScFeYbdNncOUcUV9KUHou4aif2VLO2CX3R/d
	9eTdgbBzUADADT6FCMngroE2zvOCOFbdzUivDObdvvkZQxuoAX8MDSL6EpF5A83i
	0e3DODMm/Ej3R1KMlXtR22QRjt4M5n1lL4UZ4GGZG6CsBALwU5BlWZKZMWTJIk/p
	6JA522YINqxLnRGUBt2N3NWl1ESEQJ7NA7cm20eh7yIjiVnjGQPkS/u6mhKN99/n
	3duzo3ZbyWypdkcnwkS5sPyf+vGU2chgn5w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kfej-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:10:00 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB99w622380743;
	Wed, 11 Nov 2026 09:09:58 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB99vLi2380715
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:09:58 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id DE527AC9; Wed, 11 Nov 2026 17:09:56 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: andi.shyti@kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [PATCH] i2c: qcom-geni: Prefer asynchronous probing
Date: Wed, 11 Nov 2026 17:09:55 +0800
Message-ID: <20261111090955.3378623-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfXwTOC2tRMnlww
 BGFo1tjPuKlbY/c81//bJURN80CB8cjHscl7LRPGuEHShqeda4lhXq8B/RFbhB2pKZwFgMh8b3l
 86Dq4OxxRHgOmk7XHxVul1HrGrGFBtZwD0eiN88hUtOQeJTifPtcqvoHT0iTN7TUk3Igb95zU99
 evhFj7gcRZ2cMv1gzUkd1itsp1utdFA1RQEjn75pGGWFpUjrMGBhY9BUw1NuQJHPEUa7BdHMebx
 dQ8M6Xk4xFFvXwGqlNMsjzezgBVsCkSk2LvR8rIwKV2WyTn9U1lAl+4tUBknGUHKOgs7P1oT6zI
 0AOyZ9dqWu/uda2sO8BEAny5GDzryAg4YVy3rtxwSeEv29GAh7kZRaYfuzmi7rsGr8rX+jul+Ez
 0y2wFtQX9wc2loM5th1JNVYWlx2R+Eu7ojOhjDox9S3oypJGvj1JwdATGSmoBNesIoki8lPRPi1
 yS8ttE1UuA40JCNrHyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX2qych4OhnHHV
 /WA6Uyo6+YUhVAkk9LE3AsQA/NaVYKL3jBhe77Xkhmp7rcgtvLiH+Y+rWLFw/hRMVTlKMAypzPn
 plGL5IWpWOsFt4XFcScCqpAFWmcaOhY=
X-Proofpoint-ORIG-GUID: agRRO3VdptEBKGtr-_9GAs_CicwRMstG
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af430e8 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=OKjm1hKvba8UtKpOD6UA:9
X-Proofpoint-GUID: agRRO3VdptEBKGtr-_9GAs_CicwRMstG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110036

When built in, GENI I2C can request serial-engine firmware during
probe. If initramfs unpacking is still in progress, request_firmware()
waits for it to complete, blocking subsequent driver initialization.

Prefer asynchronous probing so that other drivers can initialize in
parallel while the firmware request waits for initramfs unpacking.

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..13c1ea2af0bf 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1277,6 +1277,7 @@
 	.shutdown = geni_i2c_shutdown,
 	.driver = {
 		.name = "geni_i2c",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm = &geni_i2c_pm_ops,
 		.of_match_table = geni_i2c_dt_match,
 		.acpi_match_table = ACPI_PTR(geni_i2c_acpi_match),

base-commit: 04e9bf1648f846976b543e91c1838a712433772a
-- 
2.43.0
