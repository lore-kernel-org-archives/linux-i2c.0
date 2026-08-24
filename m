Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B936167B
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563375; cv=none; b=M1/fZSgcrioXn0CNjCSck++AQhjt1QfXTDTFRTYOMBGOGPkEV8hkRsRTglXD/Zz9Fvt4dK/hn+lhA+IGa3gXl7TNg0vLOLM25xMxSlNzxum4JL0WUAlap6L4B8G0v0AWg9MuTqr4oatmfQWFUpwNNh0489AyXe02vAm1ylNVP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563375; c=relaxed/simple;
	bh=Oip9GBI6mALpKmq9dgyitq6Uj+sBoyWs5jaVXDmyBUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVUo1ZziFVYMJZ0t3QEOyTrsGHiRUh/Ci+GUK90M6da/q5tKYGUjtpqV43lrMwO7er5SOpXHbEgngqJrDJagTbTj6WXe0iL8Y4s4Xb0oLXCrv1Xt+DJYkqQUNrgzdak82GERdFpiAOeRn07AHc5s1SZUWeqQX2UIjnXiGv5yJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoPKN2Ys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4P5pUJE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoPKN2Ys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4P5pUJE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O99ctp2572092
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=; b=GoPKN2YsoZ1Ncxq5
	Mjs8jTslU/ZT/BXIaBFrlbt+3n/FhxGSjZ1GsPknYmQt7U2EyFHSaguo/pJbLaft
	H9axYsH0KFUBct8yOX3FTqztTPFMsD7y/d3U1k/otTfYqvAHWqr7UQQBD1FbKLeX
	5TGcXgw8CoMvgH3zm3KO0NTlZdQn/yP8UWOwNBbe7Y1ybhKu/tRZekLZbcHSFeis
	3kzaiUwOes7bb2+S8bVZma5BMuDzBKnXSm2UGBeeRMO9N/wSHT02jFVBmoxF/5qB
	xwmrSzrhCW3yFWMjrYLGGGT1pNrGiYlI5xZpN2jl0Sro3wjWxZjoETHJ6xh7iG6w
	oeRsbA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr1sb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:22:50 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737c728b37fso73667137.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787563370; x=1788168170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=;
        b=d4P5pUJESNih+xSx1nPit3irRuRouWq1at1QX6X9gSGq1ueqdcIBP6bdlkf4PsiD5e
         M0ifJ1ueW1q6VVDRrB2oXzijlI4D02IKl2Y0lQdUmzH9XsITJKbgpe+NxtS1ZVL2umls
         Ra1383wVEBa4NkgM7xjaPeKErNjnbDrTONqOUIODrUBYlvvTDzMY5vjgyc3DTb8jdoRI
         sDIkF9TyKeYF/Hia3SxN+rdJs8OEyS/1NTG8kbFS1UnCMkELkDuHwUJsK+eS2t/LAMwp
         8hcd/KKX6tpbw3/9rSW/01kXGsU2ZOf3ZxTPvr4rUhOmgme2hSDLlDaVI5gV8UBuCkB1
         B+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563370; x=1788168170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=;
        b=ONqrcQy947evQ/wYG8xMG+Qyv6mQK0h/Xl70kcYFvnS5Nti/X4kFleqIzLs/YVGl+q
         ma/L91PCDaSni/7oMYtGilUtynWdif9sSd2aXa8TQyceY0f0CwSxM9lHFMkkFBeA18Lh
         WI1nHgNZdXKhSfO71JtgRa23cAjHoTYRNKW5ig+PErstHJ9e5MCzd1d6oDF7QaN2Gdp4
         3c/Tg+hDBMGmvyhYDcDL+afZZU6//fTcFlTynIylfqBrW+1BVJv9vgA7gEF5l/q05DzW
         iDCm76RdnesLEYyTB6EcoWFQZ7NYd6nrG4+eiZfPl+zd+o77LT1fKX2/JGb7I6q9ybQU
         6qnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOOJrMNDSCIfDRfsWU2w8Q8i/MK77lQg9SPN6YzL92N26YmY84b43N1xBlJdZFPjZyNvpiPZ0Ps44=@vger.kernel.org
X-Gm-Message-State: AFuF++m67YqHiNUGBHid36u6PFS7CDsjbfsDB286Si+mQrIpaEMxwQGH
	eu76QNUnpDpscumvsxP9/OWYdgCMXKtLbFXCphaLcxuXui/oMhW5yOvog9RHU+59f/MxA/+EG5C
	5PmXBgvYQpD6+1vwm+W0YfdPQwGRg2igdo8EJkUe11ucA8bq1M0107HSl6b4ZOiw=
X-Gm-Gg: AR+sD123uUsyCXmSAhCa02p/tayb3ASw6GkOvvsD1WPnHPBwiZwT3U7eUXY5r67w1V7
	ayBJayh110QBkT4jzM7Ud/v+0otv3D6WLfFTShPQUnMdJwqFmhl/qQrUZIrC1qpz+fI41byUQ/+
	kmM9RM3a6uykpyF1uY1BPHm8woh1Rn4VsesNrRrEyFrQwoR1gUavz9ccYa/s0cYYuB0clM5rWoo
	xJgWCGXeRoRN0k4+9RFqEeb/TWXYvrBgB0QKD89BbteuQUjoa+QX2IUwYoB6OzuFjeFT+sltp8X
	fgqEyKICN58KYKx4nc1cQGfcJMSrcXHOyv/kGnQHdQ7nZXO++42i68zObv6EbjuorlRhqAYswKD
	tX8sbzdDEPOVBVVFqPZNL6uCU
X-Received: by 2002:a67:fe89:0:b0:77b:b14e:b72c with SMTP id ada2fe7eead31-77bb14ee6famr1714033137.0.1787563369795;
        Mon, 24 Aug 2026 02:22:49 -0700 (PDT)
X-Received: by 2002:a67:fe89:0:b0:77b:b14e:b72c with SMTP id ada2fe7eead31-77bb14ee6famr1714021137.0.1787563369384;
        Mon, 24 Aug 2026 02:22:49 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm7681403a12.9.2026.08.24.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:22:48 -0700 (PDT)
Message-ID: <fbeaf7b6-8eee-481a-bea2-d1468ced4677@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:22:46 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
 <e3b06684-496c-4efe-9bc4-65d29583cb7a@oss.qualcomm.com>
 <62eedb1a-1da7-4e65-99db-7c510844bd99@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <62eedb1a-1da7-4e65-99db-7c510844bd99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX8eCgmrKZyKX+
 I4LasHWw2OOuiaTiYTZ4s45zOsZETTlcwbRjlCzUhuvYzBQXE9qJaetM4DKeIdFT03taOefi764
 B9eI4kxnAtQhRicDFSUEjOtg2eFJ+ykK0F4km7ImTLFF5qW8kXJ1VIpzrQUmMLZ4sgWBHd4TuAk
 IbWCt3TGwx5mA2UL6ZhpRW/v8aq275QrsKOVd8N1/V0uGHF7VPpK8FDOzHxawCLNtTcMzMbm6eJ
 8zOsKfosoTt3uQyYx37P0PBVGTACYQKnDvc8Dngtk/PuI9qUcmNSZSj5TevocvAXA8BshHYy6Lp
 8Wkdx1ivwmruXekiSwpXwkT0ZcbK/GekHoQHzR1IxEWitE1l/YODB5qwudA76VE8ME3AHaKQfX6
 oG4/jt3KiqD0Klmiw+5pmom9RmrzTTkZDcEmnsvDvgXruz6Rv+akcCQ1nw5iNBXiJNqhw1inuo1
 VvHVKvdc2xozb8yOHOA==
X-Proofpoint-GUID: 7w_W-AN1ZglcTK7xq6mRpmiH9h-Hsiyv
X-Proofpoint-ORIG-GUID: 7w_W-AN1ZglcTK7xq6mRpmiH9h-Hsiyv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX/PR+L0vzos8Q
 QaV7JY/47s4PDssU6ALsveT5Rdv1FGhSOSwMSf6T2qLrkIH7J/ssFHMkrJPuQWtYxFhIc0Bc2Rg
 BJDJoW1mdojVNAQi86PP9ZoSKpmzJBo=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c0d6a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6pWSofttRPDz3FuI-oQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240082

On 8/18/26 12:58 PM, Kathiravan Thirumoorthy wrote:
> 
> On 8/17/2026 7:25 PM, Konrad Dybcio wrote:
>> On 8/12/26 10:30 AM, Kathiravan Thirumoorthy wrote:
>>> In IPQ5424, to meet the setup and hold timing requirements in the
>>> standard mode, update the frequency table with the values recommended by
>>> HW design team.
>> Does this have any ipq5424 specifics, or are these just adjusted for
>> the generic case of srcclk=32mhz?
> 
> As far as I know, IPQ5424 is the first SoC which uses srcclk as 32MHz. IPQ5210 and IPQ9650 also uses srcclk as 32MHz which leverages the same SCL configuration.

OK, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
