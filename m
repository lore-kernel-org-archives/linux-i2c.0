Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F129B78D
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764806; cv=none; b=A348Qq353kqzz49B2A9PCPoqd/Uw2xLeGXSaXw8WD3QpV7EPyQOxFi+CQzz9fTI97O6U0UMtgXIOBvM5I5nBqWrMwbcpunpdLxqHvSZjK9EpUYLcYzo+L5/w1PmSy2fPgJ19UGoeYlULcUolDVGiLNDOJhqjzyEIXmbfUKqwYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764806; c=relaxed/simple;
	bh=wv1LRyJF436NBZkqYSed99dO660pUkPBSqfpXcjqKUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m/WyldqWBA424Fwrwt5Hvg4nZwkGemDBvgQe+lzzEf8ovZfAwXeP+grOFnry4sM9O0ITPBiXbJWknsZMOgpOh3gjLJrGv7b9MzCqYYaLTS5pNa6XKFJqVVAjVtjQEtyLbWOwZReXk71awf1x5ywzyD+Q6GKOyBPHx3mUrPF3Njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0cHsH5M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cj4ti7Zz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0cHsH5M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cj4ti7Zz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGunSU1310543
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 17:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tD1u+02Zr5j6+6GAngHUQW
	gDuBEpH+yAUOjfilb1Lg0=; b=i0cHsH5Myr654BX2GGBptirO3vrAjd5cAQBJde
	uVVvhy1rtvbnlMYolAarMYZ6XyeRnV3FeOqDhOryG+ENNmT2WIvGX7mSDS77nSla
	sr51ENigQoc03d+4PlJt3xh4J2tOjCphPQgj1kMcDcfnVAOVCwRSFbKHJBFgDnj4
	ROs/r1Xll35Buy6JDnqQCbWU1lS86ti6bkHXnG/1w5OU0gIBjIAHNnz/Pt4rtvSL
	wj0JNOr80ZYXLoOdp/se0IIzkpDczg9z5idEWeBFkmEx/lXL/VY7eU3Wz2vf0wND
	NrhBlSp9b4HquIWJwdXo4QCCV1bkhsJhHGlRAjzGcFA9QzWQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a96tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 17:19:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so1389368a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787764779; x=1788369579; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tD1u+02Zr5j6+6GAngHUQWgDuBEpH+yAUOjfilb1Lg0=;
        b=Cj4ti7ZzjmDqvnae/WtTN5LHC6F9Md6SXmtHcIf6UN7i6mbynf+yjI43R+neoAcy+x
         kHCtAjvOBVP+2fw3uskRFqM6YDOmvw/OgAvVclr95pmcONNnUbOJplvvubBcyUEA2ppO
         eiNCsXnJq2zxRpr5tniGPg1GbjkEkecZLhq6nGNk5NoWZ4i4/l/6PdYezPWULJAWSFsC
         vkmq0ZbpORsc4kQY4UuHa4bP5TlZMRP++xQjICtNSeSCu7IMe6YVB/OyUP7ldvWxFFXe
         NaIhovmAS55xe3oOlR649oOC7kvSRThMdMRmgx0WQCqcqwRefEUbMyrbbgy/jhHF1l7h
         FEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764779; x=1788369579;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tD1u+02Zr5j6+6GAngHUQWgDuBEpH+yAUOjfilb1Lg0=;
        b=VepxYfZNxy7pEujyiCAznU/Zc7bWFxyZzssbnF6DYt86QcGIe+6ZMMRIB8SftsdXfh
         nLPgSBBlVH96Zx4YBYDD14K/GXMcXFvSV5dJy5U4qqGVkefDh/ul16WUwTxCPJgnjC4F
         Z8FZGK02KDEilPDEZGuOe21uVomMeSj8xYwcd4SHY6P0PIwsDQSk5+2xjjv+GzBJzot8
         Z8Ox3DTI7y6FAhhdiTrCj7qx9RVeVblRFhnthVu6PDEfvIF2ujwADo/T8xWQbc/0wtQy
         qpNrC2pp/wHsgOjEeChv/uznbXJ49FZml2ARyoRW94tauFwzqVFKOZsssF7SALgHJpwY
         cp2A==
X-Forwarded-Encrypted: i=1; AHgh+RrrymvWISCoTkSteNyVQFUZp3Qgl7d2TfjUiOZCjxSzQ0Rhxrut0V87ZROXTr9cggC0RHKgtWnLRbM=@vger.kernel.org
X-Gm-Message-State: AFuF++l91e872uEojtvrcfY6Y6AuIxqHeomJn2wJ7BGVjh0HBX4vEXSJ
	2aUzwmHUu+G5cW2gnxdc1lOgFNdCZegAlYra4FBk32dvkkxwGkrYY5+Jnehx3DGPt90SEVFwOOH
	wRtqOUY3rcEBmF7Vn5QsFDWv/UMza97Ksm/vlbaKb4gpbmOiflv/yQu+FvOe2FJM=
X-Gm-Gg: AR+sD127d1UfwgkregVRsLoI3/hkSGsTXkDXjLBAfWzMBsaB5h6KmESaXOwsnjD2zc5
	cOuPOcjimNnhJ/IKVA4P265r4WDp5A5qRSbTm9iZIJMAs6xWfT2Upvm0K5XUbV9iq2Iq4QnSCJ4
	mDeSBsICftszyU1Iza0Roj98k3gXFeIgtSv6KG93AE19oj5cYE9e4MzowkevT191QtUgyCx2jEC
	XXAOkT1m/BXj/Uz5rTiJKS1vJ0iEnHhYZJcmPtipYol6VYBnJy36QV1souzrK8OCc7k+Qf43zLL
	Yjt1LnQeMVQXuO6JptcdLhveZ0HFcnVlA8oeTrUJCBX59T0VrUv7Qnt6u73ICauHsbVai/3V7Mw
	JRPenTjFq7D1u/hyFfqhpn+XIH6ffanPEt7HV+7oN6/s1OziL3Q==
X-Received: by 2002:a05:6a00:8d86:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-853748a0551mr17568195b3a.13.1787764779081;
        Wed, 26 Aug 2026 10:19:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d86:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-853748a0551mr17568124b3a.13.1787764778636;
        Wed, 26 Aug 2026 10:19:38 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d345ecesm1206968b3a.59.2026.08.26.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:19:37 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:19:26 -0700
Subject: [PATCH] i2c: busses: i2c-qcom-geni: Use resume and get pm runtime
 interface
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-i2c-qcom-geni-pm-runtime-resume-get-v1-1-25ee55d1f0c8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB0gj2oC/yXNwQrCMBCE4Vcpe3ahjVjEVxEPbTJNV0haN4kIp
 e9utKfhu/yzUYIKEt2ajRRvSbLEiu7UkJ2H6MHiqsm0pm+v5sJiLL/sEtgjCq+BtcQsAaxIpY5
 HZuem0QLd0J8d1dKqmOTzf7k/DqcyPmHzL037/gU4ciwRhwAAAA==
X-Change-ID: 20260825-i2c-qcom-geni-pm-runtime-resume-get-ddfbcee1a63d
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787764777; l=1272;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=wv1LRyJF436NBZkqYSed99dO660pUkPBSqfpXcjqKUI=;
 b=rR/0L1/u4biv+fJMMwzDwAWDhrZnvz6R2e9sjXqUg7saAttIuhJzroOjxA3XmHOqWkHZnqbRA
 Dua4wX1Mu9kBo+6FbKoLALLdm0mDhfW3nAjYUr4yFgw57UKVppZYeF7
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: o6o9YdaALtxIV6ejkywVqEfZxm-hTLV_
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8f202c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qnW5PnHyz4QdMw9lHNoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: o6o9YdaALtxIV6ejkywVqEfZxm-hTLV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX6G5vJd3yjEMW
 qpRjwaTH1q0NtIn8Rc1Mr3wo/zgYuzkQJvSo/LEesBFSpM22pRzASWEKUcEbsUCPMduZ7wsjN2F
 hjUnMQi8MXtWjzsU5WhtNX4yW3gK+cGCDNZ2a6qkwrf4mO+Fh7vmfSegdimVg9NaK/VLVTkyqMp
 3k2VLO4CtTrtgln7Epg/ZyGQgkqxFJLFWJ95/Vn2cCMakaFl/TYQj2XQIXAjPs5zv9cE7BN7xgQ
 G7FQGJ/a5BhP7WuwmGdeQFwFLf/+h27WhSWaERvdKfX3pdN0PLqJ/jlaZrocrAZWOu/rsvPCvYG
 XpbU1tjy2youM5TP5qUB5oJsPTBSOjQZXBpXTLQur8vATjzLj8TorZlFc39DZcR/rS87U5RJwQ2
 29hC/IfwaaQDXILEgl7p9aDXphXDTTmGOZUPqngzgwIY6cFLQrmE21nActOfLPn5TZmyybz6NSg
 8W0oqRUwayUhgH0O0Wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX7pkOqYHBIKCX
 ISfi4WHbCRLwWMXrEwWvxTddJu7nMswGZutGvogZU6uiWhLue4aTJ8JoXTLoUUps/FqhYmoRYjj
 PUuVC5L5HDaI8qnh/mD/lv2WytfySqI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260144

Utilize the provided pm_runtime_resume_and_get api
to increase the usage count and call the rpm resume
callback. Upon failure, the function takes care of
calling pm_runtime_put_noidle. Remove the explicit
call to put no idle.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..d5f4de3e0a9d 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -963,10 +963,9 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
 	int ret;
 
-	ret = pm_runtime_get_sync(gi2c->se.dev);
+	ret = pm_runtime_resume_and_get(gi2c->se.dev);
 	if (ret < 0) {
 		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
-		pm_runtime_put_noidle(gi2c->se.dev);
 		/* Set device in suspended since resume failed */
 		pm_runtime_set_suspended(gi2c->se.dev);
 		return ret;

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260825-i2c-qcom-geni-pm-runtime-resume-get-ddfbcee1a63d

Best regards,
--  
Alex Tran <alex.tran@oss.qualcomm.com>

