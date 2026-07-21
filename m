Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB884CA26E
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645936; cv=none; b=seqetb3Ti1QA0M01wAB2aRCaN/dYgBphMtYIZehfkYMrFd87uTVhg+1Q0et3yvL6imT17ntHe/+KYhEqUgs7jpMG5Vnscl6mfNmPhRYP9OX5CY6YtaBR7btne6dW2gN7B5wZpdbn2IUsqz4uvPTzRRFXALA3sBSvs3jbvtjVmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645936; c=relaxed/simple;
	bh=L4abhWl85x6DcJaIYDufzvbZjOuY0oUzE78G1+UyDnI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gjZ8KL2rDxmaq48T1WPgl4Si7JkjGB9QDcR/NproCDk+EnGUoMNTB5hgSdoMPBVLbNXUd90F+fB0QKU1/9oFjBBRNF4+WCg7fY7eew3Yq+VPYG97k4E5Sp/Dwy5+fW5IHi2LxRj4WxqLyiB3gpuaemVwYarBJAd4qtCPZJg4M7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJ8/At8L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqwSFlyt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJ8/At8L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqwSFlyt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg9Gs1939509
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=swKDBNQtXNX64Zdmsoqnf8
	Uf2vRqJ1aLbRRw7zOx5gw=; b=aJ8/At8LLVCFLQNMafmADeq7R86pWfdEGtjZuu
	kEgFonNLsiLXE4vd2MG4kJ5PMVLES71DoxL0MQjuQMuO5olx3cx39bHLlqC3iU6G
	X6GMyIJ1NZGkQ0+OUzRahcNtRLXkoBX9rZz5J+KBwk03pYZnsyn6Nrs6fe8o9fEd
	E2hsYbf/JvdfslWFMwTnvJpZL+nuTPDQx4BaUpIRR0K4csawYp+cxuokZbamOsp6
	tORxBftrIp6ONzNCj3+4hwjcsbOsOShoXYLPG50RnxOmFQkrkhjmF08LM0kPUOse
	djhvLnrhb/kqXURmaUxhSf/4ErmNVIZuml3gDdx58yGiMSdQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bs8hv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso11546201cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784645934; x=1785250734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=swKDBNQtXNX64Zdmsoqnf8Uf2vRqJ1aLbRRw7zOx5gw=;
        b=LqwSFlyt8Bg5plrl/SuTVQ+4plvAEs6UF6FxRSGL4VIoPYQdk1tFb0iAH5Ei6RRO6f
         GlSlBNErY9QqFTKAglvZnrxI/7+MbZKikkv++eMPMyPiUs476GEAe0Pd2+0VjpYyZ7Ik
         r22LdpwD0ZBke4L4+7183I3wcvjsYyKPFJ0TYMjlySsWgejOy2VVU9APU+LrIYQNduND
         T3WhA6zcN4udKmv7PC0N+YNpiSPNoTkGb/Z/AoIDtHOsxToQ1ZHIVUuBFqo4rGpdlCPz
         7znOgXZoxK/4cg/U0qfT2pfVXc89xZWkH/7e+ALI9UwVV954nBBEWLRUWLoBhtvWo9Mz
         EILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645934; x=1785250734;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=swKDBNQtXNX64Zdmsoqnf8Uf2vRqJ1aLbRRw7zOx5gw=;
        b=TZrWJ5tqOaWVtZA7ZxNnOpoayYsQFgrPIm9ebd1qudqKAiEux9GOtyyCjqzfz5BoxN
         7uiuXCxu3pBtFdFrTNo9QaDJ3pSFz2CAkkA/vw7e963YZAi8YI0N+uCGom4fD3nsogX0
         rOgEeINUY0P9DP5P0TRJcZz7wGxAFQEZkA4rGSmcLtsFrjwdEZK9ux2/kbNVTgVsGLh2
         Vfg5QAua+VWUewelh902nRApq4ipkE9YprVehLcR9fZzVZAOwYBi3oNRVhvrAGTCrJdU
         PCb3EnS5lNiYGqa1J2OgAnLq5OAiE+Oh8A3VE0Dsj4DUAfuXgMdflD7rTeAis/7vawV4
         RWqA==
X-Gm-Message-State: AOJu0YyodKlKMdUxDaCQLHPAoYkJgrB5qrkgyW/iEW6t4reOogsjdWo+
	tUB5gDymlv/tUL5gT9JeeHej/kKgfTzLZAAoHo47wqBrUUKY7jlsO4YBQ5B+n+wzJFjB9OVC1mJ
	6/kDd0dr2+S9endEapD69gXM2CxZYOnF2J2ZJr2xDYDaGqOvXvg0LonVbQkq3Fyk=
X-Gm-Gg: AfdE7cmbgc8qJFWguceDLTS1pTIghdu1J3ca4D68QkDykn2tHE97FBKa0IvIOSy59Or
	Yca9wcoHWFb8/DPl2DWfHLquIiy9wHi+GcOS36DhsmB7YV2+KtaUnJEBHaw1kDqqxFmdIEC+/Q5
	n4oHV7QeYDX5ouAr8KjGfiQv7EPgXib6GCgz70Xbdck29DGNdpp09V5cuP7md7zosTurUrHybIo
	kntavjBpSrdhyCNNuy73H18TCbrCqIhGsPbS3cvYmnBvpFYVOxKSmUkMKD5Ma/0nT1A2VgBDyA7
	6XMZc9L3IYkcoiZkT0bouZawU0ab8tYhIs3JQ820deKntkRTMXvBGEzQjk4VsYfrdBaqwGv846O
	FLqE0WboUR4BG7G9JPFdNCww1DpyX6AQ/stJC4po/bTEZiI0LnEJg7n/mkowYQMNlG484wumPVC
	obKQ4Cl8W75yUdqaZPrd7XDXFQIV36+wsd2t5MIKwrUBuy+NfBFx0=
X-Received: by 2002:a05:622a:1196:b0:51c:1408:6c12 with SMTP id d75a77b69052e-5213daa1f40mr162772001cf.47.1784645921817;
        Tue, 21 Jul 2026 07:58:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1196:b0:51c:1408:6c12 with SMTP id d75a77b69052e-5213daa1f40mr162759281cf.47.1784645903440;
        Tue, 21 Jul 2026 07:58:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbba0fsm5875369a12.17.2026.07.21.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:58:21 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 0/3] i2c: qcom-cci: Fix CCI clock rate enforcement
Date: Tue, 21 Jul 2026 16:58:18 +0200
Message-Id: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqJX2oC/x2MQQqAIBAAvxJ7bkGlEvpKdLBtraWwUIhA/HvSc
 QZmMiSOwgnGJkPkR5JcoYJuG6DdhY1R1spglBmUNRqJBOk80MuLnnXXL8aRdxZqcUeu+r9Ncyk
 f0mcvzl0AAAA=
X-Change-ID: 20260721-cci-clk-fix-fe145b2acfa7
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: WPrPSWBS81A4uaXJRsPb27FZoB5qFFXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXyOyfdlFAiCbQ
 2Z4WhI9dTD0MFq/8PjwJ3JRiG7TdL2+oC5O7Rn1j7qaByrG4Vkpf0VmYgGACCqDIpJ0jB42Hog/
 xyJBG4I3HJLScP9V3DCuZ0fVJjfXiRWJEryFJjPcqOfZjec6tvEi5/YhlzDnNI48LKQDmh4j8BR
 MCRZIrlOo8Fhr+M7nWJ+9FKSw8TxNHsBShkOcTdQZwxubaQDUeq9oR6sSqQz9l3NTJSEPM9MT55
 v2UaqDdJ8kxBqc5qVWV424p8CpNMYoIRDKMPJfg98sHf4NSU2A4XG4QgFbukAqJeVV8Ehph8lEm
 JsCysAimN3No/6AlHES4s3hUnrAL4oV3KI+b0Xtd5nifFlzxou2v+YjKiU/UOzELLjYVXTaR21e
 7V5yehLDTh/TxhXaGRRSHGx6sYcCKQ/dOoR4EVqtQfNSB//htR+Bdv75KnYB9+KS0zBHFwtP4oC
 ouR+yLPvtWNAR0CqZbg==
X-Proofpoint-GUID: WPrPSWBS81A4uaXJRsPb27FZoB5qFFXN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXyY6uge+LyV4v
 nckflqj+VQtSJXN/ohAtwhdQwlEVl5ZKRcnPQJ7xkudO/TlAKzp+dpnUotgw8x8bJLPTPbtQht8
 X5AuqpMr96gdEXMOZmS0Drk1nBtsAB0=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5f892e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PiiRB4L06hF8XXeOMdIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210158

The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
clock ticks and were calibrated for a specific CCI clock frequency per
hardware variant (19.2 MHz for v1/v1.5/msm8953, 37.5 MHz for v2).
Running at the wrong frequency causes incorrect I2C timings that may
violate the I2C specification.

A previous series removed the cci_clk_rate field and the associated
warning from the driver on the grounds that the warning was noisy and
the rate was already set via assigned-clock-rates in the DT. However,
enforcing a clock frequency configuration through DT is fragile and not
the right approach, the driver owns the hw_params and should own the
clock rate too.

This series reverts the removal of cci_clk_rate, fixes the missing rate
for the msm8953 variant (added after the field was removed), and
replaces the passive warn-only approach with an active clk_set_rate()
at probe time, retaining the warning for cases where the rate cannot be
applied.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Loic Poulain (3):
      Revert "i2c: qcom-cci: Remove unused struct member cci_clk_rate"
      i2c: qcom-cci: Add missing cci_clk_rate for msm8953
      i2c: qcom-cci: Fix CCI clock rate enforcement

 drivers/i2c/busses/i2c-qcom-cci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
change-id: 20260721-cci-clk-fix-fe145b2acfa7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

