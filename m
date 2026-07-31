Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93942E8C9
	for <linux-i2c@vger.kernel.org>; Fri, 31 Jul 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507926; cv=pass; b=Mu6CemzEcQABfZCBnZQ61b/Ix4y9cieCdr6PE26CdLcuRMjHITNU+4TxmXvsfmBJU7zqc3diMVTOUMfwQvFAdUrOyNXGNxNxC6nioU2pj/7sWx/YKXG77PcW++zid883AL9PtCuqDM0xIk80nQi0whZG4/w+HmLK7/hIklhp59M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507926; c=relaxed/simple;
	bh=EzMoMaTdDGQBqIdaJmKzvd8zpTVC4eUSTXLdE3n4PwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2zp4ywzPPZxGvPTlG6dlFiwclhYWG+dydtqnI4RP/ve8I9lGN0ZfWlBud11NELpcXTjYyNryLIZLprlDlQlMrsa64eV1Kzla2+eyf/LRgRNyxlm4hi7oU5JT7+S1XU5B4CJyuxNZxKBLzz40y5Ly+Id7nxA9FUay/T+B+isI1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dB0Hr2Jn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNR00TMC; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dB0Hr2Jn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNR00TMC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBdBuE3371064
	for <linux-i2c@vger.kernel.org>; Fri, 31 Jul 2026 14:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzMoMaTdDGQBqIdaJmKzvd8zpTVC4eUSTXLdE3n4PwE=; b=dB0Hr2Jn/dvSDwXF
	qBK7OpDZEAFPbfJFhqct+4W2FWvZds6W6as0ylgGYCzto1EqrjZGc4EaW4REIbuP
	3Gz97izsoKBUmeKXa7INLDk7Rav2hB7gyTQCFZiFfQzYmbN97TXZ/cVOnoxy0mK1
	ja2V0Lqk3F0AdluugG5fmM+L0CyolU7br5RmGf4Eue6yBvS4VdHCP0l1WasHs2ZV
	wxquCo/xfjLPVKiTTbMFRXQ1ZvGZRlLRkILW5QlCGDoubEAV9OYUYRdpsg8E2Xje
	N/LFzwazPU7MYQQi3wMoAEW5HS5+oMcO/oin86jXuqGAunmffOC9u2QBxcAf7YpT
	QkqvCQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y0nqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 31 Jul 2026 14:25:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so113551285a.2
        for <linux-i2c@vger.kernel.org>; Fri, 31 Jul 2026 07:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507918; cv=none;
        d=google.com; s=arc-20260327;
        b=HBb7rG7GGKeQRQYmV+r+eoOTBlmJgzdXzzIEcJ/zp90RSGVBQYOYXlybObQ0Gg6Xgt
         Jjc2Y01R2Pl6f8MqTTFMOZxMWDqudii9Oeo+/1izr77zHXpZLUkJf2UHFk20k30o8Mb3
         j1oZc78ks/iJdjp6hhQWMkzmHiraAarOKV1GrDgEy7w7tVGiSIXZ+x+7cdVZXIkUDpcQ
         x33QsgFSzoXIzk45kkp+jmuMmhEJC9TToolT6g0JfH87V6HhhZZcSfA0zDZv3DNVLpFJ
         jU0ALDeMSFdTeNLkvUNfjOCUH/UHYEqEgTuvMnTj+5fB1JsIbXi9iX/OHN127AVfLAAM
         p4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzMoMaTdDGQBqIdaJmKzvd8zpTVC4eUSTXLdE3n4PwE=;
        fh=Iy+Qdm4V7U1JLcLoho6vxhUYJyDJ+5jvQspgyDtAC4Y=;
        b=L/GeOFcZG2p3Y+CKMrqv+F1cZtFd0DYQZ42vOFo/LOKdHO2k/mXOPNUzlvR3RKkMO9
         PWq4kEgRa910Ce/P/YBXKst/IVNNE0aNlKj2lreNB1cQaLaxCDdr1KDgV5CckmIns3A5
         V7x8984pA984OZ2SrA36N35NwCmuhzOpM4PVdQhuXX/CpJmE4dl+hmpz10T+Tgpxp8a2
         EW8bHL0iI6NooLR1glMzqU0fDE/998dFyO0tvJgGnEb0G0EUvzgk0EdBQh1a77g59XLR
         iASon61FmvK4GilBh1OHMGw6bOW2LV94epEpZbuS++WTLpQXwS7Fn+jqOszbWcCJ0YQy
         cvXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785507918; x=1786112718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzMoMaTdDGQBqIdaJmKzvd8zpTVC4eUSTXLdE3n4PwE=;
        b=WNR00TMCl8DxIA8q95VulxxvNYCvm/lFZddIx3ucUDBc1IWmzURuNnrKO5mZAvi5Kb
         xGYrRaGo1DAziB8IeHTh+s8QdTz0koakYX2xNinx1fuRs/rp3T6p4/idAd6bvpRzqf8B
         qrGHuu+aqYrVowmiNQfQ7Hd2i+F7giLisQgdULIItgFVRubbOCly5fM0eeXLCA14PkMX
         slpdvC8sZwNCrX9IYmJkRxUS6vW3pVk+VGoHEYpWcR+9AIpoxhVPXJ0sycSJIZ5m1KRK
         G8Vg/JdC9UgW9M/RUi+bFqivSSaTz2jARMz7gZS6GiZ9jxsasxbvSEKdc+fSyBc1T/Id
         pzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507918; x=1786112718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzMoMaTdDGQBqIdaJmKzvd8zpTVC4eUSTXLdE3n4PwE=;
        b=W3HA/BlWgj4PT2wHUk8kZV1JH3Z7X/D9o/jfl7RxYz9w51N5aUJgXW7hxNfSfMBkti
         RMsaH13A98Ve477HQrhK5ZrRKz8X3oaYBsHptJoRS+9wpwuGl/5h2HNbYSeS5jBoICdv
         Hcru8Oh2gOEWvx0/LOCWp0QyHzlmFLN2MEyWfPC0m2DL4bYovL5CDHA3IvU4npY+HjTG
         4gpCIjoPteEaGSI+l7ex7cNXxEMw3DgBlSAdDRzr+CdLks7OhdIw5sE6UvPMnuZtIDS4
         tRKwIOGfb7eZX0xLpwurCda6iKFCWQlKRvqa7Xwn7yCGm+zuvTzuhHv+9VVZ36dKJVqD
         nQvg==
X-Forwarded-Encrypted: i=1; AHgh+RqAPWOk/3YePF2jhBpY+X5e7zBDuSSMHIJ3mPdr5lDsUjLLlhddj7CMjyi7d34x+yq1/PnTK95Oy3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqllmU9wBnW5cb4WetFgIRGWEG/WCzJDYfepF3Vk4lIlim+62L
	l49WYwqOlgUtjtT5HOkgP2UwtHxglG5bUEcphJ8Ab8wEg0hLYush0el1UhaEbvYO7JzMMdVs0xt
	+G7UnpNMwYnfPuK9Z3UkinciePrd8Fvsubs/nxlWUx2/Vm7lSlMut7WmcSh9FU4qWkGIZmTPY50
	fcH2+9QF68keeg1iIWcVgyC7TbhizmkJXmzC3Zbg==
X-Gm-Gg: AR+sD11JnsWk7nuq1eVFM86LjsOl1KxhwbkX55jwhiET0Imnk86sJ9dfZ+uxS+6BbTo
	My8YzUw3uh9YdJYHvDDIGGs36Rc2APvUAEtoBKC0oPs6iATMu53DYCilvBQIJHI3/5IqSvtf0Or
	1IEKctG5gPXn7lfM/Ab2iVZmuOnsm9BimgE7vacK5MTnIOYizdUmOsfSF+UrKFclrsStMnBH9Jh
	kWTXq4QePJPV7wUxTC/mdQcJpiHEaFQShnMs/4vkoo4T5KOwA3Ur8NbPwSdM9pw3cn6KoNbmziq
	DdQIsPp2Ob1W8Rq9DAnWTqzbPKei
X-Received: by 2002:a05:620a:27d0:b0:92e:8734:b721 with SMTP id af79cd13be357-934a093c1bdmr27793085a.29.1785507917357;
        Fri, 31 Jul 2026 07:25:17 -0700 (PDT)
X-Received: by 2002:a05:620a:27d0:b0:92e:8734:b721 with SMTP id
 af79cd13be357-934a093c1bdmr27782885a.29.1785507916660; Fri, 31 Jul 2026
 07:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
 <20260729-cci-clk-fix-v3-1-f3c731d1596e@oss.qualcomm.com> <016603e6-8e87-47d7-96fb-5441ddbaeb28@oss.qualcomm.com>
In-Reply-To: <016603e6-8e87-47d7-96fb-5441ddbaeb28@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:25:05 +0200
X-Gm-Features: AUfX_mzY82V-q8dyHQoiYlzmsnaF9JauNvq3EY0Yu4Zwqm6rRPBr8DI40JfzuYo
Message-ID: <CAFEp6-1j9E82SzCKjYaFxhzYD-UiniEMPN=_Cqe4_NZVC2LHdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, konradybcio@kernel.org,
        stephan.gerhold@linaro.org, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwOSBTYWx0ZWRfX13Lua/pagwws
 bKt+Av9L8Xq9rg/J7rHw7zw+8JCSSh0E58MgXzYoOd694exdrsCwmqJnoLmU7n3itoGEE74bl9J
 ejE1e3jZQjZPwoQXUkaRPtjH1SYgbU0=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6cb053 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=XFPRkxQX0av47yOvrY4A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwOSBTYWx0ZWRfX+s0LJ8v0PIwt
 TmzOL/Iy7DAthbJ4SYAyll723bb1d+dDitz4JzakrKK8EfYXQ1tmGybVka4X6I9+6KvLxC6cvxQ
 GTXWqfmY+1M5vg4tCxNKgo2Et6kzBOHjnYzUcJcXdMGsrFEapQGMgwS2dkAky8Ao2na5dGa1mCY
 e30cErWkqsIfS18MlIAMDXIbsnhPp3xqtm/gS7lp4XRtdsEoHpagvxAa3BVM3+8+lBrCekIPo0h
 ADWp4kx50xBG0rFtG0q+W8Tknb3FTeTvviS3L6tLXXZz0GUbembdae8zDsAQt5uH//K7xhTtpzA
 2rFpHK7zMzl/+X4qq7USDX4G6sa28SFTxEHb6Gm9ACBQsIiD8Vwn84bvFS+hk0xHmRiuR1dWKMW
 zHryzjq/OZzl5/5ZJYDfmjr0Yx7I0CIK2/npiHOTMoNAQhq9C/vb4CMI9E/BEs/jjrxA2/T/aK0
 7jPl7LMYCI22NQlE10g==
X-Proofpoint-ORIG-GUID: k8XpcSDNgb4iFCb1SEar_sZHni_z8OaX
X-Proofpoint-GUID: k8XpcSDNgb4iFCb1SEar_sZHni_z8OaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310109

On Fri, Jul 31, 2026 at 4:07=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/29/26 2:25 PM, Loic Poulain wrote:
> > The msm8953 CCI timing table is internally inconsistent. Its Standard
> > and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
> > clock, but its Fast+ timings are essentially the v2 values, which are
> > calibrated for 37.5 MHz. Since all masters share a single CCI clock,
> > no single rate can satisfy all three modes with the current table, and
> > the DT assigns 19.2 MHz, so Fast+ timings are wrong.
> >
> > The msm8953 CCI is the same hardware version as msm8996/sdm630, which
> > already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
> > the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
> > the redundant, inconsistent standalone table. This makes all three I2C
> > modes self-consistent under a single clock rate.
> >
> > Note this requires the CCI clock to run at 37.5 MHz, the driver selects
> > and enforces the proper rate in following patches.
> >
> > Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>
> Wenmeng, have you actually tested this on MSM8953 device?

Hmm, No, the b4 trailers got confused after the series was reworked
and incorrectly carried over the tag to this patch.
Unless Wenmeng provides it, I'll remove it in the next revision once
I've collected a bit more review feedback.
