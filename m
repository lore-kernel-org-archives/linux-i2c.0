Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F19346779
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122767; cv=none; b=T4BWYPLbx+6TPcpdb3hI7BCzlyAosJ8+DXfym6uOfpd4S4VNd+opZUEne3b4CO66oTf7esxZEXenWtDxnQkblRiif0T3xx/XWvMjfv+/KKPu7SxeNBEIPleDjr1Dj1rJJQ2Dl6uOurJiPUF/XYFzDfSG9RlV7ZGNpJKB9pIzu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122767; c=relaxed/simple;
	bh=Amt4X3KSlJX678bBl9A+eSsRqBFfHPh2lmxoRfYMDKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1cuNfqMLtri0G4rMSx2olGNP2IfqimpMVkqOnhompdinyU5oWHlpHRKRRT2HfNrvXHh9XoF3a/RviJtTJTProTo/0a4a/2oVHpZrD4onB8dV+2EAJXxIxRtxWSr03UVh20dwOD9lNa0wc1Jv4iAJ2KnCvUUWGhwj+uBckvRYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXmVbJsG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W4jnP9y4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXmVbJsG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W4jnP9y4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61371hm5256087
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FBvhKZkKdw5hN7UDdsLxHbqK1hX81+Qqdtt60bvn9tA=; b=UXmVbJsG8lh2lcEZ
	fzLYxShXvgSZtc28blNMIHWg8BhbPJqO8AeevkQbci6oEOvm4OYyyvFdbU6i/wzf
	cZeFmZZPQgYUw6oFQt4Ll7SfnWekmg8KDWGliNBclBiQ2LhEnFgKFvF+vJEOklmB
	ChHvccGu208DIPM398dWSJfS+msOzxsSC1Ao8m0kPUUIJ1j+fQq6lvreJ6iMczsH
	S8QjGpizXbsI811ny9/hnZL2nlI6UEaDNDoOqabGoDWy+uwhqJyBT3SdgftK7CUU
	Y+76h/7S6P1knbxOEXCl5MsGUJ3yaW5tK44JQRyfak+yW7D6opCU7vlv0p/qBbLS
	ApIK6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0km34g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:46:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2fdf3a190so57254385a.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770122764; x=1770727564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBvhKZkKdw5hN7UDdsLxHbqK1hX81+Qqdtt60bvn9tA=;
        b=W4jnP9y4+gDw9VrpV8pF+fq0/g9TRiEi+V205LzKK0SVYYddtq6JsHXb9bTt6/QOXa
         AQ82Vc2gZ7DhbG0xq2CHY0USTf0KwLP97NxuOOho2vvx65AdlGpn/p5OlQ+1TpQkFSHW
         qJybJPiuZ6Q5M/fwwL90EGYuqmFM8+gDYk0fe3e0y5HSGuzF1vr+mx1gjzN53YBYGkFV
         d5r0BedCAl5zTJpeAEY2lNccMS/8PxjUk/YAhqLFRgGd8iS+w6FX3cX0qh26e1PhRHQw
         goNT1RD0FJ1LNQRx5z87tYwMD3NrM/Tm4EEPDQkmz0o7C4d/mGLfy1UeXl6iJCeYuSke
         Ln6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122764; x=1770727564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBvhKZkKdw5hN7UDdsLxHbqK1hX81+Qqdtt60bvn9tA=;
        b=PWFBy8m6W3A1HFFP6HS2omN1K3SM9EUnqdv5iqJ9ggZmFsZE5ki9dxZzYAKCqXqwWZ
         oOptSlRug5NcNiZtrRwrdB7yhgJLIIk23wH5dr8KqsBhWDuBsTw1IbfWC7CRf7gvMCID
         I5narKsJJ6QQR7nbluPLfa7T6RQNdPIEtoZjlT59+5jeZzQA1ogUUBJVOX2WLlOCSJhJ
         FgMgntz3mc8qmDZB/u3YS0h7c0fzwqCH05QAhS7npBZV0/GEVD8yPmkPKTbK9IO11YUp
         wZwGz3XXLdwkvFUTwk/Xhgn+AhVztRjT3tZWqX4ElLl0auMFpgcL8G7VLH20HKmYM58m
         TRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkVz7K2txxJyR00+zCRyByJLO5q8wrCCsMkqi+sfH/39SS7yrgBSK6gx4YE/JpDRSCx+Ihm7WtNf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCKJ2fVAzJHokhZkZzixvzqPC9hcruf+129/AJyG3kcB+IDYa
	Rfdpa3luvDK48WBQu7WaJG8TsQrCBu7ncimto/mpNkrTVUSfnm7IrlSlV7ymgrQbKOdnblDhoYM
	d8wCE26dncDlGFvyFeGGcrsFd8i59NyZdRgKxhOGzmR6ImWsKWQAebPBW5GWOoq4=
X-Gm-Gg: AZuq6aKF4SsSnWG/gmdQJ1Fg1C7DgJQip5dFsctJ5YdD/sA7b0W1fXEp8MQfh0sWWkE
	9HSkd7lBZ6HRai7l3bQIvupH5ZT+nWsnVEFQ1fZccFYiiKKr8fyfeC9pkxnOaDOUAInwEiNg75F
	pz7URfBR6X2D8j8x9KQ+/w8wvXKcUEV+kCC8erfGTz4bQJzFcmxAr5fHpb6zPgQFyFEa2HJKHWo
	cNsiaiDTPqcw81bqDjc8Nz9UbGml+Rh1Z1NZUCKviFlbGs+xteoPOErRkWOjUq0pTL76jHTwe+I
	NkaiJ9WfXPQEUeGBvcM+TpE1nCEaXEhM1fY/XhArtHZWcyylzABOGL07VOdpe8KdfBJcNPYQXHI
	E7azrt/nfJXDHJFxtsIdf3wLiev7+VEheAWtoqh5y3LskZIbGUcTVTH8F8uWWzf2q368=
X-Received: by 2002:ae9:e710:0:b0:8c9:eb7f:b6d with SMTP id af79cd13be357-8c9eb7f16d1mr1175877285a.4.1770122764231;
        Tue, 03 Feb 2026 04:46:04 -0800 (PST)
X-Received: by 2002:ae9:e710:0:b0:8c9:eb7f:b6d with SMTP id af79cd13be357-8c9eb7f16d1mr1175875585a.4.1770122763860;
        Tue, 03 Feb 2026 04:46:03 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691db4sm9081780a12.22.2026.02.03.04.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:46:03 -0800 (PST)
Message-ID: <d7855286-e4d7-4418-a92a-0ed71ab72d7e@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] i2c: qcom-geni: Move resource initialization to
 separate function
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-11-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-11-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=6981ee0d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=z1U-K7oe7a0A7by5uvYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEwMiBTYWx0ZWRfX0JH/I+Lw3Zcu
 Cl7EHSCnY7q9g5VMPjujMiUD38sqT3PCL6XBpk+Qu5qd1a6Eb/QY2JE0E9veZHVc1khZokerwVx
 3jVmyqNoWv49+DwrubKpEojn4el0vTAjgckyv5ce+3MYhdrgQikWWkKcHsD7u6N1ldviN/dsCQ+
 j86xyP9JugVX5YS1glzhsTy+oCoSHQSj191oyHnb+6QR/9QF8UKJGXxVsKWEToam5KjGzdJX0g9
 vaIaLrMh8kMliAUDk1xP9CI/VeNV7PaxjTFEFVG+eMvwG25R0ZtHtGWwWSUq0n0Ik6QNXMp01Ah
 /+1bycKqwI0C93F3zz4feRaLH18JOZ0Y/KeOQq4Ka8KIraCCRiS1Ud/7KN+mKKWIynGFgJ5LE6t
 TyNnWGdRfZapjmK1mP7YbT2/n1HYFrISx430WVrluzZoT4Q5GZurtCq5mZqPuRpJ3BtzknPGzJS
 O6T23ZJLX8JwlnjwMpQ==
X-Proofpoint-GUID: WsUDcI7CyvdXzmvSzUBvJC1i3P-xmfjd
X-Proofpoint-ORIG-GUID: WsUDcI7CyvdXzmvSzUBvJC1i3P-xmfjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030102

On 2/2/26 7:09 PM, Praveen Talari wrote:
> Refactor the resource initialization in geni_i2c_probe() by introducing
> a new geni_i2c_resources_init() function and utilizing the common
> geni_se_resources_init() framework and clock frequency mapping, making the
> probe function cleaner.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
