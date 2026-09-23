Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2C4A015C
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161526; cv=none; b=oajJEJJsquROhzLjHDXApikoCmb+Z8jOxznu48lHpV7qRNHzWb0x5UX6Xu+g+gCsqHrv2t1BrDWHK7lMuvnjMw1IInxZfA2Y7PhX0WB4wC9aA928kGWZeGItcuFF+x+Jwt+zE2yUjKsS87qs1hbPjy8HSMxyxpFMPvuLNs80USs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161526; c=relaxed/simple;
	bh=bqn6l4iYdSOuw4aeXmyQs004lZO8LwBG9YK/8wnvAZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/22w3dZDxQPfN6t3Qke84UR9FEcp3jjcwD//Ojd+cIocjWBpWu1fzDDKXUzNloC1GVLYcEOKqjJGJ0SfBiP3wW+7yzYDMatM7TyqBY8J138R7516UOFwJ/NVFNpYvhqO1RfkF0B2yusEzzF/hozTRKIXrBgo1iaRzKtjfO4POs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsifitFZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ggX7aE/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsifitFZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ggX7aE/o"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA3B002262077
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tP8weeZGltbzWUDFxZtPBBXtLhbxGEarqFnYs8T3UCw=; b=YsifitFZEhisGooO
	Drib5a6RQR+GHx4EltajtUmLprp7Vnic7nEWaijgrheQAyOCSocH7wIXG46DitSj
	1SLKHTVEsXVMnDRKPYfblNUHalln9XsqFGiB/H17uAssa+6s1LJnejR6QIEnV4gT
	p07I3tX2ZDfpOAN8lDZp2BZBXN6fr9qwxXzNO/LrY6tMSft8iXCXMk3nbMMxOyJm
	Wf6WFV17EB2xy6chFs5BL/fn15oSHDtvjc8MLTCJc6gn/SlQFba7OG46bUFpUrJ6
	OYaq/xQoik9HQpJ69jWgB6GkeJquhok+1NrtYbztaUoin5IVfsOA1OTCPq8DH7SW
	elPIkw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c3p4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313d1015161so2042459eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161516; x=1790766316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tP8weeZGltbzWUDFxZtPBBXtLhbxGEarqFnYs8T3UCw=;
        b=ggX7aE/oJ7rXDIXBJRmLJBj3IGziDu8R872h/NLcpUOK2nFAmj2PUq4fj8jqUITqzL
         6LF8iR3obASRjyImDU684t5ryspBeFCByDWf9ZXgjV4fNOvztM1lZmVKMtN5A0vds1rM
         3+8/4YpxkJRhjWrEK5Fta/H1bPr5mT2RlzA1Gz5aRpCrv+Vo8D3HDDTeKiabluI46XxW
         UdvESNkpbzmw7gVlDKZZjwiYyQ4bzfJwxhphQngC8/u6oXNAZ10LlMR/ZMqHIB6AzCuI
         +94DXIroouULyDBBLOl3GUDgWv6R6F/3ARXCIKAiGA8XlGtxKMeGk1N06PSsvFDRVwV3
         WwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161516; x=1790766316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tP8weeZGltbzWUDFxZtPBBXtLhbxGEarqFnYs8T3UCw=;
        b=v4O7q/+sgfVGCrHUVx1gIwLe/HBamnwmq/syBPZLLeHVRn+RbbAnq1kv+bQl7R57H1
         qg6QVUD0W6I4jaynPVUJBPao7PYE5bVabqBiVcHOdgs02D89AsSoGJC8mcBHwt2Ntedn
         pgCngJd2jNEcwCu2IktRUfpBEdLpND3yZ2QTvwEOljBkU4niZcRBke93uYayEvLvdhum
         Ic6zc1aK3NoVROLtSVNyUYbi6z+xkciNTw8ZNjzw1DM2AkkOW6NpWHkFdGYPeg77V/Vx
         65CUIpDueULasbHP+qjMoUGX3FTtDPTB9ib83Uj3xd3x+4R3cdmDF9V8tzWGg0alCx5x
         3PDg==
X-Forwarded-Encrypted: i=1; AKwUvBxkbtJCs+y7PDTIboSs2b7D3wOqoKXy8OXOXrdJt8Af9a1UqR9d/uIPjMYRghLPcOeVNvmQjUy3a0I=@vger.kernel.org
X-Gm-Message-State: AFuF++kkDQhP4zONenjf2qxZFWn+JOZbOmIFlh9bhrj/hOMkjYnxU692
	06JCE+HUQ6/1jNMDjdeID7PpAFx/wt6PahXYiTPZb3/ST2fvF+AjElal6p/VlkG2gYt6uLGS6VZ
	Z0EoDTk2j6vIbDU5AyFNpyvA69KeuwrzmJI8No3292DShhGDo4a5cCnwDODHKr3o=
X-Gm-Gg: AYBFou3duqenEEEzpqAI5Pqm42j2tKAwO/uaZNAmliD633EDpQ7GjckcstvebQTb6oJ
	1GM5I9OLSv0loxOX2t71vfNQ+QYmWUJflLy324VEULD6buxa6tUKpWSi6jeO719ol79rxZRQDKs
	kD2AvsjdyuLBW4R4IZ7yFlBzHPSVD+URYIrzhQmH8XcG5N0ZO4A35UoI2e/LQvyz+2nLpYEZa6X
	39nsbuTdeC/NZ9CT0HbruIAKD1BkD4JkQWdMxcQOmeDuX3plO+y0y3fGw7JYZTcmLRCG1HfeQ0O
	fhLIoXVmc8ZFYBzhvkBbJymaUvoE8OmJugaGoTDcpYYYEP60PS8hDUaMGq61eH1fykRm+fuVaby
	o+XP6t/dFEHCmK8nvia4PjzfjgNEfcw==
X-Received: by 2002:a05:7300:8242:b0:33b:db21:9877 with SMTP id 5a478bee46e88-33e8d9cd464mr2014763eec.20.1790161516380;
        Wed, 23 Sep 2026 04:05:16 -0700 (PDT)
X-Received: by 2002:a05:7300:8242:b0:33b:db21:9877 with SMTP id 5a478bee46e88-33e8d9cd464mr2014744eec.20.1790161515889;
        Wed, 23 Sep 2026 04:05:15 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:05:14 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:46 +0530
Subject: [PATCH RFC 15/15] arm64: defconfig: Enable S5KJN5 camera sensor
 for Qualcomm boards
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-15-cbbb42e534ef@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=708;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=bqn6l4iYdSOuw4aeXmyQs004lZO8LwBG9YK/8wnvAZU=;
 b=BtMxks8910ezL91AonRWICuUmO6BybjXRpW34O+cKL9X7/xTV0D9Ks9n9yUFV5WtXfam3m+fa
 Sjm5Agw9OTJA50XtKxXrPLrNgIhqSX5hLQSEmrOZCA4kQsXcoINDM7s
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: ovxMTrYLzjPcDqU-TcKMyyZSdMVOxhhY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfXwxEiw5sS/sX1
 HE7Hs59V+vNBCZELnyGF2vo/jTBLNGNvULJbZNH/hELoOmP1vSAmxwogGRlKgHzx3I7dDRBoHZq
 1EVlXzNs2IGhPw6yVxyjQbMxXZS1Quo=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab3b26d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=xpjZ0Ymiy3z0-qgt9i4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: ovxMTrYLzjPcDqU-TcKMyyZSdMVOxhhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX+EPXn6Kgzm+W
 8SnqMxh7pXMT7qxBrnxxFlL5K1m4un9urmY4JOZYPVIA2+mhl6eURTtS6tFyjlp0FhrSXuOkfj7
 s2dhLvDNduBS++sIMB8Tj/SV7sP6UQ/C9kVkON84LWTQVHF86gLkM7PNtMFqra6T66XCOmvYVA4
 SifnSw3qD6x8nCi3NRJL2KNazWv3Xe++EuVrDNiO2iPSCtnLHDcuQYRYMwv91UUAPlxu1WeggOQ
 AwA5/SmUmYQY4pd5cqEEItHPA1kBs5Mn7084pSdUySKqHEpNfUxcE0yJrxpApMb4Y3ohRit2e6k
 Q8OCq1wN/68oV2k5Ey8xwGmNa+paoyA3wPFXzZG7qdZP9IxB51HqTjBovTkIwSMrZKRDmusBcA2
 +WCImWRfTxZLw2Vm+fpiqlKAipvoCgEHUMB2BsYTntUwifOpA7Z1d5TCAGT2OelyTX7A0jF8yBo
 0hWksXL94UnE50oNrhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044

Enable the S5KJN5 driver which is used for the camera sensor on the
Qualcomm Hawi and Maili MTP boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5217de386edc5e32289e453288db0bd9449d4c6f..fa35db683bb253e83af6bb25f702e3127761c086 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -960,6 +960,7 @@ CONFIG_VIDEO_IMX412=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_VIDEO_OV5645=m
 CONFIG_VIDEO_S5KJN1=m
+CONFIG_VIDEO_S5KJN5=m
 CONFIG_AUXDISPLAY=y
 CONFIG_SEG_LED_GPIO=m
 CONFIG_DRM=m

-- 
2.34.1

