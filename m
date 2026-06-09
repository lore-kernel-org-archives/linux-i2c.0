Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAA36F91F
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033734; cv=none; b=fAkKnp6NcIy1Yq2kpxsaO/+qtlgR6TTo9lfZnWJlHyGVvpjW04UC8T4V+o9ljy0ozE2ySkgyHUWbc3MCc5fb4DklNNWCwHexFFj+a6wOFB6JS0yyJTIdq1pvWO/m+ul25ZKUoMQGuOgf4xifChBY473DAVZrxMOuGdUv0zXQJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033734; c=relaxed/simple;
	bh=F8lS7QpPVnacaOQXs3rwaqUtwYpTjvSxT7xJheckgbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btpFVKEcFSpRHNaht3Yk0u4WKTqkWBCxa6ZnBxzmFUJsM/lm+it9vV5DkXP9i1u+NpPBbQtV+dbLHNEOpwOkKYWITBxbgctoTn9lVjKkU+mNawYghX9VdkwCnLGyRilTf7Fes12RVhCNjogTQgGiu1s+eZDObA2IgkMKa6esNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKdhc4Jh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z22T8Ex6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKdhc4Jh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z22T8Ex6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GOPVJ3196611
	for <linux-i2c@vger.kernel.org>; Tue, 9 Jun 2026 19:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8lS7QpPVnacaOQXs3rwaqUtwYpTjvSxT7xJheckgbs=; b=lKdhc4JhflKlsOXg
	hYS5riH9iP0okOLoMHmCTgBz4qg4hgjnuroX6AWYJnHDLguQJQ5pP1abxqi3ELk5
	soVWjFQJlLOH/kdGLq/uw2uIIcLXNH+rIlX5yN34DE012hUVGQkaw7YtfDpdftfH
	zw+bLKyace8bfspBggPhZGHCzN2UnTmiXbFKpZhw2iXHtNo/RGAHo3pBP5qe1eWb
	kFWrASMfBHEzDjclkslEveDfWKk+a6T5oHUg8oOuuvhK7KnAlqwMxc8btYV4wcqn
	DHhqyDAAWIhkLcShsepUgpxcr+ORdxG05UNzfwrBbvIV35y8aLZ6+nWc6y3Hj8/4
	EShtiw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v2ycx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 19:35:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383414cf84so999148c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781033731; x=1781638531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8lS7QpPVnacaOQXs3rwaqUtwYpTjvSxT7xJheckgbs=;
        b=Z22T8Ex6n8+cC1DiYaPHK5gZxWdVs6NYjpujZb/4KUi/H/z64SsqSAsxkcOefGicbI
         aR+lbVDX6iDrc0ltsIy+kH0P0Bq/nC2Mxl8OdUNiUntWUwfECUp1XIXDvz2sCX8QuUvW
         44YpXkfUGTGNtyn9Oc8lTQvZ2nSIXLLTzBm73opStLIuWsxZioSftlWBWxvXHXrlI5DX
         fCxG9cXYmvc4lIQLcU7KbtM6gZ+SIBIboNAc1RlVX0L+zbJWZgW6+Ld6ydJyuOVOmVhL
         E/TDUwQiyEKneE0CrxKTAFTvyDVGIFnYgdGtIyoZxHOAn2R8OEj9PnlTbBX1bo973Saj
         P+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033731; x=1781638531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8lS7QpPVnacaOQXs3rwaqUtwYpTjvSxT7xJheckgbs=;
        b=VfAjyG0lfLHnfXcSmuuMGA0dbDPywbSaOqfre9qS/O5T6+rH9+NoDtNKwmNdy4GmqV
         62/sNTlUMdGx7siUjYFZvz45FLnSaCl1hRgPuZgeb8WIIawO4E2dP7xpNvy+vZII2kfB
         G6RwKy4noqWM8xkS+I1Ju5ldNaTbzVfq/Nop//WyzPYmuvyTKBk2E1LQieFBsnsarLti
         DeqPnkdbtCbC/E9HgDvEmv97rL7yd7cZXBacl/qdvCtZhZtxG1UPuXP2oKPXLsphEOKW
         85tpEL8cP+YVWWVTiw84rAnhoOutCF+fw8UgueyPdOBSI+A8rTQMS4gyaT8WUbcOTMeu
         g5/g==
X-Forwarded-Encrypted: i=1; AFNElJ8spXVkfp95WGXDPQW3BHb+qQMP7pwdjjlunlu5kLLCXMgy+5iVxRsUWo1oMVMa4ybsPJbHFMnwocQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hCocemsEMn47eiCEl0W7gpC5bITTzn6sISMiZQe3LXGM3Xp/
	rZ6xbQ7zU2pIWFKGEX7QPHJDcaPP0CXtyN2Fk+LUMlqUqPj453nYechg+emj6b+quMQhP7gdA7X
	P7DJSXAtLRvqli+1o+bKNlDpWBNM8PvFLWUU/jiCYsln8q4l3cn8U1g76fvZg5IJoE+IHLRY=
X-Gm-Gg: Acq92OFcjgERt331er+DLKgnZMKYC/awwBuWGIWJ9+51GP/p02Pa2TXjpYGVhSRURSq
	bo19tqKRLK+9eZGdERoM+3NITfqYPc1SVGerqn1RfGgNDYAyiVqt3vXc47llQYYp0eZ0e515q9K
	w1NFyQsLaDFSzPZmdharT+0sBMv9AxISNt7gP4Re14SqFFkYVRgTNbneYo+mLegKdQ3uVQgYjjl
	JY22Qpoivfjdw9pn7/dfplLpP+Lipz13tGGLe4fPjjHHpKGpF02n/MEA21ZcHi2+osWehllRm2b
	5Ukpjk8zc52zicWppe4z2FnXEF4vixFvT4y20SshbaYvIr5ws7dNGwhioP09H8ZYWcO3TF8pqiO
	6WCECD5GzXFlzbac41jjRDvAwBMeq1DwTxlKgjuS3YKkU4a//5JjlJK75zJc7ftc=
X-Received: by 2002:a05:7022:fe08:b0:138:364e:3224 with SMTP id a92af1059eb24-138364e332fmr1407679c88.16.1781033730805;
        Tue, 09 Jun 2026 12:35:30 -0700 (PDT)
X-Received: by 2002:a05:7022:fe08:b0:138:364e:3224 with SMTP id a92af1059eb24-138364e332fmr1407636c88.16.1781033730210;
        Tue, 09 Jun 2026 12:35:30 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.107.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm15724085c88.1.2026.06.09.12.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 12:35:29 -0700 (PDT)
Message-ID: <5fddd1a9-b1cb-4d08-86e5-665c4d1b147a@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 01:05:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Use pm_runtime_force_{suspend,resume}
 helpers
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260520-use_pm_runtime_apis-v1-1-6a5238fc6cb6@oss.qualcomm.com>
 <aihahOVIqpm83Guf@zenone.zhora.eu>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aihahOVIqpm83Guf@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a286b03 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=uEP1mZ4tISDvfoPjOx4BnA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dN3C5qKZf1Mu_qcU80cA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: PwzV1BNsy-T5kiA19aKtkB2LZhyD2H9B
X-Proofpoint-GUID: PwzV1BNsy-T5kiA19aKtkB2LZhyD2H9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE4MyBTYWx0ZWRfX4pKY1aWd2Xm2
 Uomp2s9gIvvXRf19sGkuWMNn95SpWecm+74p3phicrLp6qz0tRsburfiU6JOjmOXRFlVNG7PBer
 teTvgG3OfKRHErpp9SGNzvFH2WQGizSGmoHzORjKmOJ5Zesy0vpIHnFe226ea1n5WS973yMKtDd
 WtiivD3QhK3qPp1rhMgnjnhWcsYaHb+kWK/Fv5BNIrZBj2LE53yDrkWQYfTbiaP+tng55Xq9kJO
 7lPRe6ygvmI89hEtF21iy5BKbVXctrmCr/gl6HC+mJ/ESWvauk1tZWJl5Ma62o4d7rFeJA97Pst
 3brVLHWPAfb0mgO08j7Dgbi5WXxLHLqkEu1V5Mxuhg4mJoyDW0dvqAKuylfYk2kskcJgtGJkzq1
 kigQ7AEtcfj62eysoXUiwTtw+UlKGfeO5JlRmOwd+KKT58B1EgiiNOWuIGk9fqGE5Yhck/y1Y/1
 NaeOUtobIIhGrvfoS4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090183

Hi

On 09-06-2026 23:58, Andi Shyti wrote:
> Hi Praveen,
>
> On Wed, May 20, 2026 at 12:44:29PM +0530, Praveen Talari wrote:
>> The driver carries custom system suspend/resume handling that manually
>> tracks a suspended state and conditionally calls
>> geni_i2c_runtime_suspend()
>> from the noirq suspend path, then adjusts runtime PM state by hand. This
>> duplicates PM core behavior and adds unnecessary complexity.
>>
>> Drop the manual state tracking and switch to pm_runtime_force_suspend()
>> and pm_runtime_force_resume() for system sleep. These helpers already
>> perform the required checks, call the runtime PM callbacks when needed,
>> and keep runtime PM state transitions consistent.
>>
>> Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> I normally don't take these patches: Where and when has the
> review happened? The reviews has to be done in the mailing list
> and I need to be sure that they have been discussed.
>
> But, because I know Mukesh, because this patch has been sitting
> for a while and because it looks good to me, I merged it in
> i2c/i2c-host. But please, next time I want to see the review
> process happening in the mailing list.

Sure.

Thanks,
Praveen Talari

>
> Thanks,
> Andi
