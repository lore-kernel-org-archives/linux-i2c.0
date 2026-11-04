Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797526;
	b=k4CmIO/uHXnPOdaJ0qMDZDBw4pPoQLLyYnXvJbGq1t4MOIrZZZQWsh8sZ0GO1kdnhPaq
	 vzMVocVbRWZDVodaSHajvkBk5riMeP4X+QdotbjedKR2Ou7vrSaxwA5+bgHa0zWGnXIur
	 BOrV09vHeohdpBwhWImkftIf07kP41H0VNGCkxBj0TEF0hslL97kdKeEYDu2c03Zz/+Mi
	 dMMMYLNER50ZxgoRFJHuPSijcvCRoPT0LNp6l74wy0BDNt7P51tvYdd0qhf25ED0lt/cX
	 y7QXBNLXHSEE36IzZaTHo0LCXLpnILKJuEEY0smfF8yBQCEwheQTdJLbrZnVHmBF1CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797526;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LPKBxmhyg89L22fIaf9IQyOx1ftYYGNVMEyFVHYOx+w=;
	b=HVyYqIJdM+qxBc0qYYKUh37qvt24A/f+G7Kga0K87aaZyvMn0nbHpNNeHwhwFhG/jgT5
	 1+7LJiTfmqI4nJMkDgFJOBsA4h7ysrKdZkGQPgkd6peqhNlk/wzYkOyprveJ4VK1/Rybq
	 1aCEr5UVrMyJm4f9qJBylRPP9zp9tBEppWdrvxqBMWCVOMFtfLivoWZa1jsSlZrbbCdK8
	 RHBGN1jxR3y/b2HHKomn3dfdvys+SbdTsTCRmphq0bYnHBXAEk0cZ7cCj/htunLsR9Qdb
	 raws2gRRuJyZGFNnimuQoEbpIwhRjKmDiU3EfZ7kSq6bliCCsPtZKlsvTVKifE50i2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLqSLvYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E1606A333
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLqSLvYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C861F00A2D
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797525;
	bh=LPKBxmhyg89L22fIaf9IQyOx1ftYYGNVMEyFVHYOx+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WLqSLvYwRuBRb2z2uy097jLLlVZenw1O0Ud3+HdLZPMW2W/yzMsw4PoGFqDOIDUwu
	 bYeTnemOekwxxrWyrcu3N1/2zGODfTWspcTCv2AIYLDuBbLuQUV8lPQQYsoeeaXIZo
	 s9pxZA4n1vrlJHdLmklh37T+D8AiUXYc4GVoPjPUCjjcMlonowAys/U2PRW90Kfnup
	 tuf9hIDTCB7oNt5tvVL+asbU98CD4ARrQUGqF8Nf8SlgNeuq/Vl88CJ3YEo52TiM8A
	 criMClDoEAWjWwpB9F04k/fO5WKv51xfXn5g8+JQfVgeQbC0d/BD2BPOItMFG3+Cjh
	 JM4GUMBVSYcnA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be416e603cso409524e87.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 05:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByhocQCAG9B9AIFd4OVG+9sVK0gDAKSe7ZrrVrlwh2osV42ZmKeSDs1JXDHeryGqARmBDE18OWj3gs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qQua/zLP+wNmLE17a8BrFYf+fCpwRiRV5OsCljobFEOU+6v1i
	IoLzHTNfXqTgTXr8e8E847j3lvfzaABtT01MLBuWmCYEZuzx5C1jwFoHyXiXww6AACW2v8S/7we
	nLNKawbJNzHMz9AoYgo62au0P3VPwdSA=
X-Received: by 2002:a05:6512:3a89:b0:5bc:c446:760c with SMTP id
 2adb3069b0e04-5bfd956f3c7mr5830020e87.48.1793797524594; Wed, 04 Nov 2026
 05:05:24 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:05:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLkfnsnqr9DeJG1UY1BNPmXV=L1fh0o1fRgq2N70k3Aq2A@mail.gmail.com>
X-Gm-Features: AclHuK_mv5t_ofBXXvFmTtsscxk8ZZZWMu9yfbYuWEEuKyuLUDpVdyNQz1Is1sQ
Message-ID: <CAD++jLkfnsnqr9DeJG1UY1BNPmXV=L1fh0o1fRgq2N70k3Aq2A@mail.gmail.com>
Subject: Re: [PATCH 06/27] dt-bindings: gpio: rockchip: Add RK3572 GPIO banks
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:12=E2=80=AFPM Cunhao Lu via B4 Relay
<devnull+1579567540.qq.com@kernel.org> wrote:

> From: Cunhao Lu <1579567540@qq.com>
>
> RK3572 GPIO banks have four parent interrupts and a separate debounce
> clock.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Perhaps Bartosz can just apply this one patch to shrink the series?

Yours,
Linus Walleij
