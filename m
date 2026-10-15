Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173151E422
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066626; cv=none; b=nO7vAPrVdKm73YoH8E/Rs65PI+tV9iaAg/AVlRYB6J5dI1IasCvOk3B+DoQIIM07pWo6oW8EjixjKi18UEm5p0Vh+9w6pGb9TSMj+lq2EbXZYNQtL4JvPBTm8TJ6CnrZFiWxIw+oxwroIT8zeBPA7/eDFjLiRdp+NGaECG4KLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066626; c=relaxed/simple;
	bh=RoSelfqR+JFVG/SXKTvafXJAkj900s5jRJkiQxTyBi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn9FrzMo+Rf98w5hfb3kyf+3k0xXtbskKVJXz6/9XshfiMM1llrOm4Qk2tLlrc3gFLxpcTG1ExP1oLBDjtrAKY8lGkKHnI4UChmhcuqXtrZZylH3eIOM3oeV4IjJORXc7KTKffwTs/eHXiqx/fXT1nQI1qfxF/OQhCOtTQE2AMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M461zxc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gUja6GKg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M461zxc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gUja6GKg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jgTY3510197
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=; b=M461zxc+qhaAcn2/
	qklCd5eNp6kJ0EFD36l77Z1Jx6dCSpVVEI8/GLxzB0TxK12HJxxI/Lgi3qiPuzK/
	VmGQoKKqAtcGhDQ4dz03+gSjZxGWNmMSC+n/S785IhPvtuaGQk6YtCCf0zdBZ0EJ
	iqQBZfS7GB1DgXi3UfRIbrqasoSEz2cVBCKQ0bU3580ie1kKHrkSNHWS71Nw4OsG
	rkcLBm/Chln+rD1lrrUHKiM1IiD64bfuIzhPO1qdoAMpakSIZa6K1MtizlN+ezBs
	/DaMhjqRG4IZlEOqFbfutxCLnvMOWDrnmqkCsGdkRgpdSl9yPtySXvd8gwh02Efu
	UbQhvg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds9xg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:17:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e617b5e9b3so37597235ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792066617; x=1792671417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=;
        b=gUja6GKgnRkPICqsMcanmT1Pmnth7olZ6x91+0ce1xdJwTzI14fGbWkGaDq3Nq3aQA
         JDqLRIo1v2QBmLAXD3rCJoG8O7yUqBTzNJn1I/Q07NJLc9mevOIKVimhxKqY2qYIj1wo
         aoPQXlxfgJ7U6W+WcgmOVgcDIZKR7PgkWi9cGGElANWB4kUiS+NrA1fdTrdiFgud/2b1
         jzpnWMht/pnu2OarF8rSyHBPuOhnSyG2PqHsWlloCYtoFfRwNNXssNyhei+kXx+8lWv2
         hcQrSaR0RWkcK33MDsVPYfb3DA7u+TW8ItdHJzm/J1HcTtwsED5VjbOe2QrIWwsx/pV7
         m0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066617; x=1792671417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=;
        b=WpHbeCLhWve4x18CO8ADouWH8NNogshZhWrungAIi1X3qtw/22AbaH224+gfFUKe3v
         7qE1b2DLSHDoGOhDszzrgrtB6xKLEFk0wDtkbTzA7ASxSGYxMVHRrgojYWOaajz00R/x
         peuEiJNMZMMwhNPry8Ij7pR0GQLH9owXrxT9m1aanfm7QH1H5XAxdYvlh+xv6YNlQq/n
         5NZVu1MwWCSJRiPlSeQ1s3j7wnbTkIfANzTmqLbwLFCiM2KSdZsuEl6J4RheBTuo/2wf
         CaDga30MM6z8Fkm1e0TzaZi3RD+NFST/mHy6iRkeY0kPbANtdvNU0h6WAiz6ZD7MlhXF
         wEdQ==
X-Gm-Message-State: AFq9FYInReMbT2uY1xtDxSaw8EkLa1Oh9DWsWROPF+ZFRfO49+f3EjPV
	e9yPa9idOAIkKDt+dNB+ibcnTjoZ0pqfpqNNfeoBYfoNPUF72AVWkb8PopOmho7IF39QlG8GDST
	L/eXAnpT/Gg8d5TSH4wKA4QYjAuThPX5ZlwqweqQxl1I4zV1XfRvaX1RaWmYY/js=
X-Gm-Gg: AYBFou066nsywSAxIUrmrvoeujyE78hsM8qM/nMPhe7m80KlcdT00tKHCWyiqVfKyNJ
	9Lt4L1khnTAjy4YGEu/3srYq0lC7HRqUI/X5qjM+rKOEqQdftfr+FHedyi+K0QKARCmovJ3HnHq
	y2zHu3LPGwbnoOsfvZBDP3KTo+oz8dHS3uYTtz67Tvxu6A8e7LeMK0L8rrmBYwC6v8ih7qaJXEZ
	jQfBLN+/eeDDQHuW9oP8yeNHW0gpeKvtbhGQP+qDkY6btCh2yORe1CjhunMZWmZebV4XpyBf/ZP
	26KhQJb/t+CyKIY9YS2Fp0VsdXj7cHiV2HNlnp7i2Lyl83qNyqRr4/zR8oanGYUrjd9P4rf+RCK
	/8zC6GHf+FzhkTeUwVWv2VO/VOTfefehl
X-Received: by 2002:a17:902:ce07:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2e8429ad199mr147196175ad.36.1792066617466;
        Thu, 15 Oct 2026 05:16:57 -0700 (PDT)
X-Received: by 2002:a17:902:ce07:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2e8429ad199mr147195935ad.36.1792066616942;
        Thu, 15 Oct 2026 05:16:56 -0700 (PDT)
Received: from [10.218.10.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e94ba30f6asm15395685ad.57.2026.10.15.05.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:16:56 -0700 (PDT)
Message-ID: <52bc42c2-f60b-4249-976d-83d360933ede@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 17:46:52 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Birk Skyum <birk.skyum@pm.me>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
References: <179173732257.29426.7905170638383807320@pm.me>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <179173732257.29426.7905170638383807320@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EgYjQV3EqeElIZRZQliLbHePX1TXH1d1
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0c43f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=5YmnReTpXDDOs48wh34A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX9wO7NwhKV1ix
 SB+vNUmeM02+XQXpOK53kEgz7qklGekPxeTFPFALKTQvq8QVkT2bAKq2+V0cbgGXMvboU3FL2HI
 7lpiJu6qSvtd+Iuz1S+zNCfh9ooZGnBkZYe3EfQACQndQAT1kdqx3Uz9WGJbjkiM4Z11guz44Eq
 ITkjNEyC3H66e50GhKVFjCI7qCuFujMahSVAiyMOSJQ96Xhwv+I3ZSoLTmXTxjxAR/pk/1Jt79u
 bON6Bf4XiCHnf/qe0WJQFKjhMdZ2AALw02v/kmf1kCstCfgU/Yvh1gHOdLwbYcqF14uoDKO+TbA
 8+aP9Zq2HnfsYSkghuvs6BvXJifQlSkvPkvAVYuXYCTcsQcTiyifIwGU+Aj2abm4wq06kEZh/Im
 N2QDE7xq/wVfrsPi+XrdPNE+nAfRoVywpkekl+a/AVoDd390g4LpKwDSFgNZ4i8t5tUW5J57mNs
 r54JhM/5+8Ecjjyr7JA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX8NwMmWmQlRLW
 GVPRvjNkJ7mgFLDQfx4YCNNhOB3W4iZXK2/iQQWzTjBD+UkM2rca0Q9uSZT3D4v8GSO8ysMFTVp
 ZvEt+ACTVPWF+rOj5hA38ZWEZuJzC6A=
X-Proofpoint-GUID: EgYjQV3EqeElIZRZQliLbHePX1TXH1d1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150048



On 10/11/2026 10:18 PM, Birk Skyum wrote:
> Hi Viken,
> 
> This change takes away the built-in keyboard and touchpad of the Lenovo
> Yoga Slim 7x (x1e80100). It reached stable as 139efdb3ee6e in 7.2.9,
> and with it the laptop has no keyboard, also at the disk passphrase
> prompt.
> 
> With the change the first transfer on the keyboard's bus fails.
> 
>   geni_i2c b80000.i2c: Bus arbitration lost, clock line undriveable
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -11
>   i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> 
> The touchscreen on a80000.i2c keeps working. Both buses are set to
> 400 kHz in the device tree.
> 
> To narrow it down I took a 7.2.8 kernel that works on this laptop and
> replaced only i2c-qcom-geni.ko, built from the same tree. It is a
> distribution build of 7.2.8 whose patches touch neither this driver nor
> qcom-geni-se.
> 
>   7.2.8 driver                                keyboard works
>   7.2.9 driver (its five qcom-geni commits)   keyboard and touchpad dead
>   7.2.9 driver with 139efdb3ee6e reverted     keyboard works
> 
> One thing I can see from the outside. The driver does not set the rate
> of the SE clock. Without the change clk_summary shows the clocks of the
> I2C controllers at 19.2 MHz, so the 19.2 MHz table is used and
> SE_GENI_CLK_SEL is 0. With the change the same clocks read 32 MHz.
> 
>                                       without     with
>   gcc_qupv3_wrap0_s0_clk (b80000)    19200000    32000000
>   gcc_qupv3_wrap1_s0_clk (a80000)    19200000    32000000
> 
> So as far as I can tell these buses now run from the 32 MHz source with
> the 32 MHz table. I have not found why that fails on b80000 and not on
> a80000.
> 
> I have not tested mainline, which carries the change as cb97bf3d4f91.
> The same backport is in 6.18.y (5815329988ac) and 6.12.y
> (f5d0302416aa), which I have not tested either. I can test patches on
> this laptop.
> 
> #regzbot introduced: cb97bf3d4f91
> 
> Thanks,
> Birk
> 

Hi Birk,
 
Thank you for narrowing this down.
 
Could you please test whether increasing the I2C pad drive strength
resolves the failure with the new driver still applied?
 
On the Yoga Slim 7x, the affected b80000.i2c bus uses GPIO0 (SDA) and
GPIO1 (SCL), via the qup_i2c0_data_clk pinctrl state in hamoa.dtsi. It
currently specifies:
 
drive-strength = <2>;
 
Please change this to:
 
drive-strength = <6>;
 
and test with cb97bf3d4f91 present, including a cold boot if possible.
 
We have previously seen the same “Bus arbitration lost, clock line
undriveable” failure on another GENI I²C bus. Increasing the pad drive
strength from 2 mA to 6 mA resolved it there. This test would help
determine whether the 32 MHz clock selection exposes marginal I2C pad
drive strength on this board.
 
Thanks,
Viken
