Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E93B9D92
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279347; cv=none; b=t9WjRY3owL9cPwEIl9mjEtO+2szlCoGzmDW7pKj3sqEgrSRC7Q1TESfNdOvLXXYydASWa7KPRAVBYdygu4t7BC6t2w/ViK76buNdnDIXDS4AejO+Ygj8pc4rJv9k4qPCodHj65jjmdmgcCYWRj0ZidWbimWlLTUFDOR1p9/Pul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279347; c=relaxed/simple;
	bh=gqtcrGTFr5nvODLGuJoR5tYCC5t26GFYZF492b0TvA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5+NvG1OExS8lVsN8BOHNb67ZkV5er1crMVUizE6m/o/wNxOSteSp6w1FD0lY5GkKL+ozOanB5bYn7Vu6dzI99PVOL5Ca0qKp2N27bYMFtKAfjNQDBXvTMdT6W2Tanv3iHT3WQjlScw7qqoRXVjE8reKVPWXYlsSpemLKPposl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awUdgDUO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F3JjFUST; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awUdgDUO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F3JjFUST"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGXMV021500
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 15:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Amel3Ki2zXNrX/7FZJwT6RM3+K8dNmrSBRyTw5oSvT0=; b=awUdgDUOtA9GKwW6
	epj58chBC5hgvDphFBS3cJCt0leEZW2ZTBg6+HzWewYubr3zRiiKmdCtSgb0CHlm
	zeNOT25pYTOiXzO35p8ZGm6OSdG63filyTDx8tugjgSY4AzlvvU5phViBfcIfqEl
	GmksDUY2d8vBLY3tZO30+KpVwTFG43DuHJ62+atAd7X7WZLDzi07Y5h12cg9Vbr4
	mnUALKU3zP5dZjodYaIPPY1Fg8W33MHVXYJs3O8+qrHFMrnAncRdD6uficI1VA//
	+Mh3++CmBmoaxegzL3VJVhFBv4jRYUqL7aOTvxkF77nktkY2/Pt6gmPqg5jUsZJX
	HQV6hQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k312ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 15:22:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-94ddd9b0f66so461384241.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279344; x=1774884144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Amel3Ki2zXNrX/7FZJwT6RM3+K8dNmrSBRyTw5oSvT0=;
        b=F3JjFUST42B8ylZh5nRVPCpPoZqV/AYdbhxd6feCd9FJrR5tBC0IaVC11utxmYUYNR
         3lwV+a9yH+1aMzIdibj5hpe8dpSA6oRAFjTmenTn22xq2VBHh4LV/05mOsHCDfdZL5e+
         TX37zNVtn61okvpRiVaTNxs/bL/g3Ga7kNKJgZeDSHkmep0CI6ZHapsoxBNsitmsyCVv
         etZaqIkg2csagYzVr2pJjPyW0ZrKE1mjV+2sQr45d0DnuL3du9vtD5AHHCSLnPFmTahB
         W8lGVWllW1fi2kex5eZC46GibuyA+EwKYgpIu3GwpVVI7axxbKvGl/R6HanjP6K5QmE6
         sgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279344; x=1774884144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Amel3Ki2zXNrX/7FZJwT6RM3+K8dNmrSBRyTw5oSvT0=;
        b=szwNmxXvm7f93Ch0FgSzBiz7jzM3xSeROJo3B02ZedBcagc/68zQZKzrxozmqxNKBc
         qPJ6FxX4+mSQNDUAqyVB413KVbmBiKV2dguuPh194ifsZXvJZQuayG+aql7VpoEJmGQ+
         m2N7Kk4amNyenFX9aM159JITBks2Z1casgYnvCkXDqfvvLZclR3PCi8HtyKPwZAypm8S
         kn/ooaTlhXWsE5xNUmzT8XvjnfhucVFH5VgRCa8nVA9gIiCeS0T6yOp3H6eV2hcdUOSa
         tT5Mj91k/ecPfKWlsG1V2AePr+m46Gxse+va/dW3H1Z6I3P0Xd59MNK8kHcNd9yIjVmO
         6u8A==
X-Gm-Message-State: AOJu0YzWs6HX3VGW2FOTLZ4BhvPFXH8QcnhLjU5WAq4aoBXQS9a7TroS
	u6TWyA7ZIOTKDPdtReEOmDjc40aua0+uLRYNxCOoJJ4Ss/L2D3HH08g0NQitO4a/VSOT6E/L3OY
	4LeCBSWjr5sv0UihMeKcVrkwiR1CBAoIT4rkRUEEV1o6aO1r9Q5Bp+lK1CvIppkc=
X-Gm-Gg: ATEYQzy4aZhHnpq2L3GcwTE4MTVdtLdwb/a7KmnzUhvjma+inlPreFQCVY2AsgWRQQZ
	TfeQnFZfFDqf4+bCmPP0la15pysIVa7DPYPUO/fea8Z8nH1lVoKBEePHWnezvKAVTsJgxu3VW1d
	NYI65tDUQ1qA9ug5gQ8e+sDRQsg/hfjNcdik+XcRQ8qulra1+e1peIf1hPxu80DK0pSj6wtGCea
	amhnt1rYFxlXf+StUB3XiXJ03i9j4xqaG8G5p6d0i7tkXvI2QsS4P4CXef0pNDGdtQzfJglQ6rl
	gOXE4cEkEq1jxPsbc4kzbHj4z4eDbWV7I8CtQnQdhMU+Y84ZO1RTN5ryYHK+vTSf8YVAfc+/8lM
	gORglXrBuSeFxpucPGOHkiIPtbwr3BbI9sh1DYG8KGu+2v9OYjBBuk2D2hlg9KMgtlSo+aHX7iP
	LvpJY=
X-Received: by 2002:a05:6102:74c:b0:5ff:c831:b98b with SMTP id ada2fe7eead31-602aea86467mr2333022137.2.1774279344365;
        Mon, 23 Mar 2026 08:22:24 -0700 (PDT)
X-Received: by 2002:a05:6102:74c:b0:5ff:c831:b98b with SMTP id ada2fe7eead31-602aea86467mr2332997137.2.1774279343875;
        Mon, 23 Mar 2026 08:22:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66a281b6fb0sm86875a12.19.2026.03.23.08.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:22:22 -0700 (PDT)
Message-ID: <2e13c91a-6d87-4c2b-8a98-0b58f97023ed@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
 <20260305-sm6150_evk-v6-5-38ce4360d5e0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260305-sm6150_evk-v6-5-38ce4360d5e0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c15ab0 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hKTp4ChWe8y635cLtM8A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfXwKEfuycrIAHH
 zX+wDw2hac+ysjm9l4C+3BULEKCgD8VXCyEnhkmrbH79CKNgNzDhgennvSodqddrLqN1Ge7XFyL
 uJjHLG+kYDjTlBDDP/S4AyqMRyw0oifZ1YJ67RuymZQdvAwdky9hN4sSiUh5IHJq0XCM3nFCrpR
 Vr/KnVKYVFrPfI75sSrd7AsE5zR8hsJ1JSBI9ALUZ117jfdhrAOZJ5Vi/2e7RwNJl1WeMHlUb7e
 /iHbmdvHjEcOckdqLlZOmvLAYae1tQvHqfNvBtAuJNdyXfSt8p9S8tYdVcLMW2TAcdkjW15L4HO
 JIHQnASmp3G3DRSWMduUjzysM+wq/6UfghcbtUks9dg0t9oSpAeBW4y/wlSgIkHvnHcKaRaKX1W
 9R/28sZVQ8GcEiLV9Msf+u0EU98qU4NR6v1ezgEF/9Jm/mTfJHsbvVxVZJqLlXg7MKdtKUqgCW+
 BEUh6YE/Uv775K7ooTA==
X-Proofpoint-GUID: JoEHwXj1WvZlkm55I_pBovToRdGtvQ9N
X-Proofpoint-ORIG-GUID: JoEHwXj1WvZlkm55I_pBovToRdGtvQ9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118

On 3/5/26 10:48 AM, Wenmeng Liu wrote:
> Enable IMX577 via CCI on Talos EVK Core Kit.
> 
> The Talos EVK board does not include a camera sensor
> by default. This DTSO has enabled the Arducam 12.3MP
> IMX577 Mini Camera Module on the CSI-1 interface.
> CSI-1 interface using mclk2 as the MCLK source on this board.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
