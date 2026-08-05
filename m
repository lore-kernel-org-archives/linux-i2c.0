Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2103E0082;
	Wed,  5 Aug 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913229; cv=none; b=ph4D5uQozAGhD1rLI7HoJhugJf/f0vPXv4toJFWWtl+tJ0NjoY+etLsZY7A40muvxTxF4A/J6ZVZeR3U/ntNWuyzWVKEyDfGfsriBJCatL1vaBdPAF56zqfsxb/iMe3qJWzFHHaXFf3+0Av/Gay6UCZT8/g4pmRTEvDmsUFohiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913229; c=relaxed/simple;
	bh=o0gcl/cxZiJ9EnBLgc6IVLZdiTRmnE3OfxdUQ3fdnOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1DJvJiZRy5jLkEDkmB9MR9iLJEO8iZ6m+pOJxLo4/uUIrmCr8sNEPUmLI5xmmE75/dinCN+KYQY/Z8/Nk3TPDqqaN1GrSFaPxxJtPManBCzVEngBMd1X3wExlpefy6ps5HulqvOsQdUnKGX6HCnZwn7X5jLcDwGTfL89mfBuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gXjmFGVu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gXjmFGVu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755l1SD1736570;
	Wed, 5 Aug 2026 07:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1KkRUZhjZdUc9icajjTpfpQrwvRmt+/fArs
	WkRDesRY=; b=gXjmFGVuF5Q7WKQzqv4DCCP2ILan9P/AGcf6dKz1yapKA66BT0c
	D7UVOJCpnMAVEDkTaUDF/dKZ6u2kFwMx0/kSBuIOsIFld+y+gqbVOkLhkiW0TsTA
	zn501tjsFFyXzdQ4WvM8sftdyWsW0ua76Bv4yrZ2hh6bt0aL6ckxxKAneOEimidV
	JFAgkNll3s2gFI3KKp4DesloXa6jetkyOx0nH1Ah1uXW2rHyO+ApVaclYAaseLUy
	kzuFonpGnsSic6VUhBfvwMpqF93YrKlxb46y0FK1989DQ0eYvPohZNS7AQPoidkw
	dJPrd6oRocoHukIZqZbwjgtXFhcvHhR3LrA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum56b54k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 07:00:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67570LsL026833;
	Wed, 5 Aug 2026 07:00:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fs9vjryup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 07:00:21 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67570LhL026828;
	Wed, 5 Aug 2026 07:00:21 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 67570K3c026826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 07:00:21 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id CF05221C15; Wed,  5 Aug 2026 12:30:19 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        viken.dadhaniya@oss.qualcomm.com
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
Date: Wed,  5 Aug 2026 12:30:13 +0530
Message-ID: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA1MyBTYWx0ZWRfXxR6FfqYJLm6j
 V37em/+L5s4PMmLrfQ9mrMK1eQpvuiZRyzXxIClL5o+Vv9OIaP3a7asjTY4J0c6lot/VXNvX/fR
 2ynxbRgrSA875tJhYAY+ZVIDzj+VP2N8bNFhLEDtMm7BoxyrIfJkDgJbLqa6u+v0owUxakr23wm
 hFr1+dGqVmOsIDNwNiT0nIEqsCLoLXM9pNLOZ9OxV+u+DoYa6U6ni9Yjrs+ER7xSE6deDaGpeZi
 iyirrn3i2kzfVEBEO6rBfxZrtnBUfxNoFmb0bE7ggOb9jvhOyPSPQCJ7umpDpbiSkmpGTwf5WLi
 TVXcuMfNOCDRYKt9U3D0VB4XH3aw3NAOHkYhnevsr90juE7NdaRa2rzJ7+bkRzf6ZQoJ/DJdCpu
 UAGyPiSRjWxrF2tGBhX5zp1GRkF50KsSkMJAWqkit66VUKGDZ8ZO9NUoNJ9HQwpR9+qtFDNhprH
 V7HPA47zNxHQRDt9CNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA1MyBTYWx0ZWRfX9AFUvSeK9OLe
 JHZln3GLX/YuSFkYehwia+tKoYJCVriiJWOzFyNc03+6RrtH/ZFfZMx1T7Hru2YaAGYeQroGiQn
 kprGSubLCz+am78yUg31aSmZwcwQFac=
X-Proofpoint-GUID: k0hc9K7KD1cAKUpQip9clDV_6e6vDb5t
X-Proofpoint-ORIG-GUID: k0hc9K7KD1cAKUpQip9clDV_6e6vDb5t
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a72df88 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=aadtU-L9OLO0_X_EjZcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050053

The driver currently logs pm_runtime_resume_and_get() failures with
dev_err() and returns the error code separately.

Replace this with dev_err_probe(), which combines the dev_err() log
message and the return value propagation into a single call, consistent
with how all other error paths in this driver already report failures.

No functional change intended.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index d5c977e34994..96015e077b69 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -994,10 +994,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	int ret;
 
 	ret = pm_runtime_resume_and_get(gi2c->se.dev);
-	if (ret < 0) {
-		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(gi2c->se.dev, ret, "error turning on device\n");
 
 	proto = geni_se_read_proto(&gi2c->se);
 	if (proto == GENI_SE_INVALID_PROTO) {
-- 
2.43.0

