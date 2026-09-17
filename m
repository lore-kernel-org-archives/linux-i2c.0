Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224224848A3
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658916; cv=none; b=tuvahmSqsP8eYTu4NWh2TA5XVbgSdWWuFLhT8q2Kk2GgqEr405CVGvQZrDi6ru003vEPaVEpMHB2UiWqJlQXox7u0zNvCofTpT1GZuGriSiFHNz7tg6w5bz0lcckkAL0X43UaEAqBFNJBQoQAu0ID9hv9NvBw53YTAG2ykZK4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658916; c=relaxed/simple;
	bh=qwGaYA5J8cQoMsVQMVZn6rsA2VlKVu1tTczIgrpjkX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3325qD7ZRZTwhgZcLhT0g0NdC+QZ595DT8HJEbQHPWXiUscA7CT3ML1qDmk7FAehQxJbZsms5vDyq7aVG8wk1KNNS2+Hu907vqK9A0fP4JHPNYikIyZe/nUolxuWThRJiips1Qa/DXw74wu0dGJhuwrx2zEHtibnVqTUhO5O0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SoDptICm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASzlukID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SoDptICm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASzlukID"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDiXKC2265096
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/+Kdrxqgr+DvSDtGHpmdyPJ+
	B7JjcHm1WIvNra5tjA8=; b=SoDptICml04LDj+/Hm62uX9L2Hm9dE6SyQxVys8Q
	k7ktWMgoOV8o+O/EpE8Qp+cXlre8FEjO/SdNH3MwBzXNJGtMoIrI6g+s6U61AQ7T
	37sYmKtsXOOYyf+0vxHw4Zkx/DAXj2rgUksaIzaS8YDdQ1RYSuIz7WDHtg9tOZtp
	uQQBGFuVRb9ybhW9TsaznIgeGGrYljvpNc4FqhDc3R/2u5yOj0kHA8VoZEfelkFn
	aPm+6x/m22buDEGhOAbyBBsu7QHewNMActhvFlBDUN2LjS2ijS0PaB0uKAevdswT
	3p9MyAqJVqWMTrNpTIsXcFnVAALR1pKtR0bo7i2f76CM3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfpph144-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:28:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939062ecda9so162544385a.1
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789658901; x=1790263701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+Kdrxqgr+DvSDtGHpmdyPJ+B7JjcHm1WIvNra5tjA8=;
        b=ASzlukIDuxICcITl9iPYDV+3iYdUNDfD6gkUS5UNm09dMB0oKW4FQUuQXlVzfzoaAs
         8GSpjmCKTXVkNopmgvqh4ievCT03QT7L+ozm2IcaxZz7ms4FfUWG693BSA/GBSNlOevM
         CFzYLdpphC4X1fW8mAJsYpt3PCaNu3Dke0niWDDipfvFVRM8SaVgm8/1+YQpqZLXRg8E
         5P0F3b9GZnWn/GyP3x9tjdpCMxYuHikEw60C+O7nC6Gw4wtQWSvnKz/7AdYseAvfXExx
         Bb2TOg+32dpl/x7EhJS7d5C2dlDyv7FafrI6pjOIW40qNrB1/sIAj1YI4rLnhJXR5Kwz
         OoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658901; x=1790263701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+Kdrxqgr+DvSDtGHpmdyPJ+B7JjcHm1WIvNra5tjA8=;
        b=dzqUuHM+jZGlQm2FG1ggXtfLbHjYI7+WbSnwpmjuZsvvNcPxOo/K/ibCJKkFlNvv0i
         bsFsP0+pcC2GO1WLjM+cf8CUYQ3e6CNIvjpJDF7+BtABagkGhvvwOQaGzaYU5prWkJ/D
         jbftkjLdZ684jS8O/dhBDTW7S/aXJhB2CC3uy8mDMmAqN5XDzo+bWBuSgFKuuqysikqn
         wC6kdWK9IdDOd513o82PyyuhwhXe4b+EfTd3EBi13qXZucdRXurZqcJ+DwZB1P4GeGte
         sNcH7cFII7VSUPJ0Q5aehFymx99pHu3G5S5+HBoLFJq9E65B1UVbNkhNFsz8iXjiW1oa
         F4rA==
X-Forwarded-Encrypted: i=1; AKwUvBwkHcNd0CHKDiZS62u/ymX2JHh1hITLd9QZWzAQ9YgfoaZFJaeYGvQDfurs46nlAP0WY8zWRVwK0LE=@vger.kernel.org
X-Gm-Message-State: AFuF++mdElXidr+Nbkq3Yg9/FbLMOSgWd6KoMNdNiXP5lgmC/M0T/hi6
	YXO2MlQeS0IVriG74Ln1H/LEuCc7LFuuCD4uPuMZJ3V1mULqbbp/uB5Crl/rzVCpcL0yRxuI8BL
	QnFior3zgJH5n7bOjFzFIfHCEyCE1AMPIpsEplTM/l0JmvBK3I+DAavXl1o46E3M=
X-Gm-Gg: AYBFou0ckueAJWaI66PllTxotR7O56zN6s0lh2eXvUfYnusEiOmxvLCn7k1d+eFdUgE
	fQ86H7teUbCUtEUElsPw/d5LoINBTyyzCXW09TxOTWw8/K1DRa0uRt0FNvc8xj98uHMdP04U402
	TWpZs/Aw183WeR/JXs5/ge+VUp14UqTjnYsCRokPoEuDkyWS8Ae+ikjRm/XFjVjk2rdQiNYKiYX
	nXBQ6QHfqaT+HKZBGEUZrlaQzJ+aSli1m9sS8Zfpo7qZtDrUqx74LWeJ5UFpdLKzrIiHcx88xzZ
	pomd6FOyZBJC8EV780oVgvbSW0j3RUt+lP3s1pGXRb4y6EBrfPZruUE0RKeAaVcnOoutG5E5T4q
	jhvhzD0+olzns4VQ=
X-Received: by 2002:a05:620a:600b:b0:939:fc74:b6af with SMTP id af79cd13be357-93bb76bb19emr1300808985a.11.1789658900952;
        Thu, 17 Sep 2026 08:28:20 -0700 (PDT)
X-Received: by 2002:a05:620a:600b:b0:939:fc74:b6af with SMTP id af79cd13be357-93bb76bb19emr1300804985a.11.1789658900484;
        Thu, 17 Sep 2026 08:28:20 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847ecf52sm135817625e9.2.2026.09.17.08.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:28:19 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:28:16 +0300
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
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8 3/5] arm64: dts: qcom: shikra: Add mclks pin
 configuration for Shikra
Message-ID: <o4tjzh6mufahuvhllyxse7p6vvbmbnw4mlqg5zrmgyqa6ated7@m6rmnyse42g4>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-3-9b9596221cfa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-shikra-camss-review-v8-3-9b9596221cfa@oss.qualcomm.com>
X-Proofpoint-GUID: jpqUpkQMEevJojoEwHxFLuW-owRbCsrB
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aac0715 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kTwRDD6jQfcqJCPQX_EA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jpqUpkQMEevJojoEwHxFLuW-owRbCsrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfX7i/U8CbPIQbJ
 cAcLdxKiRNZMwsNWCXp03HqH6MdEBhXDBqx3ta3y1zgg2jTOIdrl1IHfM8yhSV/RDzNmKahIfvG
 PLCWjhX0YS8Ax3R53YJF6SS5Ld5RE4qI72qaNXJpxpSi7n1JmfLQonK39yWnOsLR9o7rRxemaRx
 ty7I7pEMdcqn4qHGODxwepAeyt/eojZyFV5yjxqNjZqeDqr/oMeRpLyOcPUelpSt62q9sNC6BUg
 GME2JG5EA5Q2VXjfHvydyeQ9e2J9sIlRCnlC8NdAa9wtorbJrW+RbzGCJSFDV2xkuSxHbMkncQg
 Dmxzl2P3FGxgbHFbqbbCW6ICWhN3qoVL+TEvQW6UKhstHU9nCAXx+NSfMIkLUMlkyk+bD60NRNc
 qeWdh0obOpqcTQtdMXqd/sxFwt5CD1sJO3UCmSDWWR8tmiOpYiwDMlrwh2m/fwPnjp0J/fnxxu8
 wKjgxo63GL/VDX3IsTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfXzsrkfyfKT+rz
 hV1uMytAyu9HpAgH0KP2O9Tcs+Z1F4GoxtOpfxTrUu66FqXpNvsWacTWUgd8fxpowkT5jAFhfQs
 bjVQoOf7t6V2qjO1tpZChD0NpqUkFh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170218

On 26-09-17 17:11:02, Nihal Kumar Gupta wrote:
> Add pinctrl configuration for the four available camera master clocks.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
