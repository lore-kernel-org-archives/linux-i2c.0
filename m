Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903C32C33D
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329733; cv=none; b=kyuClVORKL1R+Wo+qbmZXy5MUsb9wNGoP82+GNKWVDw+hezpNo+NqrVB2aTgetBjXnE7d8kvjsAiTLzAaiIjmMvBZd8mnAL2X0XJkRLcg1wbseCgf2tMP7g4zP+9Fy7BawK/oQXtQUq9R4sS7SIXCJHzenegTdZI9RlMFLlDaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329733; c=relaxed/simple;
	bh=5716HxySxYgesPMYObLsvfNKf2FB8Di/1BrEhT/qcHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5Bgk7xWdiqAI04OwhmjDeHe+UWW1/kwi5BHjt2BymR1eLSHBsSOLZCQwbrN6+EuDX490Dm7KKsXLWjxsKI57pp6Sy23hfPtZs+WV/0WiVgDBfiUC6ARNhU97PQFOZN8toeQzJ/yhKNmcFfOlsO7wv52HSVk1W55k86lXeDL8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hvfclo9b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PmkFXwFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hvfclo9b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmkFXwFl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9tTxx2804570
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dqPOiVgA/LPAUkGW1EX1UemeyO4lv7fTBluprRdgR4g=; b=Hvfclo9bAahDk7q5
	MpDFvxK7wn0DwQxQ3tM4Gpx1Ml5AakmvHI4eVntH8g2+edkM5FmvWo7A5yZpt70e
	E0O8M30UZerMNLLNTO91REy4Qcjlue9RcMTwCYv4ysToXRvxfsdLGt4S1rjNikth
	UVMTrSCSpkuESAgRPmFAL+HkMeGbJ9z+XGCJ7cVP6hKnPPklMI9pXfnQCpsKHiwx
	se35bLl98mpIPDiqaq0JhMsXy0jxOLK8spkTBMHPapLHGzZOReMUZ7gUGg+i/Pin
	w1jXoms5bFgyRyvjNYS7hmAN37/ABzOh3WI5rvbUmkzBU1hCjuIhiy94kpgz7S79
	julpxA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxukawu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:02:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5064fbe2babso31444191cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 04:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771329731; x=1771934531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqPOiVgA/LPAUkGW1EX1UemeyO4lv7fTBluprRdgR4g=;
        b=PmkFXwFlJkW1Qe0wI5Ak0pH46dK37ql1vWo03bE4eiAoWR/cAodXzy2db/Ti+5woUA
         rgwTfhSnbf91kMceF98ScMiqZE//vVYcMYwSVRuooB/vEEawHOhGuLXB+ab+8Zk668gG
         DffFXEAnwgdUZd4WL+RROvJ7L3K/CrgJUugVnDbhPQ6wgUqypmmqxACcrX9tSse2qvww
         TxeHBGFtIgWTCiqz742LQfHCrRfnRmwZkVO//xArFCN18gB4ZDC+q6S7Meb0H6G/94Sx
         eqeqTnOAhLAZgNL8Pr7mdmD76nFh9+f375ALeXbydXolAMURWtHNqLEfPIb1jX7X1Zu3
         6SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771329731; x=1771934531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqPOiVgA/LPAUkGW1EX1UemeyO4lv7fTBluprRdgR4g=;
        b=UoDU+nRbDuJeGHRahWiQ3n7BqdlYYAslTw2iN8O4M7P9ZEAXLVvhKgOseX5JII0ioO
         FFmjISqaY3ctTyQlf1gSGxpvL0RpVQfg+dxfQJUGXJQp+ZjnOrRqJ9ZIesPbIIv5JZFi
         ukAPxqqrymgRnVVHsQlv9BfPu+s77j2by0gZ6uQarZBoleOKzQcSjgEiJPmCvZRWUm0y
         mcyQCrizQFsxCZ8jK7k39b0An5KzPilcvz7d5vFL7W5/ot7myr1Odv3x8AL3Od9E6SSY
         HcNapxBqBOYhpHmAoOVBj7W5FTgbjRugS9eIN1iqyAiuxsT40Y4PGhZatZIW1E9CbYxU
         LpFw==
X-Forwarded-Encrypted: i=1; AJvYcCUEPbGEZCyIlqWBiJIN74CYkQQmazj2mbSH69W3zeVERJBvZ6o/3nrLt2VWEU3K5XuFgtOz0UxdN+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws85ELkHNRQFRUgiq64To0iygF6Q49Y9GCBvogJG/8LY5OTRGl
	VWiToObG4jp3twwHweN9ITmzCOFjYf5V/8ERVa0nMgN4nzycXSaTKeoRRaGZg+qtawMECLZ/Phr
	NbzM9493PMSUJjLggGdFQBgyMEWs96pDUTMR+u2bZFN0VR1CfHtlGEIlSD1x3RfQ=
X-Gm-Gg: AZuq6aKc/pciz+P91pUsZ15Q2b1SsDAQvQp6FGZJRQp6zoKGrZi/16DJbAVbqV2rY8e
	zrbXQ8WfWMlLh82gHFRzglPlRQO6pXCfP7SxHkTNzXQRMsRSiRNlEdyMdSj7pL2TU4auptbLg4c
	6QDCssue5eRX+FS/fIlXi28+v1OjChwIlGExvcKvmUsDaBQxwgPkW9ZWplmVvJOmPjfj/ywiLJB
	aMKtT3bijMXghWSgp4PG1c9SDesZPeFcB/0vE+N4iVbzvmTUFpius1ZlTPPboZ7pYAePHGiz945
	PhPu23//occo27uPjQdTiiBryIAhuekQ7o10A3H1oYiQK85So82BtTZ3QEOfn05kzd6vA+AY5Xd
	fodPGcldrE8KHIjwO0PSt76r2HmeWMVLXOOyEjOX686Jy5UZeZSrGTHNMXGH8opDaot43wVFoVd
	Ts03w=
X-Received: by 2002:ac8:5f0a:0:b0:501:4504:6f80 with SMTP id d75a77b69052e-506a6a4d9d9mr136978331cf.9.1771329730585;
        Tue, 17 Feb 2026 04:02:10 -0800 (PST)
X-Received: by 2002:ac8:5f0a:0:b0:501:4504:6f80 with SMTP id d75a77b69052e-506a6a4d9d9mr136978111cf.9.1771329730143;
        Tue, 17 Feb 2026 04:02:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e38f5sm2332241a12.19.2026.02.17.04.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:02:08 -0800 (PST)
Message-ID: <05340972-2013-45b6-801c-7e52fe48cef0@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:02:05 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-6-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-6-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 36UYV_ht6jKiivoYagW7sMpjmyrxPAaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5OSBTYWx0ZWRfX8F9xpmdcEdbf
 NNWo2lbQKOqUylK+qa572V0HtEAqUs4WtDk3tvh60kiwIuj2leyczY97Wpdyvz0aPtxa+3AReGt
 LCLf20Qfexw8E5GrzoUWdYZl9sb1nfE6zDHAmhYPFmxvck49pOcqYt43MOriWAiwfDwVz/8BJYe
 MWDU5WwMaP7WzvPDcW5Uwl1po5T8wVCbBUkRr598ibX1TeicoZQGDgGgl4jCLu+qH1d8NHRkZK0
 y3IkmL9tJ4vSXEWBP+U5fMf9qkK3JnUMRw69MqsDXlndlo7HRUowOf4FmiirqtYmb7vep2Su5iX
 jGAIE+EigfsTEk9IAl5WaSnGAN/2bj9yZhM4r90gdQflsQ8yhKsmS1laMqn6+gsMQkr9fmAD+Fh
 6pX+MwWrXSzPhaaM/740MH5lntEGchDcCGl2ASBd5VemEnFZ+Mmm+UNL9dqPle0UZFaZxNMEcRt
 NyHFXgPOuYMOZHg+iRg==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=699458c3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W3I9JGv7J1k6QNzkgEYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 36UYV_ht6jKiivoYagW7sMpjmyrxPAaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170099

On 2/6/26 6:41 PM, Praveen Talari wrote:
> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
> activation/deactivation sequences independently, leading to code
> duplication.
> 
> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
> power on/off resources.The activate function enables ICC, clocks, and TLMM
> whereas the deactivate function disables resources in reverse order
> including OPP rate reset, clocks, ICC and TLMM.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v4 -> v5
> Konrad
> - updated return value as 0 for geni_se_resources_activate().

I would really like you to include that kerneldoc bit I mentioned it

https://lore.kernel.org/linux-arm-msm/ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com/

Konrad
