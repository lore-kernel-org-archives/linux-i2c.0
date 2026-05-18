Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6930567F
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090803; cv=none; b=qmDRXVQNjnOhyG0NzwBEoEN+CSyoug9owzCjRGiFXaISZIywslMdeawVqtMojeCk6Rs5inqqitWX9ISq22lUbAzljt5XVBPkM7h0VNmT6UghjHOYzWmJWKZJXcSWvN4gmkYpPd3kvYC0wt58b1WPPZT+P4ttLSypmkrntdePafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090803; c=relaxed/simple;
	bh=50ZnGywaCeNEbMW4oAwSuzfyJQ9/YK+/ukDRtjvHMN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRd8H0dHn9e/YgDz+EKOQmQ2NRMwU/z0sWt3unybhV+O64WC9sqz7oSPg7oKgY1VG8NrOA2AknRk2QpaE6jLU7Npb6BE7uCdq22ycXr7BVq8JDz6Am6rYyQ9WbpYY787Ca03o2k2G/QRHpDaoyQYIZYCEsosUDDDoUu9+HfyI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7GgbRi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7GgbRi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395B9C2BCF5
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090803;
	bh=50ZnGywaCeNEbMW4oAwSuzfyJQ9/YK+/ukDRtjvHMN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M7GgbRi9W6Dg7gR4ETnmrGd3H9q/+k+pwZRXf6/xO7RrDcQPOT/9lzNQa8tSUtHpE
	 YsMzylrOBHMBhdJlnTXItOGGuvZg8fMxyN6u4gWKATqg4XwB57KDYWiUU7faxCV7sB
	 eIpmF6jpBrGPnLOZtM1kEeFPOL4yECOquJvCJB84e4RqEAI0CL79A2egPvnOeVHGaK
	 NACDMmQNCnsXKa6DfsG65B88t7iDbJOycg0A49TcMe6Vlp3RwXh/y8shMEdy3QGBOO
	 Ul/onbpoHQRdOgRbqZz+Pb6peaYJ0P3d40ZfQd26USJYqgyx57LtTgpa4G8mu04IZs
	 Tnk7X4eCchc7g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393da8f389bso19728401fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 00:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2zTGtg9G5CBftF0Ji6HqBDLQjSGBxSwO3acb7F1frStpnoSs6CXzwgTIP4fsFMmUdxsQd9XokuhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8aMoBU3jBPqyWpD0H9C7baXgmvQm3MQjK8Xh4iDePj3u30Ra
	+1PLQj2HPOym7rC0VJIfNMlC2kRv275XJWq44aHRcezLTyP7LnS3qwmM8RzbeNM0Bcc/fKf3DWM
	13z3/QbsjE4/3BQLPY/rODYnusAUxqPtzDeGSYJ2g1A==
X-Received: by 2002:a05:6512:1317:b0:5a8:fbe0:bc71 with SMTP id
 2adb3069b0e04-5aa0e611478mr3926737e87.15.1779090801889; Mon, 18 May 2026
 00:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 18 May 2026 09:53:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
X-Gm-Features: AVHnY4LXzZXDOK2hIQKToWN8i8x5dkxIPDE_4j_k6yWNjwBeUZq1_mHbBwIEvuw
Message-ID: <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of i2c_device_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Eric Piel <eric.piel@tremplin-utc.net>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <Akshay.Gupta@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 6:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace and commas.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> Hello,
>
> the mentioned change to i2c_device_id is the following:
>
>         diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_=
devicetable.h
>         index 23ff24080dfd..aebd3a5e90af 100644
>         --- a/include/linux/mod_devicetable.h
>         +++ b/include/linux/mod_devicetable.h
>         @@ -477,7 +477,11 @@ struct rpmsg_device_id {
>
>          struct i2c_device_id {
>                 char name[I2C_NAME_SIZE];
>         -       kernel_ulong_t driver_data;     /* Data private to the dr=
iver */
>         +       union {
>         +               /* Data private to the driver */
>         +               kernel_ulong_t driver_data;
>         +               const void *driver_data_ptr;
>         +       };
>          };
>
>          /* pci_epf */
>
> and this requires that .driver_data is assigned via a named initializer
> for static data. This requirement isn't a bad one because named
> initializers are also much better readable than list initializers.
>
> The union added to struct i2c_device_id enables further cleanups like:
>
>         diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m2=
4lr.c
>         index bf2194d7cdbd..e0d7d8739e67 100644
>         --- a/drivers/misc/eeprom/m24lr.c
>         +++ b/drivers/misc/eeprom/m24lr.c
>         @@ -104,9 +104,9 @@ static const struct m24lr_chip m24lr64e_r_chi=
p =3D {
>          };
>
>          static const struct i2c_device_id m24lr_ids[] =3D {
>         -       { .name =3D "m24lr04e-r", .driver_data =3D (kernel_ulong_=
t)&m24lr04e_r_chip },
>         -       { .name =3D "m24lr16e-r", .driver_data =3D (kernel_ulong_=
t)&m24lr16e_r_chip },
>         -       { .name =3D "m24lr64e-r", .driver_data =3D (kernel_ulong_=
t)&m24lr64e_r_chip },
>         +       { .name =3D "m24lr04e-r", .driver_data_ptr =3D &m24lr04e_=
r_chip },
>         +       { .name =3D "m24lr16e-r", .driver_data_ptr =3D &m24lr16e_=
r_chip },
>         +       { .name =3D "m24lr64e-r", .driver_data_ptr =3D &m24lr64e_=
r_chip },
>                 { }
>          };
>          MODULE_DEVICE_TABLE(i2c, m24lr_ids);
>         @@ -478,7 +478,7 @@ static const struct m24lr_chip *m24lr_get_chi=
p(struct device *dev)
>                 if (dev->of_node && of_match_device(m24lr_of_match, dev))
>                         ret =3D of_device_get_match_data(dev);
>                 else if (id)
>         -               ret =3D (void *)id->driver_data;
>         +               ret =3D id->driver_data;
>                 else
>                         ret =3D acpi_device_get_match_data(dev);
>
> that are an improvement for readability (again!) and it keeps some
> properties of the pointers (here: being const) without having to pay
> attention for that.
>
> My additional motivation for this effort is CHERI[1]. This is a hardware
> extension that uses 128 bit pointers but unsigned long is still 64 bit.
> So with CHERI you cannot store pointers in unsigned long variables.
>
> Best regards
> Uwe
>
>  drivers/misc/ad525x_dpot-i2c.c         |  52 ++++++------
>  drivers/misc/amd-sbi/rmi-i2c.c         |   4 +-
>  drivers/misc/apds9802als.c             |   2 +-
>  drivers/misc/apds990x.c                |   4 +-
>  drivers/misc/bh1770glc.c               |   6 +-
>  drivers/misc/ds1682.c                  |   2 +-
>  drivers/misc/eeprom/at24.c             |  62 +++++++-------

Hi!

This drivers lives under drivers/misc/ but I maintain it separately
and send PRs to Wolfram so they go through the i2c tree (historical
reasons really and maybe we should move it under drivers/nvmem/?). Can
you send this separately?

Bart
