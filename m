Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910142;
	b=NH1bH7bPLxlexr18RbiY5txFXgPYb2pkv1qP4uuVPOo5/mRxqdQP0djo/DrHR1zK8yVZ
	 0wnNRtcTaf8pgGPzesnSwAgJE7kJ9U42WAWPvfgPjrtAHpJHwR5NHVF9UnilYzv7f9Ltu
	 IhlpYOZs6513Wq1wcFYTrpo5ZCAobx0Vk4niH/QpAWwuAtrVh4x4zuaTm1dursE+X9n1Z
	 mVfK0gdB0TQ7wTTgxmOlLGhdXWHX8xfCjdk5Fdd6CliP/R2LaoUrztQ8U5udRKpB9O1Ca
	 Ub80ZwDlUg+NcPeZLfhH3apQj9IK+I3qecoTZpXz+yGAb6YYQiGDz/omTAwK8M/83fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910142;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IBXcaC8CSaPOK5lnAix38sTVGCSr2JvQQd/TlL9JIsI=;
	b=AQyBvALieOhpEVkE1wRhNPF8Xim8Bg60UIAKIFB2YdXC0ryogotiFxWCAz10iKRyb9s2
	 Fi9eaqMM7w/xe5oLoMPnilC6wmfunq3SVM/drzXFpq9MN4c/0GAn9zaHhDC14NEA91SGY
	 szFq1TiFSOmyJrbjVO29v++csOZrknsAKKsT1v+pCmKwCd8EeMv/6/j2kJUoeF112cuvp
	 BAJCk4184Rm4IvmJVQQihJeXz4xTPpyOapFc3r5qA5s5njSjxflo+azyn9uhmy0cLmbkP
	 R1NKmZritOF/oYl7eDGSswjEl1zJzi6MuwPkJ/XkDAibhdBgZ3e0x8KEc58igmoNqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrx50Fuq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAD606A32C
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrx50Fuq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344821F000C9
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910142;
	bh=IBXcaC8CSaPOK5lnAix38sTVGCSr2JvQQd/TlL9JIsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lrx50FuqQGh4txTkICtA6Ioiy/BxsxtmjN64WUmmTlZp8qY3UcAm7Mpajsk0zqCIN
	 TNRZYb01+1QWyWwvxhktijZ39MFFEUpsjlTdKItv7OpwhaRlmvJKTeFKKcAIkWDkjx
	 e39jk8iDzjegeWOI9/rcfNZZthafEbpLb55qPMiZtv4+f6WitZv4AM839i63yGhUWU
	 LRFPWY6/HY68PfQ/1f+6SCRuLmhsYVSIAgAH214ZMy9j9fuGnDF5rwYsDG9NLBeTsb
	 TFJzdMEoTpAqrQATdcpFhHl/qGdcTqxh8ftKv2ke4eX8UPehtjLJMMDnYtozvA73vF
	 EEW6KKVHklhJQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adfe77d35aso42466481fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 02:09:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFwW6HtV/MFDxmpIIHVswJhXDKBDYp45EIRRlqA553/gLsToJnUe1RPKR8+T1CYRx2nzxVeR4H0HSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wX0at98Zt8ucWTN/Zgp8uiAWXxjV9i7k1UCGIFhsfcaxpzPoP
	TLQYU5s2cDQPdDPn5w75Q3TWpneehs8UwotXS9vIBX1PEub24TluEENXpKPtkWza7k+DJf21o8D
	rP3pYC8strwzl/2pVmasVDzTeJgImZpA=
X-Received: by 2002:a05:6512:2305:b0:5c1:4e18:39ca with SMTP id
 2adb3069b0e04-5c17079ba12mr4824318e87.21.1794910140837; Tue, 17 Nov 2026
 02:09:00 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
 <20261106-apple-m5-initial-devicetrees-v3-6-cee55de54b2f@cyberchaos.dev>
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-6-cee55de54b2f@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 11:08:47 +0100
X-Gmail-Original-Message-ID: <CAD++jLmXOhfBJGmPa21id+XOafL8+XOJDygxkH6Pu5zxXq9MEA@mail.gmail.com>
X-Gm-Features: Aa3M54oHRchG8imGAtTdXZeU9Swv9RX1BbEKTTONGE2twBx83aIIvKlEdxp-34c
Message-ID: <CAD++jLmXOhfBJGmPa21id+XOafL8+XOJDygxkH6Pu5zxXq9MEA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] dt-bindings: pinctrl: apple,pinctrl: Add t8142 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:24=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> The pin controller on the Apple Silicon T8142 (M5) SoCs is compatible
> with t8140. Add "apple,t8142-pinctrl" as SoC specific compatible under
> "apple,t8140-pinctrl".
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

This patch 6/9 applied to the pinctrl tree.

Yours,
Linus Walleij
