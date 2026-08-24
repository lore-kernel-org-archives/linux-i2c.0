Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F94119E1
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572349; cv=none; b=EIVdmlYgu+2Zu9aya5AwVf8g6+n2FN6/Lo+ppGmm3bK3lwCfhcLisjoCChXr2nPfsEElp5e2r4Iw6TyDhmPEJhdrd0I8PDl5CXcrveJ40zHNQY9qo2URuAJvsBbZlUxSC38Oxvu/UtF7ST4Ac1m/Dixo+OG/1A9lhKlWWTFki+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572349; c=relaxed/simple;
	bh=sMRgRGQgsr2UJjRCZNyqU+e1qO2Z+F/fILXvEUfz9kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWcrI2VrlU9YcNL/M7dag9t1NkGS8QkmL07+6Msvmq/NsTQRfIHeMbzITuj8+M+GX1uWL5wD+L1LqZvd5BTX+P9V/iwxsymSdZNCQjSwobpxx9xqvI7s9sj0iACR82UapmgR5459Lvy886fCw92ffoSW92YLiqxVFlUV9dUpHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/BgdSS8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BNbUKL2w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/BgdSS8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNbUKL2w"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMe413195012
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=; b=F/BgdSS8clS99KgE
	ln/Y7Q00FCX+nGtbe/+Yft7sGhFr7OTYFucFgL66UgGRIcAAfrAleITNFt3cUDHU
	PfjVrGutPfdPBFxvd+SO06Eh0yg6RokbEaFtEbEJQ6Gipe2t931xLgpwV5ezY4iK
	Wo11KVugOMXaNmP53Mqt6gY57ygEWZsdpOW3Hxw2t8Y5Q2GUboNUCgLOzkw9Dqbj
	iuzfQa1BYPIhXwxaG1ZcW6Oi25netVd3e0obdIafEGQHou25mW6aob4XuCOKDINq
	4bg/DjyYUJ66k2hR7QS5W9SHvWYfJjKA+vVn1Ravono2PYDMOWR42Fm573gF2xV5
	eJTXEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgs2eb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:52:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso2843096a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787572345; x=1788177145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=;
        b=BNbUKL2wlPzjcGnOCFz9P2svlg2KkNiRBpqlsADDu80YV2ZaVSIaxqZAcKw8t43SRF
         tmOa/+DArnt4gtyESmpB2BzmI3eQznXIyPEIJfHWE2MCZcMNZIunHU7qVlSFhX0TTOck
         36Fy4LVfNLdA6K7URG9dfo9AAXDXfJaMkVfSDpO1A0VtxWlLCPKMTH7fZoTtawmYBS9f
         pwN40hLlbqEyylZ8ib6YXRuYaMgc8uEK/kQTeNvmbjjtSnmpIfWBCSs7Sqd3gsWR/Pxw
         9ogD4MuiKItgyBjjvJHwP5P3qqHWolWbfDDv5Bna7mNFDmWYGQAETiwCYxG1eH7S2bXr
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572345; x=1788177145;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=;
        b=e4ZNBlxVyoyKeeSAG8oeucjiB7F8YXmOipMol7K+9mK4O9LiKfPR8yPpWfJCMV5DQM
         IkN46Kdx4W+hLMif0KoyNSbP0BO6dwQyhkUiohFk7J420g+YOvonkoTp1MXS3hQYUJeF
         eGUnl1xPPLPffeg0o4z0AxeVam8YplEPLS0Q+BnbCGMKSWjVCAV7M+XKe/HZ71VipuNK
         F8WnNW6Tr1T9bZ2kDy/lqnx4pcFLZ0KhcNXv+nxAYpf2cZ8YaQpAxCFHIvF1+VR2kuUg
         B3fm2zQfVr9iQxW5w8mFD8j3mfo/YKXxSskvhcthmMDryp7R0bGMLDnQWZ3FLcxmjoV7
         96yQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqour0+8QsoHBXiXkIAWHAa+JU/61EX/eJjeQVPqpPDTiG688IBW+eaflsnlUzya67cjSC5irtRB2o=@vger.kernel.org
X-Gm-Message-State: AFuF++lXNyvpHCPYS8ivuJsikMaU9nAXgGdUFdAvHi2KFN4y+kYLFAzw
	LZYTs7uR/QfyyFmElThQe6VnV0xpOFoEEjpEurtZrWc1CBaXxNgzdAyf+6qh9JlyeMN5LeB2p8k
	aeqdQwHqf4GMJA4KC1KNPRSggRbiabMwryQSi5OqVnOKimyBrDHvs2hPkxFjrDW8=
X-Gm-Gg: AR+sD10wyoCxSo3lc68Vy7huwVEw7asciPL0OaztQ8N/DGh0kf3eNtWEz+a864jYoYR
	CPXWe3bDNMt1DetTYqcivtsroj6I5f5eKzXmM7/KTYITUfxP8TVkweuk7l27DoRlxVN8UWaPV6M
	BRkbcHx7L8wuq2khu5rvcUP72aokBu8SdsQYzmiXmxEls8yqbqH+wfQdu91LRiXx6PSDoxHHLfB
	LQxNl3ZztPR+bV/H0BWez/+esPFKwVVN9cR0oSiMawX3AF0qPUhB/G15qjvX7cFRPOhisfME6dX
	S2pKYZlPeYZv0IrqfRp2wuvQxhiv2LIBkNVuQhNMw6Dftk5CDgCwpxdgaX4HH3ySlA0NMxkU38R
	Tt4iUimQZ269NXnjlQLL5/P5EuAUElAO79bI=
X-Received: by 2002:a05:6a21:888a:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3cd3e771df5mr36827808637.1.1787572345246;
        Mon, 24 Aug 2026 04:52:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:888a:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3cd3e771df5mr36827697637.1.1787572344804;
        Mon, 24 Aug 2026 04:52:24 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b1d6sm885985a12.15.2026.08.24.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:52:24 -0700 (PDT)
Message-ID: <3eb3b7ed-88d1-4185-accf-c81c14b1d408@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5OSBTYWx0ZWRfX938hQxVPMCDX
 rtt1zhSzLQUMPn/MWMwIJZhJLus/e+ZJtvI1zL3eiaiH8co8ZMA5esUFBAUw0jJ7zOGNPqq5iN+
 3WMlEfERGGruk3iWQZzp2K/mLZVxY/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5OSBTYWx0ZWRfX8XTxcKJfpUgm
 5ACwMTJgoNcSNUskd+nnhI2BmcbzAFnD+gChpYD7EG++lLSmOK+MSQrwHHKdaDofN++0PlrMEE8
 zzMA83T3esXMwi2WIN6S3h1vryufzDZceJMe2g1z+zNPZhdNkE1nXRi7GWv/44HNDW4bquwNs+m
 25zpCpfHDUvSQr0kSDwfbgRKHSyLY8TCoejT2JClMa0MU19dZt2osDWpgVcXyTa6nRBVgIi1Zk/
 +RrWzqhvNzu3jA2a/6giTNQFdMVxfHxXr12j84cTDP6E+JfMBJHfe5Q1xhFHWlklLxvlfpFh/ZX
 nIqmvqeiC13A+/p93dBu9WgCDS2q0FMOpOS/DOssxyREVfejJwYf2e6AB+87aWBFYwrUoGE1EuP
 7H7YSoS+/bpr+xOmjsrtdAT6F+nnF8js7FkZOMeV2kUJtEU0tKQypUDhwaLVCVsbeb2Ct4t6NKc
 NQnslviCWwP+nbkhWTg==
X-Proofpoint-ORIG-GUID: SqSLZszfsvMl058HtZltWBJxpON32nRF
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c307a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dtH3bwBEVQU6Jqvc-V0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: SqSLZszfsvMl058HtZltWBJxpON32nRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240099



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to look up the source clock
> index and divider needed to fill the GSI CONFIG0 TRE for a requested
> transfer frequency. To work around this, firmware instead exposes the
> SE HW supported source clock frequencies as OPPs on the perf domain
> device.
> 
> geni_se_domain_attach() now populates se->clk_perf_tbl from this OPP
> table at attach time, mirroring clk_perf_tbl on the Linux-clock-managed
> path. This lets get_spi_clk_cfg() call geni_se_clk_freq_match() to pick
> the closest supported source clock frequency and divider on SA8255P
> exactly as it already does when a Linux clock is present, and fill in
> the GSI CONFIG0 TRE accordingly.
> 
> Switch get_spi_clk_cfg() and spi_geni_runtime_resume() from calling
> dev_pm_opp_set_rate() directly to the new geni_se_set_rate() helper, so
> the matched frequency is applied to the correct device (the perf
> domain device on the firmware managed path, or se->dev otherwise)
> without the SPI driver needing to know which resources_init variant is
> in use.
> 

let me suggest little compressed commit message removing some duplication.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
so clock programming is handled centrally by the GENI core,
independent of the underlying clock-control mechanism.

> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c

[...]

> @@ -150,9 +148,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   
>   	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>   				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
> +	ret = geni_se_set_rate(&mas->se, sclk_freq);
>   	if (ret)
> -		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
little verbose - "Failed to set source clock rate %d">   	else
>   		mas->cur_sclk_hz = sclk_freq;
>   
> @@ -847,7 +845,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>   	}

[...]

