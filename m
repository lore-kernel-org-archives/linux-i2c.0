Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6535F8A6
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990003; cv=none; b=l2tocM/buiLcGpqSNw77pVGlSaNUqs51S737UcP6Snb2n29WDUlL6yG3NJUqXjpDuZJZNRNY/qS0+k+nHKtm8iPOogQEAhP4iO8Zx1RF1mXE35J3gSSYq3hKvUZAoB+ILI3SaZKYad/hZkP2NvlpLrnFTxP07X75l/x2dHLPQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990003; c=relaxed/simple;
	bh=jPiaB1cPnsBCSqPZwxa3BXmJi7Uws2py+99N50LH18Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jIntqZpmnVaCJZqIU8qIZsulgzNqKhkuWZsw+cs7BMf35l4LZc9OGRK4XSqOblNOoBt8laPbYcZjjIOmwt6A1lfXl790AdTsdEK8iVLpUOLtNab0TTzVdrDbV8dp27m0EDqI5WvivIwu6DRHJH9TawbtAPR1eLViEcRFSCIdVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=s5X3bNN6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="s5X3bNN6"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870778358aso7676501fa.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770990001; x=1771594801; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXlnwEJKyA8dB3NSxxIfARoyH/UHQbm9JUFGj4ufio8=;
        b=s5X3bNN6AOSgp+gNM7KYuVZalupQ5QskbGhf6PWdDdUcZK0GOVy7bKtXhJH2dxQ9xA
         NtxLUgNWSYAaQ6IEcsryue16rCumsSpjdJ5SqxbjDHhDXay35FtxkMCYgSG9ntYyPbOt
         Q6HQywiV1muyuYUfmUXB7YH9YyJiZPV//txzeIzOb64x78XY+K36OiPGK3KCiUMeLDSe
         5qowlUHV3Woj8pKieyOaDZNapLok4rP8RxG+7tFAZfNdAX2iTqMaSqSo9WQ/IlYaMMrL
         r+dfaIt92L6H5CgAQmLYAy1XyqU5PO7mwwxsuzisLUzrguKYg9GNFnQjFYMKcFdNsCQo
         Im5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770990001; x=1771594801;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXlnwEJKyA8dB3NSxxIfARoyH/UHQbm9JUFGj4ufio8=;
        b=FTYvy+jgVVaxhBBN/BovymCUz17rgcqVX5f+B8rDvIMMWsxaTXfgas4HB+vShJfyBs
         MB9mrHqppaFflnw+xL4VZOZGj6W8oiVbzUTfdDxXiqK2lgLInxGI00Lr+tmKRk6JkiUt
         DZl4u0CnG+auQp+6KMoNASfV6pE00jSyhx2X7C1sbGFiQY1QSW5ceYqIyWS3JcwjvA5W
         vN4dicATZ5T7GHIKmJor/lTq1KgvDmo12HaOwDzq444HL7CZXYnp5nWUvUWq858wecJy
         g+wFX0sPfIXo/JalSdsAbiCMRM8QoM/lSwHGKKqoUVon8jimcNoUk76Bgk7EGHPvoknw
         tD4A==
X-Forwarded-Encrypted: i=1; AJvYcCUGti/nCP0IolOvmTJSzBG0+HG+UXM1bW2UQ47S9h2/Yx/cRPxB33FatYzy04LrHPBxKo2wmj5ba5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLcjdIQiIghe54IvSpxV0K0ifUIFvKQx9YlthYQfC047FxfRO
	N3cvxUhaAGdTscb4Vg5rlbz2W33MjdUwb9HU+vzPHOr212oYYkRS9lF4EplSggLLyw4=
X-Gm-Gg: AZuq6aKknwPZkIabEFsLuJsC33EXSi/vZ22yPkLiAMS4U71AUWxAnVKaG4dhQqqTIZ4
	qdZjz0hdL/i66HQNIRSSFvnp3cGgnbLdNS8DsrgCdsESFoqmBOFwe46xiFcPQpksFBn0IxZ2ZdT
	r3C/sXiFOnEVHjlFzdUC4BrHlilLZf8nUphDLgfO/z/3ExhnA8iX5CPLwqMcWwwznypQ5GeXJj7
	gYKT9UvwXWP1haYN2PLaRkWa0fuoFY/DpDph93Pu9BWgb4f9GlQY3XVnZFYZ7Ad3ZbXJWyszO4F
	UDhaADH9tKDPc+BHTIc1+4H98IcRSK/PPP5md4jGumy7aE9l2wUw3JIM0vv+dV+0ywVeqbtrkWw
	Sa4rN789a4246vYS+IMKLR385c0I7O4rkDNkEBPAGdTJo7U5jFtSCgL7U1FvCbxScLYnwl7RRV8
	NXcIFGDmnSjbbKX329kEa3w8e3yViana1ENjlYGaJ+basLHA2rp8DMzmxZ6CW2tx+XM1IH
X-Received: by 2002:a2e:bc23:0:b0:383:2074:ed34 with SMTP id 38308e7fff4ca-388104fb2a3mr6074671fa.2.1770989990120;
        Fri, 13 Feb 2026 05:39:50 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad19bfd3sm682707a12.2.2026.02.13.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 05:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:39:48 +0100
Message-Id: <DGDVK13XN7OO.3I398MMB95Z8U@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Bartosz Golaszewski" <brgl@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Loic Poulain"
 <loic.poulain@oss.qualcomm.com>, "Robert Foss" <rfoss@kernel.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: milos-fairphone-fp6: Add camera
 EEPROMs on CCI busses
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-4-28e01128da9c@fairphone.com>
 <ae73eac1-4e27-404d-af73-88eed699db0b@oss.qualcomm.com>
 <DFQ3MBO2EAYF.1PRF2111N0U1I@fairphone.com>
 <44f65bb6-616c-4dd9-a7a1-ee62d5d217cb@oss.qualcomm.com>
In-Reply-To: <44f65bb6-616c-4dd9-a7a1-ee62d5d217cb@oss.qualcomm.com>

On Mon Jan 19, 2026 at 11:42 AM CET, Konrad Dybcio wrote:
> On 1/16/26 3:54 PM, Luca Weiss wrote:
>> On Fri Jan 16, 2026 at 2:59 PM CET, Konrad Dybcio wrote:
>>> On 1/16/26 2:38 PM, Luca Weiss wrote:
>>>> Enable the CCI I2C busses and add nodes for the EEPROMs found on the
>>>> camera that are connected there.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 50 +++++++++++++++=
+++++++++
>>>>  1 file changed, 50 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/a=
rm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> index 7629ceddde2a..c4a706e945ba 100644
>>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> @@ -529,6 +529,56 @@ vreg_l11f: ldo11 {
>>>>  	};
>>>>  };
>>>> =20
>>>> +&cci0 {
>>>> +	status =3D "okay";
>>>> +};
>>>> +
>>>> +&cci0_i2c0 {
>>>> +	/* Main cam: Sony IMX896 @ 0x1a */
>>>> +
>>>> +	eeprom@50 {
>>>> +		compatible =3D "puya,p24c128f", "atmel,24c128";
>>>> +		reg =3D <0x50>;
>>>> +		vcc-supply =3D <&vreg_l6p>;
>>>> +		read-only;
>>>> +	};
>>>> +
>>>> +	/* Dongwoon DW9784 VCM/OIS @ 0x72 */
>>>> +};
>>>> +
>>>> +
>>>> +&cci0_i2c1 {
>>>> +	/* Awinic AW86017 VCM @ 0x0c */
>>>> +	/* UW cam: OmniVision OV13B10 @ 0x36 */
>>>
>>> There's a driver for this one!
>>=20
>> Yep! Already got patches to add the required regulators & devicetree
>> support to the driver, but since I've got zero on CAMSS so far, I
>> couldn't test it more than reading chip ID.
>
> That means the digital part works.. I'd say it's a good enough
> indicator
>
>>>> +
>>>> +	eeprom@52 {
>>>> +		compatible =3D "puya,p24c128f", "atmel,24c128";
>>>> +		reg =3D <0x52>;
>>>> +		vcc-supply =3D <&vreg_l6p>;
>>>> +		read-only;
>>>> +	};
>>>> +};
>>>> +
>>>> +&cci1 {
>>>> +	/* cci1_i2c0 is not used for CCI */
>>>> +	pinctrl-0 =3D <&cci1_1_default>;
>>>> +	pinctrl-1 =3D <&cci1_1_sleep>;
>>>
>>> Let's keep them per-bus-subnode so we don't have to override it
>>=20
>> I don't see any upstream example of that, would the pinctrl work
>> correctly with that?
>
> Hmm.. I assumed it would.. and I assumed we do have examples but
> ma-a-aybe they got stuck somewhere in the review purgatory?
>
> If you'd be inclined to test that, you can add a pr_err() to e.g.
> msm_pinmux_set_mux() and observe whether that changes as you
> interact with the sensor over i2c

Yeah that doesn't work. With the following diff I just get some CCI
timeouts and at24 driver doesn't probe correctly. I'd prefer not to do
some yak shaving to get this patch upstream.

Regards
Luca

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index b6cd95fc294e..9f9410615aea 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -671,10 +671,6 @@ eeprom@52 {
 };
=20
 &cci1 {
-	/* cci1_i2c0 is not used for CCI */
-	pinctrl-0 =3D <&cci1_1_default>;
-	pinctrl-1 =3D <&cci1_1_sleep>;
-
 	status =3D "okay";
 };
=20
diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom=
/milos.dtsi
index adf050600a4e..a2438cf60271 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -1755,9 +1755,6 @@ cci0: cci@ac15000 {
 			clock-names =3D "soc_ahb",
 				      "cpas_ahb",
 				      "cci";
-			pinctrl-0 =3D <&cci0_0_default &cci0_1_default>;
-			pinctrl-1 =3D <&cci0_0_sleep &cci0_1_sleep>;
-			pinctrl-names =3D "default", "sleep";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -1765,6 +1762,9 @@ cci0: cci@ac15000 {
 			cci0_i2c0: i2c-bus@0 {
 				reg =3D <0>;
 				clock-frequency =3D <1000000>;
+				pinctrl-0 =3D <&cci0_0_default>;
+				pinctrl-1 =3D <&cci0_0_sleep>;
+				pinctrl-names =3D "default", "sleep";
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 			};
@@ -1772,6 +1772,9 @@ cci0_i2c0: i2c-bus@0 {
 			cci0_i2c1: i2c-bus@1 {
 				reg =3D <1>;
 				clock-frequency =3D <1000000>;
+				pinctrl-0 =3D <&cci0_1_default>;
+				pinctrl-1 =3D <&cci0_1_sleep>;
+				pinctrl-names =3D "default", "sleep";
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 			};
@@ -1788,9 +1791,6 @@ cci1: cci@ac16000 {
 			clock-names =3D "soc_ahb",
 				      "cpas_ahb",
 				      "cci";
-			pinctrl-0 =3D <&cci1_0_default &cci1_1_default>;
-			pinctrl-1 =3D <&cci1_0_sleep &cci1_1_sleep>;
-			pinctrl-names =3D "default", "sleep";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -1798,6 +1798,9 @@ cci1: cci@ac16000 {
 			cci1_i2c0: i2c-bus@0 {
 				reg =3D <0>;
 				clock-frequency =3D <1000000>;
+				pinctrl-0 =3D <&cci1_0_default>;
+				pinctrl-1 =3D <&cci1_0_sleep>;
+				pinctrl-names =3D "default", "sleep";
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 			};
@@ -1805,6 +1808,9 @@ cci1_i2c0: i2c-bus@0 {
 			cci1_i2c1: i2c-bus@1 {
 				reg =3D <1>;
 				clock-frequency =3D <1000000>;
+				pinctrl-0 =3D <&cci1_1_default>;
+				pinctrl-1 =3D <&cci1_1_sleep>;
+				pinctrl-names =3D "default", "sleep";
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 			};

