Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE07456E0E
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324940; cv=pass; b=k5XntT7gEaVbJSeHUWSpOwuz5NWFNhpcLr/UMudC2E4gLny9WmzbM0LlTckpQNd9TmCrKFntH2y/nz1q2sc9B1+tDPiwh+ampiDWzq9l22kw5mBUzzJtYJc0PC3RuQXH9fsakt89PFvPOSYXuxYpNo8flceJp/rhuFR2zunigso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324940; c=relaxed/simple;
	bh=C3VfRcT+sZcCo/DQKkIcGwGNwWmfsfBT5Zt9pBRzoPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jq9CA4S1bZk4a1e3LHiCludsOSoUbsi3euVtsH3ou8thfTVeswWdUo6CjXoEqpWdc0r6bkGuoKH0VqLSSx5iMJDMuOGVi0P04VWO8P3uhGmhCXPx6LMepCtTx6fPwfwjik1v6Qm057ycEJpGe8t6qw13MIcdtA7P32INnp5HG/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FD8+Aead; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evOXn+Oj; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FD8+Aead";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evOXn+Oj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBV0iV1697483
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 11:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MIJLeAnQsHAofyxe1GOfsiufaRlLhGM0oKTM71bUBWc=; b=FD8+AeadImKoU9lE
	h3LKTSn0HRGdhr/+UmIEGM1IEKDQiKH1deZDa3sdGedO0CFy2qRQHbRKAePS8dhs
	ZdKCc/eUwxMTPKNGvzMonmSyzOO4DKkXgoL/Oaf+eQdkhp/owgoqh7InB/33NC+8
	RlsOMp2KZdi/Vab5XifvBhtaCp5bf223QOXUKMeTX1/WTE1VG1NQC4hkiHuTbggH
	EdB0A85xHSFwofdoYqdOvgTPXKNyESro53sL+XAxRDQtYIO29lRQpRJjr7RyrLXb
	fQgBGnZmwiEuJUhmg/zNwabz8PMtYHwEUj/5Y/eY1F3aSl1aQMuKnFNgQlZd43pQ
	REz+qA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgqc80kp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 11:35:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93106d8affcso83535885a.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 04:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785324937; cv=none;
        d=google.com; s=arc-20260327;
        b=K4R0sshfWa+XhaMINudOCNMs1H66wEutRQXjVx/PtZaH3+syolh/JFM8AWaVVvViJh
         idhat81lkiDA8YUxbUpIlDg2NgOMiQgPdh7aCItMRqEdJs8EOe4VyK6ViyLBDTe0x2zt
         JHGHPnHmdzNmtK2HmMwbYtsHeVduUy6O38l9SkZAXd9R3L1SS8tnscEpUKFpR7g1L66b
         8IW3sFdFEN6MyGMuiB5NxDlf8oK2rQCB2OV3vMnJruPzCCwlC7Cdr0ugp/jPWQNot/Cj
         D/iY6S+bTyfI0VAQ6X4GQz16tiXFmhIRczVFl09Ui+tFYmMrPJ5E+83efYnnfnHr/oCM
         o/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIJLeAnQsHAofyxe1GOfsiufaRlLhGM0oKTM71bUBWc=;
        fh=FeT9Vgp40Ys6CBqdnIbXmmXxnj4vaE9t0xCdwlg709g=;
        b=pnZzU8TNEr/GcpJXbInFWHxwJFI9I5oUe7w8l4+StuTMJ6BrnSR5ahiBxiSvUyyp4O
         wInPF5MMuzBxlTqMBUvHb9JOmA75UUaWozEr5KGO+NhX/CbP9Xs8oWCTXFQl7QAC2mn9
         wn6oWs52sT8aUkgxc2PxMm7TQXnTqbKz1HbtS0mJNN7j9bh/pXQ2rlqnl9VKBqaKhCBJ
         14WWssAg/PzF7P5W4psL0f1STjfty1NAxg0bSVpPWohlrQuzxE80I7ObIKNkbhDk3IDq
         rEPywiK5HV3cno+0AAyfYUeHuQHleJV174IEGME1dEJCiS29atIGsgaJXKMhN+iigoSi
         Ne1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785324937; x=1785929737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MIJLeAnQsHAofyxe1GOfsiufaRlLhGM0oKTM71bUBWc=;
        b=evOXn+OjtqC/znTPs14eCYGQQ6RW3RGs7pPNqXhn5F65nAizL7Z3R+q0jaGr6g4ka+
         0pdsHjZQN2qQt0lnzjRlClukru1qR04jTsLohqE6Gveh+cDog1DNuIO1Wto38g3Ylwl5
         9tOxijFbsTNzB298bQgkorSpMl9OPAJr2VrxzcS4iUpmx2AQ6hYMec9cF1nqbwQOyq9t
         jvG1VhcG5cSS15fosd1NgDQxO+hMbfeTpsnsKUq9n2Nj7m2Y01rWh3R9taEWFOz1urDw
         Y9VAwHec4MDKWx8fyDs+Pq7p/6DTenueTjApRGMd2bDyP6swaUprcsq8EjLO1T22feHl
         aUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324937; x=1785929737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIJLeAnQsHAofyxe1GOfsiufaRlLhGM0oKTM71bUBWc=;
        b=FtHtPyNClWlATebthpryyXkJDt4qawEYr5+rKm6pZwC1umsUKXM0WPIXm9ZnBfK9zG
         h7LSlgWq17hUGL72632Bmg/acUtOURiDPK8ttfU1dHpzmLHfDcRLUpIeSWNklPK390jc
         jNGdljNhhwnWyz0GQb3wrlbWJfcFuVDOEWGM804A1VEcEciLsLU+MRvai18hZpTJr9+7
         jF6o0P/KiygBzQb7wZiG4hLtWW0chwu+Xw7EC6ulesAyTb8yyOnKqq/w5hAJER+ODJxj
         YCMxdz7M3gNLx9ulQML7s277Xu7F0tseY11pla4Vq2InzxTfEhfD5nZ+434tTBaxcq6J
         TJsg==
X-Forwarded-Encrypted: i=1; AHgh+RoC7SgKdK19zbU/XrXU+aUSVlEaJkBdqS2oQ6SmczXWNChqm0XeyiaQn90j6zuuAzO8l+J/J5CjBCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+y08mrQ26glaQ41hsZ68KZ2ineuEL6GZ84ztyQaYj2EOnSZR0
	9iSKdGilQ4eIOn9ujpNTw4h6fo5UaFzi//nLWmyGa0wpJQehiu5kD+VuQrEezkyrNk2nzpyUTK9
	zCbFau87AR2ElVM9LC3hYQwDUHn31ghpzt+/d9P5o38s6gRf3SyhjONQZ3/tOG3yWm4XlYzAR/w
	OllLI0WNf6JHXszd6Jr7Z/1P0DEuqeW2iGYYeR1Q==
X-Gm-Gg: AR+sD10VQyCeV3L1N1cfHmKY5BUWN5tPIgqMlFCCkMHWnDd9HCoZAWPPnmAeUrXMGJ5
	OiTQ0MoUbl6qbc3B2oqCRZXb6E8Sj9OiDvnyxq/RA9UFrJGKyzq+Ev48YM4UnvXNZ2J1Dj8C9Dy
	NQaRLd+jGfBMnIVlsS/fTEubvcPvLQkH1cxORTVeWNxNAd9WLEUP0QZSZaL0HQjcEm9c8z/9VBR
	Oc5v0K1hmdklZU0n1bEOivE3JwOYq0aubwOdyk9TjPzHQXZ3dsdzIYpPakdbEo2RPut19m6LrY=
X-Received: by 2002:a05:620a:370e:b0:92b:67e6:8ad0 with SMTP id af79cd13be357-9330272a40cmr620254485a.74.1785324936669;
        Wed, 29 Jul 2026 04:35:36 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:92b:67e6:8ad0 with SMTP id
 af79cd13be357-9330272a40cmr620252285a.74.1785324936085; Wed, 29 Jul 2026
 04:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com> <9fc0577e-ce2a-43fe-85ac-e382e930d5da@linaro.org>
In-Reply-To: <9fc0577e-ce2a-43fe-85ac-e382e930d5da@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 13:35:25 +0200
X-Gm-Features: AUfX_myQFTsRFeurmOduisqWnALh9oOceQK1Qw7einicpQvlHeEihgTLrOlfag4
Message-ID: <CAFEp6-1tvsg1gNHYwiyaBWqw2=bQazwRViN4ia3VHz9VWNOJjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NCBTYWx0ZWRfXxm5IY9vnQX1p
 6C5rVtdqMgULJNusuU9tNqByEwFE6v+1P4GbfbJRhSIHOtyhGbgLkWLQo/97RLyoSj9DQruudjl
 zXXWZj+ymkYOdyCdEceev8NL9RAAZEo=
X-Proofpoint-GUID: DjU6mzNA9-JmiicfkUQojWPHcHtZ8o35
X-Authority-Analysis: v=2.4 cv=XdG5Co55 c=1 sm=1 tr=0 ts=6a69e589 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hEHBz4w9bolPAqnzaVcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DjU6mzNA9-JmiicfkUQojWPHcHtZ8o35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NCBTYWx0ZWRfX8f2RLcLI12Wp
 teaodiqM86I2a+5G5d2gBN++2sPgQgicOBDGRAHgRhQ5WVu4o/yvKU9zBgCuUx47iYp2/w8auwH
 1AH34si7MKdEJER2zZNGD++rW/jbgXK0nZH5ndfhTvOrMH+Cs1VtnVWNkShvzwcB9jXLbsV08/X
 SM45a1tyX81YFDbBVzABatzwtscIPLJmxN6vmMa4GzkRgf1jILB3Yx9Yc9kSGTXtx8wsgQ8jHaV
 3gTeU47lHjkWn/JJPnD1PNMyNCGn2Q9KIfbdgwlKkmWtx57HL5zPv5PYRRFZ1oZDUANJGubfbqF
 JKsgoBejCL5Esr3Z2c1ByhfBffzXl3Ag//TBBSWziKK1HXnhyPb85w6Qahw3U01tBdy1N2PPS7I
 Ee3Ndnc+kQxtnjYLzGNpTx1YXPzB0K1yjsgZf5lt40CLwS0BK3Oyx29KMtjNP5YCSTnJKS4hD9w
 /etApf5kv5n/FoBl8kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290094

Hi Vladimir,

On Tue, Jul 28, 2026 at 5:58=E2=80=AFPM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Loic.
>
> On 7/27/26 12:21, Loic Poulain wrote:
> > The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
> > and were calibrated for a specific clock rate per hardware variant. If
> > the clock is running at a different rate the I2C timings will be wrong,
> > potentially violating the I2C specification.
> >
> > Rather than just warning about a mismatch like before, actively set
> > the clock to the expected rate, using the OPP framework so that boards
> > which (will) describe an opp table also get the required power-domain a=
nd
> > regulator votes for that rate. The OPP table is optional, boards withou=
t
> > one simply fall back to a plain clk_set_rate() behavior, so existing DT=
s
> > keep working.
> >
>
> Can you please share any deficiencies you see, if a regular mechanism
> of 'assigned-clock-rates' is used in dt descriptions instead of setting
> a supported clock rate from the driver? Or is opps mechanism supposed to
> substitute it?

assigned-clock-rates describes an initial hardware clock configuration
applied before probe, but is a bit unclear about when we should really
use it. In our case the CCI core rate isn't a fixed hardware property,
it's a software policy tied to the I2C mode(s) the driver programs.
The driver is then component that knows which rate a given mode
needs, so it should own that decision.

Driving it from DT means the DT author has to know the per-mode rate
constraints (effectively reading the driver) and keep the two in sync
(the CCI/I2C bus rate and the CCI core rate), which is probably why
several dts files got it wrong today. Enforcing the rate in the driver
fixes all of those cases in one go.

OPP doesn't really substitute the  assigned-clock-rates, we just use
it to describe the constraints/votes (power-domain, regulator)
associated with each operating rate (picked at runtime), if any.

> For instance qcom,i2c-cci.yaml example uses 'assigned-clock-rates'
> properly, in many .dtsi files (NB, but not all, which means for a number
> of platforms CCI hw programming is done incorrectly today) CCI clock
> rate is set this way.

Yes and that's fragile. I think we should remove that from the example.

>
> It seems to be sufficient to get the clock rate in probe, compare it
> against the supported clock rate associated with a wanted mode, return
> -EOPNOTSUPP if there is no match.

Certainly valid, but I don't think it would hurt to complement it with
additional enforcement in the driver. I don't see why the CCI driver
should be prevented from configuring its own clock. It has all the
information required to determine the correct rate and should not have
to rely on or trust whatever clock state happens to be programmed
beforehand. Instead of merely rejecting an unexpected rate, it can
program the correct one itself, which is standard driver behavior and
not particularly different from what many other drivers do.

> To get a better idea of my proposal please check this simple commit:
>
> * https://github.com/torvalds/linux/compare/master...vzapolskiy:linux-lpc=
32xx:cci-speed-modes

Thanks, I think I have a clear understanding of what you're advocating
for. While it does expand the scope of the original series somewhat,
now we've discussed it in enough detail, I've taken your suggestions
into account for the upcoming v3. Let's continue the discussion on
that version.

Regards,
Loic


>
> > Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> > Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> --
> Best wishes,
> Vladimir
