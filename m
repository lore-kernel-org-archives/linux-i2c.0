Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364203;
	b=lBS98YpTe8R4L+HregNovQ+81QVHZMUMkR8FMr0suVR5EpRya2X0oJbXng7gltlimYNn
	 QFnDyEL1UCSPEu2xNCw5KZgIVnkQxr7dpGvDEuxRLeQ2HMUlc05CYQrwNsPUJSxZU0cpC
	 XV7yU+tJ6qK0739Z5MBPn6kV3GAMJHTt+XLzeYTO+6kdceyNq4E2C68b/1ucjokEcrOl0
	 S5vPxiFeZQeExR92+FmQvZEpiubwJueAjp954/hjEYoIUJ7eKO7yEnjJuck951Gvc0fAs
	 TedMqCKlazgpwBRPT7aB3gbmTrD06q1acpelviTB/2xPl8XOndWLCRJQitue4zdmVWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v3y02WtQy7EFMYSobYs1C0IhrIzB4b0G9kvwXB6qTfU=;
	b=5ZU/OMWZCZ7d8mDSiMxT9+Pz4tqSzS8e2qSV/B2nT/PUynaJqiJk+DP720n8YN0YTYx4
	 IZ7YwZhxAL3E4fYnquOjCaqopcum30ITfH5XhU6cgaJ8DJRXYN6gduJUJoTr3uqpXUG/w
	 gjJuKV59g368Pen8DULTajJKrTDa5u6X8p1Li4oj6Pjvf1MoJk2SfhCw3V46KUg1pMps+
	 fggKCaDAvz/F+Sdu3O6fDmfR1ZYK83J0gJ0kcX+DIK7g5G7qRVxrBgmyoKzDe25K9HGes
	 WkQj9JeP5wDgANaz1pB/GpFnXVTBOoKgSPyvf8lPMnm+RL4NZiTVtEvFL0x4X4LtyWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYAv2km3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adZbRPpy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C7606A31F
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 740C7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYAv2km3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adZbRPpy
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGJHt1527714
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=v3y02WtQy7EFMYSobYs1C0
	IhrIzB4b0G9kvwXB6qTfU=; b=BYAv2km3l1v6m4Tj5aaig98jJ3Z54crMH9120u
	pJe++LSGHLYvh/YF7pCkcVpTifWGbxwO5a5FwCkV9BF+vHocv/jbLvtnzqi2Nb2R
	hlgDThcr4a5tIS+MAtu5SP/9jbcyAd0MQrzAnWjrrgnxwsIe24HkxznO+8xqsuNK
	8/xYNdD+u3nna1g/FHfle+ATZJbYKvUMatE3Nb8E4QwFQHXiIC+R/8U4un40a+qR
	XddYKt8Yb5eOU+c/Bdxen6vT7qf4NpTbQJ0Og1KZnuN5FKdXi1Ued49dKYevTJNK
	d0iyfaYflJW+FQPmZi8EYglDOhc8orcz4Vi71yEoqzHhalXA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pk20h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:43:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8ba4757baso6812685ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793364201; x=1793969001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v3y02WtQy7EFMYSobYs1C0IhrIzB4b0G9kvwXB6qTfU=;
        b=adZbRPpyv9sDXKrbu0Iyr1D88VVAsUVDHUDO+nMazjm40l4Wa5hHrYV2qaBdOWzZHN
         Kea+nxVyU05mgcDPeDyx8ctKXAdtrO3NhvjfLbnA5l01B5DIgnOELCtf60QAr2oR1yR1
         1fUhhEZygtdP+PB/320xK5X2iWsfT17ai9jvAXSMbK1m36WQ6pbwbaxM3T3IjxGjPeE9
         sOnNYlOmKhJzYooUXEIOfDaHeDgruLYgFA1aUIWuZt2A+xMGFW7vtdhmvl1uQQXgQAAr
         ubE4ufe6rI/jpHN/I9noznxg3vFz5mFcGnLd1RpUI0rwvIToLBHsFIJzsMUcIhQSIDPT
         0XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364201; x=1793969001;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v3y02WtQy7EFMYSobYs1C0IhrIzB4b0G9kvwXB6qTfU=;
        b=b5dLF095IX4tyqDgcCw4sB89+HHvryhlLkACCewDYX3r/2qR+0e6yP38DNGIVkZWZb
         CMwxwAx/wIyl4uXGpnIDhugtXlSyK0f661iRJ/SPZ7pvq/IZcPSGJFC8nVDWc4foWfeG
         CSVb5Y+RIr6+K4YFa/Fm9sITnHcfkYNwphJCQNv7S/d+EZD+T73mbls5FlQsQLCMDqO+
         5uC1eUN5zUgNWfyEGt0RdWV+4HPdUddcrpFdH7lEVmsn93Ebza9vK5lAYikO7uts3e+P
         0HEkuaIfOWS9wZI1nauo23Gv49KjL8x1qSpUJUEzaY+pNT3aR7Q1kivLYgJcNWhKpRbT
         df0A==
X-Forwarded-Encrypted: i=1; AKwUvBxWmHN8ZmUl5/wv3S4rVo1ctHF4J2Jqbju9b3aSXaxpd3BgamVW6Tsm63B6btn5eNkguuTgq0HE/rQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn5cZQgffgRJDkwWflHBAoGixXSQU3L55Hd1VgqiSy8obP0EnI
	yc1VH433hxeNTqFEnu2xvnMnW+hcv/FBZWOebXwIBJBPwttKS1Z8hFhKBEkYbqjO0qzjTDJcxDb
	WtD3FbmyWHp1WOmjnJYKVO9zQJnEdNYJe4RcP4ohjVSq4u2lK2VgUZvUsI/vUTd0=
X-Gm-Gg: AYBFou1STiFTj0pUK4YJAVR9NeUdnKjG6/TsFfptEpdoHcP24pAF1nExGFxq01+iv34
	tYCGZO01bFTVZo63yw+TI8yNhjycmE9xX/u6WRP0Jo7lSdHoY0ky6AyzIu//IL6QNM7r41I7VMs
	cNK2G3jn36AQP/uHwTzc/pUKDWJqMbmuUljSjRJrOlAT/tC0RfSznowaACFrvFQauDtgZpCXBg9
	wycXPTabGjcoAkO06wxYsB1/6KhE8U3GLBAu/S9Y/OXRAXT+rKtU/Ncx+/CBekMINZssvVc6+/O
	+B8dMTqYtr8pZa69FUiLoTAxAwXQ3VdCgadWx4ygyfnaioDN44t8sKDLezfVZ97KiW89/e/+wfP
	PHCYkaKVK3x2+Ode2u36d+txKJjdogHMTwD6vttH1qqUizh6f0QagR1tK9WHWA+6lGxeZ2iAswF
	Wtc/8=
X-Received: by 2002:a17:902:e88d:b0:2ea:8442:db72 with SMTP id d9443c01a7336-2eb364f19aemr22543295ad.54.1793364200944;
        Fri, 30 Oct 2026 05:43:20 -0700 (PDT)
X-Received: by 2002:a17:902:e88d:b0:2ea:8442:db72 with SMTP id d9443c01a7336-2eb364f19aemr22542955ad.54.1793364200386;
        Fri, 30 Oct 2026 05:43:20 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f5dasm6450075ad.25.2026.10.30.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:43:19 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Add CAMSS support for Qualcomm Hawi and Maili
Date: Fri, 30 Oct 2026 18:13:00 +0530
Message-Id: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANSQ5GoC/32S0WpbMQyGXyXkeimSbNlWr/YeYxeyLC0H2mbNS
 bON0nef08IgoezCBhn9n/RLft2uflx83d5vXrdHPy/rcniaQfqy2dpen374bhkz3hJQAaG02+u
 vZfeoy8OyM31c113nYTkpgA/aTtnPo8fy+x357fuM98t6Ohz/vFc44+X1P7Az7mBnvfdMzil7f
 D2s693ziz7Y4fHxbl7bC/NM/zgI+BmHJidMEhENbWKfcN4+mj3688u0ffroeNt19d0laTndbzS
 JCUODQpiitIIDIAQqiZqqEgYNYX33rSfbz2ndb2ZPLVxb7SHsJIgB0rtXFw7lVCyZJ6nXqp5y1
 VHAcuVIkLhDdqulZnQI7DwhzA2uVaqMjmxcpI2UiV2qWEOI4CylYW2aSu7XqtmGR7N5mM1LXLZ
 HVmPKkDgn9OEZNN/Ucq41MqKZDfBiIywGsGuxHpa8VTdNN764eAQAMUrLXnoaWlKi6m7oYaM3l
 LlovFbV0roLqcHIOUvCWkYM0zEGTZelosxK5UYlAk0ztMHEglC1zMq1waiYq43RC82x0rjxZWK
 UpjmJbGnmK9SRPHOqqVtJc9sWInStGkQ95v+CnlO0gG4kA3JmH70OV+91IvvNDKPPGdTixlinK
 ca5VgrPSpobacmSybDw/J5vfwEgP+6YnQMAAA==
X-Change-ID: 20260923-hawi-maili-camss-b5dc43a00ed2
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793364192; l=5721;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=lsMwYHuyept0TY3G1YvNs+p8Iz3C6tF1vslYFSKw0VM=;
 b=pnWdy0oGgt4NBHEuPPXjYTiu2Dtqebe2LXDZiG5LXd38FTl8q4HOFxYtX5igdHTNXjA0Q3doH
 fJ6AY1mc807DS+GpLcOrzy8c0dH1EL4AA3rd1E7udAhOa+gAudMgBhu
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX5CUfVuQnxGEb
 KrbezV2ZRJoWIRWD3U2qwQG4hUhf8vpYnEEpWP6jieg7FTUdCLmarzvqPwxsywXBY9LLudMltVy
 u7IBVJXg7eArhWvjsEzmn+jijCK5g+eDDU0madrgmzgEplR1NfcDS9AQx+AqaKwz85qZ2paynXT
 kizxlLfBCKLiP/UdgIqUJk1xkhioY/ikG7Yd67nimqCGZJeT3chrhpTt4ODEL8ti/QZa/DSSecX
 MXxNXzdfZSfFnayGFDcxf//4C2QOQR2KkMTl9mdgK9DO1UehBVZDQaDXdap2JJrT3PtEMjugc1I
 R893tdYiIN0CwC/V5MB14Bqjx1PGx8z3Dfz335rtjwkb/0mlxFSqV3RlzE50eBX4cCN3+7kVbV9
 ARuhgtNe6Fe3ArUbkdbY3PXCin9GkserwZc+Z07Wyp19PR5bThjeUhih6tUvUMXhEt8zxcSNn5W
 VQVhAmQQbrVqNsEqxZw==
X-Proofpoint-ORIG-GUID: kGYjlEmUun1aZtJj4Ytn6_PR3Ts23bzb
X-Proofpoint-GUID: kGYjlEmUun1aZtJj4Ytn6_PR3Ts23bzb
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae490e9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=E40xv7DK0V-5u9Ck0vwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXyUwvLvZjr0kl
 2tPwoTa8K2Rwfd8UrV0h6t9VV2YV9Fb4M+PR5Byxtj1YY7dZLim024ptfkt1CVmLVkcJka6pJ4l
 oLi4d8F6nRYkFqRETvApFDExiJk1E4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300050

Hawi and Maili are recently announced Qualcomm Snapdragon SoCs [1].
This series adds Camera Subsystem (CAMSS) support for the Qualcomm
Hawi and Maili SoC's.

[1] https://www.qualcomm.com/smartphones/products/8-series/snapdragon-8-elite-gen-6-mobile-platform

Hawi's camera hardware topology:
- 6x CSIPHY (CSI Physical Layer)
- 3x TPG (Test Pattern Generator)
- 3x CSID (CSI Decoder)
- 2x CSID Lite
- 3x VFE (Video Front End), 5 RDI per VFE
- 2x VFE Lite, 4 RDI per VFE Lite

Maili shares the same IP as Hawi. The only difference is Hawi has 6 CSIPHY
while Maili has 5.

Used following tools for the sanity check of these changes.
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=media/qcom,hawi-camss.yaml dt_binding_check W=1
- make CHECK_DTBS=y W=1 dtbs

Dependencies
------------
[1] https://lore.kernel.org/all/20261028-kaanapali-camss-v23-0-95f250b18612@oss.qualcomm.com/ -- Kaanapali CAMSS driver and bindings

Patch grouping
------------
I2C CCI bindings part for maintainer Loic/Robert/Andi (1):
[1] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible

PHY driver part for maintainer Vinod Koul (2):
[2] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles
[4] phy: qcom-mipi-csi2: Add Hawi support

CAMSS driver and DTS part for maintainer Bryan O'Donoghue (5):
[3] dt-bindings: media: Add CAMSS device for Hawi and Maili
[5] media: qcom: camss: Add support for Hawi

---
Changes in v3:
- Rebase on next-20261029
- Squash Hawi and Maili CAMSS binding as a whole - Krzysztof
- Add description for IFE and IFE_LITE IOMMU in CAMSS binding - bod
- Correct the lane count variable fallback path - Sashiko
- Add CAMSS top region to binding and DT - Loic
- Use split addr_update/reg_update in CSID and VFE 1190 - Loic/bod
- Add SOF and EOF enable bits with top level RDI status offset to
  allow their corresponding interrupts but not configured on - bod
- Move the common CPAS/GCC AHB and AXI clocks to the pm_clks array
  drop them from the VFE clock lists - Loic
- Use the GPIO function with bias disabled for CCI sleep states - Loic
- Collect RBs from Loic, Krzysztof and bod
- Link to v2: https://lore.kernel.org/r/20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com

Changes in v2:
- Not an RFC anymore
- Rebase on next-20261012 and drop the external CSI2 PHY series dependency. 
- Drop DTS patches; they will be posted separately with Maili DTS dependency.
- Collect Reviewed-by from Konrad, Abel, Bryan
- Split CSID and VFE 1190 into individual files rather than in separate
  combined Gen4 files - bod
- Remove reduandant is_lite condition in CAMSS CSID and VFE resources - bod
- Replace bias-pull-up and bias-pull-down with bias-disable for the
  SCL/SDA pins of CCI nodes in TLMM, as internal weak pull is inproper
  with existing board level pull up resistors - Loic
- Drop the unused reg_update_after_csid_config flag
- Add lane count fallback path for CSID RX configuration
- Add Hawi DPHY support by tuning register table, which prevents
  potential stream stalls and SMMU faults.
- Add a standalone Hawi CSI2 PHY compatible and make Maili fall back to it.
- Resolve conflicts introduced by Glymur in CSI2 PHY binding.
- Link to v1: https://lore.kernel.org/r/20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

---
Hangxiang Ma (4):
      dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
      dt-bindings: media: Add CAMSS device for Hawi and Maili
      phy: qcom-mipi-csi2: Add Hawi support
      media: qcom: camss: Add support for Hawi

Nihal Kumar Gupta (1):
      dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../devicetree/bindings/media/qcom,hawi-camss.yaml | 314 ++++++++++++++++
 .../bindings/phy/qcom,x1e80100-csi2-phy.yaml       |   5 +
 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-1190.c    | 417 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csid.h     |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-1190.c | 217 +++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.h      |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 229 +++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c | 136 +++++++
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     |   1 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          |   1 +
 14 files changed, 1329 insertions(+)
---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20260923-hawi-maili-camss-b5dc43a00ed2
prerequisite-patch-id: 6108fea87bf95e2911f09bbe7e95fa536c3ce397
prerequisite-patch-id: b347ad60c475f3035b04ec76741e0f1b5f095580
prerequisite-patch-id: aa51e15c5698d3425e979c810ff54968178a364b
prerequisite-patch-id: 5faef8cef855ce6fa00e2c7f10f125431ede40a4
prerequisite-patch-id: ae577f411cccd0e6cdfcfd05ea6cbfc3e87eca37
prerequisite-patch-id: 56eff00251984e6b3da63327eec1efcdb8194ef1
prerequisite-patch-id: 768be92ac0d44493176dfdcaddd24256719a3761
prerequisite-patch-id: 9908a408d5259107a6f00780d7147cddb625b02d
prerequisite-patch-id: ac9c23e579f4c3078a07d3e45373bc63729cf992
prerequisite-patch-id: d22bf3220b43f8f0bc29d0445edb7deaeb7e57b4
prerequisite-patch-id: fb4e676ec517317515f02fe4a2a482a64942c165

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

