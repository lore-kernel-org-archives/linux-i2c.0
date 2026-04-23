Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389A3A8732
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965756; cv=none; b=HTZGBbJlRFLR83ZYtqkt98AmEnydellxPMUSgc9nh3yIJgOs0ZbNzbDFKA4wJr+q3FoOIVEVIXf/d8k/7J90qfXPnhoXFQMVlkHhGqwx59SzoLD7Nqrk1gFvUmT37SIpq1m7TCLgyXoNKodevKcbDnvgiAoeN4SWxmznhexVBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965756; c=relaxed/simple;
	bh=Nevy3ShXWYVtplz3FpmtjCogr8pPD2uB/TXIwaI0LZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOl9ur9RQ6HByEYK9Zd/Lz/TFKqd3TCJ9BrXnHf3T/OLhl01/3+50GA3OZmSEnZ7axocns0IQ8roYcOxCWx8Tc7aAaZ2WAKzXgpdRSa//MWfYuXNWz+ieToU3c7xbMVmZNvba2gJLFs5K/kYFsQRtenMDPKxETNlAyC7gw96Lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FfA4OaE3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CaxZt9Ol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FfA4OaE3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CaxZt9Ol"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NGAKYx4012159
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 17:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LwKe9H0jDKItDh6x0PTGoS+4p8HWCjdUazD
	5Bx88C4s=; b=FfA4OaE3zsyEYMg+Ed7vgv4970lFwoee342mPnARGkR3MmcEHyB
	j6ew5mahkURdiAGBdqhlw7mGfa+d0qdDuiCcuf4PVz/gy5DqQvn96ARpZtOcpPbz
	lFD2cZE8FA1V+aGvB0fh6FRSXpijDu+1hEuXS2xmQtShz7fSo+Sh/xp91K1e2L4R
	L3ZX2ZsxSW6PrU3R7vXtP8ZW94LjjOyuhU4Y6D6Bw/VQ9zz0abyRgvBwyhIKJ3Hl
	S2FVe/9WUsButL3EtXAXTZqJ/ab0Y4krmWWpOMbl+W7Hq6J7IG0maRlWPveBCGaZ
	yUB47l+NFRiWa0O7LZYlcuzsptCL/RwqUSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9rbbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 17:35:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d84b5f73bso226085171cf.0
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776965753; x=1777570553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwKe9H0jDKItDh6x0PTGoS+4p8HWCjdUazD5Bx88C4s=;
        b=CaxZt9OlBILs1g7ZMjHaHYPVyPwW9zDp17ZJDmwPzPMl3m8XTX0mdcUATk2rr4+a7h
         nhWwhL9X8IZ0ja2ylUhBrYCzrUa/PeQoH97f88mXIGx3KpU35r195olkmAt8HoEVt6cZ
         FbfxzPt2t0ntaSj6Yxria1gTkVCJCpT7lsdbeuF+cjw/8PPRY98D+5bpNK9TGvCEr3/M
         hSMfPGqyCdXg5KZss3oGG9AZBHzDTqk/Q1DdqzXr77nvXtnUa3xzMkZfVwmFa2Gf1lrZ
         gAKOB3OHTqCx8hDXP065JCVHELo8U5ZcZg5glAJNp2dERAcS0k+wnEc8ZAYfTm+ETqXo
         yhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965753; x=1777570553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwKe9H0jDKItDh6x0PTGoS+4p8HWCjdUazD5Bx88C4s=;
        b=VqrJKil0/aaHevdnympJ3wiHnVaMvzdI3wV82XINvPd2Pmmix4IpgpQ1B+LHSYONo5
         yQec3GSsizt4+sW329Bmn+zPPEGDeRKEy/o8QahOFTryRb0r7Z36scEmFH6haekynChD
         wbNQKTmfJUNW584FJ2rfTR5eIPDCW1iI/AGFJvxv3IXYUdTX1gbDiVhe1kK6aabtaiFt
         D/QAPW9qh3X9uPAZs4QX6T5S8Vj+vXXbapB8CrTnTFJCPHQKc2j7uOVGzcyXnUysymim
         DTnCcgs55YPJtp+lGTe9EEfQXKqzTQAQhXZH6qMqAYJiUP6/633m3YRN5UhwtzFixcfS
         7irw==
X-Forwarded-Encrypted: i=1; AFNElJ8aVv2525PnkiBpcSnE03k9uv64PRczZWG8qB/M7xUZ7AOaSZXhHAigvMwGPbJFzrKYdwVMM8w0Pro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaqRohzFj+XQDBe1UjG21pnF+hN6DZZiJ2EmzQ4NzNcWIHWL9
	8Ct4STzWSY2JZqWTNds+m6QNU5yg/10Tqo8OaeJx8yknAW/Ad6fF7MGk/2FZZXqj6PdwAqopMbK
	S4AfqxCNOdxSFGnFf8PnzQNZWg9NNi+7ftiHYWGAdVvKtVLWpnZmi9QS6jYjPqzep2TgJwmg=
X-Gm-Gg: AeBDievJLW4cDQdyz1UgICpPLZu3g8SSn1UnW3gfqNFpNIyJD4JET5qD3chKBUFdOY0
	UsJvDI1n2h0pFu0tGaC/bo4XrakocUgA6hEAMptOAjTctbp+lS5f4x7p3fu+LtKJ3OIO01cNCX0
	1H+etFIQh5WyY2hBxAbw8+oT1CEcGh/9etNHKzDyMZZJV6KV/MvHagkjAjBdGn5g3mBiIDVrM2M
	5OH4pW4eP85bWsVYBr15Pgv246i+IUvVte2azpn1UOlRv9MkGNtZJFTlYRanATHzyjqDSWDMfKQ
	0qeU6RPDJ/mJ3qUqoOFBP5kdK6YqJvwSspeyxn3c8XJY+H1IHWL4xPJ+HxNioAP1ohXEROdPwII
	PprHAwJepYGQsJwFs8QYjmKK6k6L9pqBoNWuGpDFnl+bRrGM=
X-Received: by 2002:a05:622a:4f:b0:50e:61c1:685f with SMTP id d75a77b69052e-50e61c16accmr249940741cf.50.1776965753554;
        Thu, 23 Apr 2026 10:35:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4f:b0:50e:61c1:685f with SMTP id d75a77b69052e-50e61c16accmr249940291cf.50.1776965753157;
        Thu, 23 Apr 2026 10:35:53 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm54380355f8f.4.2026.04.23.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:35:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] i2c: qcom: Unify user-visible "Qualcomm" name
Date: Thu, 23 Apr 2026 19:35:50 +0200
Message-ID: <20260423173550.92317-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=Nevy3ShXWYVtplz3FpmtjCogr8pPD2uB/TXIwaI0LZ0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6lh2sFP0JSP8mNWa6++MOYyAcOYB1BfUzArab
 d0L7wvhFOuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaepYdgAKCRDBN2bmhouD
 15+gD/0XttKeu5vDSeXwEOa9Wnyez3938VcNRZ3JYKzmAvq1gQula3sKunvJTXnkQ7rb+amj6cM
 GqKRSy16wSUcUB2pOVk7V+hRD2Y/2NXhygIMrBt48rBhRtx3prQj6Zj6gqUcSHbIG5RylDVinf2
 IhRt9OYc88dDhf2j4PLh997BfhuIl52taVSbkeA+9x9kSmTwPVbChTJVNVZH6HvZ+Mgrt3w7h10
 uvwkbPjx1T/bMgGkAkqNYZXuCdNh4IVCTS1RqzrDwYQfV5HD8oBYfrwQz2XPQq4SExDd/k6BtZ5
 C+cPTRZZloJOovc1pJfJQT6sxkibo9Gbi3h8/4dGRx2SUnUUiyObMas22yhf0AkhOmCwdDW1bnH
 +6yBQSfWXRo05F3uaod5GYeItPAy9kUnAyNHBgxWBOHrFvTaew8j4EJM3Iy2bFFv+7/ZPadsOwp
 fzDxqO5475CtunNR+LctTyLVd6t0UKxJUJjIx9IlTJfOpkqLssVRYayKHL1HvEfLrggsk6irQqD
 FxrS6k1ZoZXQtleapGDOMNc3eDSo3wzL5QdG/GUCOaAeurXtLeOhNeE5PVu76EPrD42BWnLf4Bj
 Yq7+sUPyNrML+OcrXjGVxc4qaYMvHAg3Tiv/SnZB1DSs9+aF5xolQFvCYWJv4uwQMoqBWP4f8/S Ymnqqe3vr06v1rw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfX/aV4RQxoR+vm
 lKhl7xj6NinmQYDtmq/weEh+hSLpsezJ58uFf4U6YRXaIVKLKQ8Z0CrEgP4HIkZhABceo5xi75j
 IlC+5odF9kuPBCyYHQ8+9drmcY/PW62MyqlMFjAhSkqn3bHJBHnNt5tmu0M5vjeW4FeGbM0j3Y8
 X3VCJ/4ImW3mD+p4X3SdRyM/CMT+cmDERfHknLNWTRnamiBm6a9xOIwWbLQNNjNGRkSZ410L4Dt
 PRJOmg94xxa/Ki3fCZBJefsA66R18UyJL7476hWddE4fbjGYNi+iqgATewhNujgQYT9HqBb7GoM
 FTIeURvcw37elOOgpyxcchgzu5MiRQ+JPO3HcnpdVQIxEW4yzhPPJ/J1VoYPvVr5VI5CpMJY9Wd
 kDTKvrTWH9sqbWkfxhqEB41jyOlbZy0q0VEDksC0razipD6Qhq9Cx3ZE0ukQ5Hc4zD6Czh2WfSX
 qCpcGTwvYrvIdqHBQDQ==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69ea587a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8Z4SLfNuI_jz2Xzq8HEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 8K_daLg0MJvs2P3bCHzKLLHEYKURxcLI
X-Proofpoint-ORIG-GUID: 8K_daLg0MJvs2P3bCHzKLLHEYKURxcLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230171

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..cdc2fa51fb90 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1046,7 +1046,7 @@ config I2C_QCOM_CCI
 	  will be called i2c-qcom-cci.
 
 config I2C_QCOM_GENI
-	tristate "Qualcomm Technologies Inc.'s GENI based I2C controller"
+	tristate "Qualcomm GENI based I2C controller"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_GENI_SE
 	help
-- 
2.51.0

