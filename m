Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE933EB01
	for <linux-i2c@vger.kernel.org>; Fri,  9 Oct 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556811; cv=pass; b=brnde7zcB6LztKuRF1sceDT99zaSySXja6XnjboyK8nHKcN55k0Y/FEXmlmc8jwVOq4D2bRaUk14uibobGK55MM5d0vEZEyRikBpVeepg9aIQv/UcXBNeN+/yDiqu8vI8amIhdpxPlA3JZx5Yjq4oT24jhlAmiDJer4YNt19a6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556811; c=relaxed/simple;
	bh=JTPddtxrW73Lrd3byEH3IKo8/W3YU2i7GToZvzEj4qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOnZ2zJScpWA0G9MS3S3999c+0WoFFTqgcOKDqf0BIw2rP0l9cyGjsy+G70WNfqUB8rso2mxn3F78abXkjkfytDblyvZsrTpkZr/ItlbPAQsxIalGnzQnuv054JokBFXKm+xRMuvgOkw9Alh4Yzmp7+4gZvuHjyixRFapTlovvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEwBJpQF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqLskn0u; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEwBJpQF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqLskn0u"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Dkpxr511683
	for <linux-i2c@vger.kernel.org>; Fri, 9 Oct 2026 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oI3ezl+n4MiIBxKoGsxgWBJshhguw/mDEnDrtpu5wV4=; b=AEwBJpQF+HZELJif
	+dli8QDseOEB5D1YjoRFgSWX1/nD1zSmvyIr2DpOA53QcNWzjF42YPuXyjjGc7T3
	rAsYcE0oYm1AObdFuuq2NIxV0zWn/UP8e7t4sF2BMTQfmwFZle8LFngFDKEJHaxH
	/jCZbh5HsMG24gZVv7r41JUJMoynbAv85qULvl462KNUajhAeztKnyVI9TDphZHd
	sKIdMGy+AXD9WdFIsdERdt3s4obCzAUGz6hYwWs0eWYtuEXZ1pMIUD7lBRn2p09S
	4BE+ijUjvyIx4tPoNYuuaGiXTrwgsHLJVp+B20rSr+kFAJZ391t7RTC2yzI3yWBh
	g6OxdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f2875s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 09 Oct 2026 14:40:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e834ff4d0so1327510785a.3
        for <linux-i2c@vger.kernel.org>; Fri, 09 Oct 2026 07:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556807; cv=none;
        d=google.com; s=arc-20260327;
        b=LHXwWyUNgGFVnYG+rO+/mbH+vzWyhtE7Od9E0Li5no4Ew79Ha+TB6xcMx6Rn5EeoL1
         +TdBEoGlGOn3kHpbfOccQCr4esXF+6Ni5r6lSuETBagsdfhlqETrW5HQVEwIOuQnoK05
         hBCGrwvt8N2rGU/BdyOZqDEmcxBHu9WVcM44rQkdOqiAs2Wq7klEvyZcx1KJ6AgN24Sf
         PgfkVFGXh84sL0bVLqYCF/P7dvys8hNVhSv5Hwth5S8lelJPqzfDCmIHTIHIkKnlO/i5
         tPuvMmmkdfCClxl3hBdeh7h8wSc//pGHwdr103No4//16enIZJGkgkqiX3WVNUqJuCIs
         6uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oI3ezl+n4MiIBxKoGsxgWBJshhguw/mDEnDrtpu5wV4=;
        fh=BwRYZhoYz9iJXFhMhAt2NMqIla0blZXil+NX7xoFWTA=;
        b=aybWOUHqS3RkWf9jNMiiFcwPDsuxWsHFgyQivEPJvmqyFlTYHg7un5aKqmwW53435w
         ZncSBUX6yzGbklXMFB4zjsSn9pio1WyfbUr4PYHzDotiGHFWXGgWvHscdQ8wayMJj3wa
         Pei/CYog4DNCg8QEsPWVhuGfZufir0wZeFEHmSm+NvOlnKhxxfXECoKPonhO0dPhQz0n
         GwPj+71VskGiR9hmOBoAdAkoW+x0GmEoaGB6ksqt4g+fiFewZoKXIIqMpNvzDILgHDgz
         uSrgupHZIOSFuvoXenNQAeukneYhm401eQ/7u8+txrjL6q1EIwljHM/Q7VmV3BapRk5C
         L/Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791556807; x=1792161607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oI3ezl+n4MiIBxKoGsxgWBJshhguw/mDEnDrtpu5wV4=;
        b=LqLskn0ubw7IqJ3M3LxtGFZFZtPbyge7R9b3ibonuwTeXLG7ODLq0kofbJAeZYJ8+5
         AFcssqz1PSuGMc/p9GSxSyiv6wLwgRPMePhg1vx36BxEMufiT5d2irrnwGiKUnzz9/jG
         uRrTmvY2cKzw30CB8GqLUFUq0pkqRqNbSTPgjkG4xJtLzVEOGNuyStgSYtoWM2s+Ysip
         7cRud9Uduhz5GCOCjWwP3aa7cz/8jZ8UaDJq3ZGjAuexGcLYmv85eTM7A3h3JRJDSb5Z
         VjyOD0CrnJHou29+cX1ylh53IGvnti1hOfPAy2K+Zo2DvcnSr4YOJ6t46jjDyro+dXm8
         X5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556807; x=1792161607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oI3ezl+n4MiIBxKoGsxgWBJshhguw/mDEnDrtpu5wV4=;
        b=1eoy6kH1nfcA5cAgmjsFvUhGa7z9RerXMUnkdIumvg+VSX7fN05xBxzIvOh1W5Fiu5
         zuhKI3n7YFV+Z7BlTWnn7Ubo2JVnRxHH8icjB1i8n7o0NW5ohjmvY4Qu8GYoPLWrp3n/
         wigNM9Nsd7v37iy3/hVbasTVgbh+zlaW0V56ryW54S2cGcDmkNronuWLpDnzkS27dfm5
         fIICVea5JxESjDRgtWMjuUHx9YaIKOzpENLovnnRo6FMippuqNnI/XK+prbf8Qj1R34c
         kE2fRo7XY68fO5u4tcB2pOuXSfCrkllr2ruhMlRppL15mz17q9wMbt2vi3TWMcC5xI8v
         mTsA==
X-Forwarded-Encrypted: i=1; AKwUvByrNzkElbmPaYZQRMHEqvydzuMJyenkOiH76wmemzfahlvwqy6L2YRaHP9EClFPOSYMFUWZa45iQuA=@vger.kernel.org
X-Gm-Message-State: AFuF++l+Sr6uHxjSSCjIckvKQUBSWTb8asuP8J9wwa7EosJpXHTiKXos
	XMmr99nLx6WvN6E99kvWqk9TbA1LwAMzQyFra7aHyDXarLYZhMyfqirl/NMhiugH+4D4E8stZfV
	gtqZLICKWJfKmpVxNI/xwR94IjSEowDxFFdecJQ3AnNvtF/M0kp1DCdOV7QhyuUwcL07WHD9kKY
	m0ehpkyOUtsmKSDiOheYq43+4iO4xpATetms6jRA==
X-Gm-Gg: AYBFou06TNDed2vmE0V+jzCEUvvd2YaKiPGOoPAEbnVRAIz7eTNVnlayp+cdcf1uxpf
	5BhGpay8n8oViCbthsxjXB065AinuqfdZgnI+fMIoXPWpBpTnh9j28XRLkfyU4Maf1TVSFjoiI5
	Pc3Ayu0Jam+x79B5kjKNg91NBxquoeCYbM2qOivCCqs6MRN9wsdYOKwtAJQq3/BM8PpHxADE0hc
	ZrXa+c+5mDdgTk7lSDJHBmf9Lhl2viB71LGJVYhvgopBgixtw8YuEaQ5t5nQeuG78wljYcucFcu
	7k51IRHCfEVZeZI3jtV+olgp1buEMzct
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id af79cd13be357-93ebd2923c0mr307219385a.57.1791556807043;
        Fri, 09 Oct 2026 07:40:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1d01:b0:93e:8542:4f4d with SMTP id
 af79cd13be357-93ebd2923c0mr307211585a.57.1791556806436; Fri, 09 Oct 2026
 07:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008230725.3228-1-okerixx@gmail.com>
In-Reply-To: <20261008230725.3228-1-okerixx@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:39:55 +0200
X-Gm-Features: AclHuK-KEBHBU7JnA4O-_Ixe1AIJbaoKZCZKIAWioy0RNObR2nZvqEeX3Rl1-Q0
Message-ID: <CAFEp6-0vi0_xWGbXUxVQ3APvHMsWgX+_AUXvJDs0FZWky73LyQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: skip core clock rates the clock cannot provide
To: Oleg Keri <okerixx@gmail.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: KOwbnDmtAVUEi0Po20r_CwCtuRNtb3e2
X-Authority-Analysis: v=2.4 cv=Nf5zRGD4 c=1 sm=1 tr=0 ts=6ac8fcc8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=BuF8_mXB32IIVKhl71AA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfXyp6b8u/rU4nE
 zFd0QZCoNF5kXYlIFeT6AeMconLy5f7Gn4ZESQPdoGKd/SiYOt3frnDvIbnsgytn0W1H0ydngUj
 wmIIs3AuDVQdBJfLXIpwkOdPgygVzHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfXx59s1g7JeLwG
 KsHcupRUkSnpWZb3satpU07dh81nnJLQ1JooNsy02FMRqAyZnmtK2EXlN4NCuwZyf3Omofu2MIm
 InGtI1HxhgXB2VprGO/sFNBzqnqtN2zGVkjdFTZeyPwKc1jUoP8UFT4UnYNa9cK6lptNv4DWSMA
 +ZxvwshsVI7DOylneJKhv6vDfskWDqiI3OxORifbKGbiHmop53k98kE0S0QesvvNfHeJHRmXey4
 5B/DTg1FsBgxBAsE58i/c1zUPVRE0M7wdFPxa8QOVaGSlWD1LRFgBRpIjeDi5wDK7RIn2qeHiqo
 wHeCkJiBoTCw6cHi/nYplsE2cibGQ9ZRCyrjDmKJM6Gg80v5lrZkpJBOs+6u66YVATeOsvkqd0X
 l24AUg4fmZgv75New0FY4zn+bGNYPabQsF7Rew0aK/MDhxaJ43J5jgzvNVB/xuogqEvfYuAKB86
 K3N/m48vkg4RQbXObYA==
X-Proofpoint-GUID: KOwbnDmtAVUEi0Po20r_CwCtuRNtb3e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090058

On Fri, Oct 9, 2026 at 1:07=E2=80=AFAM Oleg Keri <okerixx@gmail.com> wrote:
>
> cci_get_required_rate() picks the lowest rate that has timings for every
> active master, but never checks that the CCI clock can run at it. On
> glymur, sm8750 and kaanapali the CCI clock table has no 19.2 MHz entry,
> so the request rounds up to 30 MHz or 37.5 MHz, the timing lookup for
> the running rate fails and the controller does not probe:
>
>   i2c-qcom-cci ac16000.cci: CCI clock is not at expected 19200000 Hz
>   i2c-qcom-cci ac16000.cci: no timing for mode 1 at CCI clock 30000000 Hz
>   i2c-qcom-cci ac16000.cci: probe with driver i2c-qcom-cci failed with er=
ror -95

sm8750 and kaanapali have a single 37.5Mhz frequency point which
should not cause a probe failure.

>
> Only consider rates clk_round_rate() can deliver exactly. Glymur then
> runs its CCI at 37.5 MHz, which has timings for every mode.
>
> Fixes: fa1eb3af12fa ("i2c: qcom-cci: Enforce the required CCI clock rate"=
)

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 6d8be7b8b79d..289368c00fe4 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -586,6 +586,9 @@ static int cci_get_required_rate(struct cci *cci, uns=
igned long *rate)
>         for (int ri =3D 0; ri < NUM_CCI_CLK_RATES; ri++) {
>                 bool supported =3D true;
>
> +               if (clk_round_rate(cci->cci_clk, cci_clk_rates[ri]) !=3D =
cci_clk_rates[ri])
> +                       continue;
> +
>                 for (int i =3D 0; i < cci->data->num_masters; i++) {
>                         int mode =3D cci->master[i].mode;
>
> --
> 2.55.0
>
