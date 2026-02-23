Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544C34E76E
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837392; cv=none; b=L711dlW4ROceEF3FMvRHshoYs+YvdXwUnvJX6BA49fhuwjpEA5TNrxHzEfDjL0RKvLxb9vHyMX/LRFCbz2e21zXpesyfjYBmvZMkDYHrtijiEhKza0Sh+x3Qjq4aoJtc7yRnAbbJk+LKA+oxDYbpPoHk3I7LcvKWNUbKGrnvzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837392; c=relaxed/simple;
	bh=iFf4ozj/QdiEuQtujPMD5IWwu+ZJbPBO8M2Nnv2CCOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izwYYEFe2TE0pDJoqFNPt3w7sJS6y3W0FSkFQo+D0/LQfl01Z9l30Syg9IHy/FD/Zhrc0su7G0VkAGAZCjaTbG2aHvG0txMMUR7hvZhSTHVRlyDujNEo3zxPBMH9l79GtzNCjPW5mlrVSed0wQOFH23L2aioYCUMRRdYZ1rDsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/Nx6ADq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fFsRZPTF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/Nx6ADq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fFsRZPTF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMp51i2481776
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	711IkeYK3iXCGrAtVzqXjRJXDcFsLIUtCve2PnVPSdk=; b=Z/Nx6ADq8qz6Fo+O
	bfOpR2fBKHEO3KBbgvgDJJmOthVg4nLCnzVnRWh+RhGuTEgqBTuSlC6/IYsb96UN
	NxaM25Q72874cakYo4zk0yJONeAvzUdbG6p1C52WZNtM1vqziUQ5H3Vxy60YUvE+
	+yNGkbUTN5Vy+151ZH87OZnyMGqbvQWtp6eTSbgM7/IBm6wRnI9bnOvDl20p+RLc
	9NUuZUd3d9GXfAECHKQjN1RBkfONNHOFT0JJ/ChNK+Mw+iZMb3NkKLDUIqg8l7w6
	OdTXdOVUDUvhKlAa4bdq/q+A0hLAqEEpWxgHTv5io/YpH7+e6ktB4IotJrDj5L3W
	fKKOEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyv26w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ed6c849so3867939385a.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837389; x=1772442189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=711IkeYK3iXCGrAtVzqXjRJXDcFsLIUtCve2PnVPSdk=;
        b=fFsRZPTFNMme3CPpWU6LP6kZAM0E4nBulLyU+rv3wj8UHzbKC62vZTPNBIjoxsm4i8
         z739fkXdVvOZ04xp4FvZZjVIWvQ/b0U4dstq2DrqcSi4q1jFdsOFOJK7xCK57TNklYo5
         WRvJg2a/EZCMCmb7X5NRocqdUOJ70YOom8DDPP1dShdWser/FwwwuWlgkwyCx/yvsshZ
         H1R4LMREj4f/lWK9/i+OVgNaIosnxlgYHqdy3ys51p/Dn1u6A1Hq4IhMh3V60EH2f87f
         QFJrJGtJvFT0S6NHtvIZIe4YjfDwCtdGkDUfnztjNLj+SBep8auQLBIpsm7GQZFXE3ka
         OtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837389; x=1772442189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=711IkeYK3iXCGrAtVzqXjRJXDcFsLIUtCve2PnVPSdk=;
        b=FnPcfzE/+2RcM1X7BCbKXR6KX1Tr+z8IKzo40nJEra+z33YULCQJZ5iiTktWhughSS
         IndYyaAgjq0yz7WMtz4CHKNzwDbZRLU6dxdpVcLte7N9Qp2gejSA1d2I+nVNRGP3KE51
         awm6tvrRY55QGscPeOdABOxILppEBmKQTXeiy4TjZQ6cRGWXfjExep8sc2XCx+I/cBPH
         hYHGL+2hHi/PKpXn8PzRQ0Q1ROPutjzKxL1XKa/uTiGfcdwwm+Pr1cKebL9zzAERJbz3
         z+u5QMJ9eqtoEezF20E6BsI35Ej53LmjqooxO1uFziMOULbkYNByWmZ6T5y/9LHDUR7h
         wNlA==
X-Forwarded-Encrypted: i=1; AJvYcCWAbc/LARPPobcNy77iqlDHmF2opau4Q1BMO0zKeCA5W6ozCA+dGJZPSFpWn3DA6kgFX5BC3Z3yc9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00TQn2YCBXOJPYU5zuI1MtgsoYVOZx6+rTpLIHSz1CjktYvFe
	IGAHR6XAxFu610l+3L5V1jEiDZ6NAQUtHugI0ny2vgqQ1Y8J4H6T5SNYzWM2ops8aPPNyo44LOB
	36w44PhqbkTWzYN3WGAmYOuRt+rykzZ6Kj3pYMmw/hVXRxd9+BbGLTPIa5BA76S0=
X-Gm-Gg: AZuq6aJjxR3NK2ncO/FVyoedWWkngqCFyy/388lZri3Bfywd2gAcS+POul/Z9uvaglz
	ntKa+jlesk+Ve6dzcFdmwkYf1cOOc+rKW7w4pH/5lP3+layQw5sKo1rDm5Hc1PgbwAF69xOs4sW
	QeF3kj6GrzZTpn56lR6eY+/hWe95DI2G/WAgdWWLxmqioUJPjDWmHjHeijaMB7zCDjGpdx5OPZI
	/4TWhHQD8DB7rX7xcAwb/Xp3N4jbgaEJ9Y+PfRIeJPez8iZuJ5tIxJIBEyOxu422ykOOX2BGORq
	xlRlZqrgzxSiYxNxhY7TFaDMSMnNCT1xcRHk8k/x269q7VdReOi9R4p/doSM29Lh0FPUD4LrJKR
	+yYYmocsyxEy5aWOft+CIT6SKbFj+1jH4fE9iigYxiixjaonxlPs=
X-Received: by 2002:a05:620a:3708:b0:8ca:4288:b16c with SMTP id af79cd13be357-8cb8ca76697mr858242485a.54.1771837389107;
        Mon, 23 Feb 2026 01:03:09 -0800 (PST)
X-Received: by 2002:a05:620a:3708:b0:8ca:4288:b16c with SMTP id af79cd13be357-8cb8ca76697mr858239785a.54.1771837388560;
        Mon, 23 Feb 2026 01:03:08 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm19657169f8f.7.2026.02.23.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:03:08 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:02:52 +0100
Subject: [PATCH v2 4/4] i2c: mv64xxx: use i2c_adapter_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adapter-dev-wrapper-v2-4-d02946569773@oss.qualcomm.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=iFf4ozj/QdiEuQtujPMD5IWwu+ZJbPBO8M2Nnv2CCOk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBfAYI6VPsKlzRGQ+aX9UWiGJbIOtpwc5gADb
 SxnQzfk9JKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXwAAKCRAFnS7L/zaE
 w4LUEAC7EBnGmpPhLBhHC7q9+EwpFJEmafJcJ/T0omjeWiGcYntPZcutmlFD0u02L39wIQF5DV+
 Q5mmsbu5SwX1IHtSu9WjuQd4029CUCtgdDVVuLKFlSsl5GQ+gCcb2dfbreP0jkuEXiuYWVelzCx
 VulRe031FWvW0cK3+BAE/CLoKVAFjMQy/Tc8ZZaxP8BWXIJ/lvO5vP0MQVb0RNCjQitWIzekBse
 TtAF8TjqckahifuGmFPH68YXyUebE2Cb6u/UsTo2zWjeW3jdtFzFdXmsDaBdTsh5HzPyLaGnNws
 UVx3hwNnmfNjIsRwoWtapeZTjHQ/yW0ZWIdlcwrds/u4VrpwlHZwWYvKiC+uvxybCmBhKYNEALt
 G3D4822VbN9t/2PX8XLHshXGeU5pk6M+WSiAr3o6+xRXFIgPWk++2OyTBB6avAafkdfLpLYv/nJ
 xACW6SGccxwPQ7UZ3cBUyaGNfz0BiA0lyH+zujnSnkdExa9qjqfj11M4kT74nCE4q/quTOe3BXt
 +oVwv4ZCHojsqNTwhPm6aEr1lB6pqZI/X1cfFXAKQLyY0fuWNYTqnIIriFEXR5o6WaJ8dbJn/Sm
 Rw3T/w+XJHSrqavDECYIg6SaaRVFbqzM/BOxrhz822VE+lafEgTVcukgdUZv40uepRfqUJoDh6G
 2amh9PjufY9e0wg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX7bY3sbjT6p6N
 AzeWu9BvYdEK7NrJjztRgF0gHMHSc850211aDmFlUKOevE5G4UXzanBaQNNxTgCGYaW82lHoUu6
 XTENWOOy58ZUT+HagynBnQNN21hgGyRXZJffTZbT/1/F0/ffmssfd2JZIbBdzYBSfLRSSPv58ai
 mP+6G6R+hp8oXJUgp1NE63gXTYB/JT4wprnal7LflPFWC2n26r2sMP1/dD/pGpihMDx0dKSUKxA
 qZGEjkSb7xkhC8hqAQo1bRla2mYIpn4efft18ksPy8q3AARceU3u+OXAcfFMYIRmqaSafO7OiOy
 fI6XkfZZUITuD4kiT96/6IgXHt6zuDJtoxJqnfUhbNpyTpEcGeAhKX7d64waxP8NilAkr4uYpLP
 qbKMtDzPYYu1C/yhgbF5kWByX6W5Ys/vmA72lQD4KLrHc75boIEto1DuzBOVT7c0UojF2HeW6nW
 5SSNtBmbn5bJPsr4IEw==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c17ce cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=GBZ916XDBFmreC34BHYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 76yUFT5ze9puWRQL4OtBcjmCl0_JMJ8S
X-Proofpoint-ORIG-GUID: 76yUFT5ze9puWRQL4OtBcjmCl0_JMJ8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Use i2c_adapter_dev() where applicable in order to avoid direct
dereferencing of struct device embedded within struct i2c_adapter.

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1acba628e16c3bd1dbf82c777162870cbe3815ef..7892793d2a1cabf3376efcec1d031c3d764f7731 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -747,7 +747,7 @@ mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
 	int rc, ret = num;
 
-	rc = pm_runtime_resume_and_get(&adap->dev);
+	rc = pm_runtime_resume_and_get(i2c_adapter_dev(adap));
 	if (rc)
 		return rc;
 
@@ -766,7 +766,7 @@ mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	drv_data->num_msgs = 0;
 	drv_data->msgs = NULL;
 
-	pm_runtime_put_autosuspend(&adap->dev);
+	pm_runtime_put_autosuspend(i2c_adapter_dev(adap));
 
 	return ret;
 }

-- 
2.47.3

