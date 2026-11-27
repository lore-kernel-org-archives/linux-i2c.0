Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755597;
	b=HeGFgKTfT/JLi1JHpPll7F07ge1U20rtDeEf/dTioQ6iQ4TNPPW1F8lcFBjaCAbu/x6t
	 5i6N14XRKc/nVnNB1cVCrWMwoccqqRiGSeTcG0V4XvYGw04Amp4LK+iMywUSD5Msp+xic
	 sQho8lLx57+S6qAhPxUu/lcpNFzgk1DEcfKBlQrLiuSa/Cz+nxsVHyfp7sTpAPeBORcUU
	 sGIZpT1Bw6khsWshNtZM4ufg8cnkz+BTIkRfrJVPJolmMMZCxhItx93lsxuYES15wCd84
	 vYj2SvKopDJ0Pxyr1tG/4PcHdnRfg+Dd3AKSTTwFWkbaG46dhfEJSXBDxGhnLTftV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8nTARFLuF8rWdXWqUL0nOdf631KIqF6Aph8p2q65SnQ=;
	b=Iio+9QIqiGx3XaOIggJpE+Sn/vg49VgeyomAUY/46Y3H+PyZxoiZNttd/MYHfApE0NV5
	 U9hceDW+AwqBDf9CieoGjpyRVAI1YV1/wFis8/9Le0+MEVSWBBm7h8Dlw4w6YYzF5OyON
	 IY+K1kbUBKHgmBha5ds8UCcQksC2kI9dmwecJvADZHM8j7zEApMlA1NmGQktOLwMQn+yb
	 x+458jT9SRY/FsNlYJhICYa8fkRyy6N5a3Klefdsm5EKfnr0lGkPJjG2McwOnq1h97knQ
	 I2phW6W4pc9Syu8Ql0uChlS0s7wjYGy/5RioDYzM6U0xyM5uVkICgPdNhtufDoVbveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DsGhTixg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bAPvYzNp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB25606A326
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 04:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DsGhTixg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bAPvYzNp
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQJw3Qw360960
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 04:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8nTARFLuF8rWdXWqUL0nOdf6
	31KIqF6Aph8p2q65SnQ=; b=DsGhTixgqrEWYjXjL+rE/8VtI9KguUuR9Lp8ntv8
	QjsfHIWfQIgl7TlTwGcJwUoX71pSnrlQwlwqZohaMEFcT1zXipTCrKVeZ6Uup2N0
	IEJXztbEr4FG2Niao8AVLIohrvPLY94FZ7Yt4Ke/fIf21Dg6+QWGQYtonyLmLK9k
	H6ZuXXVV+V2FRB2x1lE52Y3euFJpB4VP25Cg42c67DFla1mu9/bwnMcOlekNm4zu
	y2F1UYdqDpwLjd+aO3mjecFFbxTwgoWH8mmpagbCfBSyoWtkLxvavbvcmwrFrHeR
	HwoaqB7y8NthaNcVnnBRa2xjqj2AioUCTqB7pHff6icE6w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rkyub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 04:59:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386b8624cf7so6138996eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 20:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795755595; x=1796360395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8nTARFLuF8rWdXWqUL0nOdf631KIqF6Aph8p2q65SnQ=;
        b=bAPvYzNppK38dDYGxIP6bmMJuj+MZDHXSi4C2wxX+IoTGMWDi4zXHI59dgjZOomlRV
         FKpGDcaJmKyN2HtxqbrlfpV5+nPvg1vti4Tma5MvoW+o67+8jwH19WKZVhDgWxHEeqwE
         fsi1H16njs5D1NUgICofmgg9OmtTJt0q384OSqOeMsHsGcVAAW1XBqqs2Ar8U+ss9v4u
         CH43heW5jNKCwzoMVkkmS2vUsyT2QwNhHvEhH1N1ca+IsJ+lQ+rGvJm0U3MplJoKavA9
         NQKzghwXq4mztF3E5ViXO2Bv+AcwmfogBFIcJ1aAMeuGCCP0mQKceOYCxcKkjPcUcfyP
         0pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755595; x=1796360395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nTARFLuF8rWdXWqUL0nOdf631KIqF6Aph8p2q65SnQ=;
        b=hH3CXWNimhYmdj7moNdtdJLJZbJ7BK7Zk3IL/sdyZKTJZUZLuZKYrE4z3YUEW/7j+y
         7Ia6OhXTFODTZw64pc/qIJM5raXcfuuxrgzMXchlfYs+BxvIx+864pin65Sq4yGEEskv
         zA6eZz0XKUb4vqpizbwr1ZjoH8k3AcOgQLfn/pCMR1IpJFLOdriZ17zkFBEDTNqzluz9
         iCAJhKlxEwDf7qvkJr4oMh1w2sj9cJGh+j3nED/bxVLBEQoE8d4n3yw8Rl5CGfw4AVlZ
         IEBNjPPOzFBj1FZkR5On25rOE4N6s9+SkAmIXcMkWWkZK6voiBzPq31KBsgAg9bt1Ris
         Mttg==
X-Forwarded-Encrypted: i=1; AL+hErGm3Pk3nSf3m02CKaFDYdFef/0hXzef6Cbw290uZF4s2I7PTldg5ZnoaBXrN+H/FWktMPJ8OmGqlBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z90PMayzQGEmZopTCbl2yxNmEkDw0vOKjZjFj/ZU/4T7s5KGP1B
	dEh7vlDKK24TtdLgKN8hQQTt8rig6FRRKZyZp3uA7ysuwqzDtEe3fT/FbSyCIsZlJ33zHj8V3nZ
	k7+tUf3hitccWdnLAjSPfLf4vu8sAVb4mcMZ3YptjNCZe6VPDrBfdLx7gH6aD7jI=
X-Gm-Gg: AZFdTZctPCdNrdy6ZVIb1fnbWxaBCDYJUu44+He278sUOwTMP0r3RmqEHnrNX9UrnFN
	zNzbcC/vgoyMnI77wyiYixGIE16Zj0ayEOVSqvjIKHy8aFne4DL3a9/VcOU4ncLILk22KMtZyey
	wFPUAckBA2NdM9flYCKRbS4Pzb8wViThOT/hQTHPqLEOwi8HsR5sTnxtOPA3Wi2RVAesWKiE1mC
	eO+qbNxFc6uHy4ddoAhsBAp/mexcs/1jWA8G+e4c9Gcf7KaF62WGapB4D/+TYnSRSR2IaU4Tetf
	Ib4tQjCwQy9VdESFvuFh4Kx6zYIO1jsvD2KcBv20YSODCPyJ9HFeqShY4Z+UmvaKvGqhOlTTVP/
	33jWJAAwO3HpUrQ3MmEV3caGoA/ccDg/5fjzbsaEY7KfomJVDDiyjqbNH3/KugdYiIcsNOMDYEX
	plRcwRq/NbZNXnidtIwOuvEtoK5VWu4BHHUPfoyW/clSo46xLZXZIcE2cYrTvwhkux3Zh4HKYG0
	8uJmQ==
X-Received: by 2002:a05:7300:ce11:b0:384:fe97:8ccc with SMTP id 5a478bee46e88-3856fb58443mr25791400eec.29.1795755595316;
        Thu, 26 Nov 2026 20:59:55 -0800 (PST)
X-Received: by 2002:a05:7300:ce11:b0:384:fe97:8ccc with SMTP id 5a478bee46e88-3856fb58443mr25791376eec.29.1795755594682;
        Thu, 26 Nov 2026 20:59:54 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm120946895eec.3.2026.11.26.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:59:54 -0800 (PST)
Date: Fri, 27 Nov 2026 10:29:48 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: Allow minor deviation in clock rate for
 clock map selection
Message-ID: <awkORIPhj/xiG2NA@hu-varada-blr.qualcomm.com>
References: <20261126-i2c-rate-v1-1-6b8c5731077d@oss.qualcomm.com>
 <eeb651bf-a627-4442-b9de-da73f70c0e97@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb651bf-a627-4442-b9de-da73f70c0e97@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfX8Rz1FNHY9H5y
 lJKqZw3oupyUxQDLF4ewWlj7aXeJu1acpk5UEOiaHuUSbpRkCOmwbW3WioOVH0KL2ujxFtanQXi
 HIYL5bbBIdJZ4rWC2BeggPEpfnlj0+BK9pFaHq5tCnjutQoMNGtbvTVJdwSPmasdyCt4OEfUuZP
 2Y+020iL1/iqUKg9jzpUNc05nSCDmuxD6/I182+ygiKJBPhhUSZxJVgR1eFF7FaZ1iATL/Q+CbD
 HfaxkfQY1acimacNLsqanD9buoS5XGsz088Srj1KE2JyoXIGnXoGX7Yt9V5SP48zTPMxIkx9JyA
 HKua7lLT8Di3EF725Vu0KhUtrh1K1D8sxM0DkVp/3AhMweIk2lxhKXczenkxHGmfTt2hUsJKKCb
 MxXridd3p4mM9HmUREU3zbMg58uw/wxqZT35SVWjM8PahBfAA2NqYrYVScUWnBz+QSYxgeBsQmk
 EzikbUjgSbXiMRy/Brw==
X-Proofpoint-GUID: f64selZqgWEFRX0HqG2SdhMf630kQ7Ma
X-Proofpoint-ORIG-GUID: f64selZqgWEFRX0HqG2SdhMf630kQ7Ma
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAxOSBTYWx0ZWRfX1ADEP50g3yiq
 ZC95NNLXfIiEYBR6gK6X0BujjQhDwwAB7/kyEax4v4xRnyYwleRZuynPMu/l03kCQ5gAWVQ6h9j
 04OFVDgVaWOzh8qeY48KwegpXG1CgTA=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b090e4b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=5qUGMcpEgxZBPV2CaegA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270019

On Fri, Nov 27, 2026 at 01:12:38AM +0530, Mukesh Savaliya wrote:
>
> On 11/26/2026 2:09 PM, Varadarajan Narayanan wrote:
> > gi2c->se.clk rate is set to a value of 32MHz +/- delta by calc_rate().
> > This results in the clock rate comparison against GENI_SE_CLK_32MHZ to
> > fail, and the requested frequency is assumed as 19.2MHz.
> >
> > To avoid this allow for a +/- delta in the rate comparison.
>
> By How much ?

In my case it was '1' (i.e. 31999999 Hz).

>
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >   drivers/i2c/busses/i2c-qcom-geni.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index ef48ab3e8b94..88b5b9aa4667 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -207,14 +207,19 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
> >   {
> >   	const struct geni_i2c_clk_fld *itr;
> >   	unsigned long req_freq, res_freq;
> > +	unsigned long rate;
> >   	int ret;
> >   	/*
> >   	 * Use 32 MHz only if already selected, otherwise use 19.2 MHz.
> >   	 * Preferring 32 MHz merely because DFS supports it breaks I2C
> >   	 * transfers on X1E80100 CRD.
> > +	 * The clock's rate may not exactly match 32 MHz. It is slightly off
> > +	 * due to the calculation in mult_frac() in clk-rcg2.c:calc_rate().
> >   	 */
> > -	if (clk_get_rate(gi2c->se.clk) == GENI_SE_CLK_32MHZ) {
> > +	rate = clk_get_rate(gi2c->se.clk);
> > +
> > +	if (abs_diff(rate, GENI_SE_CLK_32MHZ) <= HZ_PER_KHZ) {
> It's like  +/- 1KHZ ? Can it deviate > 1Khz too ?

Not sure. But per LLM, it says for the applicable qcom related clocks
it will not be more than +/- 1. However, the mult_frac() API can return
bigger delta with numbers close to ULLONG_MAX.

Thanks
Varada

> >   		req_freq = GENI_SE_CLK_32MHZ;
> >   		itr = geni_i2c_clk_map_32mhz;
> >   	} else {
> > @@ -222,6 +227,8 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
> >   		itr = geni_i2c_clk_map_19p2mhz;
> >   	}
> > +	dev_dbg(gi2c->se.dev, "rate: %lu req_freq: %lu\n", rate, req_freq);
> > +
> >   	ret = geni_se_clk_freq_match(&gi2c->se, req_freq, &gi2c->clk_idx,
> >   				     &res_freq, true);
> >   	if (ret)
> >
> > ---
> > base-commit: 47588e4c16d8876d3058bcec030ed8a016794b9e
> > change-id: 20261126-i2c-rate-da11bbe02b6f
> >
> > Best regards,
>
