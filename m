Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793867844;
	b=iMIzJCLe+ZVEJXSRWLrytTWtWwk/IwDWDgBi3FzMo5SiVeQd0tI6qF53dS53cSgnu/Iz
	 ICPrvrK2KjMMWMDG026AeTrLNEgTS+ig3r+20advtGRxj/sWaEyTj/5dPo8lDZbDdD3Q7
	 5ocFX85S5scqSslXlEAhcYqO7bWSpEzpZ4dmabcL6QIsKlPYQeSHCdwfiRfv1PzUzS8dS
	 mRxbQRhZWSj5IV3VOg51BPpPM5sC9tpDNIRWIDGOEhvIJIj0pulWWw0RWGoTvriBAj5KD
	 oFpq9DMR+Y3lfTm64ZuLPVsbf8Sg+gsflp9dARlJ5ddhtYkbrrZnfka1NlbFagtgxSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867844;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=J20C0Q1ik5zVeSf4dk91N9VOzLrxCbR2J+L4l8jiJe0=;
	b=HRBCnHCp9GsSJxZBcK86Ca+matH5Fwf2LfqBouUFaZ/VB7KFJlEPLqWskz52oiS38Jyb
	 AprdAPKFGc6yxFAWZ8+/zx2I8ncGIPqwwgOEYMuQOiJXsW1e+ytXOxj/DM71PlKCbm0Ri
	 ZMaUEV2oeA3pcWzi13z65O0lMxlQYbkmTb3lTiXXY10Sd1a1XOds/ujBUbABKVDDaxAMN
	 UbGE6A/iYqrff/fE1NYWD1kGZxcYBMh1tB9awR4GlLRS9OiJm/EHa/tdSHUNcDBUjasM4
	 xUHpSliR1Ni/X2s3DcI9p1iPum5ysRicGc7qSL7Z5WbLIIa1qwsWyjSRolige+2uvYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMDyDbB0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="c/U5PgmB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A34606A326
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A34606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMDyDbB0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c/U5PgmB
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56TtvM3073284
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 08:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J20C0Q1ik5zVeSf4dk91N9VOzLrxCbR2J+L4l8jiJe0=; b=cMDyDbB0LgxiaTW8
	cM7R6wjoaEqsXSsiAQu8qE7hEnNM0+BtlesvfzAVxSCPM+oGVsNriN23eFgMnPYl
	voJ07Gty+6y4OOWnUYpQ2VrFSMmVOjDPT+6iTqxmz5D17WkAfyxDlF0KBtz5P1vd
	1cAPpbEpiXU2smRTebOQdtL1WmEGjCbaBplFxK/A8WSKSjy9M+liyzclLVlQNUIf
	r0Pwe0Pmmqx5irb4ayKt2TUojynAEPzMgPpr5jz16DAq34Wlere+HjE9jAJXt86P
	RRTf8e+QNaXcCFGUARXbrqs2535xcV5F9b8bX6w5bQRPa6njwtr5I5fAdE3Lle4d
	MEZ+zA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq8pfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 08:37:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so345628785a.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793867842; cv=none;
        d=google.com; s=arc-20260327;
        b=U58AbNu0L5U/Z//pM9An0fJZGLMdAFuy2zf6A4gmPmltHycpj2E4LmuI71PJXtep3f
         9CKp23B/s1zU5zUU2bvEbVb6t8S6Erpw55dFicpabTbpqrZPT1E1dcVNre97kPSK78Uc
         G4cwuRTFwbWHJq9QSdjlWHfayVu0nGjw5AKEhEbFKFEyM+WQVC7Yo0p+1GU6xW8abKc3
         /GeweQd0qaqxRNYVmYQd1VV08FgL9v/zaa7tAEgGOhE283DZv5IQSDCiRkQu/2iYEeBM
         UZAP60oMt8j15KkshpbDxAtUFxZFeg6RSfwfcbQHfYV4OsQVzJi0DD8i6m0ZwQLXmQqd
         sbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J20C0Q1ik5zVeSf4dk91N9VOzLrxCbR2J+L4l8jiJe0=;
        fh=TREuyjs402082kimk+OGZc7WH4RJkkTctF/yEyLLvpU=;
        b=rlJrNyORVlo+KiMUYnz3aR6NEunyvQCi25YW0Q9k3tqGcJ3CYvSIJo94U6ctYsnyIK
         yK609YdjNS8bzEdiWHQLfSirB+kK4mglOt2Sr8O8XVvXf/7JL/Nf/HYVtiAViJiQ8lDX
         qiX9VL+RHcWn27E8pcd/g4uW8/SWXLyJoJBk//fULRYG94Xl37iIXbAj2NuOQ9xfczqz
         l1BazDFdvzGIGQXOelHjj4xmvLBcF4if/3Vdt/MCCHjjo8K13MRt82bVNIjaGokijzIi
         8drpLAMWTF7Jl/MgB68gz7F5ok+30YBGXw+i/X8J3opa5JSicS9w7wCnbPvmXtlHJqjX
         tmmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867842; x=1794472642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J20C0Q1ik5zVeSf4dk91N9VOzLrxCbR2J+L4l8jiJe0=;
        b=c/U5PgmBuK1v+xeiJm9605kgGCQHj7G7pqrwFRHuX5cyPzUMqArUWMPyZSwwgbuYZk
         dcaYC1VgundSk33L5ycO3u3+KtTib9fASFRmYSitJR7scgMq9oO5+gI+2/cdu8xO22nL
         SsyMgUmQBQwdciq18MbMTbg3VsWyWWGmDkPeYdJ+vDPEuDove6VwiGQqlx7A+hQHQ/jA
         wBWrTpE1nSwd56TyQCRnSXgw5tpcLXXGEjXwJ+pzzfmyayIGiDqsSOWTNTXfJ/5vig30
         d4ZXJybSpn7sLOAsejjZu7OmMyQmo0oHef+kCh/0K0yOkDC1CbDJZhyudJqFC6OYcs4A
         bOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867842; x=1794472642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J20C0Q1ik5zVeSf4dk91N9VOzLrxCbR2J+L4l8jiJe0=;
        b=nxyOk/guZbGvic1La9JEVSS8NIk8u+wahBJUMIC9LxpFI+PgfPvJwQ/f263kcAGrnx
         ToSTIi8HgbID1726eNjo+44K2ItKtZ1wOY7z/AD5N8pR44G3diHWUWIhA1ggWZWri2WK
         cvspvXSEMswpKBOOlQqHDynvX5Ap+mXUenC3G6ect6BF9eFzIZpNLysOxIp24kGFfGhs
         O4+4L6j/pZAz/wX+GXvOalCi4ptX6Emoq+8glCRCusaBVkuwfkQdCB2V3579UNV8j5D/
         VxtvH7xs5nWJDjHtbs4ppZKU7rH8rlBI5QCplo2ohbXtFGG6/OpnGFI7fPQh4Vg9hegn
         USIA==
X-Forwarded-Encrypted: i=1; AKwUvBy3dERx2xZ+Hl4ZtWcnaZT+afKXg1nxh/xjsGXjSZYb5UMxSuqFjdrwFz6AGLVNi5gkUVLSaoAOV4c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ldrVg2TCZumGDkjfBzbSGQ3a75WdRFhlKjo2X4i4GgPvO0eqA
	YxwUqYVo39EHSj1BODUw1/NmjQdvjouup1wIwcrkyGf0goZoFr4rKiyncuH9elftYAEes2fkrXQ
	t4BX8Revwigg5hLmUVvX0SkuuYxZ07bqzHP8URBhUFWAUluezeUo/x/2p0ym4RHwuyo5oZ9s4LK
	mRtJV0lm355ZSzHORab1fEgghRkdjD5CwrLYaZxA==
X-Gm-Gg: AYBFou0dkRSszZNtM1d7fWLTAYoKPojUqi7JocSY9j2SmwosXCWHaYAmurO9TSM9aSL
	TH5/EUCqegOSjojy/wPvwmU/p04EoHnO5IZ0mX+qBb8oji14Kw4kAOE1RUasORW53p66D97PRJB
	rykoh7zcFKHazs5WiQC7MG9wkctDqdyWMLqokBmtI7tFxNpPoHu5Gb6TiKSyk5/2tFVo/fy4iRH
	pBcuebQKoiJ/FWHtmSWsHX2875rFpvfWkRoWtw6nqpnXNzu4D/GldHa7AnTcJXzw+wyQVlKFMc=
X-Received: by 2002:a05:620a:4109:b0:940:f2d9:5f51 with SMTP id af79cd13be357-9442156a727mr3192324585a.12.1793867841553;
        Thu, 05 Nov 2026 00:37:21 -0800 (PST)
X-Received: by 2002:a05:620a:4109:b0:940:f2d9:5f51 with SMTP id
 af79cd13be357-9442156a727mr3192322085a.12.1793867841058; Thu, 05 Nov 2026
 00:37:21 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104230529.3040285-1-vz@kernel.org> <20261104230529.3040285-3-vz@kernel.org>
In-Reply-To: <20261104230529.3040285-3-vz@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:37:07 +0100
X-Gm-Features: AclHuK-nN5eoEkZP-jg7XLdtYcXHlRVNa3PnAeXUUZCqyZmoNrEFWNQhhqo9cK8
Message-ID: <CAFEp6-3x9P7Q3+RESpMo7mKNYqn6ed0XswSJhhr1nFyHg-w22g@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add CCI device tree nodes
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX2dAwt6RDcYAx
 T23OTN8Em9f0W4TRaa4vlcA7ttAVALaLYPBx/2dUlTyWhp4IbkyC2xmu9q8dygS+3LZ7PQHX+13
 z6WHQW3KIFdj5ZUH5zOpouwmyDRCRkbB0GFGwfuE6L0tBc6CQE21WCAZcebZd0ACc8IhkC3i6m0
 BlHiWb7xT72Gi7mSJV9wp+VLjnGCy3davAKR3LhB9TtZtYQEp2IDEsvzSHp9oF6Yyw4SYjhbiEp
 0TuFxlz7OQKNwvHaTH0cqJsVsqYrYhWDLNNgkm6k5207gNiMGBRuTlsS9gIrRhUsD+CztXcWv1S
 OFFH/+dlNFQFOKEDibmwpR9svSBd9COu5lbgzduBy0v/fEFM+D2vRAra0cpuI0dOATqMFgCn7PR
 nHAcKiLG9CsaS+sIi7QW7EJ/vfk4bpq2hnIr89/enBqrrhTocJgzSn6cBDvU0PQ+owgnzdQ4Nib
 i/l8X7m2GMwyg+SfPVQ==
X-Proofpoint-ORIG-GUID: 5KWOfsPRiTUgA3wskYnXcizyts5RsAar
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX4DlwRv5WQTjR
 eKp9tIFYXJ5AUD7nVTLh6uj2kJf/P3e3bxlfx2rJuOyKtltgYf+i+C7c4TMk+1Lwf4XtyYvHMc5
 9b83Ujf07aaHP0x+4f8o7IECrgllrmM=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec4042 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=PI_Vn2BwocxK6LkTr5cA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 5KWOfsPRiTUgA3wskYnXcizyts5RsAar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050034

On Thu, Nov 5, 2026 at 12:05=E2=80=AFAM Vladimir Zapolskiy <vz@kernel.org> =
wrote:
>
> Add Camera Control Interface (CCI) controller device tree nodes and pin
> configurations of the I2C busses to SM8350 SoC dtsi.
>
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 147 +++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/q=
com/sm8350.dtsi
> index a51942c99f8a..41dff3736061 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>  #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm8350-camcc.h>
>  #include <dt-bindings/clock/qcom,sm8350-videocc.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/firmware/qcom,scm.h>
> @@ -2830,6 +2831,88 @@ videocc: clock-controller@abf0000 {
>                         #power-domain-cells =3D <1>;
>                 };
>
> +               cci0: cci@ac4f000 {
> +                       compatible =3D "qcom,sm8350-cci", "qcom,msm8996-c=
ci";
> +                       reg =3D <0 0x0ac4f000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>=
;
> +                       power-domains =3D <&camcc TITAN_TOP_GDSC>;
> +
> +                       clocks =3D <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
> +                                <&camcc CAM_CC_CCI_0_CLK>,
> +                                <&camcc CAM_CC_CCI_0_CLK_SRC>;
> +                       clock-names =3D "camnoc_axi",
> +                                     "slow_ahb_src",
> +                                     "cpas_ahb",
> +                                     "cci",
> +                                     "cci_src";
> +
> +                       pinctrl-0 =3D <&cci0_0_default &cci0_1_default>;
> +                       pinctrl-1 =3D <&cci0_0_sleep &cci0_1_sleep>;
> +                       pinctrl-names =3D "default", "sleep";
> +
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       status =3D "disabled";
> +
> +                       cci0_i2c0: i2c-bus@0 {
> +                               reg =3D <0>;
> +                               clock-frequency =3D <1000000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
> +
> +                       cci0_i2c1: i2c-bus@1 {
> +                               reg =3D <1>;
> +                               clock-frequency =3D <1000000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
> +               };
> +
> +               cci1: cci@ac50000 {
> +                       compatible =3D "qcom,sm8350-cci", "qcom,msm8996-c=
ci";
> +                       reg =3D <0 0x0ac50000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>=
;
> +                       power-domains =3D <&camcc TITAN_TOP_GDSC>;
> +
> +                       clocks =3D <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
> +                                <&camcc CAM_CC_CCI_1_CLK>,
> +                                <&camcc CAM_CC_CCI_1_CLK_SRC>;
> +                       clock-names =3D "camnoc_axi",
> +                                     "slow_ahb_src",
> +                                     "cpas_ahb",
> +                                     "cci",
> +                                     "cci_src";
> +
> +                       pinctrl-0 =3D <&cci1_0_default &cci1_1_default>;
> +                       pinctrl-1 =3D <&cci1_0_sleep &cci1_1_sleep>;
> +                       pinctrl-names =3D "default", "sleep";
> +
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       status =3D "disabled";
> +
> +                       cci1_i2c0: i2c-bus@0 {
> +                               reg =3D <0>;
> +                               clock-frequency =3D <1000000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
> +
> +                       cci1_i2c1: i2c-bus@1 {
> +                               reg =3D <1>;
> +                               clock-frequency =3D <1000000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
> +               };
> +
>                 camcc: clock-controller@ad00000 {
>                         compatible =3D "qcom,sm8350-camcc";
>                         reg =3D <0 0x0ad00000 0 0x10000>;
> @@ -3348,6 +3431,70 @@ tlmm: pinctrl@f100000 {
>                         gpio-ranges =3D <&tlmm 0 0 204>;
>                         wakeup-parent =3D <&pdc>;
>
> +                       cci0_0_default: cci0-0-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio107", "gpio108";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;

I had similar comments on a different platform, but why pull-up here
(for SCL/SDA)? Do we expect boards to lack the external pull-ups
required by I2C? If not, enabling the internal pull-ups seems
unnecessary. Also, what is their effective resistance on these
platforms? Aren't they typically too weak to meet the rise-time
requirements of most I2C modes anyway?

> +                       };
> +
> +                       cci0_0_sleep: cci0-0-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio107", "gpio108";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
> +                       cci0_1_default: cci0-1-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio109", "gpio110";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       cci0_1_sleep: cci0-1-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio109", "gpio110";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
> +                       cci1_0_default: cci1-0-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio111", "gpio112";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       cci1_0_sleep: cci1-0-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio111", "gpio112";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
> +                       cci1_1_default: cci1-1-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio113", "gpio114";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       cci1_1_sleep: cci1-1-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio113", "gpio114";
> +                               function =3D "cci_i2c";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
>                         sdc2_default_state: sdc2-default-state {
>                                 clk-pins {
>                                         pins =3D "sdc2_clk";
> --
> 2.51.0
>
