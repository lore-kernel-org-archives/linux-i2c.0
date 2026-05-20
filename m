Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2A36492C
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261289; cv=none; b=LvuD8hWoyd12ICnt0CvOFjfZUj7t2B8UpREQh4WNDocckvrvW7SXgphbJ9TOO/dkzU5a1B0pyYGNFaYIRhYSipbWFW13oZISto51KZkKAZ0J7qHQuiw0e+56yS7HrWsIBEdjB+1UEycthNZPlw+r/ECQCP+ctoKvdYGvJlsb26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261289; c=relaxed/simple;
	bh=j01mAF2BlRaYdJjrxolhRRNK6s404xsfaKWCuIsdi3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hbBf9aBbMDUZtvm5vDWOMQ7IsE5Jp6EhIvi4bdSQESMQ8xmrASDBlT/Wota1XSBlgjnqfXK7BufDI8MDEly9V1pPXtcOGkULWx9ppUu9Cg/AYdhmdveGxHGS1jYUtyflihsfholkQBH5nGlcBzADUhWOHoBUictOe3L2lv6PiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXFepp14; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIuiX5Pu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXFepp14";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIuiX5Pu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMUDoR2063888
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 07:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JMzYm37TS5IGSik2OF3PJi
	G3o/syaNDnjzGxh1Bl7dc=; b=TXFepp143QeeA9qAqCc8tP95tGoyKZS4EQhEaZ
	twF/NDZi28LwQC3DnurDZ28w+0VkKyuXVFM69kTMo/cjLb9dAKiStCOExSbf61qX
	U2VZgdU8tD9nbwiAI7Uert0umfpzpXMDFOjjvrqYxY8Rcpq2hjpvWRvTTA2tvUa+
	9guBTbISETW7MxPpZWOAWBDkVkp5gtrXLSE9BuP7HuuLhhBb7qAflniu74ISI8Lb
	jl1ffvOwb9RPI2FoKyFKw1PTnIdmN6HkUu0bTHJBkHAGYeaF2zN1tUMULj+4P5ba
	CrxsH11mhATpT/yaTwrOfZ25ux+7Rq3kK1YOSREnCCvhw10g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t3egb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 07:14:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3662668b825so9227157a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779261285; x=1779866085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMzYm37TS5IGSik2OF3PJiG3o/syaNDnjzGxh1Bl7dc=;
        b=HIuiX5PuyVcsXPZ7jZ4flS8sT4meG8mw3gSv2aStA5k5/3COACPWYbgaTnxKl5kWme
         RD4xAtgD+96HpM/mVboaoADeIyaqH4SoNezupFSADGYiHMyKlF0Ra3ozzLoZqGA6Jx8V
         aKTudlvtS//DOGGTmm9XPuLXi0FzTim4DcKwF28Gk4F8zjxOkdJ54bZDfufLVYYzTwfs
         ZKm1GipO0/shQovTzoq6yyohQUmSCDKBZJeMhTYnuCtgcW8+J9c1aHbRvOksQQvq/PC7
         TRoq/K27yAd/y0oXWFed/QCfJfgmjO2xC9bAncoRw2Ei2DQ9FBA78x9dK3L4s4lTqd+a
         s8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261285; x=1779866085;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMzYm37TS5IGSik2OF3PJiG3o/syaNDnjzGxh1Bl7dc=;
        b=TEWEjzyewar6r567Wrr5YRgfDIdtT4EBeUbmrY9DDnHiPpuuXeSGUH8a/QlzF5TPkk
         H/MkKOThIRuAqvcirNbRmZoVjibB06Hz/t87IfVY8yahhSaN+/pVQLQqU5tXkiafqCcu
         VcYfglAN1J40hRD0W9wavEW/SUEvx3I+bdh9r3BuDd+VnuR70QoWYiDVqCgJb1777Zk3
         tFovoMZnsML7nL120Mk7GY8fA53UtROjjwqpwrruuglajrykNbFNyisIeAdSaSqBRbXU
         PXGC18qeq/dTtxXusqiXpQm5zd4yNaKrZanIZXhvN8FBMnK0w6zKrFoayIo3nb2yUPSJ
         VzlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kkCKDD6f+B3oLAtwKXRi/h2UgEb6eyy3/hWMQeGPBLgTZMq3PPPp0qc6yglbfpsMqH4RmG3rPruk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZ9aR4pLEQGgTQkb04CQrjbwB7K8OaavC+73LSNdk0DGqIRBZ
	aCm4DIDOtCYGEEzi8IBwVN5Kl7IKTAHXH6jO0uhWIJF6eyET5EbueoYCTWaAWrCzXd44RwsZSj/
	0t1k2YY6qWb7+b9mORCm34ASsWcykFnsgXuoGnca/yW19k+3moguvfEIlmx61Btg=
X-Gm-Gg: Acq92OFor6inUPwSZN01T0puLdg0GUkGzHCRDoBbsH/Jw/oPIitxWM2xByVJxapzjov
	lTl2PBvUhPzf5CPPCL0tj5A7o1yHDXCl5XIy8Ev043P0nIlsLagOFz3hXHfZYfokxWsgJ5jFu9d
	PpWcv4wiMTdytwn7jGLsVxhiP2nJ/ipout/qRdR+QMuCOVBJvkmgdhLgc+sAoJpkyTlZNwFLz7d
	hyARzImJc/sRrxhniLiUY3gYqgUr94qsS/C0SLzm9CEejgz8vP7TcT4w7SuOyEGGnsKjcytOhNd
	jdQBPma3aZsFtr/5DcRmtdTW85qm9/R8XFe7C286tddt3vImeP3wkiS8I1V4JQC44DBFew7mClX
	DjpNT4d5BCZk08a8X8yaqqfBHMoq1VEKB+wkjv43Cb4+CbWvh7VG1094=
X-Received: by 2002:a05:6300:218f:b0:398:a306:d64f with SMTP id adf61e73a8af0-3b22ebe1b32mr26842098637.30.1779261285329;
        Wed, 20 May 2026 00:14:45 -0700 (PDT)
X-Received: by 2002:a05:6300:218f:b0:398:a306:d64f with SMTP id adf61e73a8af0-3b22ebe1b32mr26842061637.30.1779261284772;
        Wed, 20 May 2026 00:14:44 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb08d06csm18736977a12.14.2026.05.20.00.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:14:44 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 20 May 2026 12:44:29 +0530
Subject: [PATCH] i2c: qcom-geni: Use pm_runtime_force_{suspend,resume}
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-use_pm_runtime_apis-v1-1-6a5238fc6cb6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFRfDWoC/x3MSwqAMAwA0atI1hZq8INeRaSojZqFtTQqgvTuF
 pdvMfOCUGAS6LIXAt0sfLiEIs9g3ka3kmKbDKix1hVqdQkZv5twuZN3MqNnUWVDbbtg2VicIJU
 +0MLPf+2HGD+3wCVxZQAAAA==
X-Change-ID: 20260520-use_pm_runtime_apis-47e99f247d2b
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779261281; l=3006;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=j01mAF2BlRaYdJjrxolhRRNK6s404xsfaKWCuIsdi3I=;
 b=RedlrFg7lmL+r+QqY8uuS9Q0Ppm+8eRV2SFWsKctRFYp9Is8wK5Wxy/svo34IjC0/Z3FKtnW6
 hYEOt+pPrcZDnnRrchbgmLHR+R0a3yMiUxwXpEBTQ6OhurxxIjnosZL
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 8jrZ4_m7n_bYrwEH2B1STqrFOQAnRa0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2OCBTYWx0ZWRfX5hkfkcA7R+kP
 a+RzI9C0zK0mfmddrIJ3gGLLods+Wmi1rjoE0PTMOhsYudkpQRe9qEd9QPJzODGiq37DRbq3y/v
 9GrBpVngCy6m5t88A8ub2OwaELKECJXDET8ZhzFai97erRN3bOAmTbFQZLvYZvge0BzdplnwI94
 eLHhb0+irgQf81cPaPZwq5pQt955Bb/uf+WbRmKqNMF7WtzSsnmRkht0Q+9FSrtTPfkw2VL/sCB
 dwbbukvSgPxsooqXRLFaOV+p4EQgrhYg8zu4fvd+/X77i3STmfJDuXxL3EjDIctYs/3XiFnWQDz
 XRBczwF8sUjrNAdqUaq00VbMVQKqVOK5M7og1bY27syRVAu9cS+F6NzVkgFCvZEnudIHHL14lh7
 K4+LdLeQU6D64fZhM37tas9VOtSLTLQ7bmBo7dqKo0teG7kMj4xsuxdl2Rc7e7pqXEyz0d3bGxy
 FvkDCvHuJg7F6IVSC/A==
X-Proofpoint-ORIG-GUID: 8jrZ4_m7n_bYrwEH2B1STqrFOQAnRa0Q
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0d5f66 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DWeSS0CfW5cAq--l0NsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200068

The driver carries custom system suspend/resume handling that manually
tracks a suspended state and conditionally calls
geni_i2c_runtime_suspend()
from the noirq suspend path, then adjusts runtime PM state by hand. This
duplicates PM core behavior and adds unnecessary complexity.

Drop the manual state tracking and switch to pm_runtime_force_suspend()
and pm_runtime_force_resume() for system sleep. These helpers already
perform the required checks, call the runtime PM callbacks when needed,
and keep runtime PM state transitions consistent.

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..ee04d542e055 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -110,7 +110,6 @@ struct geni_i2c_dev {
 	struct clk *core_clk;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
-	int suspended;
 	void *dma_buf;
 	size_t xfer_len;
 	dma_addr_t dma_addr;
@@ -1129,7 +1128,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dma;
 
-	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
@@ -1186,9 +1184,6 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 	if (ret) {
 		enable_irq(gi2c->irq);
 		return ret;
-
-	} else {
-		gi2c->suspended = 1;
 	}
 
 	clk_disable_unprepare(gi2c->core_clk);
@@ -1214,7 +1209,6 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 		goto out_clk_disable;
 
 	enable_irq(gi2c->irq);
-	gi2c->suspended = 0;
 
 	return 0;
 
@@ -1229,21 +1223,25 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
+	int ret;
 
 	i2c_mark_adapter_suspended(&gi2c->adap);
 
-	if (!gi2c->suspended) {
-		geni_i2c_runtime_suspend(dev);
-		pm_runtime_disable(dev);
-		pm_runtime_set_suspended(dev);
-		pm_runtime_enable(dev);
-	}
-	return 0;
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		i2c_mark_adapter_resumed(&gi2c->adap);
+
+	return ret;
 }
 
 static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
 
 	i2c_mark_adapter_resumed(&gi2c->adap);
 	return 0;

---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260520-use_pm_runtime_apis-47e99f247d2b

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

