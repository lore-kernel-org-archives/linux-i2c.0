Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BA534443
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658850; cv=none; b=lo02thbaa8zOPZ8pUiBLx4XKW6NMnWlYCszVh/7XL7UFkJUQMRWh5ePuiUrF94rQbAyQ1h28FYJ6fJCoScHgvx1OBYGuxCFYfPWSbrbmxb5x1aQ37tIR4DxiZgTmivpstMpsMSvrGFO81lDjPQCXKnjufWYaQ9wZSy3HTOKl/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658850; c=relaxed/simple;
	bh=ORrkQdx7WaXLuX6nCR7n/UoR4xgg8OSPPnuyxEfLNUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKx/fmkmL+X6DKK9EibuSAUUXzbXeXptmR4ewMpUFZE/GDi0uEKSNNGEiGxzyaEEkmOyURsE216gT+Y8g8mIo/xx1Rb8vOWHk88xqS0UkTCxcV9ksOi0bs1KQgb1kJmU7DFNUEGewyjVxPb2KEE34DO/Pn+qWNRWK8f18SazXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQ0AS78Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fF6FPlpy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQ0AS78Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fF6FPlpy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDio7m1137784
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lOcf1R7o5InmAsKwg2E0EjTS
	IYI7yDGuX6N2Ud8ufV8=; b=MQ0AS78YiydvB/L9ivANs0HuhU7RutkgB/3kwdsG
	kMln+VSjUbSBBkbM5olq7ZRZzRo++BRaqiiaJEvyz0Akj/Hp1UHnUUiNPhcVNDSq
	pBDSU2oW7E2Qzwfg6V/uLmt5m7FsWiMArz36lg4/pTUOcg04wcln4stYkJvzbgiF
	baJAbhBtKQd1MqqD0O2f2nwVFWzvlvbm3z5RoUurE/IWD78pLrjtaHdulPd1NWwg
	m/+K+R9RONfZyvdSC6pJKvZZ+M2QdJsKFhO/3iyPqUVyd7Cyh3DcuKaYkSkTj//Z
	X6KTcpwF+lDdjZ3eULZUuIS/dgjHB6Dq53/u/7u1UaTO1g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw2vfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:27:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90ce8ad8002so20374976d6.2
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789658834; x=1790263634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lOcf1R7o5InmAsKwg2E0EjTSIYI7yDGuX6N2Ud8ufV8=;
        b=fF6FPlpyCSwQaHGjcVNd5MjyCjbetN7WV1blgzFr9082tOU0WbDziUbZG7XZT+cZMi
         SNck0Hkd9KtjOR3rC1cg5O6dt/3H/0hBYn7QcWDFnZ5ZGhIi4nj1RSx/r+dNPrwfjKEx
         +kMnDfUu34tkct9uFkgbhF01K8pLn8SaOrWRvXsj+EjZQqp2L0BLIgTycOiYjnDaJskW
         9i4kJF8+5BJdlbO5Sv8gj6MRiY+oNcxD2Z9m4nc16qf2SW/ovq+iqOtZxnRnzozFQ8Ro
         vSne9G/6mxeVVv2bd8DX7gZjiXAymgcNrkywXqvBtFp0BldruuzNkh4KERopfqtUOiRV
         ce4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658834; x=1790263634;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOcf1R7o5InmAsKwg2E0EjTSIYI7yDGuX6N2Ud8ufV8=;
        b=rROuKhBsm5muBxOCGvHK+6BcEnfiNFn+r04KEIqyx+M/bvE0mibJxYvxyr0NUTWPzr
         AnHy/hyw/0E/1mBybOWxl92jclJKwOZFgbIaazpR4SzrkcStD0tNSSsYRzmCL1DQLdYm
         rvXHB7HxjE2bqMxXblaIpy5cDunUX4b6lckfV0PeS77eVs5q7izqeS9wlWksIs8ugM9b
         /56o6guvuqfZc24w8cUevp2bksfh+b6B3O6QZDaIbAyftbZxgFNYlZXp+0tRjPTSArkI
         /W9Y+sLfhnDSTGGwOlXopVIv6p3fSRhtWP8Gb1o2VL3loz2Fl+QpOPpLHnCudW7aKffX
         0OhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhksQGda3shKd9QO0+0cIsnkKQxJ3KzEJQDMMQuOc3Xur63yTYL/cq79wjmVIP0NL8QnIxRNIaj4w=@vger.kernel.org
X-Gm-Message-State: AFuF++kW+S6flGv0yh8YKZV1IIxKcCS4S43joxJh4y+S8p1anNB2sJFW
	MipJcDSslnWatDIE5rXBWJqDroBoBI+iw9dXr6XAt9+XG3bFVMV7r/NFovQnKgAR/mIsQDCByeS
	GYWaphcy4UAEfUMbCvecvVF4FNuzP2W6eAdThpIhIZjUxCmOSAw5eKGAZWdzmdOE=
X-Gm-Gg: AYBFou1bYXDAbD9fCqCjf9Tn2R94kvP18//Tn+ML376ppcBXbQjnrQbTH9iiALVlZ/b
	BNcLOncdRnMxzFWMmB834FWyeX1wqUFMV8uCMPg+rtW7BlYmj7PsVqMy5xN1oAcmA1svygl3wbp
	F55yOsQWB3edy+zU6q4tnbDoCEOEx//1Jza/0CJJnxhMUjeLWU6g6m8tMMUVMXM2w5IxpFzilh7
	hNK2Sfyspu+1wLI0ZFzDPQj6eFiMDq6541K/UZv8A28EuS7vzhbx/TCZ+N8N3i64CXBFOjF/zJn
	Knbi077IK8HNqv3wrElZUmJQoAXsMZWyVVZHDBXTXuD8FgUB/LL/bMdKDIiUBdD/FbRpKL5790d
	gTHfulfJNd7can4w=
X-Received: by 2002:a05:6214:62c8:b0:912:4527:7ba with SMTP id 6a1803df08f44-91252411994mr6212116d6.23.1789658833863;
        Thu, 17 Sep 2026 08:27:13 -0700 (PDT)
X-Received: by 2002:a05:6214:62c8:b0:912:4527:7ba with SMTP id 6a1803df08f44-91252411994mr6211096d6.23.1789658833203;
        Thu, 17 Sep 2026 08:27:13 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf26c8dsm16288601f8f.14.2026.09.17.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:27:12 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:27:09 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/5] arm64: dts: qcom: shikra: Add CCI definitions for
 Shikra
Message-ID: <ns6fwcvy53zd3yx237nrnbyzs2dvnp2imucgdxmj2wqi7pupsf@dkif3wniurye>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-2-9b9596221cfa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-shikra-camss-review-v8-2-9b9596221cfa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: AvXelKLaP7k-mc9mvekJSs0UHdDZt5qB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfXzegufyOoeDZp
 L9nlHGhx7QN8hbv800WMGFUu3c7/4VM1ms4oGpLy9VG5yBnXlUTQuQEfcpMxH+VVx99FJ2T0U6o
 0+pYNKLQB8bveb2uSLBUx4ZHhzeJ/ZlxrPyT+2OcDiAQ/Tce1oq+whS7bILQVc4CNCkwRY886US
 mXyQ7AJuarA0ths99UfaKHdQ6uQBfyHGKUW8wPQn3IOBk5BHJkDoSpSgfxlOSlWPzx5JOgmTBs0
 n0wHGRkFpj/+b5VtHqkz7II2XPOSEioU56Kmo87MCCWt8WvPVI2k+BjI6ysPgSIPLqf47yawr6r
 tG/WXHP1SpStXSArBDryVLAYes1xBsF9RKjA+pIhkqyFuenJk/pw38BNSIGgRhElak6oMgMZ9W1
 opWJ5GV7TDqNVnbwzPYyQxmuggNNsefDROV9jGeq5rhLLlViYqPmg7PUAGp8JSlIurlBgcxALhh
 JZisD2lTp4ze9V1AEQg==
X-Proofpoint-GUID: AvXelKLaP7k-mc9mvekJSs0UHdDZt5qB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfX9ZdeNSDTh44k
 1NPRhSrfPwuFLzYe7CFSf5MBAaEE2HrgCoUSYKLMA0Ws7ok/XnTmOQC/kWX3desWVSdAXxxMbGb
 YW0YM+Vi+6N2zZeK8H+mW2JbOfrOcF8=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aac06d3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kTwRDD6jQfcqJCPQX_EA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170218

On 26-09-17 17:11:01, Nihal Kumar Gupta wrote:
> Qualcomm Shikra SoC has one Camera Control Interface (CCI)
> containing two I2C hosts.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
