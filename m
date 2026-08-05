Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394C382F28
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922696; cv=none; b=Eagsa222uiyMRnhkfydMSLyYkVDo+gJQ1dSBjMeB2ohMQJ9AmBt8H1tAkYtbTVW2NkVvLegaGOhpBZz8BU4hL90aKqQe/Z9Dp017IHAwubTX0llxu/utrhQplnNuyHIAbWqfUvIn6GZBloU/1Wqhn6KVK8d+S4iRodjZqvZ7s0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922696; c=relaxed/simple;
	bh=KMR6SWM19erGsffKdL2Iv9/3DBMFJ3A5y8JxmficuJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5Rt05erp86Preygs0R9bwtc/h3Xr2wyxp44oyz9MwHRdk92oCW2KzFZQYzb3Iu7w43IyPAx8dFH02f0KwC9yl3SbcNvnK/+i8yLB5kmDg8h4jvWNQanA2unkGaRFCBug/PNh+tZbZpJP3NA5mibv8LKQdu3+mK8T5wmIR41f/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EoMsr0r1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVxgxLPd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EoMsr0r1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVxgxLPd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dOCK2663302
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 09:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMILTWQ3u1gjsljNym/1x+Kl/G5TJKj09mRXvfx+800=; b=EoMsr0r1f4NBTCMO
	aOpTeOK+9Wrnx5rVf/Y6USVH82y0msZ/zm4VKHmfgEohVzw/AJp17Vop8Tp1j4uB
	vFdDFMryU+4tYEDr8xx6em+pxofb0Pnp7DVRSm55mhO/ONfOLwh+GnNtbkQXaV05
	vips8j8WEqpmGhg6AjUjUHQ5+UkdjHlbTYrcJEZtWmwOa4UXCjiHIwkofSEvGRek
	XSKiXWv4oKp3Ru83s0hM3zO82NJXG6lbbDJmO9X56sc3Ojr3sQyvhs0zK6hsmS89
	UMGJv4da/eghcSkm1Zu1rR3jStResHIJWgCq+fWOjoOO7f9R0CAo+9Vag2b9CVwf
	W4GGHw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14w8h10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 09:38:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso883548a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785922677; x=1786527477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMILTWQ3u1gjsljNym/1x+Kl/G5TJKj09mRXvfx+800=;
        b=XVxgxLPd1NwVjuW8paPp5MpdTVU4K/sysI8hNPzYnTI8927qJIo/mnNjaQVnn3fZZu
         PsmYbGYMxHqvqXXvCyfqQ74RwbVC9hL2DY/yqMMIajkQ0+Iiej18+M7xJI9ZsZoFvYwK
         f5bugkaei4hZsC72N0Dnrii5z/QdLRBwymjmkfUaYjTomEfwRl3TZU1qFwEMekO0vSi0
         WbsaBx9KhF3FLQ4W8Vg5A+oRN+uFBSoiFTkr8A9jKV0/je8SlxY6d2N39ZUlqAVTmmeJ
         RLkcZjAHgmunQ2M6CXgtWXZ9rqJXmIs21n7WzEOgQF3a2ne3AJRbVFwVDeEZDmdAC89D
         ygAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922677; x=1786527477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMILTWQ3u1gjsljNym/1x+Kl/G5TJKj09mRXvfx+800=;
        b=T3z6vZQqRiqIXUljZLyQ7KtQ2qepWA/UEJMz0hx3GOlFfAu3AMYn3DA7N2R2lf/Y6g
         U3QfPEX+OcOfX6odi5XFqDKvksufPOIOFGugvQ8ZCrABrxVgIYIpLksDsm2jmhr9SxVR
         bEmfXkoUkBB1YGmMz/LmmCtdu+ZwDiZoBy+vwFINBzEEpycneBlRnWQzVn6eaOVwHkWY
         XGxK3i1FPkP3pydppnhzFd67tlVEyL/uwGRGbcNDkkCXr63GDbxNVK76udXlzvmTFDyb
         YtlqK2TkL7ywu/0TDo90zTkkKsr0UOnOrCIdcIOV9q6vyPmfwNV43SCq0BZxUjk7besD
         2TEw==
X-Forwarded-Encrypted: i=1; AHgh+RpnaNCZ0jHjtdFujKLJZSJ1rvl+nhXSB4sN6+dTaEAhcxUo3rHwHLyzxDec9zD/qfnpRHjpypozils=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPmZLIo8CUDywfWoafQdBMe6//662w+nWVNiCT/2F2c3WTiLk
	hQsT+fhcmyMPu4VWJ4aqndqXpwNwaSIhEdAywOjOBNsDQYYU6Bs0Adz/a2VZg6X/j67DCj/54z4
	pgLEbOT4Pe78OuZ6WnuD+nRQS/C9Z1R7RSf4LOPjs0uN2kJeGWQcPwIbjO+NBiZo=
X-Gm-Gg: AR+sD10aNP70zGEKuwALGUQMZkBG2pPcFtHJ5Ybbmp70gCyIJsxwgQ1t4CtJG0TRQ9c
	TcW6rsW61bzDze7eVPSM3AD/rrIH95UnkkW7U3WZMPobUwHvuAfrjyNrR2vvBgv4KX3qHoZgCid
	p1hyFigP9KZRCnQRrpWE4P828CZklcDO4etIIH0mcr4N0fhl8AVvlcLGzvQmCx7Bnw3Xp05Lwmd
	gUvZgzQ6xXsHc+bY7VK9JVLGhbZ1SJYU0D8vq1cBMZqY8OdqhvUDOuhHBF42BWSKqoTOVQ1lzGY
	+dMdOM2375z04rBh6GziXdZQzb+bU1C4dcOFhlHmqS5O+Z8H7pviZoI2cZ3syzMRQZ4MeAArMll
	P3ADS4r6oq3vI1oMPkXIeuAGJCpLwLuQ=
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr5524740a91.8.1785922676965;
        Wed, 05 Aug 2026 02:37:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr5524717a91.8.1785922676489;
        Wed, 05 Aug 2026 02:37:56 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903917a5d0sm2756152a91.6.2026.08.05.02.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:37:56 -0700 (PDT)
Message-ID: <19104992-25ba-42bc-a7b9-c45f4b57c22f@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:07:51 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        viken.dadhaniya@oss.qualcomm.com
References: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfX7pZfZbi6Z3S7
 fn1/GwfDZNTvWQZxt0djPCHXWioOq42AfSz6bNxjEcBi+f0MnTllWXIeJbYyANZjFeGvv8sCmVr
 bNhq8GSSJ0fdx5AtNCGS3ytWL9b/KY0=
X-Proofpoint-ORIG-GUID: YmPBWlQlaTidRAlkdTe0WNYtY9Bq1TnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfXy4NNiAgxdLEj
 QmNGOfBvh3G5uW/GVUO8YSTAxyW43B44i70rXkrdRdy+wWdKuOcc2a7cw1B4GEdjIWkQ9C2aiiq
 5gld5u9QBA1nTgxY/7ZQiu50/B6I9ah22Bbe0jcHbb0FaKN1GRhBCxCbK4544CqFypT8zR6S4Lo
 4sC3LKmm91n7o/fsOBYnU58gV1ijs8AciSLKnhCHHIQZbu4p+cM2IjFPmUJg87cIZREmdwnfSPZ
 QQCy7R2M5tX532DJZzOqTLPIxSBbltBkAm5kLRUBUauxgBJg8/BH8Fc7gwl6stgbqARznFfBjDv
 etNS0snErl3cIrXdIyLuaBzD0kyGKXV7hCNMz8S0noZMcS4kFzDUfsHx4HhVHawBTsB7tUnFNRe
 MOn3GFasP67putxfKC250QNss3GW31oF/hgNnQDv6gWhYYP+t9SY+Ll50l6sGGK0AfpkXIF9Q0L
 dawjUtnQPi9qbj/GNYQ==
X-Proofpoint-GUID: YmPBWlQlaTidRAlkdTe0WNYtY9Bq1TnS
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a730486 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6z8TwaGRFWoLiM2ZyNYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050076

Hi Mukesh

On 05-08-2026 12:30, Mukesh Kumar Savaliya wrote:
> The driver currently logs pm_runtime_resume_and_get() failures with
> dev_err() and returns the error code separately.
>
> Replace this with dev_err_probe(), which combines the dev_err() log
> message and the return value propagation into a single call, consistent
> with how all other error paths in this driver already report failures.
>
> No functional change intended.
>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index d5c977e34994..96015e077b69 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -994,10 +994,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   	int ret;
>   
>   	ret = pm_runtime_resume_and_get(gi2c->se.dev);
> -	if (ret < 0) {
> -		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(gi2c->se.dev, ret, "error turning on device\n");

This change is not required, as this API will be used in the deep sleep 
use case to reinitialise the SE.


Thanks,

Praveen Talari

>   
>   	proto = geni_se_read_proto(&gi2c->se);
>   	if (proto == GENI_SE_INVALID_PROTO) {
