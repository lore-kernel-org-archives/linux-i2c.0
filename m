Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877083;
	b=aDmRDvzM7nodOByCSyGZKuUKgmdLcPyHPTNPOIm3I6a9uGk0ryy+/X+1N/BW/rh0brf0
	 SdgoOkb0AAjYv+LbDWSdhqUMSLJeXcKKHzkIOhUrcrq2ca2KKlK4vdZecQP2QwZNcmVKV
	 Gu/mOyxSPUf2g+PFe8uexWnQpZ/WXTXr0C6Hh6tMmloa+rpLgWj39FqjRU/mHkTgWK87V
	 wKLbuAECyN12My67rYwGXkWXs79/6z58/XYWNCsaM0mPQWPr17mw/0ldziE5ALyEIpMuw
	 vHjJpP5zN0K6dBcNHGOrPw22Y+LSmRala5YuubvckaLFAQ94eeodCP2mggqRYWkmyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877083;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yTUjoB2quATPPTKdjmhmFsI/0k5GGeEG+FF3P7TWbbY=;
	b=Kp4erOx3MIwuJFPLgXkHlzaS3H6TcrHTpOT8GB7upRMqncvhOfK/QNkYwkZUJZmI0E2T
	 /tXq6Uxi12GJxiGKY+kKRW9xU3sCuFS53U7dy/TXmv4RIaV+kS0VqQM6aShFWrEwLTLJ/
	 SvkbZ/X+gvj2Lt2JJhaMChxFJnB2TQ+wznzhdZCidCr+TG9sNte2bn0GNhFqwpDTmf3Ii
	 2Ub/ZttN2ahokXSieRb6A3OJVTeahsZuEfmS4T2tO1ZgbDssu8IH1lsNvuI+/+I1MSCZ+
	 UhPkzkablp6wHZt0vtxw7gwWdmdMKHZeq2nKZivn1KyxzTcFnX8KNzw+qn7KRgpuh4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A50yTwIG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="HwsboA/K";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC4606A32E
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 11:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FC4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A50yTwIG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HwsboA/K
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tRh5406642
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 11:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yTUjoB2quATPPTKdjmhmFs
	I/0k5GGeEG+FF3P7TWbbY=; b=A50yTwIGKM5i1OQiJfTq48HjmfTZocnHk3E3JE
	muf8HCKcL3Bl8d0EtmHUnT7QgOus5/lEUXmGdFSpjxkSmju8BelOyG+vNv5gtmQh
	+cQtgFWY8iIqW10poJdEYx/72PyFiV8modbvvAplkHv45MuG2va0g3gqqNUOzCdj
	7WmK9jub8cw1XPyM7o6gqC6JSTG9pvd8aewK/iJRPT2Rp3rPZqxdJUU4RUBRCMcA
	b2/ChDLdnCvyK8VaAx/osKdrgM6GOFsR0tD8uOC8VghBT6Tb6ZuXFQD9CMefO2tt
	9Jta3wdViwvuFFjLhdEZY3CVBp4BZAbbkUNjUDvfmgbYed/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v16ef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 11:11:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso92805885a.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877081; x=1794481881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yTUjoB2quATPPTKdjmhmFsI/0k5GGeEG+FF3P7TWbbY=;
        b=HwsboA/KVViNXmME4Oy8ILCsun5gwThlDF07+xov0jBODudPsf5pKYygUt+JN0djFG
         xokcXkoUPMYKjgqfrIqL6vTwE2+k+hM/Wl1AduTxybKGMcG3MNxJ7G/IuhAWkR5yZHE+
         yOuXhns8zlVUM90oP/ATo8bl9KpTBGm6loUKh9Q9oEax7thrvktAYeVQIdwV9lzDzKyM
         ykBUi0GZgJJVFDyVaBE7lxG39ZG7WMzN8ftGE9sT+HL+ig2jDw6vOyYwCOEautRpizCU
         L4uQ055bfMgMYpTdXIslOQCgYHHjlYMMMO+aMa0hJpwHAIM5fE+QS/43kHI9uqZTqFFh
         LK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877081; x=1794481881;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yTUjoB2quATPPTKdjmhmFsI/0k5GGeEG+FF3P7TWbbY=;
        b=cLGddWv//hyU4WaN1nj0bq6W6eiqq/PNIvo1QKQ81xVgyftDP95+jA9GmyQVZlC99F
         tIMLbCqgtE+qlQIaRi3ZUMJNfqRIpmVgAXRNbM/Egx0jbbMKwQ53yA57pQAaDKsoRl5m
         AqGMngOMhs/RPLaZC/mjgaAbCwVwqyISvOK4Ad8HHWbiPBSFU8Rp8Env+p5/4HP0xqMk
         YQRab8BE+GH2pc9MGeVnU8Seu6739ov8D1NuxCa4KlDmj89ZU2XIy1iOPjSqSVmWU0SG
         lXzD6v3ET/hmN1NwMAfIdaCW3HXzrDpGKSQFj9aijhbL4XB06Gur+w9xMlmq021Nys92
         sBHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF4c4kVAnUdvakshP9rf4+qfg+O1ncsrufNHPNQssx+am9mr04BMf7d+x5NtA4rqHWlSD3MG2aZhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+r2VaXDKT8BHZlix4n2XwWP7vxgmcBVM8kCJnCPiNSicF7Z5bM
	X7QzKGukx/xxp+xVAFO16SInqkMNcSYJYIfAccOwBWkWbDniVx1V7ByhgRELMPOfQexLYitXrmw
	Gmr1r1ZmhCMzQHuypg2cvKFHmhPPcAegJlbxIUBL8b76HqSTiL4ZGVgaoDJOJVH8=
X-Gm-Gg: AYBFou38c85AMYglmnoMAaNpdlVFwxGblgfJ2ajm+D+yVgs79dSLj+ZLhFvh0Xedtck
	H49QiEF9nvQk8JYh7rQL3+hmfDwDZaGrpg++x7hdqMRRvXwa/PXS1BG5D+9qK/FxugjY7g4nI4C
	Yev1YKn5lLnDVcI4EO3tQJ0gPUtz3BSlUTH3zGuDisbYz43V8MUv8ZH+tlS3q7aBBrcxsLhXAjg
	bnVzTs0pVL+wzLJy6z2tfpcAE7nyjscaBwVI2rTTfC/zNuuPRm54fe4xE5xuq8Qe8hVlO5Rp0n1
	p40WBsKZDbSxSKK1j5bJ+4ymRgTcHwW44aLo/GYAYXy7nlUoAslRfe6uKxUoMBVrBCcxleu8nOv
	84v/4Ukq5TCJCPjhkcVCetFOiqMa6t9daXyI0uyDT/jgIhl5CNvbtpHhoCkpgkE3YW0LqiEAglu
	2TNJbfx3n4O+At9CVYv8clMCJEyeA7UCByergg4U9h
X-Received: by 2002:a05:620a:258b:b0:93c:3863:ff7f with SMTP id af79cd13be357-945e1231638mr358614385a.0.1793877080990;
        Thu, 05 Nov 2026 03:11:20 -0800 (PST)
X-Received: by 2002:a05:620a:258b:b0:93c:3863:ff7f with SMTP id af79cd13be357-945e1231638mr358611785a.0.1793877080528;
        Thu, 05 Nov 2026 03:11:20 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm438320685a.39.2026.11.05.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:11:19 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: [PATCH RFC 0/3] Support the Nord CCI CCU output mux
Date: Thu, 05 Nov 2026 19:10:58 +0800
Message-Id: <20261105-ccu-v1-0-3accc4b901de@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENk7GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNT3eTkUl1LS3ML00RTs5TkFAMloMqCotS0zAqwKdFKQW7OSrEQwaL
 UwlKgiSUQmdjaWgDg2c71bwAAAA==
X-Change-ID: 20261105-ccu-99785a56dcd0
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, vikram.sharma@oss.qualcomm.com,
        nihal.gupta@oss.qualcomm.com, vtumati@quicinc.com,
        bryan.odonoghue@linaro.org, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877074; l=2583;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=46oTe7kPy7FuqPo9XNr2S/V6jdi+yv6WkUX1TjqwpPM=;
 b=Dol529a6/PFWr/JmX2UCTfZDRm+kygGEkLiJ5I4XGx49aXLdT+Sl4/aG0KJUZRGVrOtpfvGyd
 4gV/RXtflxMBM/DfYF5SIV5V1/JEo4mgZ8kk/3WcZgDOVFHp2oa75LU
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX3Pvz2uRzzZEq
 tFZJIsTbUAKN37Rwseyh5zDXGM4Yb/0YpPyMFKhIzOHSgL9kCns9HCS5B/NM//NsouFRgNS6o6R
 VcD6AIeymrcZIoRYZ8EXXshCY9VZv24=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec6459 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zavQIZ2TttM9Dy2BN-UA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfXzNKCNVftLdV2
 2iUFfUgs3sRFjqrFbSAJOqAldy8NdAxSHuiMp3HNMcwnAqaKw2U1vhy8ttLrbk8S+H2y9jjpJ48
 5Ua6pgs4+/n46RlZyZ/mbLle030hzJclpxlRoLzJPN3FCRBtJurrB90D2HwewC7JN0LXH8csb9k
 FrM+p35hACDaQ/zw7pZq0nP4QSRfE5uQvOerDvrHrUHecFRHyvNMnnGrnZwxHAKcTzaFXLB9FwZ
 MfU8qGUQ4JnWSwMAXflkildAuvtRCGsxeyzK6OWBRs+2Bv9JFBDtoG28+N9wIZvwf8HZQeEqf3S
 yxJ6nnLagcnBahVoo6jinMFM/jezvbI4EQZ+rPvWJBYhtvEDNpWTUnDjiPEZxFylfISIbi1XLCd
 rCYaNkGcVQF3PUcfxLyDWOqagc1uoh+cHcbjv/4VR7JNduvuBz3m9dNNqECMfMf/doga6gClovt
 lF/L0bM0eyqsx4ZluIA==
X-Proofpoint-GUID: bAkWmn4CkannQ2Vyh2rXD6mREeuYDuHN
X-Proofpoint-ORIG-GUID: bAkWmn4CkannQ2Vyh2rXD6mREeuYDuHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050044

On Nord, the CCI controllers are wrapped by a CCU. After reset, the
CCI I2C ports are routed to the CCU, and the CCU output mux must select
the CCI before it can be used.

The mux register is part of CAM_TOP, a register block shared by
multiple camera components and outside the CCI and CAMSS register
ranges. Accessing the block requires the camera subsystem top power
domain and AHB clock, and its state is lost when the power domain is
turned off.

This RFC describes CAM_TOP as a syscon and lets each CCI reference its
mux configuration through a phandle, register offset and mask. The CCI
driver selects the CCI at probe and runtime resume, right after enabling
the CCI clocks and before the CCI is reset or configured.

	titan_cam_top: syscon@<addr> {
		compatible = "qcom,nord-titan-cam-top", "syscon";
		reg = <...>;
	};

	cci2: cci@<addr> {
		compatible = "qcom,nord-cci", "qcom,msm8996-cci";
		...
		qcom,ccu-mux-sel = <&titan_cam_top OFFSET MASK>;
	};

The CAM_TOP syscon does not describe its clock or power domain. A clock
attached to a syscon is kept prepared for the lifetime of the regmap,
which would keep the camera clock controller runtime active even when
the camera is idle. Instead, the CCI, as the consumer, writes the mux
with its own power domain and clocks, which include the AHB clock,
enabled.

An alternative is to introduce a dedicated CAM_TOP driver which owns
the clock and power domain, provides the regmap through
of_syscon_register_regmap() and handles runtime PM in its accessors.
This describes the hardware resources more completely and avoids the
debugfs issue, but adds a driver for a block currently used only by
the CCI.

We would like feedback on whether using a plain syscon with power and
clock management left to its consumer is acceptable, or whether CAM_TOP
should instead have a dedicated binding and driver.

---
Wenmeng Liu (3):
      dt-bindings: mfd: syscon: Add Qualcomm Nord Titan CAM_TOP
      dt-bindings: i2c: qcom-cci: Document Nord compatible
      i2c: qcom-cci: Support the CCU output mux

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      | 41 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 +
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-qcom-cci.c                  | 42 ++++++++++++++++++++++
 4 files changed, 85 insertions(+)
---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-ccu-99785a56dcd0

Best regards,
-- 
Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

