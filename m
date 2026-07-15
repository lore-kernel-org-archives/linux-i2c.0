Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74C3A7F78
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100679; cv=none; b=L2Ji2HA7fVkxrqcX9KX/nJXUgoPxYg4Q5dlZOmthCgVelALvhVFyQ6tqoS5gOYfV0+p+0n5b3nFG4wtiAAc3x7ANUMyYKMevklL5n8c/e+uxMsx6He0qF9XTsGeX9UwLxVJRK7okHwbzajb9tz5xyQESM8100R0qXlQeJAfpqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100679; c=relaxed/simple;
	bh=h8Ayfh15p/outZyG3S/PIYqcrbov9ckVFA754vJaIHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0TUYAeFV6JMMXIH6iqKfo3p9U1Ef84N8KM0IXp56FXazOXIV4Ps2uUgMpHYurX9Nyd4koBws69Mh61iYw73+LNyIeVaBtoCqfY/OM+Uhc67BdAQ/SZ40sN+jJ+b/+dWMiiIcxZJvi4JKDtost4Djdkxwdbvmo79iviGc3Xgl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=flWivHx6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UhpPPZG7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="flWivHx6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UhpPPZG7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lhgw2625225
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=; b=flWivHx6DSNcEF4l
	3+WFGI5my90RIuFOWmXAH/VxAWTSY25H5DEk9L8jww59k0gz5NqgLobeUCCoRnPL
	hkVQWT2o39jdqbcaCjhudF01tzfSHGN+5+Fbp085SMJBeA5O9X5/il0/a6UU+JfF
	tFudpmaESNF+xHLhdbmvcYn7CS7pDJQJjpTGmwNQWk3N1aIbzWTvTKUYSBTPAs3q
	5p462r957NYRZbi7tD/hlVGkw/zqcastK20VjPhAxYz+1eWdIBQl1FaET4C08WPo
	5hVkFCG/XSgBf7Hhg8dVTiIG4IZsvjXhrSWwMu7ZFbJqrgjdtNA8gwVI40dshMNR
	/KwPAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqukwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:31:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e68cbeb53so99411985a.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784100671; x=1784705471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=;
        b=UhpPPZG7Z9ZraniwaIRdU9Er0GrxvJLt25PFd+pJ3yN+R37aJRjU3y9RcFI8xzkVFs
         zEQUrghf0TL8SszpiMu613yk8HPL0iRW14rPPokoeQfQ6yZ/BHObJbbOtvGyf5rHnGgF
         eVMz+9IzSZHdf/8PO8WtXNjHBfts1kW6kApZ4EefXTG6mF/FlxunIK+pJJDyuCjtmBEP
         rWKtgNE0n/wpAYyNdngpcbmv5b/4PV7KnqQ0lqUfL0tQuV+YinpjKbYI/xxW3XjEWEmI
         YUqWtBNSLl9o8Xih4p0zLtMvXM8LtBI9ySHdImIqSCbEiQwR/2rngSVnQHAcRODIJmZX
         XuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100671; x=1784705471;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=;
        b=mSJvjn3GNfvXw1MsSCS4o41etNf/5wHIaWmfQTyQRseM7ITUtedt5BsV5S8E4kQv/Q
         bLRLWx07HzUcR5yov+mh3y9SDgrXo/wGwjIZC2OdCdadxWOIR7hWLOHP1ZflNa3kIuac
         AnZwXU9c10Dd2ixsnkdP8v191688Jv2vcaf8WFtGvmugKz1md8Of6cE+jACKGBODJT95
         wy7oaRLUjXRDBwwcVogaj5nz4m8j3lRCdRD+6APlkDhDI0U5C01WpH33v4sgmMHypOnj
         3EaoZcugRgcUb6Oh2tRb7m1YGyzRp9TG0uoVacLtjqU1jjM79xxDvhNOfbs6yx0UDXml
         PrYA==
X-Gm-Message-State: AOJu0YwZO/DWv6NK3Zpz7kBrd//g2NeqkT3kXCG4lVJNRhD82bOiNyoG
	jRuNxK56z27uhMEAAwjZvcRgzmB4BNqPMT6tRo2D9X/oixx5RLJCI/w//nkG3cl2F3Z5YzCJTUd
	ntrq5GNiBxsRD+NsgwWb7sO386hWGMwWOijOWDk7q3aL313EixP0H0nPIXrz0k04=
X-Gm-Gg: AfdE7cmccbot30e/7/9ipSAivOMpE6yP6Hi8v9RP3HoSOnFoNOdykloK260JSsMzzFc
	IYiP988JSOQ6WMp2GPhnV8l3PBE8TFkTEJKaXrW0SypakULgkHIuPHvZJS5u2lxggvJ1TJrklUW
	hp0roMA1yClBP8WHQqJZV05cfeIgz0HyD6g3GjNbrpQHa/p5rrskAkmEwKlk2h+Jf5I3iG8uI19
	3BYXIEt5ccH2JMQrZv/EQNANA7rgW5Df0P22en99Ix3rd50uV749GX5WLK9LEQn3I1wGkd4HH/p
	v9WVaFP5prV0FeOphgy2humF8lvBgd9IpdCuav/ZM5QdD+MgjTTQOnN3MkcuvSEmpQRuPM7IY1O
	G5TqP2VemjvwHyM5+RelIUjMQAs+fvIUI85c=
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51cbf289286mr135432381cf.9.1784100670978;
        Wed, 15 Jul 2026 00:31:10 -0700 (PDT)
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51cbf289286mr135432081cf.9.1784100670440;
        Wed, 15 Jul 2026 00:31:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15fc29937esm790840866b.22.2026.07.15.00.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 00:31:09 -0700 (PDT)
Message-ID: <d6cbf1c1-9af5-4c06-abd0-0617dcce0bf8@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:31:06 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
 <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX3FTWA4/Jx6Xe
 WWASbf5dcUdsURC1l2bH8t2mLMS5JfjFZXXxRLT3qjHveISVr8hPBDYgFC/jfh67wCNfbdhZ5ec
 rZ5LBDrz1C8C1ZEeO5gg5G9dWJBk2GVuTLOo+jP/xSgBmFQHwY/XAyTQqr44hapbnVUTi8qRlMW
 Grcg3xQyhojncrDCvOGv0R6WYpIC99yefmGc44zt8ho6Kw5/IzLzIzZxwETN4+IlKVfGQ8N8DfR
 kUQkam2Q/hnyRwVcpKtTOkqIdIA7QbRdym922XnOpZ+cT0ik5zOO9W8kEYpo+FjOozNd1WVURi8
 9f+TGcwVS6u0IRwh7OtbOy0YrYsvUC+p/x8owdV/O+d8yZcG74hGHbKSIovY+sWwUNtkEysVn1k
 oB1YUVgYxqBM7bdpwZFchMDnfzhhKcp8oBY787l8O1uDXL8PTolCG6KlnPq/gblm2Wd0KvTYixq
 Rvda1bruJZoiFLbUrHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX9F7q1JhZ3vwx
 cPTgh9dksD1LnM6BCfwJ5joHJJo2j0LvEjX+F3XfXth1XT1qYMWqP6K5xNWWj/rTcTaVLppoy6g
 NAAFtNYC1WCGM8A64vWcLe9kc4CAzMY=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a57373f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lLXzRi4vikbFFa1iuNgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: apRYPvDz9SPQe-2g_7gXwMT4zfYkTAPd
X-Proofpoint-ORIG-GUID: apRYPvDz9SPQe-2g_7gXwMT4zfYkTAPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150071

On 7/15/26 6:06 AM, Mukesh Savaliya wrote:
> Hi Aniket, Thanks for addressing previous comments.
> 
> On 7/10/2026 9:40 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time. Add a 300ms
>> floor to budget for I2C clock stretching, where a slave may hold SCL
>> low indefinitely during internal processing. This detects real hangs
> not only internal processing but it may go bad holding SCL low indefinitely.
>> 3x faster than the old 1s static timeout.
> Meaning, in such case/scenario, don't need to wait till fixes timeout.
> I guess, 3x faster is relative to the 1 sec, but for larger data and slower frequency it may not be 3x. Hence, correct it accordingly.
>>
>> For GPI multi-descriptor transfers, use the maximum message length across
>> all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---

[...]

>> +/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
> Already explained in commit log, can remove second part.

This is very much non-obvious, please keep it 

Konrad
