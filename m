Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5700231836
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041402; cv=none; b=nTZZ+WrG0eBoM/WT1fKsR5smeWvUc2bkJlCbI+NdNRglx4e3D5EuNwg+yoEX3bZOydK3fvC1r4/vSKGDqUyIcZBRiXcT7sTClJielLSh/yZnUtTFRSOHZ0Ew/wUbgX51zrtmun5Im2BEXluvFWOMSewU6a6QRLLUXKFgoU8//n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041402; c=relaxed/simple;
	bh=9BIFfk5ZwDBAqd+AjKgGI4avZgAORNx3/Nps7Yk9gdA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e0x3Oiv//RvV8YdvFFXtL2Oow7vv0L8Td+i0wSZG7kQ5ifaMxcOsYJ5ESJa1Pb4ypV7JoxMXyGDr1qTvnch/dNAqXXNru2vzaCGkR+gHt7Eh7QrJZ6owyHIM7UTjLMRmL5ov1a8q0+PcRsJRb8LfF/iVvzfs0oUm/HuZaQFNNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBe5Is8n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OCBK58Yu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBe5Is8n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OCBK58Yu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EMXlsQ644870
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6m1IYzhzMlMI05KKCN6YlAZiCuqfM4U+iDqcMyD0ylk=; b=SBe5Is8nnDtb9/3P
	qjMCC1P/0I1O6BMfBHnBfVc6BiYir/a3R2GIptcdwbVEkK8YXkmK6ZXFzuMNOB+U
	Vo6oSHWFTvbXRE0iFTjoeP/hTCiJFwkibaHHoUCpfc3XhE3EDuFtaNup4b2vRjx8
	GHl46ByOipJVv3TPH67FNdJzGrP7OiAASihjJAWg53Ds1S+5LC5kyhfOqc30+/ca
	SoDp58MvMZPl8JhKZmIlOzLpKJVL/QD7XWiIViBnJjuJXmAdBRHerde1flyLOq2o
	VqFU0HO1CGzx8TfcxlcZkE2w78oLnF4cBKlTtcG1YNsCnm59pcx8SVMXfULHQCiL
	eE+SJA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy96yg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:16:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso7194496eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792041400; x=1792646200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6m1IYzhzMlMI05KKCN6YlAZiCuqfM4U+iDqcMyD0ylk=;
        b=OCBK58Yu9CMq3roUo5A28Z8D/LdnRbiRhwDHE5QhCQ4cwr06GMtd7gTdsPzB3i7eyp
         8cM34OzhP+VfiiiEJ0SQimXvbpFEYLTikyklUSoMTfc30Q9VCDsHNxcHRWTc+20mdcoA
         IlaYodLN7i4Nh1GpY+mTVjLcH8MSJwiV77Sne07B7i8W2PabaDcL2TaId/gNP4SoRB5T
         bcpXpDxotD+Mzb3/Hqh6fhDyuOJQcARxUOcb1WHBI17M9H/zfGqnLX8+0EYUGJaKY4Ru
         2GlVj4PqOFG2TJb7+ZPbG18wGnRWzE9UkKl50cFr61u8IQTGQ1Fkhx/pdCUzLfZ8bpTw
         a+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041400; x=1792646200;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m1IYzhzMlMI05KKCN6YlAZiCuqfM4U+iDqcMyD0ylk=;
        b=PUGikk8mZfgYRXQv+IwL2OgA3SPr2MADjVJG0y+WpRgyK69Hob+ETMzUJxDxURy5QK
         jHvAwCcalOi3N5/9KaG5jbL0OH1jlhCHBr1wXXK7NVyY1i73MWY/L1ppCmYpPY0O1X8d
         VmC1kKnjdEotJkKjvbBnNneCeea/eWuvDGn0fdzjr6+oHOl+FHKvKwflCIwduA+BeyYG
         CZDvq5ULsngDyu3c1QE3PVRvQUd2JFJQFi/pEJacGkUIcxd/dNB7Ws1zLRn8toZDbYxj
         HHJbK+zGUSS5r28XBpwhEY2+9RPonpBVFfsCnYNH2xVkhqoonsubz/o13/diRff6Wsm6
         JWuA==
X-Forwarded-Encrypted: i=1; AKwUvBy5qiNChKP6rLTADJDfqY4hEYQI9uHcxeOJP7BpkpUv970CXTNA8S8OHzCB9X7CeUUhJ1DMRQKVhHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoPyxtqgFtn6CARgj5JVcIVCr+ZimZ0oL2WdBq9sYjOihX4514
	WZlSzhqYKtWgJuieu8cLk8IyGMRyj9lRue/okVYO6+AMTM0Ja67FpksIJpfGysUzDZcQLy4nnH6
	kfeIu5fz81gXR82yTa+o0PV7cmyO4WGrlcxeAe/wBkx01xyijPSUhjOW662cNgrw=
X-Gm-Gg: AYBFou2HMZCYS3SHn64tRTGrrV3kCKEcFvnqNCQoqWIZ1lcMX8N8xnJqpSagCa8+nR5
	73eUkT4HuT8y7iUfjAQ+61slAuMlafFYKtymJY+8lYsJg7krYHuyYykaHKiA86KkRc92aLpp+a0
	QlXI0KpAC7yGSUMVHuoL8jil/61qH228PI8AiSv8nkVSYSS2zJW3XXE+qUs8+IE1/qhXtCWWGkJ
	3de9ZLggCutdxRjdFDVEYDBqv8HQqx4pnkprj6oBBP1rfr3o4UOVlF9HTjJRd4wTQ05PHV2bx6N
	EViFDL03osn/UdGNnhfSMbu44pDpMCy7kDlCmW13OjukB/jO+oAEYydkHHBmFQN3mNwPZZt3F1O
	4dCYsJFO2BVL/+G8syPd8R/dh0FA=
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id a92af1059eb24-16a5adfc081mr25190310c88.15.1792041400031;
        Wed, 14 Oct 2026 22:16:40 -0700 (PDT)
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id a92af1059eb24-16a5adfc081mr25190265c88.15.1792041399409;
        Wed, 14 Oct 2026 22:16:39 -0700 (PDT)
Received: from [10.204.66.72] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm66982336c88.9.2026.10.14.22.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 22:16:39 -0700 (PDT)
Message-ID: <91d2fff7-2cf9-46f4-8143-371ec9d35c93@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:46:31 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/8] media: qcom: camss: Add Hawi compatible camss
 driver
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-6-fc93222da89c@oss.qualcomm.com>
 <4fe3f636-2352-4f3d-9634-637622b2cd40@linaro.org>
Content-Language: en-US
In-Reply-To: <4fe3f636-2352-4f3d-9634-637622b2cd40@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tJUnmME1gQeqokTH-bRILEz7XklKfchu
X-Proofpoint-ORIG-GUID: tJUnmME1gQeqokTH-bRILEz7XklKfchu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX/XVJ4u+Qchgr
 4F9NzuVZrCXZF/s1dArwwoPHvbCE7dn6NVhuwU0D6Kztsy6u/VwMNT24d0HwaqixBaeM2rqmA70
 G9VoB3TFlXmrBKnMixMqaPsFKm2CZVI=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad061b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=A9cSDzJAzJsspl3E_m4A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX3GO4j8amCwX5
 Ly/eEg/AizTwTLWAkBiJZe9OzN++oJkzSmqIFEJbu4UL/dCYO8jpcs+NhMHtp/VklpGnCAn9Ede
 pmcmluafiE6WzHlVlZySS3sE7Mp890LT/QHwgC1Qd2f9Jjs1dcnuhxKkVs1V27B9bwAVQg8vD5i
 ZCKueRcr1ZZ2XnK/4mxBGif665iFS+YiN2VpFAWLWWtsHFzZaRwoRGGpo61d2axSETQjc9rI7yo
 gUEWv1YJCUiajDqKlNkUzdLxzRVOx3zvZYdFVkNJHyjWfRcEkz1OM8Hks9cnOYFIBjn1buqNgwx
 Fx8FN+e0KJ/0t23mTgWIE3gh435SCVZuuJh4G8WuzDdmBPGZlqJ/iGpCgkPxqkLQjRnzPl41Xkn
 k+T537rPu1SbQeIivv2yohLnkWqfxA/oFVr1mzV0ltUl8P0qg9vEIQGRYRiXrRb3FAuTgIy94hD
 kfcH98S0VpWy9IDzMfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150020



On 14-10-2026 15:13, Bryan O'Donoghue wrote:
>> +};
> 
> Wait a second - no IFE or CSID in this table, with both added in follow-on patches.
> 
> Lets just collapse the last three patches into one. I mean this can't bisect in a meaningful way as three distinct patches really.
Thanks for the review.

The split was intended to keep the changes easier to review independently.

However, I agree that this cannot be bisected meaningfully as three separate patches.
I will merge the last three patches into one.
-- 
Regards,
Nihal Kumar Gupta

