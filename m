Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFE3C4B9B
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101989; cv=pass; b=drQ5/R/CV4J3sb49FNjsRXO5WjMfzZFl7CRFR9aEXgmZxlYlHlziHvDFNgG2uREztSjBECwBSfcwTTRYqirN0yzN/8t+CW8YzIo2TJVghi2p7XHU5q0IA9/xExo2ctRfx7yRap/QWW09NUHLwTByhg7NWXlE7TsjQplaNrf+NQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101989; c=relaxed/simple;
	bh=9YX4dE+yfNDLsdJvZJbsFDglIGvjVkjjw2Mk4BuFTmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1PxMuognMnxEAToPC7yflymF6amU7JtEnaBmRbiJGqeII7SueLPn6Gk3V9sZ/j+vLk25yyd0hETXNyl3JqIZWopHaOlJrcifkIj1Nv4YYyqcl0UxzpVr2LJmJSRiFqpHX9uqhMaokYORyKzp5a9RuAQcPXQ44ySwLKeGHgloCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sz+G2/VC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=On5jnowc; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sz+G2/VC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="On5jnowc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lJUw2624419
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLek28axscsCPFWO/Z/JAne78HjenYIUsRjAVNxPzWo=; b=Sz+G2/VCYAbYlEVg
	GWsJHKNm/x1ElQWVGvbElyl795HC6WCN4WOhRCllGM8MOAU9YVPnUWr8nfjcAj6i
	AfSomJ/oRUOA3Mpk3ehnz7XD8cWUfB+0uWBqAwm3idNoqVq1AmKS1wwbYXZGoOFr
	r3KTmwK91J9i6vmnou7C9BY4g2JzkWu0XEGw7BC13GwG8SLrMptnde32Ho1XXUGg
	XA+F/DEH3kkYbV9gzNSVNTxYbS8tG+fOBnscHcvIuEqpcfffLy2HYYhbUoiu8Vuq
	Vd7b2v6BncOCq6mdqgj3DU4gg6I21hUDnOF95n2wcQAb4eMkyvFISLWK1xBypWod
	pKDHNA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqupmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 07:53:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55f0613cso622673785a.3
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 00:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101981; cv=none;
        d=google.com; s=arc-20260327;
        b=DUru2iTbhI2dpzvxB243Zg1IrGFK4yeyMnP7iz08XwmgRi6MteEUqDEJ7YDzMKICHc
         X8pguLrftNWuZ34FIByGDjdblJdHU65xVE/j0tcZlvAWq4Z9YPY2JplMk9kN63zPjJpd
         Jz7qDnU7k2OdRpkIeKdXvZySjXae9pA8BhCdIyDlrqaPzZdPRhrNOoT6Uv9ZsDkBwD5a
         Qv6D25F+wspUACX4CZm/njVUkEtTjXfRN7ZiMxtLvcn5nuQNLXYcNNYXijoU/a3Ek668
         ugQUxKYOnngENsBTuunJiPpiSVStqKsxN6dJ1CkP4ctbjWCk1FcOh0WVxPlFrNjBufIn
         1IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pLek28axscsCPFWO/Z/JAne78HjenYIUsRjAVNxPzWo=;
        fh=ZMGXdIeRPZhcQBsc7rhIIy1goDcniEN3ZHBUaqL18+g=;
        b=TajJSG4gRNFZrYd1LNEZTBH6+mGGFNI17NNROC+IvfqcepqF5iAa4X2MXJuTVHq5zT
         XS9O9laV4B5PUt3YMbw4wRkmSVJg0EL4l0gBSpFrNIFz8X7TBzJZxd2+R6nT2toB51Ao
         3TxO4umLSRWXhVMMEZvaAmvXCclQ3yB+6GhC2HqQFuUxxG2a6iVDODe2JJZtK9o2nDf0
         ktM875orts481TBKovepY7EQrRetlSDFM34Ou189IMmI0xN8vbRLteXpAcrBoGM83V56
         WBenmaV65lfvzElHfpyDDmzcDCkQTG68G4XuUFm9cQlgNzaxNbGkzRJh+YKQGVTMJiSR
         JUSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784101981; x=1784706781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLek28axscsCPFWO/Z/JAne78HjenYIUsRjAVNxPzWo=;
        b=On5jnowcUAQW73FA5VrP3yxVX+/XHWlfM1SEUeBmnd1R8K4gYWN8ghzWSgDI7NIMMS
         Xgwj9HZkglErjevBoVEUaEivjtqUG8/QfmyTZM2Vonjk8OqDcwPfchFIT7jsLLbIuRCS
         dgIrA91vNAeBmEUygv/pCePQU6ucCwO7aD0SM7bpNAG+M2uC8LtUVtNtSDnavAARGRB4
         lqKT2sf3HK1d+JOwVJQs3nQONXcMgkp59O8KV7tP5593C4pjzB8An5cguWD/P4my6Zhk
         9Gr+JCw/dx89izTe89MK0Q9KYNBEF4G1WER0b1eNJDHekfz2eYhGnSfB85V6p1Ae2Wkh
         oCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101981; x=1784706781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLek28axscsCPFWO/Z/JAne78HjenYIUsRjAVNxPzWo=;
        b=WZWWM+o+2PL341HvWAyTkIwyabdHKS3zXzm8kpmD6SEq3cHbPzKPFS1P7AOu6z4jPA
         9wnFrXjGSOy5uw1RqQUX2jeuw/Odj6hBQ+A0iOmJVki/vloVGrf8r4bpcxScltvn9XpZ
         iv/sAO8+I3B6ATt40gkmdPTpZaFCesVgc3CMENKFvB8YDUwxzxAzfYbNQ/rIDihArE9C
         o8o69u/DyugZfOeHsaLVTepWGCX81IrrWwDjpbQOqZ4gxafUjsRyl4GJH8vYFmKA6H8J
         5oDZ6pBq6fQQfFT/ciOhKMicJdwUU5xYmItlUlqeVtkF5ccEFkl2v7S49BJKgwiCmjIU
         DPTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp22jt8s4plOU6FDhqYoiuCdTHL0md/FFA9Mi42RKnng/Px5a4AdUyP1TgwuX0obQZ9Oh3Ieqgtd5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xO/kbkUkOcKb29wfst8Fpiqx7o4Kc5TcJhRVesE63YXDGbmC
	qBXt0lYyrqGhwjYIDeKgaEaQW7GIu9u1vvLex93gAWf4Qke5mUG2llEcc2SLHa0qqlyaBW5kYqf
	q7qjJZv1i4qT6rqyINiILqocCFFYVqKzoLR/vi7OHAwEqsvHL2nljAVvMzBnDsRRJ2jcqWCLlI9
	OhEqp6/v4GDdPkz6Oig5pPEA1ug2PWsW0kqrB3Ow==
X-Gm-Gg: AfdE7ckTMkc8GvlRzVjA2X0h2+770ZtjC7DQIKJwS9Mk0u1fbwSWroNovqCV6YbO0WK
	70UmISxlczX7J2VKOb033gzjrp+FGdL4ed9PgWcxa58En2GT09rx2lBUwu6MjxkZUeigolp6XUS
	RwWSHfn59RDbL33cEktZ/z/+/JI1ewph3UEPM9D6wlHnwVVa31dIQJsD5Ct4YuqWBixKCjrK8bU
	H1MLE0gRyBQBlY9+a2LUM6FbBnpVwEY8996WskSsjm5+nqA4AQk1V5ypCwJFd7eY9gw3hlaZ3vf
	Xk4xBgwSMKw=
X-Received: by 2002:a05:620a:600f:b0:92e:8210:fff9 with SMTP id af79cd13be357-93086bea55cmr545859285a.56.1784101980994;
        Wed, 15 Jul 2026 00:53:00 -0700 (PDT)
X-Received: by 2002:a05:620a:600f:b0:92e:8210:fff9 with SMTP id
 af79cd13be357-93086bea55cmr545858585a.56.1784101980599; Wed, 15 Jul 2026
 00:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com> <20260713-shikra-camss-review-v5-3-db53be15dc4f@oss.qualcomm.com>
In-Reply-To: <20260713-shikra-camss-review-v5-3-db53be15dc4f@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:52:48 +0200
X-Gm-Features: AUfX_mylGXRGoAJ8WLPXjHG-LrYjgeK28hgV3O_EXafPt2RbMf7pLiI-38KOrs0
Message-ID: <CAFEp6-3MrGLyTQ5+qaZ2nF=EWLgOhepTB41CwEEQZwJ6zQh8Rw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] arm64: dts: qcom: shikra: Add CCI definitions
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3NSBTYWx0ZWRfXy8xUzxm4M1Jc
 lsA0GpIi2JcgXXAw6aNxK8JncB8HEb8pfB6iFnI6O7amsup+OrNnqstVnS2i2mYGQeRuINm4BHL
 lSIm/76vUNmIA7BoXROdbzKh/2WH7khtngERGZVW5M9htLzTbaLnSqMmHS9UZWKwNlbQQiRg/mS
 Vtk2qgYNLD7Wd3PEB+b0JGwBkEyLhURSGNoCoUy3QbAz7CA7eSRJHj6x/v6MC5pJ/44rPdJl76M
 KueYQYtTcChOGLUZJ+Hw6VACFqtcJd5v9l/nxnJBEv5jVvIfE3bTF+7N9tsNojk0De51rogCpy1
 9W168OXJbnT9DKO/c7YaPPpJ29iISmkArzjtiVRlIfDc9aL1sZAZ76p4WDBgaZDUUU+BTxgoJvP
 wWu5DR265xF/Q+OCqygHnnV56gqL9+ojZpwlIPxYKx5TDubOKMQCKuB7HtUsK6xVhJRxqMt4U/G
 CxPdeioLWbBwN5fjb2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3NSBTYWx0ZWRfX2AX2KBACNq16
 0ckIja330kbiclnUp3JFDCK0ucV+0ZcZURli/s8D6t28atvKBT1Ej/hN48FarrvP8cRxaaJXJdL
 Nj4RZpsgTP2GiEeAc2z35ahW1RNsVdc=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a573c5e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=U2PIo7JDszhCzVx53KgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tLae2plNyvA42h-b7WPrn874LBda8E9o
X-Proofpoint-ORIG-GUID: tLae2plNyvA42h-b7WPrn874LBda8E9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150075

On Mon, Jul 13, 2026 at 11:29=E2=80=AFAM Nihal Kumar Gupta
<nihal.gupta@oss.qualcomm.com> wrote:
>
> Qualcomm Shikra SoC has one Camera Control Interface (CCI)
> containing two I2C hosts.
>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/q=
com/shikra.dtsi
> index 6335caca329808ee04d9067f1f95e8075e2fc3ed..18da1380e52acdd8813625eac=
eac796e342efd16 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -355,6 +355,38 @@ qup_uart0_default: qup-uart0-default-state {
>                                 bias-disable;
>                         };
>
> +                       cci_i2c0_default: cci-i2c0-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio36", "gpio37";
> +                               function =3D "cci_i2c0";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       cci_i2c0_sleep: cci-i2c0-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio36", "gpio37";
> +                               function =3D "cci_i2c0";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
> +                       cci_i2c1_default: cci-i2c1-default-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio41", "gpio42";
> +                               function =3D "cci_i2c1";
> +                               drive-strength =3D <2>;
> +                               bias-pull-up;
> +                       };
> +
> +                       cci_i2c1_sleep: cci-i2c1-sleep-state {
> +                               /* SDA, SCL */
> +                               pins =3D "gpio41", "gpio42";
> +                               function =3D "cci_i2c1";
> +                               drive-strength =3D <2>;
> +                               bias-pull-down;
> +                       };
> +
>                         sdc1_state_on: sdc1-on-state {
>                                 clk-pins {
>                                         pins =3D "sdc1_clk";
> @@ -702,6 +734,44 @@ port@1 {
>                                         reg =3D <1>;
>                                 };
>                         };
> +
> +               };
> +
> +               cci: cci@5c1b000 {
> +                       compatible =3D "qcom,shikra-cci", "qcom,msm8996-c=
ci";
> +                       reg =3D <0x0 0x05c1b000 0x0 0x1000>;
> +
> +                       interrupts =3D <GIC_SPI 206 IRQ_TYPE_EDGE_RISING =
0>;
> +
> +                       clocks =3D <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +                                <&gcc GCC_CAMSS_CCI_0_CLK>;
> +                       clock-names =3D "ahb",
> +                                     "cci";
> +
> +                       power-domains =3D <&gcc GCC_CAMSS_TOP_GDSC>;
> +
> +                       pinctrl-0 =3D <&cci_i2c0_default &cci_i2c1_defaul=
t>;
> +                       pinctrl-1 =3D <&cci_i2c0_sleep &cci_i2c1_sleep>;
> +                       pinctrl-names =3D "default", "sleep";
> +
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       status =3D "disabled";
> +
> +                       cci_i2c0: i2c-bus@0 {
> +                               reg =3D <0>;
> +                               clock-frequency =3D <400000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
> +
> +                       cci_i2c1: i2c-bus@1 {
> +                               reg =3D <1>;
> +                               clock-frequency =3D <400000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                       };
>                 };
>
>                 qupv3_0: geniqup@4ac0000 {
>
> --
> 2.34.1
>
