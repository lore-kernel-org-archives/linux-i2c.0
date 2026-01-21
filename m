Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E83E8C47
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989317; cv=none; b=O22cBIszcXacpq8VbISw+lIsZ73H+R6v3PiUBAR3AS8LpgZJehfNllsNEIYYooFwqwUmdZ/aNHBPVULX2vjgkOAEPeszhVr4KMG3fw3+eu7iA3RqL0bBnE6WSedacUalW9hRaJ1Oy9J1eWB/tm3lrMn9QTb9eHIZ3WkfRUx0Nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989317; c=relaxed/simple;
	bh=y0sokPdvFEn9F2hvyOJ04JTMdzGyOtjOTO3vl6S677s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHLtPjWSIWg9nv7ncXsGnaAd64qJJo/LvYue6uQMocpuw6EjUmDSUVh8yQlmiO7gJlb/Rl6C3kicJFNREEcWyVHCsHnXIxQFycSarhd9puJPV/KqquAkKHSwNRg8hRw6MP7egqZnXqOscwOvOCxYmD2ZXYRMMpOwEbRVm/WuNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAgKKepc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7yORlYl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAgKKepc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7yORlYl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9pWjf2452264
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 09:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sU2f8E6sE8rg3Ve9xasi4ID+eX9h6YWUdhC
	hzdT3kOE=; b=SAgKKepc9DXIeWgOjE/1334RvsyzkOBD84npsJLgCR8WAm4pFcK
	YENiJbdKnUveUU1d1KVIhwTcBgUqBP68L6Hlguxagbp50chiT+njrthjg8E/rfA0
	6gqf5sZnl/l/h+6UuHrzAogpm5RDffA32iLaF8MFFFrWqxrzdgmBJv9LuM1zNUla
	165I0mY+nWIe3W//UI1dgG4K4hRr84LVj9BleZ2HpLDiy19HarW/oM8ayiWZcezd
	cbzYmxN4VDY3IBwf5wTGMdeMTbm2A3JP19PDH9k5f8opxsJe/EkIEE35I9s6DzeB
	84u/oVmsdA/lqjSe05NWa/V5s6T7cfXg6Tg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btvhqg13p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 09:55:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52c921886so789985985a.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768989313; x=1769594113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU2f8E6sE8rg3Ve9xasi4ID+eX9h6YWUdhChzdT3kOE=;
        b=d7yORlYl3jcXCdf33rtHalHYPSoTLrod4thDuJc5iFwP0D9ljR/XkTwTSJoNB4rG6G
         S7NdufvlWigQaMy5YIG539R4CrokYJJA1zoRy2nAT9N6DPcFj5DXsOd5Kzu1OSP99JfC
         TL9Vs8szmPXBCK1HSRVhsNZ0UE11zAIDbgmiZSHGgJeTDxVYn+H9z4TmUzzwe/DQrXth
         J5QXQ3E2YPYiQVzmvW1C3JtfP0PpLZhDCOchgbP7EWdF53o1NDC0WCEfiM3F+SNuKNkW
         HyMxlE2/5PUd0SXItG5TfH6nNV6WYzK9uQYfC4doiVLK1BGplhyYAcDfl/P5Dg8hb3cI
         ajNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989313; x=1769594113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU2f8E6sE8rg3Ve9xasi4ID+eX9h6YWUdhChzdT3kOE=;
        b=rXaVIlHwrRIkpTlDM9aB3K74tdElJTMhZJbwmQdiuMeXIybNx7IsM6ySmtPms56lGb
         eeGLsGaS5wCmSS/u8WbVEJIrnm34h+Mi9yoMBhMdxk8dSWxMsUs29wtpnX7BLTaFDqw6
         qc88kHU5Rwf7aJjM/QiYqKFpPq6JuQ2Xoz/aUT+vqJHfnamRWT6rlz0DW6tu8GmCz25R
         b7Yi3HX0tqn4nhoclXG/hlVjnumOCk1gxSs2ntPC4/qy6GFP/9WIu3jiiLwiQt6WLuvK
         yjnQQTjN7UlUExck6ZSSMq9OtGzpsRmODEVEsrRwZrbxDXcGVR60h5gb1ALLDTj1O2AK
         lZLg==
X-Gm-Message-State: AOJu0YwOrMkPurqM3L8SSUehwssv5P2uFYrwiO5yHPEdYreecj+dgkFy
	ukOoUffiQftPeH99ctGsd5RJdauzcvaq8/l4kHdxFeNAm9iUsZSTnT1aNlYYfgVfjxwNzvE+zeF
	ymYtGtGASfuDZe1xNX1ds+DE0+5/sskuYU7UBrTR5QKVdPGtdqyttzBXKmllmYPo=
X-Gm-Gg: AZuq6aJKzLP1A86GhpvN2gTaj5B3oUXaQRitE8Qa2zH+oHrMhyCvLt+peCjO3JWwwv6
	wtATFf8X+/0Ih15feBA05CTcaneaJB2FYstT7LItc7YxUCD/1Y7R47in19Jgm3eqJDj2miAXqSc
	a2jn/NertSkmNbaQhxDKxEodhJutLs20xF554Pnw7lr3p00R0cANFsVcu+q7BNvTLYOZwLQhbGY
	M2Qtz/OGCyo0B3sWfC4SHNKV1V5Hd6av2tNd5Vh+/xayAKqn/nGVySHw3ol8qTFmWl60a+2gk3z
	rm3oDfsxR3rw+k8mRPTrJC1ETpUbCHHQljifJZE/BVeCJb8FFjOEAybfFIWOhaZ+TjDQmQyGtb1
	XOTifylHvtgCC+9nWvnmiflHclmIcyZk=
X-Received: by 2002:a05:620a:3f97:b0:8c5:3881:da8b with SMTP id af79cd13be357-8c6ccf1f14cmr578903985a.59.1768989313299;
        Wed, 21 Jan 2026 01:55:13 -0800 (PST)
X-Received: by 2002:a05:620a:3f97:b0:8c5:3881:da8b with SMTP id af79cd13be357-8c6ccf1f14cmr578902185a.59.1768989312812;
        Wed, 21 Jan 2026 01:55:12 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ad96:3a4f:e269:c0ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43597bda41esm5766544f8f.28.2026.01.21.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:55:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Google-Original-From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] at24 updates for v7.0-rc1
Date: Wed, 21 Jan 2026 10:55:09 +0100
Message-ID: <20260121095509.16678-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MiBTYWx0ZWRfX0gJBkRVuoJps
 iijW7v0FNNiN4lFx9iitQzWlKEt6hFA87h9QA1UlgHWknV9N+u/TdOfOve9kBUlXrgNJCXBm2vP
 HofPAHaAMBt9p5cLXNKA0vjvqOgLyjrStrT6orb8JcNkFDRCc0fIsi3akEKnWxEkHu+l9vnhHyN
 I2X0+KWmC8whUGvhpHtfxSPwIE5YR5qUetAWWaO6ZuBuyHH8DgKbZPPMKHRDhNVuYvAQzzUQl0g
 L6eQUxIzjGpdARX06TD/XsynW6MPu4m2I3YibGbciAjUHuDHTPRl003LihJ41fzBIKkSNVNJHLz
 qZHTIWyLlSoRb6fnkdibeN5kMyQadzCJnDL1bSPw6f2HMA8YZs6g2P9mxNU0f5whhQAh619tZWe
 LzqiHg1ZbxalyAgFOwkiwq0RJ8Kvuv1pTOKnR/p0JyHJ1QVETvAKBaSdkN6XXDV5IdUvJgBhv0D
 X+7gv9crPfru601MTfg==
X-Authority-Analysis: v=2.4 cv=S5bUAYsP c=1 sm=1 tr=0 ts=6970a281 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=lpbUgSyjs7udtc5wli0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 8ly8LZznjvFOpRRPVl54StUJdfsg2LCt
X-Proofpoint-GUID: 8ly8LZznjvFOpRRPVl54StUJdfsg2LCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210082

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Wolfram,

Please pull the following set of at24 updates for the v7.0 cycle.

Thanks,
Bartosz

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-updates-for-v7.0-rc1

for you to fetch changes up to de284988c270cc16a3fb41f8f6955394d4af2a12:

  dt-bindings: eeprom: at24: Add compatible for Puya P24C128F (2026-01-21 10:50:12 +0100)

----------------------------------------------------------------
at24 updates for v7.0-rc1

- add a set of new compatibles to DT bindings
- use dev_err_probe() consistently in the driver

----------------------------------------------------------------
Bartosz Golaszewski (1):
      eeprom: at24: use dev_err_probe() consistently

FUKAUMI Naoki (1):
      dt-bindings: eeprom: at24: Add compatible for Belling BL24C04A/BL24C16F

Luca Weiss (2):
      dt-bindings: eeprom: at24: Add compatible for Giantec GT24P64A
      dt-bindings: eeprom: at24: Add compatible for Puya P24C128F

 Documentation/devicetree/bindings/eeprom/at24.yaml |  4 ++++
 drivers/misc/eeprom/at24.c                         | 20 +++++++-------------
 2 files changed, 11 insertions(+), 13 deletions(-)
