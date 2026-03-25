Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E13A3808;
	Wed, 25 Mar 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435333; cv=none; b=ckO91o09q6/Ww4G07BqjvKwFLP0118wkI/QUaX7CZqGWUolZC5U559F2OZCJY9Z4R7kdN58VEVE5hS509p778lvmIAkNZdox5gUBCg6UaP7EXCn0hp0N/Y2tL858jtq0kkRQr1erwjnicBm7GpvcmVYM5iJzvY1Ej3XjbZOJ5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435333; c=relaxed/simple;
	bh=6ThVK/rJaviO7Jrd2Rhoa38vC9ZXpd/LSGiKWL+Dqdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ds7C0PtXsDdn78oF2rdPoYwL3nefgNdfrMOl3wiT214o7wk6WCjUPIBjxwK2zGYBL9fiyrZk2PDQDEhg4ijUIoAKFRZ9GqM7xyNx2zVqYxrEu+6UcyO1PoZhyatac5TVZSC7uqfSpY4LKwR05OPSUjL8vcRsxBBU2KZfa0PYH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=KQoizdSS; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="KQoizdSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774435313;
	bh=5h9Gm4hE034FUJ+tLsF/4KbhVSlEW2L6viFtWACnUaA=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=KQoizdSSmPzU811q9F358BCaQfYExREBkPK5k6mX3fQi9HFRTwPK6P3rTb/88EiKp
	 Cikx+3Lnyg/u4x+LPB9j2KHzNiuDHEW3QtQOm3xeAVHaXmUOgxVrYc6qN9NnW9BYbF
	 AyLoKItsONGgOalvErq7RsFpaNE2iV+KC83S+7wc=
X-QQ-mid: zesmtpgz5t1774435308te51a1058
X-QQ-Originating-IP: 5V2fvYPK8sKaEEHdU11yJxTASq+yaMttfYnhxI/4Q00=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Mar 2026 18:41:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2505999498786661497
EX-QQ-RecipientCnt: 15
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 18:41:45 +0800
Message-Id: <DHBSTI0A3SOW.PCIP544HUYP4@linux.spacemit.com>
Cc: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dts: riscv: spacemit: k3: Add i2c nodes
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
In-Reply-To: <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M/AyZGld0ICWZJOKLI3GDPQX/bB1AO8EkYCDTjotDUGbS+sd4RQIxmYN
	aMQdXYqa3mWV+S5uW5jLgU3+peTJIXubpnlxQgj2EylTCYsjyh3eFsEOCexS8rgXoVvOjoS
	kvu8+CxafXG7HT4ob6tMtFvuIKw/VyIat4PxbDTXFLGOUz5PzLAjH+BcqyKxTfVNoYUrXZY
	1YRZjgtVL9ydzZ3LcOAswpnzLZPxxw1QCkf05CmFcdIpc48WsqRg4K39pfCQeZ5u8YJD6ym
	MurFo0sXpQX9MsvIQxj02dGk1vQ9iCILj2uxj5uU81NuNActuTKYKK5GolEz1ievBq+zwlY
	k0wU1DFm8wjtY4ZSBl9z0XI14s80Sre8ebg5NDmLBVD7NOvzm1CDQdAzyd4FN0tXToLXcke
	152yNX3AbtIvbPV5hbA83tQF+WqWl7VHwKb2E28vHEXjwyIXf8X9Zdhj0CFmdbFnib1bMOr
	7szhNkW0y9FfuZbG6bVWDHBO6KHb3TAagXf/hIxtePXSwkvKsyRkHfW6IcVyMhzZS0O8ct/
	KHS+q9zoy8ehk/ctSoeRzeTESwVGpiFGwevUC1Oki+FVqVc9qMbiQbhxcgDnJMm6FPQxoi9
	XirWoIIiE4kal82a5VCWheB2UyJBn0xoggaQT/iJehMfNTll7sM1m7Qbi1JUK+5UYWsxbHn
	xVrOflxpV7Kg/tGYEbxbvo/BSbbqjKqgWrCla0SEv/4QOc6zKW5LbEQY1y7IUk3gvskMx3v
	toOtpfIP7rt9eqjFn/DS8fbVf2mBJfJ9vQqjQdrt/t4k9zmmB3pUWPSPhd79Wjft3b2mukc
	2vti3JR5e6z0qFES0bgCkVMlz3fNNUsG1pJTUU5/OxvSwEwoeKbNPWqd113rfI2e3AyD+hH
	kl3TYUmuLdOPgy8lj1aR4XRQRQjhEq/v0tVxy4/G1uhe5Yd+gMUDQ2EY02L6STcf97IXKmm
	UcZROWpAYXiOshNoajF5qYLG7dE1DCsnWQN4ujtx8DnnpLzfJfHhRfCj7gywpcvoIUxs5nV
	oPllE68dMJxPn0gJQbNbx0r/EQr2D8KAVrabNr21oOI94hkHlelwlzVM+VovE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Wed Mar 25, 2026 at 5:49 PM CST, Yixun Lan wrote:
> Populate all I2C devicetree nodes for SpacemiT K3 SoC.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 98 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/s=
pacemit/k3.dtsi
> index a3a8ceddabec..cab72591b7f1 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -438,6 +438,76 @@ soc: soc {
>  		dma-noncoherent;
>  		ranges;
> =20
> +		i2c0: i2c@d4010800 {
> +			compatible =3D "spacemit,k3-i2c", "spacemit,k1-i2c";
> +			reg =3D <0x0 0xd4010800 0x0 0x38>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&syscon_apbc CLK_APBC_TWSI0>,
> +				 <&syscon_apbc CLK_APBC_TWSI0_BUS>;
> +			clock-names =3D "func", "bus";
> +			clock-frequency =3D <400000>;
> +			resets =3D <&syscon_apbc RESET_APBC_TWSI0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c1: i2c@d4011000 {
> +			compatible =3D "spacemit,k3-i2c", "spacemit,k1-i2c";
> +			reg =3D <0x0 0xd4011000 0x0 0x38>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <37 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&syscon_apbc CLK_APBC_TWSI1>,
> +				 <&syscon_apbc CLK_APBC_TWSI1_BUS>;
> +			clock-names =3D "func", "bus";
> +			clock-frequency =3D <400000>;
> +			resets =3D <&syscon_apbc RESET_APBC_TWSI1>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c2: i2c@d4012000 {
> +			compatible =3D "spacemit,k3-i2c", "spacemit,k1-i2c";
> +			reg =3D <0x0 0xd4012000 0x0 0x38>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <38 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&syscon_apbc CLK_APBC_TWSI2>,
> +				 <&syscon_apbc CLK_APBC_TWSI2_BUS>;
> +			clock-names =3D "func", "bus";
> +			clock-frequency =3D <400000>;
> +			resets =3D <&syscon_apbc RESET_APBC_TWSI2>;
> +			status =3D "disabled";
> +		};
I think we should add a comment here to explain why there isn't i2c3.
Otherwise, LGTM.

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
