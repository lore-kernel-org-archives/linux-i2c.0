Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA43438B0
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919726; cv=none; b=gMto4U43iwch0CPlW323+nfZEdTEF5aUJzUi0SRdEJRKR+CgSwr/emPgd+dR3I0TdlJv6KDctQXUH5oeUoxc1YBYxUPhpJoJq37OUVsyee6VnMdYbYud1cmdwmXV9Jo6GGAG6Ky5cxAMBwny8qKWSYB75KYHYypkRIB0Iy+ob+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919726; c=relaxed/simple;
	bh=oswZl/DGMs8eoEd/aGuPv1AWlVCGLCN6LemdERuojdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC064YWb32vuVZp/Zx62xRno+O75nmFtz9wduMu7Es13pxIsPCZ6bCHIDcHi8cujGqNTKsEMKdXjpby4E98hg5vEDo74015A/mZZ31Y4QbViJ4fraOi0JmH+DGNsn+hoE0f6AFXwy1zka0l3Iknm3MfeIEi4YfXWI1oPylHjS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lwzBRPFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dlWwZSfB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lwzBRPFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dlWwZSfB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3AKRp080081
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 05:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S9xVYkyXqvuSpTs2QWTynmVppBnWKhiGOrHMenH7w7o=; b=lwzBRPFAavnedYb6
	s77F6xL0sxpG3lTWIK8NYWpaB9e399GNLmbLBOB+bI46HOHjBBBwdPsx7c+h1h5d
	p1CSaP8y+9BACrRYDBWL5TUi+Voh2DAvvr0eENWBN+EW+eeuBZNgMVbfZVnVejAE
	iXU5eIWuxMq6JE8zVWp1A/lTb82Xj4eRDGuCr9WbCfsVQthOseChzUe90BFMfhE9
	c6zgE5UNA25p0BmmIC+wGik43OavoPT0Ou19TT7AQrOD6Du7CiRu8YOAseuzOHBW
	+vq4myZAb9ylwOTklPztbNRmeMks6jhGbV9I+kJR9H7JJ7SYTUSO7YUHFfs5l5xq
	2pdnqA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcmcrm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 05:15:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so3827991a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 12 Jul 2026 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783919724; x=1784524524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9xVYkyXqvuSpTs2QWTynmVppBnWKhiGOrHMenH7w7o=;
        b=dlWwZSfBD6PFJxxbU8uNZbWuMy4Wol7gG0uwwdz0q08jzT9l39e9a0kgyGuhrilJZu
         bgSKc4IRxpZPwjgzQskK+5gcXa7SGpZLAQ1LFSay7MkFXiAuKTBwEJXBVgMuF8lCMK76
         K/+EVmDejRdbxnTC0oVvjpIjMqIbNMBp7THft2qhawMKtnN6Q20MujumIcBKRcEiJr+d
         b2ek7xPJXzq/E0SRfk3r80dKZWipy11zSyMAE7TrSvvrnNQacE+crrtDHY2YNbFxnqEM
         SSTSCkLuEGga2YCw8z4rhjPSLdYYAynbN4a7CCZkJVmWZ1Et6jOYgn0aHOPdY1LjUDH/
         2V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783919724; x=1784524524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S9xVYkyXqvuSpTs2QWTynmVppBnWKhiGOrHMenH7w7o=;
        b=FxwNNz4ZCyyzjt8qlOCGlULiUJe16V3AkCezh8H6zUBrv/0eTHMK4CnhiII0dABkCa
         1u/WrY52p76k/20a5GEM3QR0gX8RKN218kj1Qsw53sw9dShDO0wnEoRvRiMemwGvkLLj
         ea0srfGJ/vhE5+SoC/fngdZaB5QRAidgZvDIgtUjjMhEOQ9Oi5QYQen14ne1qegFaY6g
         e6AWusPVvXTHdVF9yawg9EXoo+hpcmwOj6Hsg4HCZXWGVfrp41XrEdCOpYgILJTZrdVF
         rS3PkjDct3ZIXKyU/DFRaHM8IVbs5vKT4cRs42ymUPmREYzbOEveLZVcOwUvaTdOXEjt
         IpBQ==
X-Forwarded-Encrypted: i=1; AHgh+RopY1NYda4nhjPcm+OY7i3Oolvl2P+ycidBEDwAR/g6th81isVzZQv5f+d6LTvVFfJGHpAniqKfk9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+F89UJnJ9id8+QQ/NCHpBnKzhtX6JJJnSQZRgU2GdXiJ54Kzv
	c22li3UJqAIGVFpfhIY/qdwV7w3zqoszJU3or/kabZpveGIvQDE2TQXtvN/zcOAxN8XdZBg2iXy
	ArpG9bs3PWnRjnSurH4RAF1XYnpv1iVmprKr1AiGYY0z0/Lpg9/kd23Wmab/iwms=
X-Gm-Gg: AfdE7clbWswZErk6GhaP6KRtVern04ajswtnMvBliPds0fIBFcvtt3A3uFeqs5hggQK
	lDW0t+7PmpWEmDM+L4enlCdTDA0Wb9pE2zNSLE5h7dBq9LP+94YWJISBZ08Va2OgqK/r5v+FBXz
	Uh9m43RnaMJS7Onpm6yscJSIshW8fAPsULDXZHiAP0i7UaMmgOFv0fPLMGOJ8/Y2sieIonmdriK
	4dyDCEsqbcLi+PO5xUpJeHzQtMtsV5wxgTGz56Gxeuf4YcsIm0aqFXcs+MqJ3Zm3EtRLR5RzZMx
	nui26K0UDLvw/WEVz3ssRK5IZORUym2SQ97M7COYN1KOWojehn9wXi/JlGPJavf3LQCmb4814te
	gk3CWJoaVSzVKOGje1wA1c6J7q47cxQBh3nC/JdNqgyab
X-Received: by 2002:a05:6a21:e8c:b0:3c0:9c19:6598 with SMTP id adf61e73a8af0-3c110b78efdmr7269819637.64.1783919723743;
        Sun, 12 Jul 2026 22:15:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8c:b0:3c0:9c19:6598 with SMTP id adf61e73a8af0-3c110b78efdmr7269799637.64.1783919723302;
        Sun, 12 Jul 2026 22:15:23 -0700 (PDT)
Received: from [10.92.175.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8fc7c088sm17904482c88.2.2026.07.12.22.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 22:15:21 -0700 (PDT)
Message-ID: <27a69fe9-7822-417d-8e62-056cdd2ad9fd@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:45:17 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, troy.mitchell@linux.spacemit.com
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
 <76c5567a-cc93-422c-a18f-a32dcb101428@oss.qualcomm.com>
 <d047f823-feff-414c-b1b4-54f6ccea6b66@kylinos.cn>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <d047f823-feff-414c-b1b4-54f6ccea6b66@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfX65j10ziwShtM
 iFZq+QCjurZyp4TgEtcu2qiSwoIJCvzu3aIJMwIBz1Qa+ulnQXTcHFhpbl2ezZopUZfOZkLcxfm
 dekLzj4mBoef3Gw5k74MYycVu18siwNOtBAMcgeTM4Ph9+mj6zfy6mRElT2QQ792VlM1h+NZSOn
 gtJWMyqI/0eIrsK52c0M0BFhUBwSCV5JkpgyRwz764xdYletee3cfevEWhvkyeiHBedpUUDASi1
 R2Ie/dBMC09Nx0RA5GvM+FXCqaMsRPURxACVDXOdfSED9QVoJGw4uIncXVXgPosd+7k6cXY+R3i
 BhDR8GPn528ZigSRCAG/HliYAEYMqM4uwnhFnOJL/AwBUXRd6hDtYhpFrJQdEZeN/QbpNOzScsp
 sqiRvfhW8E6vzy5ZU63ImG/FDs7f/jZjRlKtPXlCj26XD8LRU/tYY/j1EFZnhP9Kd+PHh7FWXcs
 4PIAWDXekvKGo/yBnRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfX/TufXnvTPbY/
 rZ800EhMKYFx6pByds5C4eUOM1Ji6qHdV22jLds63yAW7CqqnuooOBKCdPuYcLCLep3gUd40LGE
 ehbKSr0kkynuwtVxMgusCbCBn0vrvQo=
X-Proofpoint-GUID: g4F6uXC8wkdtW3jPO4pMmZOWT2o-iyde
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a54746c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=_3TyFvm4RMDdthPgtvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: g4F6uXC8wkdtW3jPO4pMmZOWT2o-iyde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130051



On 7/10/2026 2:58 PM, Pei Xiao wrote:
> 
> 
> 在 2026/7/10 16:50, Mukesh Savaliya 写道:
>>
>>
>> On 7/10/2026 12:51 PM, Pei Xiao wrote:
>>> When the interrupt status register reads zero, the handler should
>>> return IRQ_NONE instead of IRQ_HANDLED. What the return value
>>> actually feeds into is the spurious interrupt accounting in
>>> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
>> note_interrupt() ? You mean to say No interrupt OR invalid interrupt
>> here ? I could not understand function name.
> https://elixir.bootlin.com/linux/v7.2-rc1/source/kernel/irq/spurious.c#L222
Thanks a lot ! I understood now.
>
  [...]

>>>
>>> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>>> ---
>>> changlog in v2:
>>> modify gitlog for Modify the incorrect Git commit message to match
>>> the reason for the modification.
>>> ---

Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

