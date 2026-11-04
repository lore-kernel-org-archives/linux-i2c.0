Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797467;
	b=YmVmRjeMbj1jiT9f2LpqiRqsaSiBxm9MnhxPhdwbXhIx11o3Z6aK6dWRwqZInZ1A7lZD
	 QpV5i6WKq3799o2RniLU5UzEuAOM5U6cxzXtXrdIh8ncdnXeCKglCzxcZqrB65SzoyZ8K
	 sM27PMrfdMfHQDVAZrt+0MHMBkYJaJ4tsBNhhIFRR8gfMMnHJRc/WPbIrwYcf3U6FSLjk
	 PWCE0Dmvk+Vqr+kFBi6L3yQ9UNqvRAxuyQRjLEoA+9NuwcfC/eeoE/+Kkfr6o//m9ZCC6
	 Pm5m/ORHQrb4ZgRSLbhZmH66CRQnSgZDc6zeb6/FDvVu1D4snNBLPN/sIYYetJIKdSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797467;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0gGIxmVj15HwpHlgucVC67kzMBeDjNiHcqiz6hAOrv8=;
	b=vIsb7Hdpy3E+uPzrHSTB7bcuBJnZT1z6QBM/kmEwuYRBrS1Ae3d+Of0osl6vPUC88Epr
	 yLot7Ou+sEanRN83Syjycd89o557lKsNOW5LVOq40D+VJrXbrMeUuiwpP4KPxhjAz3pax
	 Viy4Pz+OOKCmpq9m0OkHTZrSmnHZdNDf7hgHBzol2hTJ7DH3ZaUFGJsBm1gvyBsiTD9Wl
	 0rE/1Q/qa4S8Doin6SctJxkRcMo1tGRtXId4Tr1UuM9CAoV0tHkMGMYGZEdFr+ohYo6LJ
	 linFvq9v+by4/yzUmNruPW1WYQtuEnxvwTWb3YzYtkCvZW5tDtMcV5Hxqt2Vjdg2e/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C182rFoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD92606D81B
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C182rFoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6084B1F00A24
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797466;
	bh=0gGIxmVj15HwpHlgucVC67kzMBeDjNiHcqiz6hAOrv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C182rFozjpn+i/0Ts1DVq3b+ldJzLaYXncXGSKU5f4XCAI4+yQi49mycFeAVy/gy7
	 8i034pd2KQtcZ+CDX7gNbb1ARO9RfgRTbhmouZunnvcULJfaG9HPLVwZ3ytUngroM8
	 egwAbMwpz9XNDrjkbvaFb7ks4aeC1jnf/7xgjiQSSRWyIkLiOi9LhuCZ0m05jFhICK
	 nr+140ioY7Z+vWkH+hoTBBLG9p9apDmaJAyXwiVWq7Jj1yLXp7seJxi3P3EtW934rg
	 oWpdYy+4j+63c1HAegqRqhpSl5cl6n6imJzOTlCBDI2RliYbTkTkC1EonSRTyah1Td
	 f1twz4w1M1Eww==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso713914e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 05:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzar2AE82oxudLh0f/ojbEz83QqLnbz9IWUI1q8Ha79YYftAUnxr0oek64PUs/1uoaGY0eP/GQlp3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AgVRhEcLBJKJPDyvxEw8qqNRRP07KJ5XY1+QNQgrw3iCof4k3
	uhTg3aGyU7g5y6s7eFEGHxgOmt8X+sVleVEPAKK0JLVdWC9+Xy6Q+4n7LjLYaoCyxZs/pdlpio5
	QuL/vkxez4Svan+X3rykhvnqj4lAefmw=
X-Received: by 2002:a05:6512:39cd:b0:5bf:b166:f58b with SMTP id
 2adb3069b0e04-5bfd95782a4mr5476115e87.55.1793797464785; Wed, 04 Nov 2026
 05:04:24 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:04:12 +0100
X-Gmail-Original-Message-ID: <CAD++jL=2Z3hP74dHRyE3Aabp+PvpcHX_90PQy+a_HMQwBdNx6g@mail.gmail.com>
X-Gm-Features: AclHuK9_TlXav34NYeX4rfS2IYWnnq1y5c9wSfeOajfltWQaA7IZMQ4oBhaALpc
Message-ID: <CAD++jL=2Z3hP74dHRyE3Aabp+PvpcHX_90PQy+a_HMQwBdNx6g@mail.gmail.com>
Subject: Re: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
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
> Add the RK3572 pinctrl compatible.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

This patch 5/27 applied to the pinctrl tree.

Yours,
Linus Walleij
