Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506923A1E8C
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722763; cv=pass; b=o9nLPRR718ZzMDDeWDAEdvANeUy+tfix9SrU/vdhat+dHz3/wVsQJ64Ox1TLQIclRtKUZu/kz1xScd1WPNoBnKBVLSPbRr4HQCkTca0CVcSJLGBkLttSYxXbzK4WP/zECx68nIMCgPAJvSqDu8LzhkCRPYj/rR1ALrdeJCNX49Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722763; c=relaxed/simple;
	bh=jHS0ilS7g1CMN5ZK8zes++7dn1FRimCJWBs7yUa4Lxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDRvJVp/Bl4Vc15iEOs40PpaejXv8PmTeFbHEZpmVrPAegsPkNfW17bjuGYoTSOwALRXtlrPiJHkmqlGLyTDPE/6x43qYvZTo1qwXUTM0w8Sq2oVfjUhtpaeMNKaijpoQrTpoSNOSOOb9+x7c2BTv37PafIKpBkJK5OQm2+QcWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egDXJk0F; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egDXJk0F"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso1074609a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 01:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775722761; cv=none;
        d=google.com; s=arc-20240605;
        b=jJiXcmoWD5HLTS/qGhuhmHl+qOLDUXbpYdU9AJZ6hgXkdaGECPXKqAHHNF7fAGP7VN
         JlM5oDVYJSZbQmiPP7noYiJhkd83BwGNHBwm4/cLeXEr3TsY6AZOTpdd99egntxvTwXF
         IC1DzOHYOrcCP47jv6dpZ09Z0Zmrt0ZGuSAj3eNoedlyNViVdN6ibYgR7Hm2jXF64/xy
         1AoSLLPpIvj65EtnluoBoOcbReDv5lCWgYZfvFOQo0ww10zDLsjADgoJchFEAz93+pcR
         C0Gn60OqieVSdH3WMOs6T7Y6klUFxaXN6xWpnJILKK4v1eufEmUtOIagQ70K2poVeF89
         RTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TAxmTNbRbQNg/gEU9ThdCz2lz4k+tx2ML5iFc0liaHs=;
        fh=dyM+RoIcDT0PiLWg6jFUlEDS0K8puxFqgoWbFQDL7es=;
        b=OoFmbYW/QvVVRbw0OTytdBJsNm+uEQKEFHkteOUBvUEszWrqUlFaJkyp8Pr9mkv/zB
         9q3FfMV+4VE7ymifvY8D8qnWYU6yckbGf1B5MhZvtK2BPNp5Cj5dYi2m7eVUjTaXYrO9
         1iIXy4N47zdNCbkW3307P5i/AAJVaQglFGpzWrYmfG8qy+pxMk6Zk6RmjEI3Zy4AqAGo
         doh1pGwxHLHF5NRCA5bZgvJrsHziVry9JirsEoVQlfZcVNYgaAeaF3WbKAKjEGvsECwm
         7zGKN4sD84G8UiTZEUVPTe7RmfPygMDkcW/wPbxmQ0qFOAxfmYjDz5LJJb0QrCOuYwUN
         gksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775722761; x=1776327561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAxmTNbRbQNg/gEU9ThdCz2lz4k+tx2ML5iFc0liaHs=;
        b=egDXJk0F7C+EyhjSI8mL/MmnuZAbcv4AZXQtHmYpQFmQK1M9vwZvz4/fCk3BmJ99Q+
         5L4Gu6AB70VZR9EmDhRv+EqjFV2/CcWoJntafzj1kTJL3QfIxBGPf1G4dvTnhzxF/yxM
         Q3IWCOg28zaohMrDMAQUYPQEOldPikFcLXEakAZc6I2r9Cs52iU0tmDuiq61y7Q8cKkm
         ymlrExuU6mjbGF6CGkUf3bddEe/BgyUnX2nFwJ92VLcZu4SwFsQnbaG9QP0BoDeXfx0Q
         YXl5Lw+RRGlZnpXNqxwgM6fsz3yhX3FYRCCW9lUgT+vxDuMVLZxaE8AsWoIzCJG3H/0y
         Zlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722761; x=1776327561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAxmTNbRbQNg/gEU9ThdCz2lz4k+tx2ML5iFc0liaHs=;
        b=C+eOHtQrLojNsOXrpN6AFaN8kuMt7eaLv6bWW8a2QcGoUtVqyZ7dgcJsF1PJhh/LsZ
         yAoJQcPlOR+GcyNwD4vcXS5g/EUjc7aupytT/8mUZicNG0HsWd8VORzIYu0H6ad6f4Ul
         RfHFxaKDOtQBMT4LRn2Npq1FYkcuibvrGbZJRGuWkaMH8Yf73rV3Oz8ZTZ/qu9H4VNv8
         5qTg+1gpptRog/J/HLf2UEQjTaOC74EPP+6UnGqv6A0mmYLx1AaWq0NYxrQfMC3avxLJ
         bE90TN07fISz4iqtmFnNt8h9opoBTLLc42H9tJcSZOdLBwSm9N+cB68AEjxV1Md9ga48
         fLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf5We/ThM7y3XRJ6XBVO+l6DtmYQ8ubR9KfCptvn4t5bL+4c2bNS+G4ZMNLGNgnVUeiwyKspeq38E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BWp/BJf/A1trtSZZQEdCTdEa2YavDXiBvGCeTHaSiyO9uvAP
	czXVBjYQre8+bNXkpogP+GL+6yFHGCYQIA3RlluyxbvjtBIdvRvbqDqlAvT2UJIiOaqPyU305BH
	zNmGE+2D1V+sjUOONVzioLTUJMxB15o0=
X-Gm-Gg: AeBDiet9ZOgkE+QhF5Y0DuRY+y7cCKkOq4txAegPuw+ngz48V37ejJPjJ/ghsb9jQUJ
	wdZHnfcSIqHmKc3lDyJKuDmuRKDqXhkO3ItGAO5cuHl7f16rEdXkYRHjQxsR+Wl0RBpH1zvAL5A
	EridjG2ndiWhLWBiUjL6nWGMa4GessEQOj94019AvOKZ828/af9ToEnqRavjZiyucn7YE/juE/N
	wsieQuhzd3a6+aAqFNqx3AwFpDWXcUUt5kKJ35oGMwirZcD3n3PPPZscuQ8J6rVY5a2hWAjCZVH
	g4GsMyJW
X-Received: by 2002:a05:6402:4403:b0:66e:aca0:7c28 with SMTP id
 4fb4d7f45d1cf-67003fed4d5mr1344317a12.10.1775722760369; Thu, 09 Apr 2026
 01:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773991081.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1773991081.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 9 Apr 2026 16:19:08 +0800
X-Gm-Features: AQROBzBKuMNrIJGz8GW32I5rwsJFCx0e5ZCnixWxt1QzwEvhaZPhGrsPHuZHB30
Message-ID: <CAMpQs4KTMKrH3ARzM7iwY6tbQ6Zugyw1AfJAXWRMHk=86ufR5Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] i2c: Add Loongson-2K0300 I2C controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-i2c@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all:

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

Gentle ping.
Any comments about this patchset ?

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
--
Thanks.
Binbin
