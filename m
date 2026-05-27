Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C053BB13A
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865382; cv=none; b=Jb/lAQWcrebBQW9QCQWWJSaiMnltEjg6qQodVvEvXaQJ8qd+rUA0nFr5JFK1VNcSlfj9StJQHN2vnLy5sdC3LnR5dVBzc1DaKX11/YogEvXpwOIn5vptZW0qvr5tOHxUbeadFo9RDKyAYm4o2EH1g5txtivvXunZR87YV0X/2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865382; c=relaxed/simple;
	bh=BhFMpXm7L9rSrl20eMhGv/QWz5SLQYG0rIJnjo7EiEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxu+4DWV6e91tf9JHUZuteDFk0tuKGoF00Fs4ZYz3E2FwMhmxqJuTyrNDxi5tbSyehaY+1kP0gnaqySWPAiMYZgiK3bDDTRDUFtyoxICCH1wH80bKA85BNv854eNJy32PRoc2cNBx6XEVyhpuidjReExlpecgFisADFM0xaxyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf7+y0D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf7+y0D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32871F00A3C
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865380;
	bh=jEA6rkYA68se7bce8su/6SiopoEE/vmXsyoz4+8isGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Tf7+y0D8dWQtX2RviGlS52ZF0KRc2rh9EDWHvl54j+rE8bpUIXixKzGhhglDCHGME
	 WPO+Ba8KQ2YG6iyuE55hGDZxoUw1AWWMjixVPqWiH1OSBLrDtezRTrnvpwqYAlraJi
	 HyEwRP/onSYggMUzX6wpLiTPE6UhHAM1Lsc1496E4VFgO0e40Q1xyu+EfCAagcVkYG
	 Q8D3x9Idnro98LGxb8if9qJW764VG4O6xR7k1GeZrMFJDsO/GKzR+ncZXtCuY9h53+
	 xAUH8PV+NMUF/43A/bcG62RZQUNhs9YLVV9JThRLtuljNb7cJ3HPg7KgcTWhjHDDIj
	 gtd0/DaqKiHAw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bcda7765d64so2204933866b.1
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 00:03:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80kIL7o/SGwTmqYaySucbWjzA8xbWliIRpc+IGZwrAyQKtkr8VktzalHUACJP7tl8SoYWBFLCsKNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwhtZ3o6JMGzO5Zxn8EhXfhNieK4dO5JRF06kZMWqTcs6c7KB
	oI+Xuc/Vmna1L2Fz3cCcdSADYP5Pwq9niK+1AfBzTFbcDLFR5ROio8cevYoRHRgUF5JlrDMKSsQ
	LHKg5mgiT9WF+NQuIL5+xqkUmDHDopDQ=
X-Received: by 2002:a17:907:7634:b0:b9c:bf69:8b54 with SMTP id
 a640c23a62f3a-bdd4a3bba53mr743925766b.18.1779865379378; Wed, 27 May 2026
 00:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526031021.32662-1-wanghongliang@loongson.cn> <20260526031021.32662-2-wanghongliang@loongson.cn>
In-Reply-To: <20260526031021.32662-2-wanghongliang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 May 2026 15:03:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5eromO_QWNhus5XJdXrhB7RXf4UgdYU_WMWMnzpgUOeA@mail.gmail.com>
X-Gm-Features: AVHnY4IB20M18oEv7aPRZl3DUM1liFr5KJ-I8Zsc_7nboNz22RXeqCPbi-_DbHI
Message-ID: <CAAhV-H5eromO_QWNhus5XJdXrhB7RXf4UgdYU_WMWMnzpgUOeA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongliang,

On Tue, May 26, 2026 at 11:11=E2=80=AFAM Hongliang Wang
<wanghongliang@loongson.cn> wrote:
>
> From: wanghongliang <wanghongliang@loongson.cn>
>
> clocks property describes the i2c bus reference clock from APB clock.
> clock-frequency property describes i2c bus speed.
>
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> ---
>  Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml=
 b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> index ee09c6d9c5f0..4bf89bb97e7d 100644
> --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> @@ -38,10 +38,13 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
I don't know whether dt-bindings require alpha-betical order, if
needed, this line should before #include
<dt-bindings/interrupt-controller/irq.h>.

Huacai

>
>      i2c0: i2c@1fe21000 {
>          compatible =3D "loongson,ls2k-i2c";
>          reg =3D <0x1fe21000 0x8>;
> +        clock-frequency =3D <100000>;
> +        clocks =3D <&clk LOONGSON2_APB_CLK>;
>          interrupt-parent =3D <&extioiic>;
>          interrupts =3D <22 IRQ_TYPE_LEVEL_LOW>;
>          #address-cells =3D <1>;
> --
> 2.47.2
>
>
