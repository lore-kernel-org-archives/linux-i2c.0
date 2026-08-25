Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447123890EC
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644191; cv=none; b=rVBP/h8eV4p5oGkCQQcg2MU2tS6oSpsCz/Oqt+N+VUw07QBSI1X0KfN3Cak0BDQZ9RxfoAhFVfX2PBdj1EXNmBGLIHk5Hsa8qEzIWv/dZKj8EZ4aMAB4rZ+yKOxolnw/inNg8AYKyc5+OKmgPXvWAbL8Tj2fdgbPIBF29E0zngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644191; c=relaxed/simple;
	bh=AGPUJvy6/WWNpoBO52LwnbUPqQOFQ18ZAU04xEE45/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4XYdWSJJwDXPBeHPhD5TYCNq2PpLYlS9r24p0dyojq/hWRf/J4IwkNDbnFLEssee2RZ3NvtLN/4FeAI6NeZaul49SYfcEKvjT7s+Sd9ZDmg+7GsMFjMTED7wZSBt9utHBoRgEJCo4vSwJVhJMUwhKylRyc5aZIB1FC4b4iJeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDrXyuAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDrXyuAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024AE1F00ADB
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644189;
	bh=YjhxMFTg6Dkjbfc3K3kwX4KsYf7ic7xd8S2u4eCcId0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iDrXyuAv/tQUdUZH3zDL+7ytt1ns3wtuzZIMoDcN9dMkCDCO9qI/EOiUDx5qEe3Jz
	 XXVD9/ESqEjpjFpf5PdMahTduAQg1rBx3VrW1QWIpKbS6e0oXHWe02GCquNyd05Jen
	 w9n9hy1rPAEu3qmGHC0jBwcI/vRtPR+val1Yk98a/6tL3wYV/5UrXdWMkBb4tZM3Hl
	 QAjQ7hydTralQGqbKcfsOkJ62xnbS++Q5p/f7Kz8F5pSGuPqDTN7JdkNlXLLabrgLY
	 jHe7mGB3kc+Yocx0W4sqH1Zm2x+mtxdm0ie5M4QzyIi1hk01x3nxjjdwO+EJkyKKmt
	 qnHDxayJhJhdg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aec201b582so5026931e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 00:49:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpgZ+G3jWaXWl3SwfATMTw2qC0Xgj1S0Zfq7J9ZIiHRbljtmnk5f05RqIr53lM9cnRJcUnNAfN6kVw=@vger.kernel.org
X-Gm-Message-State: AFuF++kN3viodZT47AqxC3K41c1ba9FmKyZNsmk2NN+For8FiKa3dF7z
	xsjUqwD6pR39N0AZNkQQI1S8OjYz8L4S6mXywJxYkfI+9cI9BDlY9GevV07jXhA0oPWX1n6BdgG
	r27rc8uLggY3wwW67cgBBjYPP04ji4H0=
X-Received: by 2002:a05:6512:398b:b0:5b0:eda:de25 with SMTP id
 2adb3069b0e04-5b48b8842c7mr6931537e87.6.1787644187690; Tue, 25 Aug 2026
 00:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-2-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-2-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 09:49:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLmVfkZj0pnwN8EY7MmBzt9hXHcdFbF4=y6BXqpbmbJ71A@mail.gmail.com>
X-Gm-Features: AcwNN1VDSIEN1O_KlxOxJ4LSVUsknzQ5a2So62m__5s_y83VSIXXTe9XoEJFEco
Message-ID: <CAD++jLmVfkZj0pnwN8EY7MmBzt9hXHcdFbF4=y6BXqpbmbJ71A@mail.gmail.com>
Subject: Re: [PATCH 01/13] HID: ft260: add serial driver
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Beer <daniel.beer@igorinstitute.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael, Christina,

thanks for your patch!

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> From: Christina Quast <contact@christina-quast.de>
>
> Add a TTY serial interface (/dev/ttyFTx) for FT260 USB HID devices,
> providing baud rate configuration, data transfer, and termios settings
> without requiring userspace HID report formatting.
>
> The FT260 exposes I2C and UART through separate HID interfaces. Only
> I2C was supported previously; UART required FTDI hidraw example code.
>
> This is a port of the v4 patch, adapted to the I2C hardening that has
> since been merged upstream: input-report length validation, the
> read_buf/raw_event race fix with read_lock, and SMBus block-read
> START/STOP handling. HID_FT260 now depends on TTY because the UART code
> is part of this driver.
>
> Routing UART reports through ft260_raw_event() also made v4 fall through
> the report dispatch after an I2C input report had already been consumed,
> so every I2C input report was additionally reported as unhandled. This
> regression is fixed here.
>
> Ported from:
> https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-qua=
st.de/
>
> The follow-up v5 series stalled without being applied:
> https://lore.kernel.org/linux-input/20240216-ft260_review5-v5-1-36db44673=
ac7@christina-quast.de/
>
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> Co-developed-by: Daniel Beer <daniel.beer@igorinstitute.com>
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> Co-developed-by: Michael Zaidman <michael.zaidman@gmail.com>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
(...)
> +/* UART interface configuration */
> +enum {
> +       FT260_CFG_FLOW_CTRL_OFF         =3D 0x00,
> +       FT260_CFG_FLOW_CTRL_RTS_CTS     =3D 0x01,
> +       FT260_CFG_FLOW_CTRL_DTR_DSR     =3D 0x02,
> +       FT260_CFG_FLOW_CTRL_XON_XOFF    =3D 0x03,
> +       FT260_CFG_FLOW_CTRL_NONE        =3D 0x04,
> +
> +       FT260_CFG_DATA_BITS_7           =3D 0x07,
> +       FT260_CFG_DATA_BITS_8           =3D 0x08,
> +
> +       FT260_CFG_PAR_NO                =3D 0x00,
> +       FT260_CFG_PAR_ODD               =3D 0x01,
> +       FT260_CFG_PAR_EVEN              =3D 0x02,
> +       FT260_CFG_PAR_HIGH              =3D 0x03,
> +       FT260_CFG_PAR_LOW               =3D 0x04,
> +
> +       FT260_CFG_STOP_ONE_BIT          =3D 0x00,
> +       FT260_CFG_STOP_TWO_BIT          =3D 0x02,
> +
> +       FT260_CFG_BREAKING_NO           =3D 0x00,
> +       FT260_CFG_BEAKING_YES           =3D 0x01,
> +
> +       FT260_CFG_BAUD_MIN              =3D 1200,
> +       FT260_CFG_BAUD_MAX              =3D 12000000,
> +};

What kind of "enum" is this that re-assigns 0x00, 0x01 etc to
several enumerators?

Either this is four different enums or you should just do a
series of #defines instead if they are all really coming from
the same place, because using an enum like this does not
make sense: it's like numering pears, apples, oranges
and peaches in the same enum or something.

Also use the UART_ infix as mentioned in the GPIO patch
so you don't need to immediately change it in the next
patch.

Yours,
Linus Walleij
