Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92843BE16A
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916142; cv=none; b=OhFeEHBd9tr/PQiZq0BXnNKJHmuNOPcEs2mabWDufIWkxWQNfEmSkQK7Ijq29/aqFLlfmOe9x34MrFg0upYjyb+BqKhgiYIR4smFfI2/pXAOlesh7OHPVcGIJZqtx+HVRbcD2ZCVFznalJVIJKo7O4dW9pRP3X6rdPNeQMhMmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916142; c=relaxed/simple;
	bh=e9zBphVBZjd44IWcpVI0lqCnAplEQpZXDYyGO8O3PSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwEuEnawEY7GNfUUNZzd8cwexrLtJKeOvPZNROFHpRXogmPIrmHYjFwV2qFHm54dbNlPLPeaPGchLcBliOyq/E6bNfZFfeYSj8owvmTn6gs22Slj7tgkSrf6jwrkK2B/p7NFz/zsGM60vbMPTagJaFKS5J6Nk/uy+Ua4yMBF6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZ6bS9TR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ul3EVaQP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZ6bS9TR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ul3EVaQP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE45Le009510
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 18:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=; b=YZ6bS9TRHlzDLJ1M
	S5RPkSa/7+VXXes6MMLQbiUVW7Ag0HpQcmw3TjFHKrUzQLem6KECe9yf4me1uiTM
	KF0i8Zi9ATtrLN1dYlIUsSpMoby4PhY23fCgp3Li0+QZOTMfCeEt3HZJnlmyrAfC
	56oh+tvRP05IlY+5Ot+VeIFl+M9AdpegzATZekhxE33xFN1dpTX+raO+5AnysYbI
	h3O3hBgp3s6KL5+INtX7yemKJY8Fg4LfYDvI7ACE3f12KpUvADPXwSIzVGOncIg5
	1h0nTao4ggd6Bpp6FkwdvHQbv4ASvzBUDeTS4zp6z6PvkKQd5JI1qjDlkSjw/4R3
	//YMcw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjk6sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 18:29:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-154e9d2d94fso267396c88.0
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791916139; x=1792520939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=;
        b=Ul3EVaQPant+aYGS3EV/2HAHDUm41oHwNiVIMbuHCKB9qLXLyLWLfcPiiqbSXK25zf
         6YvZWYy9hklwrgmfmbPeybic0rzT3GZk7y7bI56uuVr4L1ZjBKNY8Owg+R/6Oxt1q1Sr
         iCh2SGdXmUjESUnmXgC5Op9eqS+kHNTvz5faOjJldTuCLWQbKvqLpgkRiCMNy4pRDxng
         TVF/TIxWIpKy3cjE37Gv/x9ykzZpshzkuec8Wl4STaL0TMij3QXN+dhb+i197ZjYB6L0
         vGhzVf/hJX4XU32MAckKrBJrfVtbbSO+JXMzDzRrj8plkjc1GZmpmYmvnbP0VSyvyFvG
         vYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916139; x=1792520939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=;
        b=xyVK/YGRexZszYMnReBlP2x03KXEQ4GgoMsYTolCYgdTISY/Lxapnf5bRhZq+CupXu
         F2WHDRy5fzuyaNAf5Yfo2xLI0rNoDi72HDomyW+KuHNI+j9UgzZF7/7PQHjde/2A7QUC
         ZKj3DeNxe2YWV0tY0NciS/NMS2deui1bC0/TszjkNXXujoFp+htTuBZLvzfBj70/fAzG
         gm/8kXyp3DFzCf4y9M9MqpLiJyVbmDVhtLZWsmlhcyqPj2mlqa3oR2iknN5d5pQkTCS+
         Pn9dxNoBfUnpjcgL0nKzgn/kdwqT3DGun645NJuHB4ARdyYJm1/G1xN53UECOnfH6fpv
         AmZw==
X-Forwarded-Encrypted: i=1; AKwUvBwfzy8X+LmpnwYo5AdtUKCW1eVQyxoR5DOD86/xXPMQElfT2gJKB26WyIpyBPLGg64ny2qB1ZDVymg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrD8vXptuhSg1dt0wyQnQDlO4JvYurXDddvg0zRcDub/SsFTuu
	Mers2JgeQNvlX2ElRMFmtEfYiGHW1WNkbVKzQ6QIUw0eBL0abeDSBIgCvae3M/eR5N8WLw847JM
	7Ow3mykxbmbIc5/3zUDamcrNiCobs7xA5gkFbFlz2BDS+dTgxEvQl0U1FYNiTM5A=
X-Gm-Gg: AYBFou2jvvfI0XliXCn25xgyubrpGgj+BzKZ4d6moYLHqVWnMpZNFWKi38tCC2psbbK
	5Fu3ympvS8cVD2WXHSI1Xbf9odBqNwZVB8mFJjxV1+EasJtKhRH2sfUcRSuI73hASqCIyLUyrRF
	VYLW052yaH4YwPlFVoCYQcgRPPZ6KhCLUyWVinnFt4vELt/ioyFtqjZzkRyt+fvxYtyzMO22SSd
	nMvQcdlFKmKNBdswCfoL19NL2FPruD/sOUgti+RQSfzoGTF0oCqpm7zV7GUnsQP51oYjBIyHZZu
	lMmNd08xf38dwpOfGIeRsBbnum7MGGuJp89ISG4tXnFbMFPJxFrwWQgTzD+AEMr1DaMg7PGh3cY
	+hV9oHc00IFW9XfHxWVIFFUmWkEI8e/PZePRpPg5woMS9ohXcmhhU+pxJjjoMCpKOpsGe0s4=
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id a92af1059eb24-16a612bc1e8mr20627348c88.39.1791916139064;
        Tue, 13 Oct 2026 11:28:59 -0700 (PDT)
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id a92af1059eb24-16a612bc1e8mr20627312c88.39.1791916138466;
        Tue, 13 Oct 2026 11:28:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:889d:390b:491d:8cf9:7389:5b70? ([2401:4900:889d:390b:491d:8cf9:7389:5b70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm39437810c88.19.2026.10.13.11.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 11:28:57 -0700 (PDT)
Message-ID: <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:58:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Daniel J Blueman <daniel@quora.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
 <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
 <20261009145800.rc-reply-0004@kernel.org>
 <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6MHkM_nLGQPYO1sB1C7dzSKOXjtBCYup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MyBTYWx0ZWRfX/Unkoj22lZ1q
 f6KNwCKIBvw1QY1sXon/Ka/xUBHI+n9NSjmB2mVbSCMVkga88jS3FQnQWfEb7AubpgV1r3mvT7W
 U3HAnX1c59w2dI19bCiYQU8XSpFVMLgidKYzVZkoFuMYBtaOxvsnK5zjEwqsYXj+VIKBa4nIGzW
 hxXFK63MxOc5HcpE4tqxbGcaFGZcVOIdVDdF5W5cTYM7CvTpQO/AgjNfZzKPLOQmov3ms4Bfj7j
 eXqGCFAd5S8/rCTtDVEs8h8CxZBKLWQmLJGf9KluAS3gAqvQP0bUWY0rVitKs+X/fuvS+SFbVX9
 ETIPB0ov1TJ5HOA9aTtO+KGA0tr9d1SIMcyl1HR48C6aMQS5dH7rj/hKNX4NbgjtcwPqCqZ9I/P
 LN+bIe4rW3icc77YmCHwlxKsj9oylP9785MZZhy1deJ6J2xd0Cp01UfL/G92LAtPpYDixlk87Kx
 rRQIkbp53FF5aYfRuEw==
X-Proofpoint-ORIG-GUID: 6MHkM_nLGQPYO1sB1C7dzSKOXjtBCYup
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6ace786c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=-sI2l8CUKJjV0ebggCoA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MyBTYWx0ZWRfX5q/Jr9FZaJ39
 IxpWXL8ARTnqhcaISZGngCY4bbzUpnysZRq2uZ5Uf9cyFrubNTgF38f4wRIXiZPq/ZDlTVpduVy
 FPtGLQfqOxpHr4xUADaEyIWQuoU4GhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130073

Hi Thorsten, Thanks !

On 10/13/2026 1:04 PM, Thorsten Leemhuis wrote:
> On 10/9/26 21:01, Sasha Levin wrote:
>>> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
>>>> I would revert the original patch if there is hardware that uses the
>>>> I2C 1MHz fast-mode, since the current timings aren't to spec, but also
>>>> weren't before.
>>
>> For stable: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
>> SE_GENI_CLK_SEL") has already shipped in 7.2.9, 6.18.55 and 6.12.112, and is
>> queued for 6.6, 6.1, 5.15 and 5.10.
>>
>> The 32 MHz clock map (506bb2ab0075, v6.13+) does not exist in 6.12.y and older.
>> The backports there pick only the 19.2 MHz entry, so the Yoga Slim 7x /
>> X1E80100 timing regression cannot occur on 6.12.y or older, and I'm keeping the
>> 6.6 and older queues as they are.
>>
>> 7.2.y and 6.18.y do have the 32 MHz table and are affected. Once the fix lands
>> in mainline, I'll pick it up for 7.2 and 6.18.
> 
> @Andi, @viken, and/or @Daniel:
> 
> Is the patch at the start of the thread or some improved version heading
> to mainline meanwhile? What Sasha wrote above is one reason why that
> would be good rather sooner than latter; another is a regression
> report[1] from Birk (now CCed) wo ran into the problem with mainline --
> so it would be good to fix this before 7.3 is released, too.
> 
> Or is a revert the better option to achieve that?
> 

This is in active discussion with hardware experts, but taking time to 
get specs compliant configuration values while it's being tested.

I see 7.3 release on 25th, so what max time we can have before reverting ?

I am trying to get values asap.

> Ciao, Thorsten
> 
> [1]
> https://lore.kernel.org/stable/179173732257.29426.7905170638383807320@pm.me/

