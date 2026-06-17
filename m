Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA053314DE
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671839; cv=none; b=nGPQTBJPmTdegONu8lByOuDwd4Hpdd5EKJGJT43jxSnoGTwwr7CbWvulBIrWx0oNl11XTVelBAO5cTBvob8H73hAoivAPadyof8d6uUkemOx9cria3r169RBmuPD6UGLxFL+k7zi7W/hgmZSVluIBEuBnNHEKo4h8TRVruaMbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671839; c=relaxed/simple;
	bh=spKFOt2uQRUmgzg6z339+CqBW8ZV0D7qW+BkRQNLY4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mLXdgT3hmyh1L1QeaXaQ/7aUldXhvgzVBQOr/HQH/5c/5tOLVEoTcF708WGlcQWno+1V4RJr185GnaOKdK9pmwgQHgMUHlBd2LxOAmT+NXO6CPV9Zuq/qqvK76aAZSjITsiCrYp457Ko8F7Z3x0uWEMltfU+oRdN74yt/1AJ4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzFsKFqy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XoOyujLL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzFsKFqy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoOyujLL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLTJDu248916
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wLUVYnlfKmcir+ZX5+8Uen
	3CpnqRprkzNTALqEG16T8=; b=MzFsKFqyJE79frU8ZCnO/ZSMbru2OzqI/NwKq7
	XYuRxg34Fs4ebr/o3bC4bqWKJQbNkLw1RoFq0UPYBp2DvF6ezIS3+VEOpcqVfcGe
	EcBw15glot8F0BXirORDhPB5exXCD4u8QpK7d2fqO+8gB/jxNCt2dMQQpAkmU0ZX
	+NXFBzerllDhkLIXhUnI7uNptsnVG24mpaOKJP/q/H5sXAlUcFQx96iiBO7pX4n6
	bCDhftvHy6xkMlBFRuXXprqUlRaMEhex51/DM91Piht0/fzQxD2BzYWeersB1v6A
	cnj1wYvsEWVsfk+YswsPOhMKKnrMEO4RlB9KccmHetBrga1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet1au1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84235f9b91fso3864614b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781671835; x=1782276635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLUVYnlfKmcir+ZX5+8Uen3CpnqRprkzNTALqEG16T8=;
        b=XoOyujLLxfkCuC/P6AGBE1WcpU3c33MSnPak/64VBNEs7aFDR3I9e+hE4KiSPwLE87
         VK6bTcOvMUo893WTyDcoywuLwi21peLSzr+s6FaMssrsXVemwqk42fPMji/JjiJRm6If
         7hjtMUQTDxGpBv4w+baVN84dhgRZgNrIASZec5njnKJZULKp0GJICrtu0JNd+UTPeuc0
         OGk7tCXWm23AP65ryXpNo/YP3go8aSYf8NNJs6vJBxSXIqO/u4q7zzU4qzS4ropR1WmA
         G9GPUYuAlyyXyZqXfmj4Z1iyx+VB+hUjEAhRJn9B8pd/q3qPxUfFdsSWJ7fBb0H1gyen
         2PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781671835; x=1782276635;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLUVYnlfKmcir+ZX5+8Uen3CpnqRprkzNTALqEG16T8=;
        b=R6Qabgk6zlQVRan0IBIe+NySvDrINjvLi13BRUXofCtRTK/OSINSx3dOOjvyZrsJ/+
         ZcmLXIffr8lbtc7N8EXYYebxBlHDDUTpI+yUuy8qj50Nq64tdc+ANMZ7dy+nypZbZX7y
         e4xrn2r+GAnSNkE2BF555ck8yQObNDGT+NlVV7qG54ZBvLtFI0OywVgk2bVCPfb7hQn8
         0BNOOJHgmus48pgzsqbUoeSO99HglefxPdl+CYMufEwTEUcE7JYvx0Fs6EgjeY5ixwaQ
         Mgv5fpTrLC3a7pth227bO7DmdxZANbzwBNM8Fzq+cr34ZcDhI/8SbW8v4TOE3LGc7NF2
         sD+A==
X-Forwarded-Encrypted: i=1; AFNElJ8hSRYZjxbXKfRMVqABQ4HLG5mkOZEGPmYokgtzXN0u+8+G41D552PKF/Bz757GVaKmjP5F9/T3y/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhV9jabdkxTROBg+INV37hBLk+3aAXqHeskKCgAFSmWP9cvJdr
	x+0uZt0ugwj7v7BbBVT8zsQVqt3ebMarSgYTd5x54iKmoqoAZEgIjJB7YzZh2N98OyVYjvUgnKT
	/xEtAbPAtXX5auWbNjHaGxwkj6O+ChQO3YXxodauZSfnpMBz4KAc3m6B6dGPRRL8=
X-Gm-Gg: Acq92OGLSz1+5LeIp4MJ5RJu1wfvlOE2psmK8CIWyLmpWpHyXXn0Y4ElredJvFOsPHn
	qrA/MMh8/pUyZ6XpIArRYYqIbDIxgDv5EckaMIKCf0rL4TAhIVB81+Om1coWQl2dL6a1W1y7RtY
	8c1kgS5t7jMlVMpmv3JIMtQzd2LYJZfiqpSIypiTSIPFhVWk/phxJNzWi57lUJwaJZsiHTdvkaH
	bHGzVAiuxeZDWiKXns4ICWdwjeeTy4hY9bLJB5o4ZXR3KYjdBMTJzxoBlpwVho7OqTFB3H8irci
	G+rdoi0xL8BLJuC3hNWozSSMQOmEjgSpZ5Ucq1BBrnbAuJRiATVghjzsdl14UyXW90m6Lrmhfy9
	j4iI3xKvJZwXjsLTinXrsrZWtopchbQLGAo6sRyo2YosQ
X-Received: by 2002:a05:6a00:a10:b0:842:6fec:12aa with SMTP id d2e1a72fcca58-8452440e345mr2197135b3a.8.1781671835038;
        Tue, 16 Jun 2026 21:50:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:a10:b0:842:6fec:12aa with SMTP id d2e1a72fcca58-8452440e345mr2197093b3a.8.1781671834434;
        Tue, 16 Jun 2026 21:50:34 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm14721127b3a.8.2026.06.16.21.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 21:50:34 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v7 0/6] Enable I2C on SA8255p Qualcomm platforms
Date: Wed, 17 Jun 2026 10:20:14 +0530
Message-Id: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcnMmoC/0WNQQ6CMBBFr2K6dho6UFpdeQ/jotRBaqDFFogJ4
 e4WXbiZ5P38/2ZliaKjxM6HlUVaXHLBZ1DHA7Od8Q8Cd8/MsMC6qEUN5E3T5xQtBA/JaJRyhKr
 EBktdahKa5e0YqXXvr/d6+3GamyfZaZftjTaGAaYukvn7EVX+IauKC6XlSWkQMEazEHk+md5Ed
 wkp8ddsehuGgefDtu0Dranv6cQAAAA=
X-Change-ID: 20260616-enable-i2c-on-sa8255p-432b23838e18
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        prasad.sodagudi@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781671828; l=2902;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=spKFOt2uQRUmgzg6z339+CqBW8ZV0D7qW+BkRQNLY4Y=;
 b=DikS8Znj/WZofRiWUuac6aEGo8lXrLS0DgcxgWccwAHAXsK1hzvT0Zs3P3Ufg6idqJugURIiB
 B1qwMNjWHMFD7LK5rIq1vV15qtUIoOCRHE7mAx5J5MGvNDHUxZ+BIRu
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: HaeRODUOlwuVB-DqlEUISnjRuEOM_nGU
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a32279b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c5CysasVHaCf_lOAVd4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: HaeRODUOlwuVB-DqlEUISnjRuEOM_nGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX+652+6efG3qq
 98lcU1Zg6SPbJF0aOtmTTDEjrDLUCNjcJRIS2dXneuqzre/n8kDDvxew/JQLC1Rr+NDf21T1oNs
 iyWAWNlqTsa8FmFIhQL20n4+0LnUjY0RrMggTY1glEDVOsdQnaAOt5eQr6Xz9yuOir3IkUFV4a9
 UGBCD8uzDK5kaT+oLkrRh5scWLSXzpGzvC9WqJlVQ7MRMoBULMaL84CC2VqksWZCL85gijgOGVa
 9PTFr//7j5of7ifnzgoBbOAH86Ij+H816vCtSsmsnPT9nbBykdyoRQ/dzNxPXnUO0VgNRx7jaCv
 26evyLwz4LMGi2YM3k53NCemvBIeN4qqEbXj75hNyiS0bBrzTba+CvzmwVfalm0ERxQBQ7im0qy
 GjcfEf9HNMnUNbYgKzdV9kkFR6vD4mhfS0zmF4c32TwIdRvoQQaIsEVxxZQpDYWivj7Xf6TmHB8
 4hT5zfv0IkjkcY5+fyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX2RtpFt/D7WKj
 YZLgo4NqHkt6l5MR3IOnNo2vI52FYZ7x3JLlIksan6TxxuTtbQD5leGdHrpNFVOulTCMdXHxw0E
 DRaO66UEKYzIluAtIq1bTf6C4/o8td4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170041

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

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v7:
- Rebased all patches on latest tip
- Removed SOC related patches which were merged and available in
  linux-next
  https://lore.kernel.org/all/177950280353.1097700.8285469548487310751.b4-ty@kernel.org/
- Link to v6: https://lore.kernel.org/all/20260227061544.1785978-1-praveen.talari@oss.qualcomm.com

Changes in v4:
- Added a new patch(4/13) to handle core clk as part of
  geni_se_clks_off/on().

To: Andi Shyti <andi.shyti@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bjorn.andersson@oss.qualcomm.com
Cc: konrad.dybcio@oss.qualcomm.com
Cc: aniket.randive@oss.qualcomm.com
Cc: chandana.chiluveru@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com

---
Praveen Talari (6):
      dt-bindings: i2c: Describe SA8255p
      i2c: qcom-geni: Isolate serial engine setup
      i2c: qcom-geni: Move resource initialization to separate function
      i2c: qcom-geni: Use resources helper APIs in runtime PM functions
      i2c: qcom-geni: Store of_device_id data in driver private struct
      i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms

 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml        |  64 ++++
 drivers/i2c/busses/i2c-qcom-geni.c                 | 322 ++++++++++-----------
 2 files changed, 220 insertions(+), 166 deletions(-)
---
base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
change-id: 20260616-enable-i2c-on-sa8255p-432b23838e18

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

