Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D23EF64F
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145557; cv=pass; b=X89cdPRrRAf63EtCADfrddwhs8Op6PnuSadRb2GABlV9J0aknjq7fDbzODrelKq9gaCc7v7MLc8L/kGW9KqHEe1Ad7FYoSwisIha9UiG4997uQmZNZVb8DlevFKr14/4p+wY6qRvHUvwNU4+KKxQZwO/nADwAHpAFp1Vgz4TmvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145557; c=relaxed/simple;
	bh=mu6tqP4n2BXyp1b7zDoOv2JB+eBkLWB/j7TibZCCzOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWZyC1psQsUY0RGR+jWggq7r3xt1fZrA269mLCv92d+7djxn44k0LhQhuLc5YA+E/3O8HgVcS5Dkhs9t1qDuTPOdcTn+OBSHkjffTJ8HsYpPjZrWP/l2ZXbwzbo5e+IsvSc3zudZjEZzwOmc1o4WBMQhJPRNFiG1OF9+4/i2YcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HzBdEgsM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g6Bb3YPR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzBdEgsM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g6Bb3YPR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9X4PA3646607
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9jIGX30jRJ785ZTPysrFlAseyWnVDAEU+wzUDkrCcO4=; b=HzBdEgsMhRbjIC3f
	xfKtcaVzUN9afYRVJ0X2TAOEtvTXOHaFNJYzXMKLcDYR+C5zjmEFJxc3vZmdCd4i
	IjK2PiXE5nY83QAE94sx4rMesrSZ1frtN74y0aQ31kcvwG0B0F9lLyGa3wHuc5lS
	ZP67vvA96uyVt0PUmfFmMVciR3x68oI5nTk/ohCcnWOz0BESf7a5Q6AZ1vF5OV7v
	kJ3KrW83tAU1uSz4K5UKKod6Di+t4g+rt048r36t10WsrzLyQJhliJ0haikvsP7J
	6znJg8Sl4gxmhMEo8/EQhX2dd1OpmCqdrH+xKxFCkrbSM+y1WFxyHtAcFuuEvkyk
	mscpfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c605k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:45:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5fc4c7e9so241361385a.3
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145554; cv=none;
        d=google.com; s=arc-20260327;
        b=TMvgPo7FUxz8/fN59JAMJ5Iqo4pxJ1oAPDn+Mtcdk7zEBgeGYZJzcf/BMbKnfie3eO
         Fh0iOvYY5KD7rih8TrRFJqCx/Of1D+ojX1er53NqSs5lPug15OoaF6y3S8OWWw7BfYgb
         RVhcVrllVJ1TPccvgqgNLwliTTpWqKwk18rAPBPAijVtqKdamD3UGERWGFrgV835nqsk
         a980GRvVGSBJvrWyMVesnftE5ZfwrJN8Nm4tXorbPLY4oJmmnfmsUH++bBQqJIHGPrW+
         tnJVna/efJ2RbzgT6k1OsIiOdtYSd9FpwB9PM7ksKqVIbaCV7RZjZefh9ukFee0GAKPg
         yGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jIGX30jRJ785ZTPysrFlAseyWnVDAEU+wzUDkrCcO4=;
        fh=hotlubr1MADvZ4Wr6bRn+rOD54Z9+otl6bnBIHb8wSI=;
        b=jMdkEyUy+ycYasIks51Naz0pX+/Nq8k+zKJFF4q4uJpFsOjbeSXMYw2twfM3TXCMYf
         TejAnnCaDkEoHGUjIrrUwCLpnuXRY/ULjWgkTgiiq1P8doPCeLit5ICp34MelUMgY+9h
         mgy1eOvnWQemlasFvcUllpgDQIj80BBFmEY/578apqn/AimIxSERXjEazwr2xaRlVpCB
         uJJNgTxmf7B6Z+RjwH70DzuLoXn0KOBrtTXZv44jQq+zQnglSSx2+e0p76LBSd1sQcI2
         1s2WrCt0qeYEA/k+e9kG3RqlHN/8Pit+WYqRx/e4oPL570Mplm9D0lswZPVc4kxzKVAS
         DkuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785145554; x=1785750354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jIGX30jRJ785ZTPysrFlAseyWnVDAEU+wzUDkrCcO4=;
        b=g6Bb3YPRWV6aHm+7ZgUJ1JdAUiCMSA82KozveVXeNzGFEFXeI8Px2EvBMFcJUFPcTn
         Wml8bsJPBG/PPB9b00njIKwWaZCn8V7sAP1vldNkGp/x3+PtwIwwSWNOBGg5MZ39vX82
         39wzd6quFoUfSeSCAxNKjvXhhq0bgGMt3JZi7g23eTmsHT/Gz0DM/92hfSsTD9Qq2dky
         eVZhetgBmdLTcRecc5+VY9Ongy4PvuniBb0T8wiRCv4xIg25s3wOYDQFQ7AoRv4LSIxX
         oUzFpDdmtWVwotv4hPAQjxmbcJAmCON9oQQtgW8djBoSdXbQSG0gJ/7iVlpcJ7rJr4cS
         q1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145554; x=1785750354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jIGX30jRJ785ZTPysrFlAseyWnVDAEU+wzUDkrCcO4=;
        b=M4QTu5e61DqEdVXd3irTNmRxf5iFW/weNeCmZrRFGLc0VcsObFEl3qnydvjGhkXDZG
         huezXsgA0QUeiA32IIshhfVB3q3Mh5G5ti347mZHwTiTs6t9g9XRgT8FcZeWye+EMYT1
         vj3KiM/D4H5GTLSKZFNzfn6c6zSBLbkVrqPPksWbJtS7xIzATj/M0bcpMLZ9fJG+7Urt
         TD3lbfWHo1gRJ0JgPQ+bTZGosgVSUpYAkw1mCKBQ+WqRyxgiX9R4/mJr9SgY4CIOBblx
         +m6275Ygs5lROtSP9nfuDxhOk9nZEJ26uEgtAGF1FmFQ8LPEHvGsEZjEg8DLdsMo0gxi
         U1lg==
X-Forwarded-Encrypted: i=1; AHgh+RrgjlIga9K4u25x3htFppqWhmXxGXd7QdSKZoVttouEXgpbxO3VFJH/E7+H+D15fodeA+fqKegAfGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5ITAElTxb7BRq4IYUs6bLVNZKMb6T+XCeBzQe/UxhB+wL0rN
	Jn9gsJi2olNyElPvb1yq/YsFTYaAeEfcLGhlnJVWg32JsbptzlXdFFU6EEhNr26qX28wYduIWxP
	jJW5Qyadjr+z5rkOTI9jWLUq7CY/nwi9782eofQIDZD7/MBTyjPBdKLDdf8NeOayITI/nFKGY/0
	HFlyok430sH4SgPxk87+rGAnhnsNQceaIRYLPRkWaDjjOQnINuR7I=
X-Gm-Gg: AR+sD10d6gxL8TK362biGlwSBBSESaf0fgA2/F/jJf0e3Y02NRsylmuLgYv041MNG89
	e4x76oitE0VDFOI5h6XRKH0MDEZskXVVMeF/WHsK6UtFQvELwtO1aVfFeWkh1nS7WiX75FDMumH
	trfLzn3pVEagbpt/oF73q3jlOt3q3XVgHYv0zf88oONN0QvJO9wA5ZKmloN3Ub9vu3qGUIBOIMN
	dmP2WFfprye6WASrpXi95PQRLc2LZ7So/+lawSfqfpDf2AoXd8Zuuyf7Y0r8QZj9KLTUJqriME=
X-Received: by 2002:a05:620a:44c8:b0:92e:81c8:3629 with SMTP id af79cd13be357-932df62587cmr784207185a.4.1785145554144;
        Mon, 27 Jul 2026 02:45:54 -0700 (PDT)
X-Received: by 2002:a05:620a:44c8:b0:92e:81c8:3629 with SMTP id
 af79cd13be357-932df62587cmr784205985a.4.1785145553714; Mon, 27 Jul 2026
 02:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com> <f127746a-6b8a-4146-8872-6790431b563c@oss.qualcomm.com>
In-Reply-To: <f127746a-6b8a-4146-8872-6790431b563c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 11:45:42 +0200
X-Gm-Features: AUfX_mxZgaPeOnTxeXUHF_4ciOWWT8hLwJofeT3LrHwQFFJFXXT22uksWDND3ao
Message-ID: <CAFEp6-0bZXmh-2+ZKujZg+vbJc4ZYzVOq9zXbsbDwVGz3XLBHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.zapolskiy@linaro.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a6728d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=t5tfKrHthdDDn-AfuNsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NSBTYWx0ZWRfXyezU1ATjVZsc
 1R1peqZ9bJ88YEfwc3EpUOOj38BRQXbvTt1hsrn7m9+Ck23U9rslYaBZo/6rbJNm/JWsJ90MmQD
 5LjW8e0M99G7xsqmkY2I7P2x4wSVAG0=
X-Proofpoint-ORIG-GUID: HOrGcUlYDk_wCeGkCLSJdqZaL32f2Mvv
X-Proofpoint-GUID: HOrGcUlYDk_wCeGkCLSJdqZaL32f2Mvv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NSBTYWx0ZWRfX0RRNtVeeRFHT
 RlvgXKeZfq2A1Q17RusxkaOy9b4QF9rj+83atITeAzf3KRM3XuBzVCQSbuMr3az/hm/VgHrNPls
 T2Dg5y7/xTZW/6TWKmwM4CFVqks3OKbMwVXiKm4LMOhO/S+LYt5HBxzkyBiwfe6KQyHw0zQWGj+
 76c3nn7Tu2m93uPPOK7C5/8pDJ/0eXz8WhD24880aKjsnEItiDuROknnOuO07R4Z+K8hcoc/qbu
 qjVw3q7EYCaTWmTUiG2Z3DzqgLQ2+nD02CRhgcq2cUsakMpo83O7Y0mjNdIeDqIFGONyTlgacBC
 E+aX+BL52ZqcI331zljdB8O/bGohHwXJ8ey9a2eJfACaWITre6VeNhJojPouz5q0CnxC2wjasav
 bbUcRUm4bC8GjgdJOmoKYuFyJwZRGvxIocJ83kHlSB2CY1uAo+fjbrpdY6A/I/V8E6+HYzvLmYr
 W4ffsIBJxPTnyy47RLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270095

Hi Mukesh,

On Mon, Jul 27, 2026 at 11:33=E2=80=AFAM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 7/27/2026 2:51 PM, Loic Poulain wrote:
> [...]
>
> > @@ -587,6 +618,24 @@ static int cci_probe(struct platform_device *pdev)
> >               return dev_err_probe(dev, -EINVAL, "not enough clocks in =
DT\n");
> >       cci->nclocks =3D ret;
> >
> > +     cci->cci_clk =3D devm_clk_get(dev, "cci");
> > +     if (IS_ERR(cci->cci_clk))
> > +             return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
> > +                                  "failed to get CCI clock\n");
> > +
> > +     ret =3D devm_pm_opp_set_clkname(dev, "cci");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set CCI OPP clk=
\n");
> > +
> > +     /* OPP table is optional */
> > +     ret =3D devm_pm_opp_of_add_table(dev);
> > +     if (ret && ret !=3D -ENODEV)
> > +             return dev_err_probe(dev, ret, "failed to add OPP table\n=
");
> > +
>
> if this is an optional why to return with an error ? IMO, further
> operations should continue which are not opp dependent ?

The OPP table is optional only in the sense that it may be absent,
that's the -ENODEV case, which we deliberately don't treat as an
error. If a table is present but malformed, or can't be added yet
because a required resource isn't ready (-EPROBE_DEFER), we do want to
report/propagate the error rather than silently continue. This is the
established idiom (spi-qcom-qspi, qcom_geni_serial...).

Regards,
Loic


>
> > +     ret =3D cci_set_core_rate(cci, cci->data->cci_clk_rate);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set CCI clock r=
ate\n");
> > +
> >       ret =3D cci_enable_clocks(cci);
> >       if (ret < 0)
> >               return ret;
> >
>
