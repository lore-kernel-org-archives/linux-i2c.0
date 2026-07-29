Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E543E5A0B;
	Wed, 29 Jul 2026 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310261; cv=none; b=PWn9gTDZgl/hxea5DTgENtWT1HibDPXxqF0rQQo2Mk+WiOIeE9hr6ph+WkgzTTNWpss5NAYY1asAeTVQ2rnsrM6dGOuX1l/lW2KCx6S+VVrEh0qw6ja7l1UxnibvaT6HsRA4mQGmM971oj5g6wpQOrjsyp2jUyn7IWr9IV6SOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310261; c=relaxed/simple;
	bh=TrkPsdHifxWxlu9JPjHwoslczde4iSfr9O5NgjlL5Hg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pluD7C2kU1t80c3CH39EcPvNhQNL7thBHkTuH/6Rq2AhqTKknrTcQ7EXnGuDXMM0LbsxHf7vS3OO8OgjERG9WWxrLUnQ8B5GynMPp6XIiRgs2+atCuoWJUp959bOgKlI7TceFcmr3mJbDiL+Wyt++iWvtWeUk2ry57oFzUH6ls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6/eU71b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6/eU71b"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4cY2P927380;
	Wed, 29 Jul 2026 07:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=P6AdHUCVESn/EVbc2I7mbpWhfPePhUFunBq
	8rmD7ZnM=; b=E6/eU71b/c+mBYgZVrnaYs6fGxGtAowP9v+cJOOIOglzpduWP03
	kYD4TegWFJABfYMnKuLykFBWnt72nKAAfGWD5A6ifooF0SfGrbe30NKA672fo0iI
	S9jhloiTTZAHQ1s+yWCrTROMxLawYGvUdE+BU+D1qbN224SNsGIn+zEnMJhXPy/w
	aMgov0SC20tE0/rj5rcLs0E9saHyw+3GjQeI/iXLsmAm4cpl5XKjaJEYZlGbhqau
	AOrilNHg2naPSKNQtC0taOyfg2B+A7cnH/yR8cSOruPBifTMK3GgQCqRHfRIdKcl
	3GVWW6Eo7uNH20GZzbcF37XL+596++9vZcA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq0q6tth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 07:30:46 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T7UhVc028941;
	Wed, 29 Jul 2026 07:30:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fmp7kfw0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 07:30:43 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66T7UVD8028849;
	Wed, 29 Jul 2026 07:30:43 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66T7UhRf028935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 07:30:43 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 641BC21C25; Wed, 29 Jul 2026 13:00:42 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qcom-geni: Use modern PM operation macros
Date: Wed, 29 Jul 2026 13:00:40 +0530
Message-ID: <20260729073040.3227692-1-mukesh.savaliya@oss.qualcomm.com>
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
X-Proofpoint-GUID: aw549fz8nAiDNTslH6fvjxMlrsv_XobR
X-Authority-Analysis: v=2.4 cv=DqpmPm/+ c=1 sm=1 tr=0 ts=6a69ac27 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=0KRUuRaIvqVBs3DjABkA:9
X-Proofpoint-ORIG-GUID: aw549fz8nAiDNTslH6fvjxMlrsv_XobR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX2cACx54bdrQ/
 q/3Rjg0lrIvNt3QBsAyRNRIWRVIhoB1lT0x5V/J4iNAZeyaU7LkrU1oFRRrf5TFeZA8gB9w9O8V
 hDoxLw6rg9z/ogTdzE7K92WAIAjxJSw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX+xOl3oD8wWOZ
 CRIOqMHWh4uCtcRwjBYC1RG9HNqyzPUzVvFUbB3VGhXNE3Z8aLx1T64cX5DcYviFCSvIRK1B0yF
 Jc9bQyKmJBcY8SQngNvU1CnDNQeIngcK24An9PUiP8nB/+cFrkscIxA3ipB059lJoP2+95XkENd
 3FORRVwcSiCte3x1AHQm2yDWE+6Pq7iXjxBPMwLWgrGMA/Wh2K65TEE67+NsIC4oGqiHkr3t0Fu
 HMJVvDk9wcm4vjMSy45OAoRVjrjPeLFc8M4cV2t1mHwP47Q1gy6triYXDpwVxokjJV3dyDHBmxj
 TcY5oOyJtpX4UBw36WW/OiekSK9ABYusSuXymZZ/t8HX+PlRb/+c84vZ0Q+Z/5COAfmnT7CIZoG
 xfWTpVYwZjhXpWJ20EZ2VoEEr+GEjKdeFz7zHjZzvxsmOCx14BxVqIyHgExpALcVwxEdyhHqsUq
 +zeAZIVblXf7oM9RaCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290059

The driver uses the legacy SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and
SET_RUNTIME_PM_OPS() helpers to initialize struct dev_pm_ops.

Switch to the modern NOIRQ_SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS()
macros instead. These macros keep PM callbacks referenced by the
compiler and help avoid potential unused-function warnings in
configurations where PM support is disabled or partially enabled.

No functional change intended.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index d5c977e34994..71ae821dd147 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1163,7 +1163,7 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
 	i2c_mark_adapter_suspended(&gi2c->adap);
 }
 
-static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
+static int geni_i2c_runtime_suspend(struct device *dev)
 {
 	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
@@ -1181,7 +1181,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
+static int geni_i2c_runtime_resume(struct device *dev)
 {
 	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
@@ -1197,7 +1197,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
+static int geni_i2c_suspend_noirq(struct device *dev)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 	int ret;
@@ -1211,7 +1211,7 @@ static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
+static int geni_i2c_resume_noirq(struct device *dev)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 	int ret;
@@ -1225,9 +1225,10 @@ static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops geni_i2c_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(geni_i2c_suspend_noirq, geni_i2c_resume_noirq)
-	SET_RUNTIME_PM_OPS(geni_i2c_runtime_suspend, geni_i2c_runtime_resume,
-									NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(geni_i2c_suspend_noirq,
+				  geni_i2c_resume_noirq)
+	RUNTIME_PM_OPS(geni_i2c_runtime_suspend, geni_i2c_runtime_resume,
+		       NULL)
 };
 
 static const struct geni_i2c_desc geni_i2c = {
-- 
2.43.0

