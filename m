Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAE3AE6E2
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523468; cv=none; b=blQHXgNK8GSO3A45ix3foB6u4ooD64YCc59d6JrGpXrB9RMmWoQrRnycOSUSwpJqtmUqVnfyvetAgFmuDptFMD1dfPgETJv3gXib1Do3szUegb2ex1foBIFjRgDvCVJSY86SZduxiU1sYanjCQam0r5S1QYtSECYMeRoa8ArAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523468; c=relaxed/simple;
	bh=Au4LybUfTiqkTdTHsaRYZAfGKUJf0+c8s4BPVAExPKA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W82ikSKcn2eIQ9ljE4WJqwTu86Ws/WWu9A2Cd96X6iXP9KnvCQ9czf1hCkpCfYLBhPrCZTgiSt+yy23vxyEjEiLxtShfBCeCm//TpDezRjLGEcubHOgycxHb8KIwuL9aIXRDl4bVFBE85TJXJLIdGnkMNmfM/R1jijCCznLp6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLoXbSrT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iRTNpvVx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLoXbSrT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iRTNpvVx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C628oY3506061
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c1Wnzoct6vCWZ6w6VX0TjA
	CPZO3HCWQAYpOF7tFvREQ=; b=hLoXbSrTXkxzy2L7izWyUJLxdGurvYvUSMRw+t
	uNYBRtp+gbLJCk2PKED34dlsMVN957TvZGTWc84sZ+y4oihZZh40cWiyr9R6Ak8Q
	4Za/8PNVIBRfOe9A5Q6n2gSbhHzrbmEDRxLMSxpRSl7dDsGFrRafIUHm/W2nnJwQ
	RkseKCHpfS/19tJr0cfDqYpgNpvyLML7kfCZByRorqWRqxGImvmPyndoZ7B2//g9
	0JfpaiPZRRhl1YD2+ETNqRdYjsDbiVC9UGiXtY5IgtudThPI2DRTCZ+thyZUWMaa
	ouz3yBPfGyPvlVFUJsPAqzN6sbH5ZK+q72p49qEb6h/4DD1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5jwx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:31:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso807755a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786523465; x=1787128265; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c1Wnzoct6vCWZ6w6VX0TjACPZO3HCWQAYpOF7tFvREQ=;
        b=iRTNpvVxGTRN/VgOPZsyAePRuxlemwv903qxQOcOPi/kPZKcoptW6q+6VxkvGtkcwn
         zCLA3tlha0UkL5EYie/uIYXT8QHsoXBMk2vfdtwpESPpW4fXOS4Tnis1AhzaXER1Iqt3
         pMwcF1rcy5keOy0egofC/imjy4wo/9D9u79IpwgjIiyIx2xOqecO0NeHoSv0tUr3iAkV
         ICxI3Lp5auGHIVG1n40B/C0EKFRgSskGUkgjIYBKzK902UkXsba1qpsRnxZFk9DZhLQD
         hkzzU6guEdM59yLAN2jh6MZCtq8TqESFPr/YDWBnj5rzvjoWpAZlZWMJGuuDnoGNPJAt
         P2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786523465; x=1787128265;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c1Wnzoct6vCWZ6w6VX0TjACPZO3HCWQAYpOF7tFvREQ=;
        b=DGzbbsJ32KNLQ4KAzmOrXqjthfPD/D7XcH6bJvRucpj7j3ODsZifmCChg4Bd4b0e3n
         cEzVtVxkUxQP3znc9NAubsVu+WtuT5AJPlAPtyIdAGLU5b9DWMAIVupumoCgA76Z7JIT
         bnE2z+zcH9YKKoZDmLGBjdou58I53710qxALSOODpJHotrPkt52k6c0NBHeBbwnB05Bh
         GJRyWsNH+4VjsYJ9NLgJpfI7K6rSJQqjcEzd2Wrcel+V+4IgjfCsnvXGDis/TaDrM8v7
         hz7widFmRqsrfrWNM1sZxH6YsRdyvLLt016F6CVVe3R0IXmld3jTColhx1A8AOhNCaFJ
         KG9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr9kk4I04UU1Zp6hnKkP6yW1WGhuiYw3c5J0TfZh0guUVh/jfE1FN3+FYSAzOWEDBxeXqcQfsS6xrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECjMcaopSCMcpYDs0K3T7XQ7dw2YKEW2JFYPBLI0/Ll8D+7mW
	Bkr/X5T/1sAEk97EClZXu5/BsM9cpx/tvwIzTH0CDtYl/XAqA3rzfMdRDY9EvGbR/83SUsFnd5j
	7nHIzPbcBsFcmggSEzt74bVR1/isYsS6spaIxV/EfsgWhZfgfdEq1BaoT2BpQqmw=
X-Gm-Gg: AR+sD10ZIQFbNekSAgsB+1OJ5i6bnZYsEkvGi9hDVgoMNFODwuC13c9s66HiP/HD0yS
	mpz46r7qldRwm5/7JxAXc2A8BMv5mpBHi3zf8K25jyZI6aWuqZVag/hkQGlLKjWu3OPzVf/hI9V
	oa8+8y4dEJ4/StPuIQAEg0NgpSTWnaX/+YjsaqLyycuNPMfZTb3Xq1GUQWjjW1QagUF4RG8VUsA
	CAQkgjSCvmvYlsMakGIRAkGNf2AQzU9RcDtfDzCd09MY2/JHbDqI/dxL6PNBWjlC0UEYmw3pdri
	99YPtdJTnpP8Clb1ChSq5gxgyKRut7NFQ+sTdXCih40cOgRv0Ag9r3eDaYSvKB1zIRI0iam13YL
	flyZYE6HM0JBHjKMgdgtIAv87uBLqaz+JuH/QgGat3F3jvs7Lf5NjQIuJeq0kSmcZ8EiKPhP3zy
	VwJeGLZ7rBrrd+dqD2KBaJi2ESeBR9J53LFyM=
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id 98e67ed59e1d1-39301834f69mr3829732a91.21.1786523465512;
        Wed, 12 Aug 2026 01:31:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id 98e67ed59e1d1-39301834f69mr3829657a91.21.1786523464910;
        Wed, 12 Aug 2026 01:31:04 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245a9f70sm9942865c88.15.2026.08.12.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:31:03 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v2 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
Date: Wed, 12 Aug 2026 14:00:54 +0530
Message-Id: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8vfGoC/3WNQQqDMBREryJZN5IEFe2q9ygiyc+3pqjRfJUW8
 e5V2203Aw9m5q2MMDgkdo1WFnBx5Hy/g7pEDBrdP5A7uzNTQmUiFzl3w5gmKqmcgoqgrebB6gm
 J1zIrMi3SQtTA9vUQsHav8/lefplm80SYjruj0TiafHif6kUevZ9Fyr+WRXLBjbVgFCAaq2+eK
 B5n3YLvungPVm7b9gH8J6U/1wAAAA==
X-Change-ID: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX0XkqhRGQXPyj
 +eiHP0XPnLEIqduaUVTNxVQRIcyf4qKP/MSrLtaGuCdv6J2LiyoveHIbnimYQBqqqniZIBREtdj
 TmLwmqgOzuwYM4JY6rDjkzM3qIG3tBc=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c2f4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=cGTXhytWI82EO-564y4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pTRMXamGgy7iXh2heV2_2jEhNy-voabL
X-Proofpoint-ORIG-GUID: pTRMXamGgy7iXh2heV2_2jEhNy-voabL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX1EaDxRcASSiv
 /u02dMawWaw5nOcAkwgYggjUYi1Jdy9JKoT6ZkyyxbRUUAk9F544n/DzxczDTUtz5pBT/BK45yZ
 OXRD4UKRiD5bsusof5SugHO/5N0XTRTdcYs0J+L4pmPz8aA0rbujz66KUi9qtAsmraygBVuKWvo
 DmITfc6KQYF1tNc9uRMQzDhMismSng7KL0IREYnb3Bc87gsQAZgkIy2/KW3MiLJI85El7V1S87s
 uovgJ0HOkb2Hkd+GZOgxSvFdRM9L8kwCpD4fr9ZrwuywoV5gIuPBIoNMJxdGO9UpMN/ViHvWcGg
 WGebnnE4kcfLa037YlpVl7lVlb2GPB4MTP1tZ9RtqOJ3vSX8zVZ62KrlvUxcWByOVBo76+WkpGe
 qwHrEIiH0h28kUAwvTB0Boq2MJLHps5dOcxXeoVxtP1RnS/1eHTeDGOUTPQ+VSjd+QP3dfsBz8G
 Pc11RRCv/5mvwGG0hxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120067

To meet the specification requirement in the standard-mode bus frequency,
update the SCL counters as recommended by the design team.

IPQ5424 uses 32MHz source clock for the I2C and I2C is supported on both
RTL-hardened and firmware based SEs. The driver already provides SCL timing
parameters for a 32 MHz source clock, but the resulting I2C bus frequencies
do not meet the required specification on firmware-based SEs.

As recommended by the hardware design team, use a separate set of SCL
timing parameters for firmware-based SEs. Introduce a dedicated
frequency table and select the appropriate table based on the SE type.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Reworded the commit message to provide more background
- s/geni_i2c_clk_map_32mhz/geni_i2c_clk_map_32mhz_minicore/
- Link to v1: https://patch.msgid.link/20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com

To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Kathiravan Thirumoorthy (2):
      i2c: qcom-geni: update frequency table to fix timing parameters
      i2c: qcom-geni: add I2C frequency table for 32 MHz firmware-based SEs

 drivers/i2c/busses/i2c-qcom-geni.c | 29 ++++++++++++++++++++---------
 include/linux/soc/qcom/geni-se.h   |  1 +
 2 files changed, 21 insertions(+), 9 deletions(-)
---
base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

