Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48103EEAEF
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144802; cv=none; b=QF6N9K4Bw9sgNESuoe3qn27Gy2fVt9i1m455X1PnEn6IyMNjLvCRlvnsogKa5AVqfJ0UAQ1g/cjh9TGMhkxQ4sTpZwf5+10MG9AiaEGGJFdOAIVpCn9TxV/HlFrhEmsczVCjEulYknnEyPGN84gdv9Xx5Rr9TKfAxbMPQRqyBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144802; c=relaxed/simple;
	bh=MNYY1h84EpmIY1RYBpjfrjnOmLrFg+EdsCvTAztO0m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNlJNixLk4IZI5Qy/4kC+61ab6GdZ990ny9BcyxcDfSGNdkck5DRkcmqNwFVZ7a520g6lP0r6FwL2meWhfkJO1oh8tjOGk/2QmUeAjt6s7p+HzOExoOmvzko4vu3oaevxm7vHAPbyLqsWhbsbRCrrID/trdyLAzz+4/ggJ2RpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=np2olFkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y3QyneC5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="np2olFkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3QyneC5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Wvcb278816
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wa1TtJMnngd8nPLKlEErbenLvZBNtCEdzV9cCxILRr0=; b=np2olFkZYYstbOGs
	KDAbGr2T1ndffz3gzg7gzVP6qMebtYjKuifx8wRlR/8DVLyL29T9Rs/HOQNZ1vA9
	5u1KpDdPhPRlscQrmldGuiP7B/hx+47JVPmMROTN5Ri2qhukvp4lXFUn6NV3LR5I
	TELA5xZM7k64EraMcic55wC3rz2jOsJYIrsVpBC2koSULXt4VfuxglIgByUutkVv
	5toROXUKv3xmFR2KIcbuTIHpu0JqhuXIOpN55YtO72NtkxK1/JF8eL81Gh/U8ops
	UE/z51A1yQp2Zh/XNszU3im0COl7ubg1bOmglO/BpuNfS9vnR8II5rcxWtiFL3zT
	gJVLiw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wh9ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:33:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso1673571a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785144798; x=1785749598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wa1TtJMnngd8nPLKlEErbenLvZBNtCEdzV9cCxILRr0=;
        b=Y3QyneC5huQO5tAyYSRGPyCccHv7aarmAIoIj+vXv/kifnvhgonarSPq+PcAw7yHXu
         cPMQDtmk9JnJ0gDgb0C+4w38Ta764RgiO9U5TGTfBicKcaapPCItC6o8xvT9W93iseeQ
         XeH0CWmscST0jy/sRnYotoMVG3Y2zUVTATtZ+q3IBywSgeW0XV4NTC+/Y2pDi643lWWt
         r9Z6XNSfnItUMoeW7nFhV9lNjXZdsa5ci6rNs+o187sMTYeYO61XT714DG3aJwlEPp6M
         t1pRCggtDHO0MTf+5mVkrPS2/qmmY2ov0hUyim2WSlxAME2rkg2EwaQF4SvHqunOgrit
         C88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144798; x=1785749598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wa1TtJMnngd8nPLKlEErbenLvZBNtCEdzV9cCxILRr0=;
        b=nklR895BI+hu3GvG+5f13Mc1uX/q7vexqJizn9hQKEQ9piICtj3q/QTwm1Yv8Vog2h
         9oUWd7Fk9pdJFYFhUNf9J8Urt6rCqzmjPbu65grb2Hv1v98I0007HHOmsahcP1TZa1w0
         mrAqBSqkjBXEeWSGM6tPnnw8HnnmZ/FuopAu9lZ+V0w9ybhPok44i9ORUgoZig1fi14T
         kPZYiCzKS7n/ant1HAUctK4e0QumcrrfhAfUfRbu5Gy1McysmIHdkE3WfWvvGRUxHNYP
         gGpw94lXq+UA7XMtGOCD4+o1nrFEncxuhDtt4MVCvt3YlZdk31FdU9Aii93Y52E3C0Is
         FNhA==
X-Gm-Message-State: AOJu0YyI5c1LruYx/glPfv4xbEVBx4ZAdJqsRu57JazNKi9Q0Bi+maOJ
	UCsRBGTbs7Uy/7ovZWNaXb5vOrs8wHpWJ5+7fDhA7vp3q7socmbPN6vcMapoqSzA+25mljmZ5JJ
	L5PhpFstWqepMMbmFMM0z99eX5EYwzzd1QeauiH9omDocoZdYxwiVaE0lm4xx62g=
X-Gm-Gg: AR+sD131oAAxqWVClhbpEHENiG+PAso6X2JhKW7pDzzek0IjZz1X7cMrRnxizpDwafY
	79ObJ5UC1hJzzIC472nzvrT00+RDi0N1sQ/OK9XkRUU9mDeDJrvnHZnZeP10752pNaAdzv5E2tl
	4xAoHJj1N0qA93grPPiuH60MRWYnT7iGmxBIy2AwjpMjlc5s/LjaZ5D8e0TYpGhBQDDGLXzDq8B
	jJE0XbYn2yBnjcKoO6h41+FpCxeHsm3jRrl+32/xK5XgosfBOH/w2wNCyiFOZuY/d0B+amNkOsp
	exg/GYz7Q5E8Nf/rf4n1basYm10Z0UTo6A2ASgV5I+1wHob1m6I5ftFgPLNLWd+2wZDeihoQUyC
	+f8nULRWiHIAJBsXQow/A8vvtmwiI0l0V0A==
X-Received: by 2002:a05:6a21:682:b0:3c3:66c5:68d6 with SMTP id adf61e73a8af0-3c67d9b36a6mr7755270637.9.1785144798422;
        Mon, 27 Jul 2026 02:33:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:682:b0:3c3:66c5:68d6 with SMTP id adf61e73a8af0-3c67d9b36a6mr7755217637.9.1785144797445;
        Mon, 27 Jul 2026 02:33:17 -0700 (PDT)
Received: from [10.217.219.72] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66e0dd5sm2789586a12.31.2026.07.27.02.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:33:16 -0700 (PDT)
Message-ID: <f127746a-6b8a-4146-8872-6790431b563c@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:03:11 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MyBTYWx0ZWRfXx/DLIPem3Fxp
 ScirRS5hycG8OyneYUXvCSX1oW/5VIUCVE7NWtJdMkoq5H4gxxWoFTP6GmiR0fANVG0ZP4FS7Id
 2MLvS3xQvjhli8f0QACFQpTW0Qj+GNNldoYu/8t9hTcjwvGZO69fcwbsj5C/35FWfvjcfVbjT24
 o+z1TC4Fhsne/euGC1lP+r5a+dnOhkwyQUtHFsDzex2EqbwwNO8aHxRyV1HrHaeQh6zJoqsBmAu
 zL0gdJHvWFr7aDaYdQEPHmEnPtd2NEmw3xbzab+lekA2Tu0iyt2SlmL8xKboH4kbPhOf4yLl7ls
 HQv8c1KmkTeFbgeKftpZj1HeHFaD0eAB5SFUbBR4P1hgsg+Sb73DJIEwDBUedw49nRlNvZgiCrM
 7aaF29ymgCmELpknK/OR4sRELXR6PnGm3AZ7/lyd6Vc2yesfFyTZl7Q5dDB/evm1CgA+YHb8MW6
 MAzH9UN41/Vs9Gsw+QQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MyBTYWx0ZWRfX7XZ7UBdJUH9C
 HjBzxpwPFA5QDJDsc5uNLudlW8CF0IE3c+zrafCNVRW/xaszBBCPGX4d2b3cCci/jIIcQ/INOaj
 OgPXeiwSOqlJ/HHZzzeL78LQoXbpsd4=
X-Proofpoint-ORIG-GUID: M8L_kxGDduaI3v6B3hwLMjQUwMfDf8cr
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a6725df cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=GxJzyCk_ZRX2HhHMd4YA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: M8L_kxGDduaI3v6B3hwLMjQUwMfDf8cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270093



On 7/27/2026 2:51 PM, Loic Poulain wrote:
[...]

> @@ -587,6 +618,24 @@ static int cci_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
>   	cci->nclocks = ret;
>   
> +	cci->cci_clk = devm_clk_get(dev, "cci");
> +	if (IS_ERR(cci->cci_clk))
> +		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
> +				     "failed to get CCI clock\n");
> +
> +	ret = devm_pm_opp_set_clkname(dev, "cci");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");
> +
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to add OPP table\n");
> +

if this is an optional why to return with an error ? IMO, further 
operations should continue which are not opp dependent ?

> +	ret = cci_set_core_rate(cci, cci->data->cci_clk_rate);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");
> +
>   	ret = cci_enable_clocks(cci);
>   	if (ret < 0)
>   		return ret;
> 

