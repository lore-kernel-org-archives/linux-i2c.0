Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B23F4DDC
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226874; cv=pass; b=UV5RqmTgkdIRhstWNCMxcpXukO/W4lT21BbH1KDsO4km+wVj3G8PFc3GpK1f8pzraMG8XOWjry/AV/H59ZfpIploqJwv4Mwgje7UZ7cq+8xaOPw+JtjyLguvUk4thHiamhgAE4gDRXw+Gdz5IbWiBIru4ynmflJDIQLzgc11u6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226874; c=relaxed/simple;
	bh=psbVZug5PRiB7TIApmYfCqaUIt7m7uBgwaKFqFfBhgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP98XvT9uDqPQbPuauAOpQPvMmTYTt2hw7LR/AqDICyV6Y1N8CTO/yduGAwyLQVt/xm0zejoQUUFjPayx6o1CpmeEAU8PdXdY8qlShEyo5mAA4puZ2dIS+DC/7InX0Yk165c/UjpNtm1hACvoRRU4jmPDo/2x9ET/Y7ol8soXVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jb4WFy6w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hthpaN9Z; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jb4WFy6w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hthpaN9Z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82DSV2480127
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psbVZug5PRiB7TIApmYfCqaUIt7m7uBgwaKFqFfBhgg=; b=jb4WFy6w+C3vBF45
	B1f/F2ZUZXQinx5ZKBwrwmNP7X4YMbEhhwOYcrkCSBbffIeYbKfQo/YQI71EZJBB
	Gx8jguhUwEvj4MBJnCW8/8+P0JnQQZ6u2IvIS7juiZvLFKMVdPYBhDECWd34WzXu
	t/cVPrT9ZsFC5AJVPvVLDecexAntedNAMOBPRpL47s3f1w5D2e8fPxLWfq6J8l2n
	PYwi9pHRSZ7+xItoIoPDz6ctG/KyCLOxWcjAU3FUxutXIYdgRHRkD9WxmdkRr58U
	QyvMgKf6ZQge34rgks6TuJY+CU4SQ1iO3U8KVI0hHMJQf2/6n6pyTj9CP5y3CHGc
	oHHxBg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy10y0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 08:21:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e606e8f3eso280572885a.3
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 01:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785226869; cv=none;
        d=google.com; s=arc-20260327;
        b=PVmKx5g46/yuFN62lhHBSplGzZnPoPlKh+pEfrI8HrysKUph9+POtgmxjUKvRC5Hyl
         82RkDZ/vyUxc1cnkQj6S18J07QMyjQ/DnwvlB6chmPpe9AIXMh3EL5CU4yv7c+1LLQBN
         XkQBoRaDfZ0bKCD2B6xEj4woGXE+j9l14VYk7DwS/oR5im3nbdaVCpQpJBBvyTslSrr0
         G3YOfiu8MEKDpTA308klpgGH+ERhG1wdXEzFPzM01EmDQzXqlV7zCuuPu2x/FWqteQkf
         9vZuhFhtEKV0FaFdZUitny9j9qEsIRb3vIBtUGFDCpmfP8eyuaTu8u5D3G46pgoiPPP+
         W4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psbVZug5PRiB7TIApmYfCqaUIt7m7uBgwaKFqFfBhgg=;
        fh=K0fX2bIODPV+Hv1ns9OqTpTS9bbn5hK+OA+56UMGY04=;
        b=JMC7Ga8ZH9MHo3fu8BXBtNs9l6/lTGAZVjb5gBcovmVkJNnL0kXc/pGzJYQkkifnTT
         diawpvw2+c0oTVB2aNaeFCvIpRH4bywlPetdRZT9in5pCsTp+YYIfcdsUPTWRh9aO3X2
         /mnqFkSEyUCuuuqNSJBBVaVMJP0ykNZB243I6453SIB+RIHihAqOoBhm5RmNDNpKqCzV
         H7Oi/ORR+ObB8YxwSr7hqQ2DvZkvnhZuTHzS7G9kLcwQNqmNmWEUoNgOkMHSlXrDhTPz
         G3n+CD5QGUV7ZYckKJkiuAsZmokYf08sflGm1YSagBOhoWBm4cMrmUX0fibavo9I+bhi
         XvQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785226869; x=1785831669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=psbVZug5PRiB7TIApmYfCqaUIt7m7uBgwaKFqFfBhgg=;
        b=hthpaN9ZYv9R/NSXhLPjzgngjdcna3fTDgi5F5ZqWcFpddAkW/05RRjCw/IKmXMD7f
         fvlWIPoxvfeJwctWma8ZUC2rNTkAJlNw8Y8+6RsUyTSB/n3cPRYK2ncBuYklFrWqV+OY
         v5Qv5q/vKmFs+qAyUuOoy3Sjozo2QO9m8YifXIVYLac63ZHoZEOAObx0gQ5RF/PuhAH8
         fxC4tG10W5DTOhnjoMiuYFYNSc07H9bjbK7EQkRDj+1GqXdYWo3idWfn8KNGCx4Os93W
         ThVgMMTcPy7ATyWFEHv6SdA9xFg0u6wDPTfiRYWVJEgY89bRuabNkHWDBuOcnLf8Og5u
         zNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226869; x=1785831669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=psbVZug5PRiB7TIApmYfCqaUIt7m7uBgwaKFqFfBhgg=;
        b=bo8ou7+hWy6dv6JGMLqWGfFY2aIt6NE5LywU7xieSHu5zGi+UZW3ep/K0vs+tOwjXo
         iiFNyX12i6SIIjvHo72bD63MQdv6C/pXM3b0VM5uAYKv0ofayx2H+2ZRl3M4phEwvqJl
         Ja+dUA1/YYxK5HGoc6W/T3kvpAUyuiA8/8QUoxsYmhH9g2nZyZDxnYeYdIIHQZod8w69
         msrTt6yT2ByGpoLI7slgXDsjt+zwv7rGdFi+hQb3hLYiO5bn1hBr0R6U9Hysl+A3LGkk
         NEFAFQKzTHxntc8P8CxpROqvIDqxy4flg3N2wdaJSyd1vxJflZMceyjLS94+H2/ujgFX
         7q/g==
X-Forwarded-Encrypted: i=1; AHgh+RoFTNdaDS4XIyVjm+++58EOTf+bLmzTYainGm6X/Prs+gfsU+YESD8VZqHxseudoxomvWOjhlCAQ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjrnYybJXgf45QH+6lDv/A/f4ApB+TnqFg3Kzh9u+5NvM+BLr
	WZZ9AEw3GZZmmITOrS2HVj2PntxuXDaOrVbnQpEyOx6sIzz2oGxqgRbTN1TprNhBsrA9pZlCQFo
	NuoOmTtJ0uXoStp3PieVvymFYLA5ZSJtXm5Oby/tkbUVCPWUUJQpVjma2lzAdm6gsoA2bhTHt0H
	2TrSO+0LMflFngtwA29U8MfqRLiPtVTOdPRfv5Hg==
X-Gm-Gg: AR+sD13ZNgAp8QpJdFrZoy+O+7NdVgubzh48Cg99OeM2ghrNtGrWlRzfNIk0PnKpkoR
	IPKUa0+KXPSMxXiY9YthrW9O9r+nirIdU7yUOTUtUGj6yphL1kRU/BNj1KpAVRSJNrsRoGjQCwJ
	vQtEqewyEekaAX0eFPKL5fBSmUeue0BrVuZ5am+5Xilr1taomS0wwvmnxoc8sJi6Qt82bAhv9C/
	zg5xaqMRMrGgNK9B49uT4uLwEsvnVEMc/mPbkyOVRlEGyl5sLU3hqtoEXiX2WjM8kAqnKFHSZNi
	sHIuiILyzC1mysx6g2VnNfxa8+/7
X-Received: by 2002:a05:620a:1b99:b0:8cf:c106:faca with SMTP id af79cd13be357-933025a6cecmr116304685a.36.1785226868431;
        Tue, 28 Jul 2026 01:21:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1b99:b0:8cf:c106:faca with SMTP id
 af79cd13be357-933025a6cecmr116302785a.36.1785226867986; Tue, 28 Jul 2026
 01:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-1-c3958f28b045@oss.qualcomm.com> <c7b0213d-a4c9-4ac8-be09-b449da457230@linaro.org>
In-Reply-To: <c7b0213d-a4c9-4ac8-be09-b449da457230@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:20:56 +0200
X-Gm-Features: AUfX_mxSXGa68pk4Kz1yQ8PsRKYdtiXqJrr9OnpBEFcc6F3FtJJEooLPHFz-yKg
Message-ID: <CAFEp6-2VP1pVbKJEkPTOFdMn8kv=83CrP-MCYPDTN0BHURn2Jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dhWUYdlFyJXuQh9_enXMhVRA_0KpQg6u
X-Proofpoint-ORIG-GUID: dhWUYdlFyJXuQh9_enXMhVRA_0KpQg6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3MCBTYWx0ZWRfX3cnq+JYl0SNk
 pgGFMu3BL4xfBzGvQcDUlTzH9Di9j4pcwNmDkyVE08CUZ+tmM172H/OQqY/65lkK+wKU+ni0iFF
 3iaCut5lacdb8x2uFlRlWJtnlAdQVb2sGdoypUALm03jE0basKzcrPt98J4Ls2v0vzEfW0zabBz
 w7uTglTlacLiFbs903OaOHd5P/tjSB/fuCzlwbi3r/AVsG5tfjX+zTbKo7pSWM1qi+PNbN8xNIS
 Rnaja4l/0L3cj05T9zIObn083IYE+t578phhqWi1V8AwFeotG/paYHOpAh9S3OZVt7l2cjNSmhE
 HLU5DeQ0z4t336Is+tQuQOVBea7XKOouPjcG1wKvibf20v3pgjIFF01BeI6f8121rWM/A/FF79K
 vpYDujBk9QHBiJ29/HJItGxJsaihe5POX3d0jpR7duQe6LzgkcVwVZw0nyamqcd2K3j7O6aN272
 fTuUkxOSynF+LCJCj+w==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a686675 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8 a=vOiYUO998qp6HqxB24gA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA3MCBTYWx0ZWRfX/8phTvSDMjvO
 mINMZNy7j6cK5cScp/NEqXtUq3Iy3iMggB6C6C0Xe+WOn1AkNcJcn711nKO4sPVaX43A/VxQt0h
 Q59D2a7VJnFDXoJrDYRt6VzRr2Bb4TE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280070

Hi Vladimir,

On Mon, Jul 27, 2026 at 9:21=E2=80=AFPM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Loic,
>
> On 7/27/26 12:21, Loic Poulain wrote:
> > The msm8953 CCI timing table is internally inconsistent. Its Standard
>
> likely I was misunderstood in my v1 review comments, and I believe v3
> will be needed...
>
> If there is just one master, or two masters set in equal speed mode,
> then there is no such issue as "msm8953 CCI timing table is internally
> inconsistent". In other words generally it shall be permitted to have
> supply clock frequency intermixed speed modes for any CCI variant.

The two masters sharing the supply clock are independently
configurable in terms of mode, so we simply can't guarantee they will
run in same mode.

>
> I'll repeat the same point as given in v1, namely supply clock frequency
> is not a property of CCI revision (therefore v1 1/3 or v2 2/3 is invalid)=
,
> it is a property of the mode settings. It's correct to remove 'cci_clk_ra=
te'
> from 'struct cci_data', and it will be correct to add (or parameterize in
> any other way) 'cci_clk_rate' to 'struct hw_params'. Each instance of
> 'struct hw_params' is strictly bound to a particular CCI clock frequency.
>
> > and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
> > clock, but its Fast+ timings are essentially the v2 values, which are
> > calibrated for 37.5 MHz. Since all masters share a single CCI clock,

So, you're right that the supply clock frequency is a property of the
mode/timing settings (though I'm not entirely sure timings are fully
hardware rev agnostic). I don't dispute that.
However, this reflects the current driver behavior. It's not
incorrect, it is a simplified approach that uses a single frequency
point across all operating modes of a given platform.
I added a brief paragraph in the V2 cover letter to explain why it's
out of scope.

My argument is about scope. Today the driver has no mechanism to pick
a rate per mode, a single CCI clock is shared by N masters (usually
two) that can run in different modes simultaneously, so per-mode
scaling requires (1) per-mode rate info in the params table, and (2)
vote/arbitration logic to select the highest required rate and still
apply correct timings for every master at that rate. Concretely, with
one master in Standard and another in Fast+, you'd need a 37.5 MHz
shared clock and a Standard-mode row calibrated for 37.5 MHz, which
the msm8953 table simply does not provide today. So this isn't a small
tweak, it's a new capability backed by new table data. It would bring
more fine tuned supply rate, but without huge benefit, as cci clock is
gated most of the time due to runtime-pm.

> But what if you have only one master?..

It's not important here? we have N master (usually two) and have to
deal with that.

> I think the msm8953 data is correct, it shall not be removed.

The msm8953 table as it stands is internally inconsistent (without
per-mode rate info), no single clock makes all three modes correct.
Moreover, msm8953 is the same HW version as msm8996/sdm630, which
already use cci_v2_data, there's no strong reason for msm8953 to keep
a bespoke, half-and-half table.

> > no single rate can satisfy all three modes with the current table, and
> > the DT assigns 19.2 MHz, so Fast+ timings are wrong.

This series intentionally does the minimal correct thing, aligning the
timings with a single supply clock and enforcing that clock in the
driver, which owns hw_params and has all the info to produce correct
timing. It fixes reported devices misbehaving when no (or incorrect)
assigned-clock-rate is set.

Not saying what you propose is not do-able, and I clearly understand
what you mean, but I'd prefer to land this simple
alignment/enforcement first and treat per-mode clock scaling as a
follow-up, rather than coupling a straightforward fix to a larger
refactor. Please clearly Nack if you do not agree with this first
step.

Cheers,
Loic
