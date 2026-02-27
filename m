Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8A32B994
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172958; cv=none; b=QVNcSHwGuFigMnrBlfzCiBoIoFC0+Oqjlacd8BSl9YGIe/igBINP/H1lh3ik2WyE3OsJ2xCYbvt0UWHhaWn3sOWvXIQ5gOderZrSTBMclQDtaOjZFbliqyy+eLs9Mi2nDeg/f+rbhxPiREikcKHI8il7VyHalgeLrhbpIcli89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172958; c=relaxed/simple;
	bh=CK1EiWH39nIgMGzpiIrw0qj4PZJ7T3qmsANCuWgg3Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DL70r/+yzL41J9Xcf9450HlzQd6OKTaPf/Qq7TMupGaPqdEMCBpgEY4b8U2hjdx903ASoLlakFSlwBRjNh4rk5H7MhxO98wFB9Pq8r/tEs/fXeN0Q7PsXrJyTifuTZeKNBeJCU15pKZdOxetXhCWzUCddUdKIwzm/6BO0wsajmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPnuW/Ff; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3Ei3+CN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPnuW/Ff";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3Ei3+CN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K2M61620133
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=y+YVL+8ip+GvScu0qrmLIG9vdAth+JBxGdw
	WOLm98ZQ=; b=aPnuW/Ff01FGBG9I58LIoQ1oZQIynm6tPSWrFeT8TV0eG+wvbmR
	Ay3brOoscnhptvKJUGwMalMut+15GWQy0ZMA4s+0HY3Q99GXA7BC2HAR2j1OFaoV
	b3BRnVS/XHUEnld1v56EASvM/iVvxt3Turt5cvLjaYlQNcxMx38vSLF4+ym59+Rh
	1znWCWnhZI5nkgyYpvk0FHfuDDVpdfxozfsnyPf5ZMBbzWFVtNML2NuxSz3q89rp
	EisxyhVP6wqGADK2iejjZrQH3JEZ1LiReuPkFA0ujaRQssZZp0rQPBNP1DJIlTEL
	PHmqcMUC8/HU9cHAYraK3Cwvvr+v+v6nLEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjn0x3efd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:15:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaeafeadbcso18011415ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172954; x=1772777754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+YVL+8ip+GvScu0qrmLIG9vdAth+JBxGdwWOLm98ZQ=;
        b=A3Ei3+CNwHImB/zXSJoRLUJyLUrmreAYtUeK0C2VqitLr4ezGJYxLUBlS4vtr1nkpl
         DTHH9lT5S25tZ3AEje0aTdvmB14bPxsuG9wZW1rQFe2HRuMnO6eY4gOmPVSird0keZEt
         sGCuFlFsekyB+eZ0ZOPb2c6ZBLuR2XPRYh1b5GXv7UyL6o417GzGTj0oRx+LAwht7Lx2
         8WfJ4hszWuFNdbM4mR/0Hhzpb1WZV5DvaphZi09MbA6mAI/yAt7WlpdTMOYtdSYIbQvv
         qESzXcTM4XAMAUs9uYPOvQEH+8gs76QXp5NdTiQLUenxY5oHFzOZvZR6zZfaN/5pmb8W
         PCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172954; x=1772777754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+YVL+8ip+GvScu0qrmLIG9vdAth+JBxGdwWOLm98ZQ=;
        b=GZNtmKoJbyHN9uDxq4b3xDsobBnonTCd7sDUAH4+pZyRwvuEjzQKNG9cVsTdgjK1ZE
         gT66e0IZOZJNZah7HgJvkjj3mk3NFS49r0msgTy1Lbg1ZvlxcBZcyU6dUL4VHp0sFGWI
         YYBXhb+Swx2hhA/hgNu2kwppzxHWZRAx0BJDpXisEZAKR8r9566Qg/2nPm/L1minKNQI
         9IEVTgQkvaX4oW55T/Li5TDAVg+KF8UD9Fk8JSI8qw2g9LEt0xJP3d0lYdEwhSLe3bbp
         jWZOP0zWM7IUlaE2ieopsHeRdMT4UUumz6XyWpDbJ7kBPOYwLV17HJtyPiS3nIl8dM2B
         2DAw==
X-Forwarded-Encrypted: i=1; AJvYcCUTXRhBX9egv07MbfbSxlN/RgLHH+999eA0+79auD5P7XhWUAv/soT5cR8WVhYFrBzAAZ5EBpAMUx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2Jkxp2bPHdeNWwWmaVAKGjiLSKjpIZN51U7d7plM/iIfY6c4
	RfZr4izBepDgdUE0LuskqldXgk9NGbRTW+FIgw0wyBQXBIQsUAio6pF9JT4mJBQzrDxgzKcciSS
	TMHUSPiOcA4gl8AGG+UE/+T0L+Jqj1++eQKZjIR16OYmiV1WVR1iqcuXCXwiAfvA=
X-Gm-Gg: ATEYQzyrToZGnGbgyXHxiRn9NsYpqE5bsMIea9yWyDayKxTouKO/Ni0JKexhToMVmzR
	Je/wNDNHfUFRIuoe0r+zbuu7StrdbcmDaqQfnHKsP9IASxWn1jjVk3wDOWtAnqL7nIiZx8QyGER
	uUbkJ9QNqILg0dsGfrKCqWUCcXvBXp2z6FWIExNk5Hqmb1jyh8bihQKdRzuwOYgtbJP8Wa/Hlt4
	+94zQbfvH/T5fCUirqrgMcKvLNYZiwxNHCUf0pZYCIhcq0g/NMGVsckduN2Tw3uY0/jpoAAbbhB
	B4nOOlSKGnxcqegQr64VpUb6J727AIbIa1SMpMC0jXUxNSZ9LckQDeSO813hs7O/7JBxe+9/RB2
	6yAoPp8AdjLX8Wzz/WDAEkg4msnr6wUVj91RRlDkUA6uR97378n62Jso=
X-Received: by 2002:a17:902:c94a:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2ae2e3f14fbmr18877285ad.18.1772172953981;
        Thu, 26 Feb 2026 22:15:53 -0800 (PST)
X-Received: by 2002:a17:902:c94a:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2ae2e3f14fbmr18876965ad.18.1772172953429;
        Thu, 26 Feb 2026 22:15:53 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:15:53 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
Subject: [PATCH v6 00/13] Enable I2C on SA8255p Qualcomm platforms
Date: Fri, 27 Feb 2026 11:45:31 +0530
Message-Id: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z1-fLRqD5pNgADirElFFhc-EW_WX_3nL
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=69a1369b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=8413JC8MLbS8ckBEwAwA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX6LcOTASULTGE
 U/FR5h9xlIborNEjTJ4aY8rf2FRRud2t/M1LSqyPiEXK+fqbgzhGA3+GQLYladjBCjmZiYOBJVm
 wL6aicFWIBar19NSq1OCpTY9l4BpZAdp1FnhuZvRf9xBLeLAyh4J5I+0Mvu4DzTURqCJmUeadVw
 O0cbD5n+hgL+p8DesFUhEPvQ3+4W2W+OHpMgrIcZ4vzj5ubHnr0dBx5rU469cmJGmUKWjbhoVgO
 EPgYKog1hwSlhHU/tPlr/unSTgf6aiqn7l8aTe/F0FOyVv/aQJ2vpCh/YtkDiMFNmQQNct+rZRF
 sLnv7UcdtJpaf1T6Gck2ev3+NWAkwWxrrCnYbqwivALtzTFWbNrCquyxRsW6nL6mhwkrmONp3yW
 oWBedXm+X+MERzhPEjFbiiibeQgS5nWcKY7sRuv4JMWAxDx3xWQirjbDWSu3DboojAj7jWawG+L
 /p+nmVdR5D7qNtsRTyQ==
X-Proofpoint-ORIG-GUID: z1-fLRqD5pNgADirElFFhc-EW_WX_3nL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270050

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages I2C frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate..

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Praveen Talari (13):
  soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC
    path optional
  soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
  soc: qcom: geni-se: Introduce helper API for resource initialization
  soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and
    geni_se_clks_on()
  soc: qcom: geni-se: Add resources activation/deactivation helpers
  soc: qcom: geni-se: Introduce helper API for attaching power domains
  soc: qcom: geni-se: Introduce helper APIs for performance control
  dt-bindings: i2c: Describe SA8255p
  i2c: qcom-geni: Isolate serial engine setup
  i2c: qcom-geni: Move resource initialization to separate function
  i2c: qcom-geni: Use resources helper APIs in runtime PM functions
  i2c: qcom-geni: Store of_device_id data in driver private struct
  i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
---
v3->v4
- Added a new patch(4/13) to handle core clk as part of
  geni_se_clks_off/on().

 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   |  64 ++++
 drivers/i2c/busses/i2c-qcom-geni.c            | 324 +++++++++---------
 drivers/soc/qcom/qcom-geni-se.c               | 270 ++++++++++++++-
 include/linux/soc/qcom/geni-se.h              |  19 +
 4 files changed, 491 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml


base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
-- 
2.34.1

