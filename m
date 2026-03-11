Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938051CF8B
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236176; cv=none; b=aMqCc5vqi8h53ve2mKdWuTe0+MzUesDVFi3bthFsdqXEKaMyy2zrXDR0r1dQZFUNVrTtUAnAIX1b9/Glo8vSscOVhXDTlPyWklQxy+0v9soioDwXIOVpSbj4VnQClGuYv6KmqNgTSbLWE7RdjyWnkQ6gUgP5DehuAeEKsGFmSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236176; c=relaxed/simple;
	bh=rH5ts24BQ/UhBGGhX49B8Xlk4TgPkmgCrBdXZkBKpwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkYr3+CkQZE/0rLU7PqU/0s5tE8adbslpgoKFbowFyjUgPgUdUCKMPiNolo6ki9OTbZXOBARqAROjZ0zw7sCoT9xUq4y/d1OEsNalF3P3d13feLTkp3KKeYdvqZfwO69G5ruogowG7OB+A3rFJnpsEF6ufqVu3RleJyh5ZqQJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMZTCGQl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqfTJOnQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMZTCGQl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqfTJOnQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA34DN2038162
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykOfdb/L2I81AJssik4ZwdY6lbmVgNW0kf57btl/s/M=; b=GMZTCGQlBkvsgqCo
	o8yeUOIFiW8eKDJKssSiH1woKTKYhkMcY0veLW0sR97oqKDNcNEmkLzPoftvIWrT
	/RV64yTGYi086ah8Euwh0Z2D3Rf6ekgRzhutp9DKXVDI5c/HtZS9tMkDjcJrVFgF
	d7B1pRdJZo0tSW0U2YkSkB6RBNM0cYx+93/rWPgWatZaKzXIKNJFsk0qosurYJM1
	h9L+mzSKTRDqrUjttp8I6+tPnUJE9twFK3Z0ujvMiUs5TKTofImvsKphDfNxCYJp
	LC1agcaBGHKvMvYdtH57oq/ITqLbMtOowRlAS0s6fwMhgSiMkU2byjNKP7+/0cY2
	zbadJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6a5gqqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50938030661so6871201cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773236174; x=1773840974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykOfdb/L2I81AJssik4ZwdY6lbmVgNW0kf57btl/s/M=;
        b=XqfTJOnQ8vg9NsAUBCId3v/sxBVa+Gtegkks+FvVJreHgqTmYOuiUHGAuTNBh8bLra
         otzyXt1sCxiEN1/E9j6qTPptEOxg/NqMEzgSYedM6Axn8WI1thxt9fqSJ/kHXEJZGhg3
         2H7F8hGc7qDOFYF+DM4Fn00HRDKh94iWTERmCoXPA2l2V2RSnuDV96s3+BjW+ev1T37y
         IBrwIubhcFUROfkKdvXWLOb71DkVPOWdY4Oyb2w09aUuP3q1ZqqisUjXaXj53ohDbV84
         Q0ulxkKFXVpIzOdJM0T5XwBXcB1qK4j4fA7euF87e6QwWCGc+kmO/rNC9AYBbncnFASb
         GFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236174; x=1773840974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykOfdb/L2I81AJssik4ZwdY6lbmVgNW0kf57btl/s/M=;
        b=u6HDv2fL0lRSF3Nio0Xojm1qiu5VUidQPMB6EonqV40kryvFj8tmN/K5pZHQ2402TA
         PT1rWssFPiW6QCY0wspqooabxAmXf8TgkFFF+ZMfK/3WRhTxpaEG6fOYheJ3FhZx3xMY
         3jrInqWsv/YpqbiBPbvt9E74OR3N7pHLaU/CGroKxHkbFnMCeblSDxBRn6qbefFg3EUm
         2Xu4ym2xknBu6YosPurCMp2qtGw/HfTscqGuwIW/SFa+jX+fsmSGbsAwqi155YZv5Y1b
         72VOkja+wInlp0/Tcl5BXBIzkHQBNhwsG+4dBDOErHKWp5uw/wPnIi3esyaRp+3be5nv
         hqlA==
X-Forwarded-Encrypted: i=1; AJvYcCU8DyI55OyLjVb8tMSfVgaHUgmaAmoBcFmdtbbNtV55/tCCAqT7LmdyoqrBeRXjr8LbN3UT3evw9Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtfx7QUlawzgpjN9kfdtYPhUS6yeRqwMREINC41ap9NI1iWoD2
	a6uvCIA1XVRAC/Z8QWm79uZasX4k6Z2OXwDxAxolCaUu/gXfMg8DIe7vvh8AmW6GIlhkbRC3Txd
	eOWQKYF09UQoAT0ZCO4X3752A5OmE8pTNEoix8R1mYO9h2vPf9wMIv+/YKF6KZGg=
X-Gm-Gg: ATEYQzzoeqCQvvOThqsmr7Q70DfjgOtL9VuATT8wr+nieKzZvGIsfpKRiyvg+xhL+i3
	DEOXxyIm+MfMaBN6lflCMQRyFfMNtqHG5hnBYuKE9V4DsaeMi6mv5R42E0viKer1V2Qtg74bWC/
	PgB+X6HCDsIHEyu2SyRQVKn8S8lOm5PV/QB99zL+rsOmByQR2OvJjNmjMxq/zuCQQr9j3b9F1/A
	Xe/V4uJA1z7BeYClK+9p45k4O9zj5CdOv5t1UqgYtp5o01X+UUd/7RLAfMQfu/vPdqMTdk8V1uE
	UWy8v5t8nnv1ROrr4m6ZpXAhFdnaaOvFPueAmh3JRTRywAiwie8d2T94EX9oq0RJu0eOI68Q8qz
	fTv4Wre0myPCa9zfsoN6IzjCFmC5e8xsYQmmzJsm16NYHNeKoLtNv/Ihl/mKe+Cn3sB2yq7egrS
	I9sAk=
X-Received: by 2002:a05:620a:28ca:b0:8cd:9446:cee9 with SMTP id af79cd13be357-8cda1a7af37mr220998085a.10.1773236173983;
        Wed, 11 Mar 2026 06:36:13 -0700 (PDT)
X-Received: by 2002:a05:620a:28ca:b0:8cd:9446:cee9 with SMTP id af79cd13be357-8cda1a7af37mr220993085a.10.1773236173453;
        Wed, 11 Mar 2026 06:36:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de80974sm55622766b.24.2026.03.11.06.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:36:12 -0700 (PDT)
Message-ID: <17648d10-386c-4d8b-a135-f3358a677ef8@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] i2c: qcom-geni: Store of_device_id data in
 driver private struct
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
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <20260227061544.1785978-13-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227061544.1785978-13-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zn_9ia5uRHq6qSc3CjfbBIbjnJMxp6mX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX3PVsC492GX42
 rHNcJJPdqY16Use2kGAQue+IsNMm3D5Z7jtjzabOU1M02fUn3y3+2y4azucb6EvJxYLlSpda6jG
 CKmJ31lo2fBprub4wBUSwyI1vOUzOdkIfTgKwILmaOLMf/znBz6qlRDknhTnujgDjrELsOaah3J
 vQfJzHpM5yJZruVA6gHtEN4jwiyBkBy5YSr0MQKHAwIgnjX9JtVHFChiE83LHjjGD4UDTuMhFF+
 2RQR5pT2uY30ieCVsci1cwNatva/rf49texmzC50tUaV6MWvox+BXPitsV/eqdV9YSR5JXt2k2m
 rx+Ym0L0aOR4eSQy5iP+yFchPHGdOfN/JnfmSsfDegpShMc5tXdEKI3i7p0Rntmpy6BkdB5wK7u
 oF3PBxCyYL0R9zh1971Lz5U409SCcrLdF3TxORZO/SPfZkR5edgcu+E/+M6b4JTgHbCnDv2c8AA
 QCTg4wf0SXeclX1utrA==
X-Proofpoint-ORIG-GUID: zn_9ia5uRHq6qSc3CjfbBIbjnJMxp6mX
X-Authority-Analysis: v=2.4 cv=TtLrRTXh c=1 sm=1 tr=0 ts=69b16fce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LGq9mxx2219gQT2QHCcA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114

On 2/27/26 7:15 AM, Praveen Talari wrote:
> To avoid repeatedly fetching and checking platform data across various
> functions, store the struct of_device_id data directly in the i2c
> private structure. This change enhances code maintainability and reduces
> redundancy.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
