Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D153D9DD2
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041043; cv=none; b=MAHruOjtiSSRi8bXYl8Er2xcwGNzrXOh/O9OXsi0eIK4QdkxNs/A6ukjl5OYs0iyQgxTSTWqZfc44ndWrw8zHEvugoCZN1o5lp7RNF7X0ZlmIus2t2egcFHj/aLaBppZGPW9AsColilZpF1VaY7pH8FznXRHpOqVzyLpIhLqJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041043; c=relaxed/simple;
	bh=sssIOgXcZE2/24fknlxXJ3s5eJ/OoslnpIdFTEo50tI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KRY4qDRmXaHRxdD2KV/eu8E8QOJyAtYtWmdn62LZ2k01U2835GcIqdk371TYrL9oy3RcTr4/b/z7T9lChyY4pFMq8uI7El56xLHDj5+jevaUYnN8bd3UmhbuwjgYq7AWscHDND22V22b9PiAObOn7QduNPdNV6pshVnXmMNt//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jfLGB4yK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ddZNHrXl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfLGB4yK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddZNHrXl"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F00U2b2121588
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OzATJjicdxKOoPMvx85ZokhsKNViTN7VDVAgDDyZFsw=; b=jfLGB4yKrVfnzO9N
	8uAqBkNe/EAfG0ufL9LX5rnszgjbNd+r6/5itF9HELLaBJK3PPrN8x1/YEHMy0Os
	s67f/JAOwAu7P83+ARCGL5sih93mIWkEWGs9TvJqRgYNTrpj1vH+J34+ovfOeMaf
	CgM9bhfbqatfCJLke/ON5uy75E2YX/JVAC4LikbwE6DPCNxQdPIdrjwIjSHwv5IO
	GrOnVMRbxPoCNny3W1mkELYun02QEhv8Mk+JbL8Nxg05zoumW7OLuMg8/IiWIMn4
	xK/1emLDGNeNLfQd9nKxuWTKx1alP2Fu4/1vhvHY77PJkoumtkSrinesEHxB/orN
	He8Fcw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn0x4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:10:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-887c99013edso856300b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792041040; x=1792645840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OzATJjicdxKOoPMvx85ZokhsKNViTN7VDVAgDDyZFsw=;
        b=ddZNHrXl1s+De60hHnW8EFgXlZGl/7pCG5neQEX7f/pGrZ7LEOr83pZWqqV4rYJDzN
         ue+kIG1hAXfQxWqQlR2HKVOB9dKFpO8CSYz+Y69mzKaDIfavlSi9gDYlSlhlSCwxqscA
         o19WU3nUyHmoXfz1ddfWodCSoqoCAnFO+ruT7P+Nt+qtEQf/VPwmyAhxfI7xXPIe2I6m
         f3ElFZa2Z5xbfBvf+Ekg3CaivNg+gAMkHUfBtcALPR0se+Sc1EVpugKBu0j5caasQZNx
         ohGZEAhDverVJ9d7T2FZCg6aV0gCINsgNIwjLd6C0rkVdqpt4Ejn2EVTayh7jaNEL7BT
         +wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041040; x=1792645840;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OzATJjicdxKOoPMvx85ZokhsKNViTN7VDVAgDDyZFsw=;
        b=qXmoizfy71KI8e0O+W4XSpQnd+4ljZywLPIS/7rlccNS8AkINHFFZ2INv6cp7by3q9
         fVXRpUPH4vxSPDipe7+fTWEVK8gtTQXKmWe1O1eeMt9vRbMi2uhgRcl6HXAVF/cJUm9m
         hJWdxDJWon/TWO4K+/4wqCpIB1deUqCYgKvwAzunX0Eu0asWoAOozm/bPoRNfTdhttAR
         UcPUGzv+vr2AA1OQYn5+5xcxzqJj+E4KLsZHcp7pPtaoHs7dxKW/lpPBI3NEV+CEiy23
         NHi4579URsTGQ6ntC7Gdb2zSqxGfUp7jkC+jLJrAPd2bP3/tDbc5P148ucQfd40N6pbu
         BQgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKrdyFIXn+gXrOSTPnfqeD7VEIqJNMadr7AnlNIlAn4GC4eeL22cwyPRGN1u1lNRlT5j7LIzU8Lbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3UYoMR/46yjFiYEZ0wgPQc4sNi01dwWBgx7klikIGN55bOZyt
	aAfEz805r/MB8bEy/mYdbEnWMxEOpVKfDIcmkBoUqqOPk+TbjddWhmu63bdiJ8dJBUsfBSSGrEB
	71UicZ7UwyBqwIYb9uv3y9h7EVlMfqo5k8BgTfz+opKorCkvzBjl+7xtklPxhhKE=
X-Gm-Gg: AYBFou0FLgnC0eNxL9ZEYBN1ReMT0/3LEwd+cHSimXqS9Bks/W0TS+ag+fpqG/Njfrq
	3TH10MNz4bq5HWe6Os8L9AuwARRyBVJLe3/7KkOinTNcwkmKjGVKxstVg6NLrGQRmgnEOUC8Lvb
	BcmlRSTMbmIRdi6o/De4rymzmB4UQaB/ZyUM/UydMhlpuOZXAdgzpMLxc1Og/emnvcszxkcmIXV
	H474OQzwlb0Lx9ZEBIfO90D3M3Yrvm9oQa6vDA0A9OFiWy008FttXGa8AU7UJt/6hv8gLtuVSIF
	bkytpVDqYw1RykX9vYTTFSK4vpn8WOd3kpEcXyCHCM2AzRbboPriI2Nu1VByUXB2saKsaROEE0G
	oLMiRcZ/FNtGLZbRDnm9+E1PIdJI=
X-Received: by 2002:a05:6a00:811:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-897c86a3c91mr16386253b3a.52.1792041040351;
        Wed, 14 Oct 2026 22:10:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:811:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-897c86a3c91mr16386162b3a.52.1792041038316;
        Wed, 14 Oct 2026 22:10:38 -0700 (PDT)
Received: from [10.204.66.72] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d80508d5dsm1800223b3a.50.2026.10.14.22.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 22:10:38 -0700 (PDT)
Message-ID: <df8d5a9a-b1c1-4346-bac4-c2c028678d91@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:40:29 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: media: Add CAMSS device for Hawi
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>
 <20261014-fast-swinging-dormouse-26b5bf@quoll>
Content-Language: en-US
In-Reply-To: <20261014-fast-swinging-dormouse-26b5bf@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX80XrQS22aw1F
 Z0L36rAokOWQh9fWnDlYnweK/ytu3zXi5IKn32Cw9wPDTVbzna5h1f5ef/JWFVGBGA0Y3t5FyhA
 Rl+qq6bbsAwZcT1RpirXUZeNvY0o6in+ByrM/L/YTQvNTQw/sc6AAnPMbBUYG0mcQd/MSSgJFCT
 Qa/nREV8lpv2tnPL/Q18Gk8vLE3BA77SSJ+DiofwUJpIfSIjML55D4vAjl2PggYpy8QIK1Aoon1
 4S5H7KQILhZLVrMosTQJHia9FBkQR06i+5sXVU30fzD4Ic0PDg3lyhK3bq1hDW5/HxhHudJUr2b
 aOUDHckZanJoVgXWFtDd6TNfSrruAhhRi35neS0ZPoageua3VOx+bOTaT2akQgRuyYGuxt8GIXK
 +ZKYBTWv5S8+xw41pZe/5Pq0W1OjuoVYGWvvjp9S+jVWgVSUVDqD8m2nTIHNYDx5T1AWB7fkvX0
 OZU9gizNUepwVvgUvZw==
X-Proofpoint-GUID: hmAx8Hg6YuRYSl2TjlzSWVgA_QtisD78
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX9Tix8s/1T/qG
 6PayZwsTBrXE6m6A7ImhTB/W99BZJNKMDdhHr7vP+sQvvaIaURso7Vsd99AspWKWhpS90RkeSnE
 WWwxA/IivB1qN4NAR/zpnPXjucjmgvo=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad06051 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=m9Dd15Dd7eNj5BCxSOQA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: hmAx8Hg6YuRYSl2TjlzSWVgA_QtisD78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150020



On 14-10-2026 16:48, Krzysztof Kozlowski wrote:
> ... so here is the missing file from next patch, so just squash these
> two.
> 
> Don't add new device piece by piece.
Our earlier plan was to send Hawi and Maili as separate series.
However, since Maili uses Hawi as a direct fallback, we combined
both in the same series.

Sure, I will squash the patches. 
In a single series, it does not make sense to add the device piece by piece.

-- 
Regards,
Nihal Kumar Gupta

