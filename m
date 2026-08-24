Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598F369D74
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563498; cv=none; b=tiwpluUtr4roygCvV0tk83w6XNn0PjCXSDVTLhoLmmjuh1a9psHhBKD98IFw8OpGlozZ8xcZNMhFkSHUMk2/PYJVqvVk4Zg8JfCFdH7KK5OLSG+JrTXnmOnA9feomIaIFhGfv32YFkd2dtEI4CBspo/1n0XKyRd5WQQ41m/cMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563498; c=relaxed/simple;
	bh=Y4EgcjluYnSRJLSjmvyLzbSd0FfjBnqIP95LJDK8Xd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfMFGuaAlzKTDjWQ31K2wmKqNgWgz6glK3DENi/43D8OvEBMjy2ooyRU2C6eeaCWuut36PFh4/nQLA41GpzTs1Bt07UoFOi3EEve4Y/O1t6xeF1kXIxkd6UoovFiRBZbrWJsqMKnp3og9zqx2k0NyXrk2wGnMbgt7amTiEKtLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mm5hBv2H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hjrrvFhT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mm5hBv2H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hjrrvFhT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9A0LV1509344
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRh437KQ7ulwK7lu5Bc/hF/l6rZw1vWutipg0275TjE=; b=Mm5hBv2Hu29EiFSQ
	aD+o9lx0dpXmXug1FTo+YGJpikM6UujbnAVDQ46BWskqfSeNudMUrDrDSwk0DKJV
	gLg9W/BXSZSjnvNbkbscetWBaGHGCviydf+VbSiHUbtJEY6VtK4I0PIRR4peRvQn
	Kfzv9WLU9ZMsQeo/6rnXvS8eh0EHDebWFZfGdLiZQhbzK2zH4pmRmvoaZUi+kNTv
	M4MSzObS3U0GhpnS5RtC8iJSKYHkWLEihOUHiYL6msER1EGQ4TS3oZo6s7Az2v0f
	GM7+8O0pCPLYw28KSEMVZAu7JhaBIO6sJhSULTkXxZkGt8osjBL9XXvAUXwMEYrV
	5oG7tQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhe9p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:24:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51e9d892f0dso7638871cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787563495; x=1788168295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRh437KQ7ulwK7lu5Bc/hF/l6rZw1vWutipg0275TjE=;
        b=hjrrvFhTBGKN9jQYCMZh5lAal/2qtZ8C7t99HYRIKeoxRjr+YdruAg7XlEv9NTH+JW
         nz/O2qj0NxIU/5hvG1Ba344fTnTZ+IyxWdSLGAY999zxgk4IvNiIYANaCUZwEUU8lmHy
         /n/4PTt4UfLbMakkmMlx+YjitABR2nJStxoAje/aStaNdjGg4FWP3a4oL5vnVxArymxm
         f5cAGLgPozw56yOyaqndDfa4lCfNl71WAASsuCvAXYzvoBycS+ZCsf9THXjC4+nDKgNo
         uIteSn4R1wwkKWk+0HDKO6pLPBPlc4pzagzDTlMs4h6O0v5gb/4MM07bTiIaH7NkgYmL
         4TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563495; x=1788168295;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRh437KQ7ulwK7lu5Bc/hF/l6rZw1vWutipg0275TjE=;
        b=X0hg9f0ZyMIAAe93/Hpk3bQH+E2A+sfVrZv9NYdfDSp3IghmR7GWxGtIK0HIIDmJbU
         o2OsdJG9cXV+yjFjtte8zLN40t4NoqRaS/kvUQssmsIHloxTJWKaWLK8XY3iiCjdHgLd
         7QPdGrJWTIcpD9GV5bvyyJP6ttOX261NsEiFgoOo673HyzfRgNGgVyCANiwk1KLq49VJ
         0aBOWqHWP1CFwF6252IZvGA2UOQW6QmoSbvUGxtL6FJXugtz4BVaWHW0xmr/anVXOVNU
         RVZEsrHqe2GoSwh6WMiZ0NoxotmhrWBXmqi1m5spV2u9eN4XXWGOB3fFJCpxIMh5dvtV
         f2+g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2N2UJ7W5RbDBBaEn/dEQWyt1Nx7Mc3GdXvBN7RoaGnApy99tcAPsflEN4lQ3nWC0EHhSiZ7VWqYg=@vger.kernel.org
X-Gm-Message-State: AFuF++k+zEwkOXoGFDg+py6SWoahgRUK3oX6k2YkxlwnGRrj8UiRrgzk
	Bgn8AJ7FyjfO6jzgh5Lh9Pojl17LfI4oSckDnFBhnXWr9rECyyD1GkZFKzPLoTAzW/LYv9CgBJP
	vrqhT+Hw0q1HEttqwZdRguuz3AGzfsVedqL2AJZiPqQNwbsFSQatANx74kve4QAY=
X-Gm-Gg: AR+sD11fqPPILtwiv0+xknwZdNX9yfkbbB+mIqY3nGVGUcvlORvW7HGc0x0I5jbI18r
	T02Z9ms3IfCrc6GA2XUTlSbFjSJURjSWuentyotY2sDm0PTq2jC5hAndX/fXpQSkFPBuyl+z2mX
	bm3Vc8ZKFqbExm+qZq+CDyxypvuwzyAl2J/wYEkna5SCO0WMFcFy+ynr790rWLfRdDGFjOqavXX
	wwzoGBVQy21y4uRRAETLcFacTF1SrlSsK2cHA7Qoq5j6A9msq2y8zanB1Pt+xadmjTDSSlAOncs
	PYRAZ5wW67LFm6emcE0+1/T20xLM4/yju5Hp9GbT0i5C/6OmmHF1v24XM1hayy07LKjplNWKeSx
	Oao5qqdUralodUBvo4PvImX0H
X-Received: by 2002:ac8:5a95:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52df565735dmr167550771cf.2.1787563495007;
        Mon, 24 Aug 2026 02:24:55 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-52df565735dmr167550501cf.2.1787563494479;
        Mon, 24 Aug 2026 02:24:54 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm1236377566b.43.2026.08.24.02.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:24:53 -0700 (PDT)
Message-ID: <30a04183-b8d5-4a6d-8092-6b888a240410@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: qcom-geni: add I2C frequency table for 32 MHz
 firmware-based SEs
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vJD1s5SX3Vg8e6lE50i_Ue313nXw3MU8
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8c0de7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=NH3m5DBF-mqJd7-nbgUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfXyZnjPp1aRrfE
 USYUg1KXAWemZh9rmHV+nvj7S+r72qcrUzqtI0d1lPDeZojLE+q6oKQgXcRiSWbL/BdU3AjWxJM
 FlvvaJfTx6Q4l5ntJeyk66wlzMJlbnxpqdq8zoKEvpWPcOAEdz875tg6RKY+VtL00xngitTRNjy
 BNpF6LUeor4u8adYkAVBb1M3XlxFjGYBiywN9NQ479Hc2sGdvgr1UuQbMO+7Wk1xTVpFbMVjpcr
 UEDCF/1e9mxIvOv71F9qUz9r8TKNEV1ci4lePLaFWe89JvPHCKNmldOJK0VKVa0Z/dPmqkVKhpu
 5Xv3tdZaEjY+qa+RFWiFfHYZ4oz5PWDcY5qcX/j4lxyrtkp5H7NLORqO62dIO4npjCdI5tqyvG+
 Y+ds2qbjqAiPzmplRBCxBrBAcFCCmGzwexBB/Rm/fexHxZoxIYtjrY9/8GEF42sIlWydKhtzhj1
 YDJYBvVG1MjZVuQuouQ==
X-Proofpoint-GUID: vJD1s5SX3Vg8e6lE50i_Ue313nXw3MU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX3gjfbpEpf1Bq
 tTi8fsgJ9XKVeTp8IDJ4/Efiei8dGfmDxNW8mlllR+KoqquB4J4dmKqDHxBYgZaHvF4iQQKH5sz
 WoE34EmeUPQnKaJ75eIBOiBQ7Km6V5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240082

On 8/12/26 10:30 AM, Kathiravan Thirumoorthy wrote:
> On IPQ5424, the I2C controller can operate on both RTL-hardened SEs
> and firmware-based SEs. As documented in commit 506bb2ab0075
> ("i2c: qcom-geni: Support systems with 32MHz serial engine clock"),
> in IPQ5424 SEs use a 32 MHz source clock.
> 
> The existing frequency table does not provide the required SCL timing
> parameters for firmware-based SEs. Add a dedicated frequency table
> using the SCL counter values recommended by the hardware design team
> and select it for firmware-based SEs to achieve the target bus
> frequencies.
> 
> Move geni_i2c_clk_map_idx() from geni_i2c_resources_init() to
> geni_i2c_init() to ensure SE_HW_PARAM_2 is accessed only after the
> required clocks have been enabled.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++-------
>  include/linux/soc/qcom/geni-se.h   |  1 +
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 00013b41a6f5..15835f10b062 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -187,19 +187,28 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>  };
>  
>  /* source_clock = 32 MHz */
> -static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz_minicore[] = {
>  	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
>  	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>  	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>  	{}
>  };
>  
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz_fwcore[] = {
> +	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 25 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 18 },
> +	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 6, 15, 29 },
> +	{}
> +};

The fwcore one seems to be slightly "stricter" - wouldn't it work
for both of them?

Konrad
