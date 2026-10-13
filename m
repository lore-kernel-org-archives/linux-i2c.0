Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB94B95C1
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887435; cv=none; b=qJlkRZyXBHHWuhGSzQMuvCrpaDMhxw0pa4Tb4muVd7xQCe4meZUzUVI0S5edkdRQ6ytwAroNhp15QTj59sHrGITOIDBe2dRp7ZHll/5M1vAf7TsG8rfskFW/7yHNOYkz8r8ICYD/Abp6BE6xdciv6YwbQs1ZlM9kK8N7arjKjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887435; c=relaxed/simple;
	bh=vfE6OmYRp/eyHIg3fq4n77FSKItN33OklybpiIvREks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jsnvrm8Vxva/zNxulynpNi5r5AakmdRIbXQGgxVHjwsJRAzonfobbs1V7yWxhzt3bCWqbnxLI40Ok1IChKE9kujItKJMo+g6zZ5AvMuwXWasB0wVsBTXvfLqNE6VNN6pjjOHKwfF8lK9Vz9+S2gVYOiCofbbQegWMXaLeIAUf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=knuYwcmN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUJNA+VS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="knuYwcmN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUJNA+VS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7OdkN015591
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gWdIPEJCACXXkjJjb8PQxL0SVTjR4Vn5uqqJdivVJIs=; b=knuYwcmNJlZpeD6T
	tnChmTxyDpiKpv6fuWw6NbVWize4q0qGS/2Qj9dDfN+GX7BaXAJhibHjfEx+j3R3
	Uc95hNbliSAZZymsvOwCf0+LEQfS/pmWAmGQpgsl+Vd+0YU5ghMth5BeVgK+AVQy
	SVhTpsG/HDc+UrWMtz+QnOottQHAAKAwoxUBubC4fEZTZ24IM1/nzq7lVQ0GXO7q
	UR93Yj2g9zY/nD3KWzTsIU+kYDTCL32WQBxdA64UuOtf6h3jZth2RknCXkJWXf0z
	0Yjc7vBHlbqwyyIPONmWq/8xry4i54LWbGC21MWfnPnZ/hVOMs6471cmMpFYsdpc
	4TVGkA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugs76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc7a6e4e1so906562385a.1
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887433; x=1792492233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWdIPEJCACXXkjJjb8PQxL0SVTjR4Vn5uqqJdivVJIs=;
        b=AUJNA+VSP/F6yJbHqRZQuzwWFtQSg0BNRhA7yQcIc/fnZgIrzp9Yw5QyxV8rUSvIEa
         SR1RZkg7rAj6i08/yjYwGnZJC+fwxf+iWcePgcGpSW0iZR2oY99mOCgEp7Hg030Q7RyA
         KHboU4HmnEuFImmyE+3UARpqUuU7J6qcqp+e+cP7VGMEIjZ2RELFJWXfORLMgXjpWGK8
         5qLc2VaZSFxEcKjJeIZF3ss3TxcYQDaogeoWwESXuLphdz02jiK9FxxdcakaQrkUc/41
         nqdjSJ+DJNbv3KvtcVaveYgIg75IoemRHcwOzWkKAAYadjVZsCQxxHDoJtWzlVo+jT5v
         zYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887433; x=1792492233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWdIPEJCACXXkjJjb8PQxL0SVTjR4Vn5uqqJdivVJIs=;
        b=BwB5T2L5Vjr5K7+m3MStmKQ3/YPpJaI4nXdeJEfwS1W/QcF/ll4KotNA47jwKWBG8t
         j6dtKB7m6ced3/OkR1QZhAzUujk3eViAUOKk0o0rw5pwpRaTVY+XYhLgSYbu0x8suQx6
         D5lGDbopph03gxFW+uRJr2ltPN+GdqZJE+6nXDWbb8YwkABr6/4CtOMHAuSXx0miWGZX
         iUiuFSnrV30Cboz6X6bpWTTNgna64YQMxXWGJ8WdZWUIZ6GCjgPozp0JkScf2AKRSj9A
         +JkvSaGayjx0C41Q3EwJpeiTaKdQwwH2XsEM82z6Nd24jjwap2HXqg5Gpd2oTldKgoq4
         0pkw==
X-Gm-Message-State: AFq9FYJEqp7qWBnMXG0I6RsjtMMkvfX6aldR7o1LHZHm8XRirHYZ/9Y6
	OTF+XrYz3GK0X/CAk4jTrcMlMmj4nVnRzRp3UALYdxUX7t2nnmlA39h0clyKlYlc6EE54Gok3fW
	pZC2GBVqVJKszU0rfTpVydfztl/WX4oM9H3ecjbwTIsUSeZXieobrlAyf9knF37o=
X-Gm-Gg: AYBFou1g4QFDYAoOLDQnzIPeNye/0Bb6iWbesapwg0owXxpEETMUCP2SP1StsMUlxP4
	WSY5i1vBSC5bu2LkrEKpZua22wGsGqMg5ni9MhyNKx7P9O9g7NAJybRGlDy1Ut8B5KLPRHhWq4S
	hfJE839w8sd/WP5qZpePkwDeGJQiz4Nplch+8BHPWOd0ypI+oqjP+aED1wb2pBoRyDKBHo2Z9Zj
	f0MgY+tciafzBsMxe65KFtOartWi26e7OdWLW1q243GRLYfOcJbeFEohUguYv6XiivKH6YOCMpu
	dbHFQW7jJ2NwtlJ2Endf4pwmfq4kA4HHW2EdYWbJpFnQ9zjARGDl+xZmdte9DEgW6yuukAC3w12
	cZZEMevEYULloZpBkdRmwTzChKEdDeo+L5iZETamIbf/1+pvUSMajzb4GyqQlc4hnC2rKkK1h61
	858tQKQkh+zQT+h0jYSxtQjql+ucma5cBuKKFISMAtl68N4VK6TTc=
X-Received: by 2002:a05:620a:4689:b0:93e:5312:3c96 with SMTP id af79cd13be357-93ebd20e0c1mr2147145485a.26.1791887432806;
        Tue, 13 Oct 2026 03:30:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:93e:5312:3c96 with SMTP id af79cd13be357-93ebd20e0c1mr2147140185a.26.1791887432174;
        Tue, 13 Oct 2026 03:30:32 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:26 +0200
Subject: [PATCH v2 2/6] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cci-imp-v2-2-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX5mQFWp3LcK6Y
 3nrOi6DDIizG2CHbrB0SzN+V6wn3J6/4t5dImzBSVhfA/LuN7GuJdzLq4JLshEYpO/WmhhX7vK/
 fEErRk29w2Etaf8I9RfX71RipZ/tRyxrO+S+QiA95xB07pu+9ccruIwqUcqV78IggVeOlHzguCj
 eD4SeyA2CN9cgkvb9+hHXUi4tryBGklJIPqCcUA5S9Ncklfv3irkoyJ37TAfgwAxccgxwyGKjJb
 LF59H6/bDw7YeEYdAilKh2xJiJZh0Rl/OK4A8lSSCgzC4PrTbjFrDSNhkScrmcDDcWmW/HaF0lh
 dUQ+2cIme3c5CnFxN1GXxSFV/uZnSSkSpfx+fbGhr8dnnW+R/SsyEEjbuPWZBoZcLu83Igrh9DR
 pDBIDyVE6YtmYVYP+ndM2xhvViZWhs0CP9vseBvZPCJZ1YXtQo17XftXR4ICIesDRhnBAJOFHoz
 iS1tdfHNh98D+EYmY7w==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace0849 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=L19FZshse16xndK5FkAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: TdZ5Gclay2cTntEeRNeCJ9FbUF9G8WZb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX/66cXy3wt0Fb
 W6VlH+RXHbR53ZpmFiFd+LsQhF3/uIHb2PbyewTBqID71B9LVmfeLoONWv+M87hyd7vhY6rbPSd
 tEZVu7+0tgb0O9724w9nVKzqSUaFckQ=
X-Proofpoint-GUID: TdZ5Gclay2cTntEeRNeCJ9FbUF9G8WZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

CCI_IRQ_STATUS_0_I2C_Mx_ERROR aggregates the per-queue overflow and
underflow bits together with NACK_ERR, and all of them were
handled the same way: report -EIO and halt the queue. There was no
way to tell a NACK apart from a FIFO overflow/underflow in the logs.

Decode the individual overflow/underflow bits for each queue and
report them with dev_warn_ratelimited() as such errors are not
expected in normal operation.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 3304760411082b72e10e529a2bd66361e100fa06..099da0069251681cc52e351fb656bd73e78a96c9 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -54,10 +54,18 @@
 #define CCI_IRQ_STATUS_0			0xc0c
 #define CCI_IRQ_STATUS_0_I2C_M0_RD_DONE		BIT(0)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0_REPORT	BIT(4)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q0_UNDERFLOW	BIT(5)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q0_OVERFLOW	BIT(6)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q1_REPORT	BIT(8)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW	BIT(9)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q1_OVERFLOW	BIT(10)
 #define CCI_IRQ_STATUS_0_I2C_M1_RD_DONE		BIT(12)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0_REPORT	BIT(16)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q0_UNDERFLOW	BIT(17)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q0_OVERFLOW	BIT(18)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q1_REPORT	BIT(20)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q1_UNDERFLOW	BIT(21)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q1_OVERFLOW	BIT(22)
 #define CCI_IRQ_STATUS_0_RST_DONE_ACK		BIT(24)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK	BIT(25)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK	BIT(26)
@@ -190,22 +198,40 @@ static irqreturn_t cci_isr(int irq, void *dev)
 		writel(reset, cci->base + CCI_RESET_CMD);
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_ERROR)) {
+		cci->master[0].status = -EIO;
+
 		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_NACK_ERR ||
 			val & CCI_IRQ_STATUS_0_I2C_M0_Q1_NACK_ERR)
 			cci->master[0].status = -ENXIO;
-		else
-			cci->master[0].status = -EIO;
+
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 0 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 0 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q1_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 1 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 1 underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M0_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_ERROR)) {
+		cci->master[1].status = -EIO;
+
 		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_NACK_ERR ||
 			val & CCI_IRQ_STATUS_0_I2C_M1_Q1_NACK_ERR)
 			cci->master[1].status = -ENXIO;
-		else
-			cci->master[1].status = -EIO;
+
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 0 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 0 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q1_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 1 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q1_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 1 underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M1_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;

-- 
2.34.1

