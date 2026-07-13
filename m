Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9F241CB7
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938881; cv=none; b=vAVJeO9zwNJ2j71TGAH7G7yQ8+Ei7f6ZOvWnVO5HDQTc3xXC7vURevVxb+RRrTIROzVwneM31q486EeQXZGqWZrpjYS0ThObvbelFC657GYOh5T1Q3QqrLcMeMNIgFm/TxD5ACOkW068VOvsWCTeRNtggO7AClhJG4LoDmkyFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938881; c=relaxed/simple;
	bh=a2ns7VJ1cGEf33swZ803LYzM4m/USCko3oPVUeKJ0KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mJjETlXcgTQk6vx9ohoRXN03uj8pvPJ2Kk40KeJA9GJ26rswX4JuNqQ6WlPqzPsDpRPfgVatfIF05aBZqAOIdNofrrgxQescV1B7H7/IHfqO8v988Df8tLIrJmvYqLft5hdJeFJ25+jbIGvtJOnlSMOPW4j0wXrpY87arIPbeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XiZnhiXp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CbSGZRW4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XiZnhiXp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CbSGZRW4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nght731641
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2FQsviU3LabeSh9mHc1aSHq4d7ML6OgJAdel+fkcW8g=; b=XiZnhiXpEI/1l03R
	1m0V7lE2x3Wnf+rGk2dtXKwrqGE4oPK5GJOdu0bO8t+7X/7h/9vIafx1agA92lvc
	U/WKNNZTFCMruVa62RnpxQLfl7TtwfiKPoL/LLgUggJ9rZgXsDkcNcG8soH95J7o
	K0b0Wjs6Yt0EYt0lksu5VeDG3jKgM19E9X0vJahuvZexwSgJEnyf7YZb04DcKxiU
	MiEew2aJ2LAVT2Da0gZg98cLp6LePtnP6/U4jPVxovvH+4oOyPON6N2hmCG4TGB1
	Oknq9JPU2UJeftVqiDD2MNeKj9IUB1VPoSBB5LwLW7ig/kR6Q+eeUJY4F3Jk/n0a
	wteJgg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3a384-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:34:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c27616421so12184791cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783938878; x=1784543678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2FQsviU3LabeSh9mHc1aSHq4d7ML6OgJAdel+fkcW8g=;
        b=CbSGZRW4DhinwWn/iCQo0+Fv9rCeo1/Abnm1LfzbRlcFKySfbkcCmsPUp+rmiJpPxr
         mzZ58m610JV8xUbJZzKR4S+kWK2z26rXM1cpweTMERmPGNK6IsZjvlWB8JLAwhA3FH/3
         H7GBPq8YVocjDhTd2zLgrUfh2lhKncLsO53coL0SgFTWD8w+dr6eB9gYDDjE7Sdsk2iz
         zT420jYlxg6A7zglHtxdvH7PhH/dTskGzTi6zZevtf1ykOKsVZZJYhBjN+0xQklE63Ab
         xmi4mFPTe8Cvn5DYJ/dLOa25R9f8ZTGOs9RHh0epcuvNK6iDbCXd5atQGEJI0ZhOltt4
         gtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938878; x=1784543678;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2FQsviU3LabeSh9mHc1aSHq4d7ML6OgJAdel+fkcW8g=;
        b=PGV8MPzy977pRGQtwVzG1VzJ2+FqrVyg79e+OlmH/jj2PsKP7IySo9/17jbm5zBy/N
         iG4hKuq4ujvPmH6AczpwqI/7D6N5e1T52SGDUlzbdBAJp91KhwWFGs9+sAY1o/UDqBHc
         hcUKZQcSaVYwlDRWQ9pRtWHsqxcYMiusRtk4vuXgkHyJWnabTl+LLzj3APC6YnZzlAVU
         R+nCsKmpa/laLDG/eht34nbi94/IHYN2NibFCPeh5dClDjfIt5M5zWAy9LibfqzUutx8
         /nnQXM63nZAIKWaweIFS5SzrsqrDTUp35aWllzZVyIQvaItQmJuHkYoNcqjSaabVI5Ii
         vqcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+JyHgwSyOMTRSb06iBbF7+KEMX40HXIPxEfsu45oziXOVxgV2nJ97Xyiv9pEb2gEWQRPE9xCrUXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PaVLl1nNjGjnhX9Kht1CF/hDHb4xaH3G5iqCsOVIBiFqsl4Z
	i/MRr8SGKsDIa/FVXrfLTbuQ2KMCEi/finNl3TORNo5v7qxDxbPLmwDx5zJ0iifoA9oqCZjO99L
	W+4y1r6WIXTE/XH2WI3Akzyjkui0A/9C6StyX+DYbmqLnvLcQm9Y9muRDxNYuZQ4=
X-Gm-Gg: AfdE7cl+DolTadTpp2ofOAd126Tr72QH9guSJPWqviHaGIN2+xrzipATvaQAH0//r5Z
	CcEHecCtsRF4570ld4on7Bws20FLkav8ehdblUVl0T0TW0Xm/smYicAcJ8oUcfaCqIBSJinYhr7
	6/GnJk3axGBJF41W4CBB6Q7iE7bnSpxw2G0z8wkhnjtizZV0UTwDBQsQwcj4XiOni1wl89Ek0AX
	iietXNBz6bFp9TwVRoNSRwOkr/jWyy2WlWvqHpLlFHYN270wKIApoqCyAoBEjcTHLUV7OFT4g9e
	x29V72S6B0SdheOLGUaXq0MiMXBg4e/fIeKiAqVyNxUSZdfuQ+Y0nf1oyOJKXPhpmoLlV6BWz3v
	UAHbGFp9ulvWv+B9Bj182AsuFY5FEQ/H9iUk=
X-Received: by 2002:a05:622a:43:b0:50e:6311:7380 with SMTP id d75a77b69052e-51cbf2157c5mr75175311cf.6.1783938877732;
        Mon, 13 Jul 2026 03:34:37 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:50e:6311:7380 with SMTP id d75a77b69052e-51cbf2157c5mr75175131cf.6.1783938877229;
        Mon, 13 Jul 2026 03:34:37 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd89b1sm14741341a12.1.2026.07.13.03.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:34:35 -0700 (PDT)
Message-ID: <bb9c1c2c-a09d-402f-9b57-feaad8e4d2b2@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Use devm_pm_runtime_enable() for PM
 management
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260713064130.1681130-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260713064130.1681130-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwOSBTYWx0ZWRfX8F/mYPt/aAP8
 OL8fjyRsDSebGnwOpOEeI9GG3yQgQuo8ijLE1CBC4KUBw2ws+rws9SAJZM6aLGpKsaNlVraTIf8
 2n7XaUrKGFqxM/RS1aRZ7VlW5Dmh9mQP1Ym1DbMtromSNhKSobj75VWZPr9t5CgwQ0GjQ91m0Dp
 mVFzzo8EUeEoysoet2cxwSo4m52QwvtcwhRa2lJ5q1vPW+OD/tBbU6NpVkAddfAlrfjPvaSZzwU
 h16j2HiNAK0krlWNMl0DzJz26m85vjPqli0di+t0rzkBmRZ+/45HTki44qW9qD/Y2Z5lz/E2iX2
 ts5rAwLYK4NmG5E9iRGFbyC5V008qkZhYMnbP3Fk7Ek1E9yHEzC1YBQTz1JnN3ARokh2PPyNTZs
 ZbkSlVcKKZwidU0A5cPgWlDJHc9DrIJ/sP4Xnh3cIWOpvUo5ZckZYXjI8QL+VwW/KTGKadm7avq
 A62460oaeTShVUPoY5A==
X-Proofpoint-ORIG-GUID: vgQDK_oSAi_OxTiHbkrL6aE2ZEKHcH2a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwOSBTYWx0ZWRfXwJH1Wp+YJFop
 jt0SPVEEUTMpUu5QexmRS4034X0R08bz67M/LQfWjlNXinWdyTSEJcrpgcn1/iMLTDWqI+YkjtL
 xD56uqTDFsiCTMvZaRpeEwXi5dHoBUE=
X-Proofpoint-GUID: vgQDK_oSAi_OxTiHbkrL6aE2ZEKHcH2a
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54bf3e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=jculsIPVV0WIAI6NCkAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130109

On 7/13/26 8:41 AM, Mukesh Kumar Savaliya wrote:
> The current implementation manually calls pm_runtime_enable() in probe()
> and pm_runtime_disable() in remove() and error paths. This pattern is
> error-prone and requires careful cleanup in all failure paths. Using the
> devres-managed variant eliminates this complexity.
> 
> Migrate from manual pm_runtime_enable()/pm_runtime_disable() calls to
> the devres-managed devm_pm_runtime_enable() API. This simplifies the
> driver by automatically handling runtime PM cleanup when the device is
> removed or probe fails. This helps  with Simplified error handling and
> Automatic cleanup.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
