Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CA43E071
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824076; cv=pass; b=dB01epD7f0gsgqBIezj66Gt2/SnDJyrC/n5fFI7OnbFz050wIAZ6WEUBknDqUL6DLS7TG2IRiDgu733FD59THswO0uXx9cND2Won15L5wxCxdJ0I6lZVkhIlC3tyYO/jkzvTOSGWKOxpxKcflWD68y9iRfI0QyaYAcY76X4S3z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824076; c=relaxed/simple;
	bh=JuXzEHuVQBfgdRJHtLy0w8Tm/hLDg4z8iSiFl2XZ1fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLIhHwoQ7h2raQwtvC3AFwxazVYzNOEYxZ0MDo3Q6WGkw7+jVVJw45crmyyW147LRMFprufvSQs5warRwn/tIW2HYLXDGn84jdQBEWhwp9WdE7Ze8X0o+FQAg/AWT8ALskkykEOTb47H/NhUEli4l96yCCmy/OHg2tHjxhsksaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PUzvhR0j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MgffUWdw; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PUzvhR0j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MgffUWdw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9I4PW2462387
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lDpP6XgjloxhoC88JAns/FHOS4c40trZCa7Vj/8tlj4=; b=PUzvhR0jD9gUh7Rk
	Je/0nWJsjrzn6iimDNy601rNYowVPq6nycIq2Od7ioz41vRVqjHwG/ttB49Udxag
	QAyEKNq3MI96Tp4rQ2CAud3VR+YxjzKM42aco9keyjiCTgtgVCHbWLOWe9CfUqL8
	5Y7WJy6RpeYEXMQtOBgBCR0pEMruVD5X37iDb5zNUOOhZMaQWeVbw4O5kXCQuuB4
	YZ3BE0fdcvnVyh8OpRzCihQkM8bSlFHMBfU3THJlSuOfhx35z7EErBG+DcsBTI39
	QsHjw+TIcDPhi64DSNcHR/DCphiY65cQjH39VUnGNvPX1hWejbnpBB+NBAmBtEls
	o5crwA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhxgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:47:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90c8d271ac9so37760666d6.3
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 02:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787824070; cv=none;
        d=google.com; s=arc-20260327;
        b=cY6GTa2jxvsSVWL9HaV3hPVlSd4pRtVUtN0dqsSzM0bA9GutF/vwpS6T+0nZzTAtdy
         qsW+LjaX5REoX2jr0bYRwhOO6kfiobtc7aBpS1WjjDij1y4otwKXQX6ErVWm/8zEJQZy
         doAfivJ02kY/ArDFYlmNMaFV/Z7cE+KZUNvmBSNTJuOpUO+USD6IYPmk/gT/0ZszZZux
         Cm59inVP2+qCXLqQMhKrgl9TVKBsWc5TOKNvWs3vWJVd3BiXieDOcZ71jVJiA/I8rUsl
         aQEdS9n28Pgoj6IdRMCdplr6IUVZDByjI5PdxGa7Iuq1Z1028cZg4wex+LegXe8mZQ3G
         bbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDpP6XgjloxhoC88JAns/FHOS4c40trZCa7Vj/8tlj4=;
        fh=OyOEGku79bkHHeePF/DHzhOsjIIznXwSbXj9A7uOu20=;
        b=sx1/JPDOBOwyHtHqocUIo57ai0+sGBU9ElX1UQ+1tfij7eyyv+6MAfGHbi8SuA/krr
         McfXUPKYT7n0DWQOD5QZsdHlPqFLz26pylQf7pC7gVfZWcYhaoBoUxLwZdKLqYCIkGrb
         568fB6SHHe4av5GnCRpUj/QcfNm/a/jtkSL4YuVbp1FmpV/o3zzuVQLsP/mUne2sFkFs
         ljMd+01gjIWEDe1ehTWSNLXws0MFGGrAwvVl3opW0SJuAIo4zrgosICs5W7g5yblTWqI
         pGzLBmryrPUxy/tK8EmPA1zp/zF2dE4LpALAB4OPe/IWybY+BzzloKIvdzGXxM0Ue7hZ
         YxjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787824070; x=1788428870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lDpP6XgjloxhoC88JAns/FHOS4c40trZCa7Vj/8tlj4=;
        b=MgffUWdweD99kE+HlkZ9FPJl3FGJBnEOZnVYw8tZdVDw+QF/8WfglhDpAFDcFHGpFn
         GD8lqz8ojTddhJo+f+Rr5clHs9TL+TqMFBb05W9givCE5aoCJFT0zgbaIaIMl/tbY7oP
         hi6DLHdwmEXqN/J0Vh2w+Y/S0P/KZ2z0gnETjoWnjSK4gpIanZ2ioopA7iKD2xC61GY0
         iYUBBTuJ/NSqpkItUiwuS+cw8HKFFiOxQ0ADvKc9E05Do/BSsFpF2u9JxS1c8BQINlIG
         +Ow2Dnnt88IzVbJS8XskMBaCKosy7EAQo1HXyR+fC7RwOsDqRuIZetWZFCyOopvScpSE
         IrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824070; x=1788428870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDpP6XgjloxhoC88JAns/FHOS4c40trZCa7Vj/8tlj4=;
        b=Nyc2VJzQoldTtGJJTOvpeXtD6Xo2a/SvpNpSPy2veqGs62HpSp7iXDP5o+v1rsJ0Of
         0t4+0xtH7A1/b4ufwtzFv4gANQzLNErwt+bSbJl2xDgSh7HTVvc1kdk6LvdChDXfnYFX
         GV5CI+mc+pZJ3k+spWmpo4w6ct1cTW52RMRMCg6zwXBHzOlpIwKU1XS5CvPgX6C0Ep+A
         yIhmfFIOLBbjATEVP3zMLQKA2zQ2fDVYKPUK8Yq0y3hcP6ccbqzuDe1It8Vjl43s8Bom
         4oSnB2IvMF7Rj7jntulZY1H6iTWWxQyCDMEHqMml+Z1bQ56R663jiRJCzRYXqfNIHu/z
         2xIw==
X-Forwarded-Encrypted: i=1; AHgh+RpZH/LickVf3pbd1RHkrUdka5mGI9UMgq4pQpkOlgr9uBTQH7F6Pk9I1JEUKqY6cHcuavTtDqlpA94=@vger.kernel.org
X-Gm-Message-State: AFuF++nKROI2To9+pyElhEXtCZB3rCbiTWEX3BTdCrdeDOze/xTIZIE8
	kRLujqJu6e15l1Q/oxbf2FYzID4nhuvyv80xbOLUtYB34LkZjzApAnGjWqKf2p5IQmPdCq7lUOl
	G+WJRRtJfBMFOyH4HHoIgTEAtZgX7j9CBOZn1DHYNzulyyDq7bdhGz2JOLiUbtOvBeKYnwMczx+
	Y0qL/CqGb0AFC2k4WJmOuRtM7jJ1MDg02nvSN5+A==
X-Gm-Gg: AR+sD114QHbly0guW7lyQWWVX9ZvFF/XzQDp9yS+A4bPUIEABbkIlHQLimbNmZCsoeF
	lZYatrWKuLsbJaCWvARK3eqmNTaCg76QidwflHYH6+61PDXOiFHzNkmNRmJaQlKgvOs4S+50EjT
	L8zcaf5WQy1apP3SxUsRFcRTkvmP/L5aXoYMrH2glvYwBQnr+B69LN3TiudD5NyhZIp1sQcYWFY
	8rW+YuVTTSzbWOb7year1uJ3LtE5XYKdnWdGpynuedHzKQAjh73tRtoLeA5ZpU450aOXMqm4Cg=
X-Received: by 2002:a05:6214:3ca0:b0:8ee:f531:4de4 with SMTP id 6a1803df08f44-90cc79641d9mr158390566d6.13.1787824070127;
        Thu, 27 Aug 2026 02:47:50 -0700 (PDT)
X-Received: by 2002:a05:6214:3ca0:b0:8ee:f531:4de4 with SMTP id
 6a1803df08f44-90cc79641d9mr158390086d6.13.1787824069678; Thu, 27 Aug 2026
 02:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com> <8af313a1-5f7f-431f-91f6-9e22119d456b@linaro.org>
 <CAFEp6-10Dz8EJjMNrM0FPHwmaMr2ownKLBh2=F70PmkFn9Ke2Q@mail.gmail.com>
In-Reply-To: <CAFEp6-10Dz8EJjMNrM0FPHwmaMr2ownKLBh2=F70PmkFn9Ke2Q@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:47:38 +0200
X-Gm-Features: AcwNN1WuJAB30amocG5VJk_kLO135Ov3JmmsPFeNi-Nes1kxU2WiNZbVDs65lpE
Message-ID: <CAFEp6-1GCa2t3wBznoF-HnmtNCUSsshnWnrv8O6R2_06KqgKQA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] i2c: qcom-cci: Share the timing table across CCI revisions
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4MSBTYWx0ZWRfX4YrMveZqbkx8
 Z08T0AlpKU+ZjpGcZ4Hqc8NzHKItJ/5m8aAx67TNEhiUutMCt6kDQs900ETGBRvGq8+5cIeev/N
 1F2D2++et2wI7uT3iPE5dWxH4f0ZaTZEeJ+OXVnXLeSLQMwJr6oOiYKZLdaklkG8/qvJqhJ2XNC
 BriHT4Zwyyx/5JpoGGGGx7690sEAXEulYkNF6jySfrokQGSvNnNZ8NyZtAJL7xyu0FtL1x7V7X4
 G9sB8DV71c8+pwI3+eKMWFnJNVu/iUJw0c9RUQJHitlHdqk1Ee439qy0aIrjXUTQG+dfiYiNI3p
 kh2jmnQkE+3BQS3qWWXfSOCP8EZPyBnpjhiYNPjw+/Vx04RW0X01VeHXInmZjFavPqXxJ5ZNFMe
 gcvkxxfK5uTon9RucrJdoQS+fZtZXLFygA6jL456WOCA/skUxXn77aMyx31wXBwi7W/anPzhzNC
 rl8ohOBDNIpW1y6ralw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4MSBTYWx0ZWRfX8jPGzyzcV9Qv
 z7w/n/cSht3Xr/X1Z7HovjuzQsG9olep1khdwOX6VjP0dFAojJb2V+KCf4Ugjf9pe9wBQMbdSq/
 EpnuX87aagxbSzk9LhTKXhM3Se7we90=
X-Proofpoint-ORIG-GUID: inddYwPUiFugmAEFbgG3olrx6oIFnSxt
X-Proofpoint-GUID: inddYwPUiFugmAEFbgG3olrx6oIFnSxt
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a9007c6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=kM4g01ekgB1IreEBXJAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270081

On Thu, Aug 27, 2026 at 11:31=E2=80=AFAM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Vlad,
>
> On Wed, Aug 19, 2026 at 1:31=E2=80=AFPM Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org> wrote:
> >
> > On 8/1/26 23:10, Loic Poulain wrote:
> > > The hw_params timing values only depend on the CCI clock rate and the
> > > I2C mode, not on the hardware revision: every per-variant table used
> > > identical values for a given [rate][mode]. Only the set of supported
> > > modes differs between revisions.
> > >
> > > Move the timings into a single shared cci_hw_params[rate][mode] table
> > > and describe each variant's highest supported mode in cci_data with
> > > max_mode instead of duplicating the timing values. This removes the
> > > per-variant timing tables without any functional change.
> > >
> > > Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >   drivers/i2c/busses/i2c-qcom-cci.c | 181 +++++++++++++++------------=
-----------
> > >   1 file changed, 70 insertions(+), 111 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i=
2c-qcom-cci.c
> > > index b6fa37a306758ec33ede6fcc39ce4412b86d9a84..21695c744502f7fb5d333=
f1272f3771e4d9d5508 100644
> > > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > > @@ -124,7 +124,8 @@ struct cci_data {
> > >       unsigned int num_masters;
> > >       struct i2c_adapter_quirks quirks;
> > >       u16 queue_size[NUM_QUEUES];
> > > -     struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
> > > +     /* Highest I2C mode supported by this variant. */
> > > +     u8 max_mode;
> > >   };
> > >
> > >   struct cci {
> > > @@ -249,13 +250,76 @@ static int cci_clk_rate_idx(unsigned long rate)
> > >       return -EINVAL;
> > >   }
> > >
> > > +static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I=
2C_MODES] =3D {
> > > +     [CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > > +             .thigh =3D 78,
> > > +             .tlow =3D 114,
> > > +             .tsu_sto =3D 28,
> > > +             .tsu_sta =3D 28,
> > > +             .thd_dat =3D 10,
> > > +             .thd_sta =3D 77,
> > > +             .tbuf =3D 118,
> > > +             .scl_stretch_en =3D 0,
> > > +             .trdhld =3D 6,
> > > +             .tsp =3D 1
> > > +     },
> > > +     [CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > > +             .thigh =3D 20,
> > > +             .tlow =3D 28,
> > > +             .tsu_sto =3D 21,
> > > +             .tsu_sta =3D 21,
> > > +             .thd_dat =3D 13,
> > > +             .thd_sta =3D 18,
> > > +             .tbuf =3D 32,
> > > +             .scl_stretch_en =3D 0,
> > > +             .trdhld =3D 6,
> > > +             .tsp =3D 3
> > > +     },
> > > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] =3D {
> > > +             .thigh =3D 201,
> > > +             .tlow =3D 174,
> > > +             .tsu_sto =3D 204,
> > > +             .tsu_sta =3D 231,
> > > +             .thd_dat =3D 22,
> > > +             .thd_sta =3D 162,
> > > +             .tbuf =3D 227,
> > > +             .scl_stretch_en =3D 0,
> > > +             .trdhld =3D 6,
> > > +             .tsp =3D 3
> > > +     },
> > > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] =3D {
> > > +             .thigh =3D 38,
> > > +             .tlow =3D 56,
> > > +             .tsu_sto =3D 40,
> > > +             .tsu_sta =3D 40,
> > > +             .thd_dat =3D 22,
> > > +             .thd_sta =3D 35,
> > > +             .tbuf =3D 62,
> > > +             .scl_stretch_en =3D 0,
> > > +             .trdhld =3D 6,
> > > +             .tsp =3D 3
> > > +     },
> > > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] =3D {
> > > +             .thigh =3D 16,
> > > +             .tlow =3D 22,
> > > +             .tsu_sto =3D 17,
> > > +             .tsu_sta =3D 18,
> > > +             .thd_dat =3D 16,
> > > +             .thd_sta =3D 15,
> > > +             .tbuf =3D 24,
> > > +             .scl_stretch_en =3D 0,
> > > +             .trdhld =3D 3,
> > > +             .tsp =3D 3
> > > +     },
> > > +};
> > > +
> > >   static const struct hw_params *cci_get_hw_params(struct cci *cci, i=
nt mode)
> > >   {
> > >       unsigned long rate =3D clk_get_rate(cci->cci_clk);
> > >       int ri =3D cci_clk_rate_idx(rate);
> > >
> > > -     if (ri >=3D 0 && cci->data->params[ri][mode].thigh)
> > > -             return &cci->data->params[ri][mode];
> > > +     if (ri >=3D 0 && mode <=3D cci->data->max_mode && cci_hw_params=
[ri][mode].thigh)
> >
> > This earlier introduced sanity check for non-zero 'cci_hw_params[ri][mo=
de].thigh'
> > is not needed anymore, right?
>
> It's still needed. max_mode captures the platform limitation, the
> thigh check captures the clock-rate limitation. E.g. we don't define
> Fast+ params for the 19.2 MHz entry, so the two checks aren't
> equivalent.

Maybe I replied too quickly, you're right. cci_get_required_rate()
already rejects any rate lacking a valid timing set for an active
master's mode, so the check here is redundant.

>
> >
> > > +             return &cci_hw_params[ri][mode];
> > >
> > >       return NULL;
> > >   }
> > > @@ -696,30 +760,7 @@ static const struct cci_data cci_v1_data =3D {
> > >               .max_write_len =3D 10,
> > >               .max_read_len =3D 12,
> > >       },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > > -             .thigh =3D 78,
> > > -             .tlow =3D 114,
> > > -             .tsu_sto =3D 28,
> > > -             .tsu_sta =3D 28,
> > > -             .thd_dat =3D 10,
> > > -             .thd_sta =3D 77,
> > > -             .tbuf =3D 118,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 1
> > > -     },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > > -             .thigh =3D 20,
> > > -             .tlow =3D 28,
> > > -             .tsu_sto =3D 21,
> > > -             .tsu_sta =3D 21,
> > > -             .thd_dat =3D 13,
> > > -             .thd_sta =3D 18,
> > > -             .tbuf =3D 32,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 3
> > > -     },
> > > +     .max_mode =3D I2C_MODE_FAST,
> > >   };
> > >
> > >   static const struct cci_data cci_v1_5_data =3D {
> > > @@ -729,30 +770,7 @@ static const struct cci_data cci_v1_5_data =3D {
> > >               .max_write_len =3D 10,
> > >               .max_read_len =3D 12,
> > >       },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > > -             .thigh =3D 78,
> > > -             .tlow =3D 114,
> > > -             .tsu_sto =3D 28,
> > > -             .tsu_sta =3D 28,
> > > -             .thd_dat =3D 10,
> > > -             .thd_sta =3D 77,
> > > -             .tbuf =3D 118,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 1
> > > -     },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > > -             .thigh =3D 20,
> > > -             .tlow =3D 28,
> > > -             .tsu_sto =3D 21,
> > > -             .tsu_sta =3D 21,
> > > -             .thd_dat =3D 13,
> > > -             .thd_sta =3D 18,
> > > -             .tbuf =3D 32,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 3
> > > -     },
> > > +     .max_mode =3D I2C_MODE_FAST,
> > >   };
> > >
> > >   static const struct cci_data cci_v2_data =3D {
> > > @@ -762,66 +780,7 @@ static const struct cci_data cci_v2_data =3D {
> > >               .max_write_len =3D 11,
> > >               .max_read_len =3D 12,
> > >       },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > > -             .thigh =3D 78,
> > > -             .tlow =3D 114,
> > > -             .tsu_sto =3D 28,
> > > -             .tsu_sta =3D 28,
> > > -             .thd_dat =3D 10,
> > > -             .thd_sta =3D 77,
> > > -             .tbuf =3D 118,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 1
> > > -     },
> > > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > > -             .thigh =3D 20,
> > > -             .tlow =3D 28,
> > > -             .tsu_sto =3D 21,
> > > -             .tsu_sta =3D 21,
> > > -             .thd_dat =3D 13,
> > > -             .thd_sta =3D 18,
> > > -             .tbuf =3D 32,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 3
> > > -     },
> > > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] =3D {
> > > -             .thigh =3D 201,
> > > -             .tlow =3D 174,
> > > -             .tsu_sto =3D 204,
> > > -             .tsu_sta =3D 231,
> > > -             .thd_dat =3D 22,
> > > -             .thd_sta =3D 162,
> > > -             .tbuf =3D 227,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 3
> > > -     },
> > > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] =3D {
> > > -             .thigh =3D 38,
> > > -             .tlow =3D 56,
> > > -             .tsu_sto =3D 40,
> > > -             .tsu_sta =3D 40,
> > > -             .thd_dat =3D 22,
> > > -             .thd_sta =3D 35,
> > > -             .tbuf =3D 62,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 6,
> > > -             .tsp =3D 3
> > > -     },
> > > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] =3D {
> > > -             .thigh =3D 16,
> > > -             .tlow =3D 22,
> > > -             .tsu_sto =3D 17,
> > > -             .tsu_sta =3D 18,
> > > -             .thd_dat =3D 16,
> > > -             .thd_sta =3D 15,
> > > -             .tbuf =3D 24,
> > > -             .scl_stretch_en =3D 0,
> > > -             .trdhld =3D 3,
> > > -             .tsp =3D 3
> > > -     },
> > > +     .max_mode =3D I2C_MODE_FAST_PLUS,
> > >   };
> > >
> > >   static const struct of_device_id cci_dt_match[] =3D {
> > >
> >
> > --
> > Best wishes,
> > Vladimir
