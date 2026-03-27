Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C92652AF
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579815; cv=none; b=k5XLuGj06r+mZnOtLgX5AJ4FKMxomQXlRrtduTwG8C9CiDAkBTa3WNqaRA9jXQlUCdDFRAgrUxRaYyAcYqGjHSS0eua20qPOjfn/VMNxexKxCNH2ZTB3EGuH0+stuIlbde+euixs9kMxz+U8OTmelUNsew9trsoXhkPcBfF89bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579815; c=relaxed/simple;
	bh=EeR2ghfQJW+Im1ogJ1DveL3qKBLXf5xwwrhzVm92TwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTrviXN50KWzC44kO7Lfm+BO/nl8DYY3N19lJAH4RhYbcR5X1gwAU9iFjOj/bV8cqLnw/jvQTgXTNBacWM7gfi26gCW5BNuifc4p6d0QlmmLe9di58qEHcPHX9TzfCKi2ZBGyyjbo2+/D0lamX77WuufKI4wVJT7pjo8/dncCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQqSUPlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQqSUPlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA29C2BCB5
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774579814;
	bh=EeR2ghfQJW+Im1ogJ1DveL3qKBLXf5xwwrhzVm92TwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aQqSUPlhKnKTufTllpwSEQ08jG9hc8kHYX7eOulcmajI34kwCHmiAs/iM9ugsiBOz
	 Ze69PAlguKgMxt2t+gLAihwaQGYBFSHX52o2r+UPZS1QVmpdH7t0sw4C4le+YMj/qI
	 bkNTEqZz7w8PxYMKAOUBpO9ZHsC+lnSA6iJubqhD/0aNKFkr4ApohjolKcPQio+vPA
	 wAErcRIaKL9cjzJ/lvnjCALofjUFaaP//soE/T2AhBoJ4VWYYl+YVVbEJrjfRgulHq
	 phN56rEIiHy2ZwaVdvFep2xyVsXwUczLrP4JzmcUtPkwRnLkRzYMKjXgt5vmR4Uod8
	 X2tam9Yndiqlg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so2006341a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 19:50:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjmuYodoY5fAoc8ytQD400Izb9MT6fBPPUTiA5FywwdP99bsMlLbRH31wlZtQdnfvdrWHPH+1Hzq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ddVxwD4IMC5te1akNYS/DL+T2mLOjlwXtzLw8+SiIKlBcmeX
	bv/2TqD4QNFmvSFhdBtEPSjUSbzGK5b56Z3ed5bAbR75H2nfUpiKGr1E6iM/OFbRRi0JlsOD7gi
	Vl3qdqaO5fgSx2Rc2TlUncOJtCvke+vg=
X-Received: by 2002:a17:907:960e:b0:b98:6c41:a77f with SMTP id
 a640c23a62f3a-b9b50360c1bmr41758066b.20.1774579813141; Thu, 26 Mar 2026
 19:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773991081.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1773991081.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 27 Mar 2026 10:50:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VYjdAxEpC48k6kLO8zva35ZBwHdEXZ0fwrcbpBN8dZQ@mail.gmail.com>
X-Gm-Features: AQROBzBu9j-t6TF29c5qqk7L_3HlwULFXFLlCYEI3RHQk_QGfgebXI10G_BgZOk
Message-ID: <CAAhV-H7VYjdAxEpC48k6kLO8zva35ZBwHdEXZ0fwrcbpBN8dZQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] i2c: Add Loongson-2K0300 I2C controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Fri, Mar 20, 2026 at 3:26=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> This patch set describes the I2C controller integrated the
> Loongson-2K0300 chip.
>
> It has a significantly different design from the previous I2C
> controller(i2c-ls2x), such as support for master-slave transfer mode,
> and  DMA transfers (implementation in progress), etc. Therefore, we try
> to name it i2c-ls2x-v2.
>
> Thanks.
>
> =3D=3D=3D=3D=3D=3D
> V6:
> - Rebase on linux-i2c/i2c-next;
> Patch (2/2):
>   - Update comment;
>   - Use regmap_get_device();
>
> Link to V5:
> https://lore.kernel.org/all/cover.1773142933.git.zhoubinbin@loongson.cn/
>
> V5:
> - Rebase on linux-i2c/i2c-next;
> Patch (2/2):
>   - Add time.h header file;
>   - Add the `MHz` suffix to `parent_rate` and `freq`;
>   - Define an iterator within the for loop, with its type being
>     `unsigned int`;
>   - Use dev_err_probe() in loongson2_i2c_adjust_bus_speed();
>   - i2c_adapter_set_node()->device_set_node().
>
> Link to V4:
> https://lore.kernel.org/all/cover.1772714348.git.zhoubinbin@loongson.cn/
>
> V4:
> - Rebase on linux-i2c/i2c-next;
> Patch (2/2):
>  - The parent_rate parameter type should be `unsigned long`;
>  - Drop fallthrough and add missing break;
>  - device_set_node()->i2c_adapter_set_node();
>  - Use i2c_parse_fw_timings();
>  - Use i2c_t.bus_freq_hz instead of priv->speed;
>  - Sperate loongson2_i2c_handle_read() into loongson2_i2c_handle_read()
>    and loongson2_i2c_handle_rx_done().
>
> Link to V3:
> https://lore.kernel.org/all/cover.1772001073.git.zhoubinbin@loongson.cn/
>
> V3:
> - Rebase on linux-i2c/i2c-next;
> Patch (2/2):
>  - Reorder header file follow IWYU principle;
>  - Better indentation and coding style;
>  - Use generic macro definitions;
>  - Amend *all* struct data types;
>  - Correct unreasonable variable type definitions;
>  - Refact loongson2_i2c_isr_error();
>  - of_property_read_u32()->device_property_read_u32();
>  - Remove meaningless blank lines and output.
>
> Link to V2:
> https://lore.kernel.org/all/cover.1769476820.git.zhoubinbin@loongson.cn/
>
> V2:
> Patch (1/2):
>  - Add Acked-by tag from Conor, thanks.
>
> Patch (2/2):
>  - Reorder the definitions of read() and write();
>  - Adjust the calculation method for bus speed.
>
> Link to V1:
> https://lore.kernel.org/all/cover.1763018288.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (2):
>   dt-bindings: i2c: loongson,ls2x: Add ls2k0300-i2c compatible
>   i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
>
>  .../bindings/i2c/loongson,ls2x-i2c.yaml       |   4 +
>  MAINTAINERS                                   |   1 +
>  drivers/i2c/busses/Kconfig                    |  10 +
>  drivers/i2c/busses/Makefile                   |   1 +
>  drivers/i2c/busses/i2c-ls2x-v2.c              | 544 ++++++++++++++++++
>  5 files changed, 560 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c
>
>
> base-commit: e9b13580b334040da0184a9f32106d808acd7fd5
> --
> 2.52.0
>
