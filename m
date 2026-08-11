Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF773033F8
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452135; cv=none; b=swVLXGZrp+XNKxZjYb+F8u6AhQS/ewTGr6wgdjun4O+csuawMEDnoEIHQOu62Q0kriMMamt5wFiZzRUxFlNXLQqNaw7Zxi3gCRf9ntdGLX7sPw5UdWU4tJL2uNoHFjAXiBEyaIWuKugaTDDW57UeYH3cl3aa9t/Hzu+3DsTxPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452135; c=relaxed/simple;
	bh=eidZb4zvZq7KecO/wJjalrxzCKhi9hoyiPdYriKvyy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsdifK2WOAacRrauGD25e8TYEpOgjxvcU2XQqW0DlTwpJZgG3lPMQG4m/CHxdzmRKk/nI8Afjn+XRmllfZTeJ6A+bq1ewzngkywyRQc5R01NaWtyuVT50Ojr7+S21Y5pOoe+yOCeRn6KIS7DyYcky2RY/GSR14r8XAHPMJvx6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8j0hori; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XgUlL0Lu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8j0hori";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XgUlL0Lu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRNeh3569269
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=; b=Y8j0horiPqcCf+ns
	zZs2LzI11qEEncRkh3cGYtta4DTPZUqP6l7LJhLSqhxGCu+2HuEOOaIFhcQ4Bdil
	f3QHI4A9kN5IHsO8opSYqmWe8HOKojQYZKvHnBFiylhWm+KXXuvp930+o3/n3HA3
	UC3WJAKB6LrgGxtd/QwMSKug8yFJvpySr43n+fIcrL/YBX1TepZDiUeUmVBWyWgM
	iMHR2A+wWiSJ6irxcCRBbA7E5eBmKUzfgJGlv9qoQIEpnF/B5ndkJU+i6nJ2EQn1
	EU+toplNVuapx5Wy10WtRzpVEz4KjljsLH/kCAKH3rVASHubzF6CVAdauiAJ979s
	ujbv1Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwes86w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:42:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848474825ffso1138750b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452132; x=1787056932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=;
        b=XgUlL0LuWvVcDBfWuAXeqiMDb2sx1zLcTMVPdfRbaPU7bTJX8S3QD7FfxXKpj860iF
         ffcaBl65XZytbCTKTZj2Rt6uW00yrH9jo77+SnpvPcrZaO4UUMdK2RVPIo0MHZ6Ez8uf
         Tjcbxg7INY23yUCiy4VIr3+JrUwTxUu2wi0LR63mJYTUQzAdT1YR6b3iA37LFwK4LpHi
         eW1Du+M9qhr6NFTXJQI0cCNQDBYyRbl1mI2kP1HBlJ9GJAZ1BXVyx+tzW6rASiEFzuLS
         gxzMmdnZtbmJ1uIn8o5qla6+KNUsrpi0vNoslsCYoKs/IBECV7CSN6kb1q/6fzkrTAsI
         u8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452132; x=1787056932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=;
        b=hoMONHk8UMGkcKCRWh/1vpCZGcbcfbXGmkLA2VaYSFAAlPghfaJBTlrUQOn6dXLWJZ
         nlU72QZdprvUgjyV45GdWPxaB2Smyw1ex8bK4cGvgZdeb3BtiDp7xo21Vc0G/IOArSuI
         na3RaSff3uGUdZO6lu4rR2YACoRfn8l+ydpzlAydhDe7b6/sL8rM/1toGLkiaSK/BJxJ
         RVujkYy84Y+tiXQmCUc+JL+9iEDAgiyf3edNr4j20ySqZ3fJIvUNNJtblhREVWfnZoVb
         xXvnSRLuq2+f/iz5Df2Lk6I59B5yn1995IbxRberP1FGzOMlp0vn7HFWyhTBvvvWfvE4
         bLNw==
X-Forwarded-Encrypted: i=1; AHgh+RrBPePQZA/F3GmFGcFMY+bEFJVpOu8NGOmTI9HfDhTtBjBHcpnDGHUDa1vG5VAUN6sN7WBV4kO1LUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/M//d9/UQFDpdUwtN97h7BI1tV+Lsip4CuFl7EnMz6nRi9mbb
	Y+W9XhzRyc0A5BXxEcoJw0WPp6m05RSze5JVDmTtQE+PSPF3E3/+Uxu+m5aqf7Zv1bbSu0mcgqB
	F9Ax3s4jRkCn7tf6pYm0LrKsSHH3PGLjzoW8AmKTFswI73mRy1sj5mUXbDbKshIc=
X-Gm-Gg: AR+sD11/0e/Igg+XurYGYM8Cuvl5uXsKOo4lhjM/O9+VKiBzvfWX4jkcwclqqzvIiF1
	ctjnytxSQQVbwwVv+3gB4ipRen6GKtikjgeQqc9zRGmEnh11XyyzDoekSeSRUdWUG0DRdZb1IBi
	nujS0GiSD4DNm0Cx2SZIR6TNYTO/JZ4cVje7VT98zWi0Dl439hYSRxdk50N2w5ikOpyjwzBGbJX
	TLBVXbDFH/fzHnsGw+B4R83nvTpjDlbbwCXCFT45yk7Qa8GuyMF00SPxk5pIXZrMG5ESTfPIp22
	klNGFcsB8rt4ppDZ+jCeZG1khVn5kp7DFMMq2GdNkQWacBHRL85S8kmbvBz8uar0cdpcyrzIn5M
	EOK35z42dxSYjN2Zh+0HrQaAmpwpEpG64kUQ9ecsmxJGFv7frffKDniCaRkeJCgu6iMdqLBKn
X-Received: by 2002:a05:6a00:21c8:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-84fa8b7ce83mr2802167b3a.16.1786452131719;
        Tue, 11 Aug 2026 05:42:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:21c8:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-84fa8b7ce83mr2802106b3a.16.1786452131144;
        Tue, 11 Aug 2026 05:42:11 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:973e:782a:16ef:897c:10dd? ([2401:4900:1cb5:973e:782a:16ef:897c:10dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9526492sm687974b3a.39.2026.08.11.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:42:10 -0700 (PDT)
Message-ID: <8a6581f8-e9e3-4c02-8d26-245c102e7428@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:12:03 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i2c: qcom-geni: update frequency table to fix timing
 parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
 <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -mod6mWO0YjMPoBwxWlFsGyXH37WRTsI
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b18a4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE0sPqqNSvbv8NVRKTEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: -mod6mWO0YjMPoBwxWlFsGyXH37WRTsI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfXwFyYVhRQJa6/
 g2jmMSXWAbJuKjxrWnbR2WXz2yRoaHPY62rc698y1M/SRkcwK5Uax+CgufxXKAbv6qkn6vBa9x0
 o6yFdaz6BPEQaRWnE9VTSI4yXMPeXl0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX3Mz4GLE4t1RR
 VEgY0bDgie/7r8WMBXrhhohjgFV0vGUYUhow3DN2tnqOYJuqD2CxSHNol4KlWof/VXlDQHyhUef
 20ERR+RFPhpc7xDYQqyElYjFBGw3E741plglyfcddUb9RYb9eG4NFetAxk/bafFszDeTdFe7bsF
 3Knq9I14gqqckR87LTwxbJKyq9ocYlb5FVRiIlk19/U0UH3B8Va/Kw/USPNcupPvF5B2eBYMqVN
 rG0+ZoHdSK2eqQggr87bTaXw6NeyhFdpytFZKD/UcApyLdbxDLIaR5m9BiP9zrnf8/hfz9TQ8f9
 WmNB4acOfFXTmzpU2WyGLrwXKUUPO3x76ke+tk5DxgzrqHmvqO16vMlvk5GIWg5dlX1Qe+A3JSC
 6KFQbLzuIiVGNkOggltDMCtJPx/I7UC1VB70vTcT4z9bbEiRmFo5N6DaZTX5JJ8CTB70zmkYWVE
 8jgb5FH1FJeTXEEE9kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110106



On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
Changes are fore FAST mode too, please update the commit log accordingly.
> HW design team.
> 
> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 658636c1ee0e..00013b41a6f5 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -188,8 +188,8 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>   
>   /* source_clock = 32 MHz */
>   static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> -	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
> -	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
> +	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>   	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>   	{}
>   };
> 

