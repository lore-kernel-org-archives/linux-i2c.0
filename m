Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849D1C3318
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380581; cv=none; b=Wltu61yar+R8/VPY6vsPkwJ4BusFoaWGjoCO2Kl7mZoRKZjTKbpEV74NNQwwweIMTTd9t9GtWE7gdf6J8B2TJTI5HCVdx17J+ZYCNWjA1HWQZMt/JG5EeqGufOyKjVAMiRz2GP19FUnw6+9unUZcoLd58lHPa3KAY7xFV7uD3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380581; c=relaxed/simple;
	bh=GeZzJ2lUUyqOawlzry+eBfuMH/i9lZW22xMIB2YOYZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fsGr5FfYpk/DEuvpkfnOEmkGYcCMIE40aTUnvU4lsU+8C1bPQQyYBkcQ2DDNOhzWBB3DrXuTZ19wbsYLuJeSybCnVZX2JvI/dZXeFNMK+OhusopsgwJeRZ66ISfhgyiot82KrN0eV+Mw3tm9aNGhUp6C5Va67zG7yZ67znUPmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OV6PFj7U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BrQ4oa2y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OV6PFj7U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrQ4oa2y"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8pWG81795806
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+fUJ9z7/1Rya1MBrHCkQJY
	9zUrIg/DgVL6Rli088cxo=; b=OV6PFj7UkQxzbqCn6tJEMuGDqAu4Wm0ytBQDPn
	hEmVAAU5fElFR32mh4H4Xv3NFbpTNjHWh8M5U3bFKp58s5/XiRQFUhPgJocaGJaY
	4G0W8wDFLNl4OV286anWeUZWs2cE+8cfH5hr3MiGzvV3OC/gff7vwlbttyNPRh78
	smd4g1+VBgHbk3YnepHzJiGS3D5/6KLCUQZxVJEWxHZJrz9gRf6aoIdG2LuXFKqH
	Vah+gVWEE8BVLW4hq4uqlEWFynRGor9e2Jl2UcCA4BMrU5mBvb/hfUHljFjwmGnC
	URftZsepG5VwjCdQR47rVXppt0ZXs32ahsmPYU0qlGdCFK3g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueu9jrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:42:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92045e86763so159786785a.1
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782380579; x=1782985379; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fUJ9z7/1Rya1MBrHCkQJY9zUrIg/DgVL6Rli088cxo=;
        b=BrQ4oa2yJuDVx7IbePOJFDNLbmowIuEQGCxzxHycuey6O94/4gl1C5xo49si+64m+y
         5OcGibvIvG9TkpIdvlK02emk0JPubM6FD5gfTbTgjY74QiDl9oCgSEMyJ+XaPY2td24/
         Tu2xbzwgLnY5NZMUqUQTtQK0M5RA01O7E2KY0e+aJWvlkLTG9P+gAhmbBLk1TB5MfgsG
         wzoTxjR1RlAQLEjuFjQTRitKdVUB58PHNKGZ3ejcY4/O6gaKL5zcpIlAmlOoHLcey2AO
         vaH4qezAr3AzPExJekM8zZFC4Nxvv6TCc6vaY4L5cWQA1UkcGN+X5bAodE0AtN2Bc+W7
         sDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380579; x=1782985379;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fUJ9z7/1Rya1MBrHCkQJY9zUrIg/DgVL6Rli088cxo=;
        b=lmzmhdloZY+b5jEjDSj+NfV2TObPov2VGQEyClR3ibdW+PO31qjFoX5NHiw6EWpPt7
         GkStlPlfx1TnEY1WakQIrR4CnkKenRpTo6xv48qBaemhhhoyqrtlTKh0TeaQJr+3Pjt1
         xeZbz/gYbxDallyr93B9z6SRNEwqkQ1P6fuTBsavbc5okoRkQo1llTVjh/EF1BjMwbEb
         qCcxlux14eshlh1qk1/jF4nfUWzbQc5qZFjP6mNdPFd5qZV56ARkeO/iGangmv0cNXek
         bV75rx8sJ8xVU7kQPhNthd7LeMV5S4j+aBlFXVEjQuYgtBi2fjSQ2GGj9veAbzSsN5TL
         p6Lw==
X-Gm-Message-State: AOJu0YzQx2vRSacef2espeT3tDBFSO1/qWiqdqCI2/UYuSqmbrzN6IQB
	tGpcGMVnR512UeWmeXhnkho3kCkeF0/u8aG6Yve/ViXrb1QrviHG8iwIJ98dZvHcMDRTMF820VS
	bizG7jvT2pbMeF3A/61H0f8TDNiVViLrnik+LZdr26JLR8sZkPJ6OAUVeConlRbI=
X-Gm-Gg: AfdE7clm9CSEvv4CkEF/jheUM1eqw5MLQuAPtb2Qa9t0MWqHmrPa+IYg+q9DyBeRZQQ
	ovhMonX5dph13GfJ3kUCj9bKF+BAV8nsohkUTO/5WYoNkmVU9AvG28IJksIvdkFX7DKvCqtJum2
	fHwLrGr0NaionQCnq65ipylx6ZDkeCOyyOROXrQ9we7sAILnE0Wtgv3WMhLhwuQhaccnLBq/syr
	ZZst/fIPX0NDWEmDKYkbXHVBmzUF1wgQxvc7RjmsKpGbkjOnVtYI+Imev30DGQJ1vKDFRFgTyuT
	Yzana+SrjZVITJ853IrMQ8ZpO8sIoJCBhqn1tylnz3Oe2wZQ0az7yGvU8VZhNKi2nsCt30v4sD0
	Xn1GnKSv83/pRdkke2vMzPTIrgY2Ivj8DwqaI1qur6ZAOLIuXGewN2dXua5p//uwCxQZ9oc1ldZ
	YsjSI=
X-Received: by 2002:ac8:58cf:0:b0:517:91e5:108d with SMTP id d75a77b69052e-51a51bf8868mr151889801cf.42.1782380578695;
        Thu, 25 Jun 2026 02:42:58 -0700 (PDT)
X-Received: by 2002:ac8:58cf:0:b0:517:91e5:108d with SMTP id d75a77b69052e-51a51bf8868mr151889641cf.42.1782380578260;
        Thu, 25 Jun 2026 02:42:58 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a6e7669ebsm15037901cf.12.2026.06.25.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:42:57 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 17:42:45 +0800
Subject: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABT4PGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNT3eTkTF3j1NSUNHMzsxQT4yQloMqCotS0zAqwKdGxtbUASFSZY1U
 AAAA=
X-Change-ID: 20260625-cci-3eedf766d43b
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380574; l=1696;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=GeZzJ2lUUyqOawlzry+eBfuMH/i9lZW22xMIB2YOYZo=;
 b=y4tcfj8mA/WqgImYz0vooABkfL2DEx5+/5V2i80MAcTQI7vA7eCjNQitwNBRVPLIFzFp4oObY
 wMnYB0V0DrlB3B+oHcsjtk9Nx4MppDvjo4Djgm9KwMHCeqbGWMAebC4
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: Of2YZWNZ9mqBYlx_gzhd7XexDCfDoEy7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4MiBTYWx0ZWRfX6kfQDgJVSw3d
 0n3SEJwzS8YS8dAap7q2PI2ovtoadQvqGo6JxHoaI8FNUPsoJ3jO5bKYVx8RGca5nMhabxtx6EW
 lMeycvh8zaw7kwKweKP/YR0TMtF5S78=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4MiBTYWx0ZWRfX79K4dGH6ij9R
 8Tz5M9rujidI8UeAHbOSPrJXf6O4y30Kx9BTk25Wq/b/E4o09hzCnP0zSfSxkworQeKc3rIiIOW
 0OqXF1QWud8GWfVxwFKvu4Yp+ncwwWx23PYCqMHuJgymdDFKdIY1CHJLDxd8PZggZ3p7zAJd2Jp
 L/CXvme0+zKMje8ZdKilfWQKZAEdwKL2WaMbRmpEomrLAvRAtChYUEr/JfSGxVjcyq7G+ooAkGn
 dTjr6EZK4vQx6pzfu4crA53k7wOt+h2SaQbGFlquRQnF2RLLPK9jox/Slbwk6tRRmcYusowGqkc
 zo+bsPv7ea+oBlnQlWjeNSA+CAnZgkKYPwCHi95mRixit2QI/fzFpeYrPWXkiZKwluPsiCdK3SV
 t44+YivZYU66/QSf99lOevm0x+uyFrZ7Mf7s0jtKeRiD4hPLv/qpAkg/L3IXZbykExjZiGJ3gCR
 DH7UQSUB/d+oxOn8zoQ==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3cf823 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rHcAlnMhGb8R5zFVClEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Of2YZWNZ9mqBYlx_gzhd7XexDCfDoEy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250082

cci_resume() unconditionally calls cci_resume_runtime() regardless of
the runtime PM state.

If the device is already runtime-suspended before system suspend,
the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
As a result, pm_request_autosuspend() does not arm the timer,
leaving the clock permanently enabled.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..bdeda3979c4814b5cdb463734b8361da7fffa879 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cci_suspend(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		return cci_suspend_runtime(dev);
-
-	return 0;
-}
-
-static int __maybe_unused cci_resume(struct device *dev)
-{
-	cci_resume_runtime(dev);
-	pm_request_autosuspend(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops qcom_cci_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-cci-3eedf766d43b

Best regards,
-- 
Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

