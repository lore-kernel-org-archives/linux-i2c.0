Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722165;
	b=HpH2HyTlpgvfCWe8rKFcHuJQ+t/dX7myUmXkGBlqSa0y69dFfHbCh66qsBgsUzatFW+U
	 FtQlkP7X0gFn/PfWyN3dXaXtXg5RIDYn3gOzMI1ngvPfj+/xjv0xVJeeLjK8AOf0VztQB
	 AA1HH20eq3D6xCMdK1IB9H0QbS4MrhO/cnHDQ+QGZkiUGdy0xBmYrj1YbSD1BL1XT3o+L
	 bw00ZnZ+rIoBYB23cOsjng0eQ37ps8zq4A2xkgMhnuPVDxivcnMdN49SnVNCo/EF4csui
	 dYFY4BVJ8hTXTd32z1WUzWQUzPRCOTRF5tS7mFj+7FqOOylzRiiqByElNQVLndZy/Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722165;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7qH6C/bojM+5YQ/ZabGS6/zYTmCOp3ZJSa5Tlo03HjA=;
	b=gjqSRpyiGOVCIrwXjXYwwJ7/6WzsLgCsCIbvW5G1jh60IUG3XphWISrF+R2OAwcXBO39
	 5DOvRTlhdMTho6YauiabR/jN6IwHwvqQhSYvzGpeYqHTpQM5NtOT44VMritc3Ff6NFv1O
	 YT5lHxid4UaK3sG3EzGCdvqKaGvQyZzHaQctSJacwI5DlXgjmvgLjZUqvEnY2sORVmcXC
	 2Dq0goIhPYy6oecY31oy53DNwywnDfGQgWngEacCHCilFuPJaaX218ZRCkWzZ5Go3/tTk
	 wYHLGJrJDcJVqCMGQa0o2xMQdW9GB0bHHzbjVVxcXpY6AmeoKjM3UkxBmxoqVwJRu1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="WEwZs/3/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y8Xwb7hD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E09606A321
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 19:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E09606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WEwZs/3/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y8Xwb7hD
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFtxmi4048197
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 19:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7qH6C/bojM+5YQ/ZabGS6/zYTmCOp3ZJSa5Tlo03HjA=; b=WEwZs/3/2F0ukAJp
	BAiBZeoL9v1RSJMNfzDV8iNpGZTtj2RZT078x2gka/1I+HmeurEbdboDErwzdx8S
	snbGm+nMRL/ZL9lJXU4JaRMy8FlhL11TDW7lSWzUz2kyCTxT+MGSbfJCafVeneLX
	EohW1QyUc2br44NRGBVfj/wPOrJUMXuU68D52kkMbTo44Ur7+yF07c2xsGKBQEnm
	ejgROT6fmPA9wiaxbOaIQQ5mY0ZlTnxY93ox6+TEwgBqRr1cID8DWBi7dhJmH2iC
	F01eqcFhAjiD2bajPX30KoBNV/XeAlqHSl+l22e1/d1sxPKyShbDIaWFFGk9GkvE
	2xphpw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rjq57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 19:42:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38531c1a566so2520645eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795722164; x=1796326964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qH6C/bojM+5YQ/ZabGS6/zYTmCOp3ZJSa5Tlo03HjA=;
        b=Y8Xwb7hD/d4w3Mhqlb6r8INoEM8R3fyxolBSATOsZKnmsyY5YEug5Yb9g52eT4V0WJ
         D9Z989Nmn0kIGNdg091Is1N7AKMDhChbpKJnBVN++E2nqs7BYkWD1yjkLVaDAI1ji5lb
         GWxolKvZW8qP/5LAUk5QuOR26QUIpCla9pX4uP/GTFvo99igoyQ5ysSTKx4S049ARKBx
         lNmavnpaZoWrnOwetxcS/nu35oqbibNBnGiUsfY74jZKAra2Uu4vMJsSH8adjntPRbz5
         j+KacS7p0OEa8JYtez1rmUly/X5ewJgch7qVy/FXu+soP/RLX3DRfJDfKcRPECKKbVaF
         Gs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722164; x=1796326964;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qH6C/bojM+5YQ/ZabGS6/zYTmCOp3ZJSa5Tlo03HjA=;
        b=KsTugnyS0/WqoiF/EB7YDdOd/4UTQE3IWvQ5r8e9RyEmQogAtClp7/N1i4CqJrnYkC
         YE6EsHunqB8GBHRFwleUvrzXcg+ftRPDY5rlWF8gIAwtQq+dx1oHwimrTyG+84K1Z+fc
         L/WMi+gsLfI7KwFT8zdXnSpdqHli+JDdTKhUdMPYCTEoXPrl6sBCtXc/Ygd0A2LrXpze
         BEMCFFBeokVZF0txfJ7q90mHa+E8UHUTCZeQonQQSEG7cQ2W4Nd9uMUj1e5tOUmruREZ
         u4/FKYTn2SxE8QOoR0AjuRvi6VV7BHs20TzB65cf2KXwECoWNEalzt04+BBz/ck5JdLf
         AXgw==
X-Gm-Message-State: APuU4Z9yzp5PK/KwMycNw0+ESxyo88GIMMD5WVssEQZUK3/tpwO3vjmr
	4JVhIhJ5SCfIWzY0eqUquOhp0k+OS28bqaAmPE2O6B+Ad9isdrknLicGZRHzFbajG7pKe8IHo5r
	LJyrFD89mRNF1YKQQlYKdBKS8KQ2CULFlmgXls90LQqJZeql2ml4wprPP2s8hApE=
X-Gm-Gg: AZFdTZfj7wuciaL2CyohI5ivueTfB7gWTaJJxrE3Lk0d8dToKc/XWqKqfSsUMD9e/1D
	AMxBLqnrQ4SNdfvqpIE0Hcgh84+1CGbPc8jpv7nARC2r+UurCop0ViWNMB+N5jOZlCTbSgnvdkv
	TSDoBHGRleabVSvH6LoBSlZ24VqGLHAyRK1Pdq73Epz1SM+7SBUTrAQewxP7K/+SIQOOOKnG9RW
	1mm3hH49pKW4qKCVJhPIyvoEQjVki0j9aFujHfZbcGW3/kR6ue2AyFkB6E/cGIGMqamcpu+bZ73
	off+py1FnORuZCjGbJvjsnBYtXgbVrGBX+6Sri0t/aFoiFkZtNpGGgbAikD+jlaQmzyRP3hwRS8
	BC53mOdL6R4FvBtVVwaEaquxYX2ehN+67+Wo3lfye55imttrrGaN6PQpHddgm1TEAEfU6OK1k5I
	hbab2+
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id 5a478bee46e88-386b02522d2mr13900450eec.16.1795722163526;
        Thu, 26 Nov 2026 11:42:43 -0800 (PST)
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id 5a478bee46e88-386b02522d2mr13900435eec.16.1795722163015;
        Thu, 26 Nov 2026 11:42:43 -0800 (PST)
Received: from [192.168.1.5] ([106.222.228.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm79449604eec.10.2026.11.26.11.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 11:42:42 -0800 (PST)
Message-ID: <eeb651bf-a627-4442-b9de-da73f70c0e97@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 01:12:38 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Allow minor deviation in clock rate for
 clock map selection
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261126-i2c-rate-v1-1-6b8c5731077d@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261126-i2c-rate-v1-1-6b8c5731077d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX+Wzk0H9raeIA
 r7b9BpCGmMBOvLIBoUkkDLv4aib4Uy2urhLq7uC5khL16O+JsBnj4Oy/dH67ZOgebOHYWjWPCsc
 HT8a96BMb+F1GX8hWA0nBzrq/UQ+DaqOOKuAmUUFUSi6D6Tmuy1S+TKHxJJnwzFUSRsfVgNGcVI
 oRZjIMWR018u24zlnpZG/nUISqY1YF6jJ0S/ULm2XLMd43jiduKgc+nt687xLWdN8cgncR7srYq
 452hPN3rGSbAoqCgSsTHmrhQwr7neQnhn/tp0Z8Iy0RXlfmP3N0co24wfQN11lm7nU210Om/z4/
 cpVr7URyO/AWZpJnaQxQD9yURr8oApgqohjt7AotSqOQcdITAedVDq4RlmpukKs4bWSrJzGlMqh
 IWXTEZpj+/01HEUI3mNYNN+jC2NZjF/BpKOC6g9OkV+OAWPRrcyg3D6/XjsXnvp07vo1Hat2kAK
 a4nTZbSVyJY3aWkeOKA==
X-Proofpoint-GUID: QJUa8_u0RPjXTP3tIKQE9uTwjecTWyWe
X-Proofpoint-ORIG-GUID: QJUa8_u0RPjXTP3tIKQE9uTwjecTWyWe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX2Sz7PpujFhFu
 QdfZ3Wn0QczzN4hdjJYsMhTwZXWz3U2zt6qfvZ5c71gPV0fwjOlJnS3zZOZWWX9JbeCDi2DKUrx
 5cH6k43N+gBo6OZeY1fmrEG3gR9k54c=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b088bb4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=5paVSw64R4kEUMRm3sSMUA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_1O-lDtd4d_n81_3sOMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260077


On 11/26/2026 2:09 PM, Varadarajan Narayanan wrote:
> gi2c->se.clk rate is set to a value of 32MHz +/- delta by calc_rate().
> This results in the clock rate comparison against GENI_SE_CLK_32MHZ to
> fail, and the requested frequency is assumed as 19.2MHz.
> 
> To avoid this allow for a +/- delta in the rate comparison.

By How much ?

> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index ef48ab3e8b94..88b5b9aa4667 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -207,14 +207,19 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   {
>   	const struct geni_i2c_clk_fld *itr;
>   	unsigned long req_freq, res_freq;
> +	unsigned long rate;
>   	int ret;
>   
>   	/*
>   	 * Use 32 MHz only if already selected, otherwise use 19.2 MHz.
>   	 * Preferring 32 MHz merely because DFS supports it breaks I2C
>   	 * transfers on X1E80100 CRD.
> +	 * The clock's rate may not exactly match 32 MHz. It is slightly off
> +	 * due to the calculation in mult_frac() in clk-rcg2.c:calc_rate().
>   	 */
> -	if (clk_get_rate(gi2c->se.clk) == GENI_SE_CLK_32MHZ) {
> +	rate = clk_get_rate(gi2c->se.clk);
> +
> +	if (abs_diff(rate, GENI_SE_CLK_32MHZ) <= HZ_PER_KHZ) {
It's like  +/- 1KHZ ? Can it deviate > 1Khz too ?
>   		req_freq = GENI_SE_CLK_32MHZ;
>   		itr = geni_i2c_clk_map_32mhz;
>   	} else {
> @@ -222,6 +227,8 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   		itr = geni_i2c_clk_map_19p2mhz;
>   	}
>   
> +	dev_dbg(gi2c->se.dev, "rate: %lu req_freq: %lu\n", rate, req_freq);
> +
>   	ret = geni_se_clk_freq_match(&gi2c->se, req_freq, &gi2c->clk_idx,
>   				     &res_freq, true);
>   	if (ret)
> 
> ---
> base-commit: 47588e4c16d8876d3058bcec030ed8a016794b9e
> change-id: 20261126-i2c-rate-da11bbe02b6f
> 
> Best regards,

