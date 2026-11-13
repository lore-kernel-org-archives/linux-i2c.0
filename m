Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590996;
	b=ciJKkFfaxgoe96+mbXTz+VWTLnLf8IgAAjGBXTASRCUSlfUUIU8FlkfpHbvEQwGaA3Ll
	 FxAeb8BMxWjBj2FlItuiRA8a/UOrgwFCWOQgR5o1KJEKkKIwW4aOYiwsinLsLI+kdf7OP
	 sKGdFcEXoPm5HGbNFBSiXaRr83FycTWSknHNK+5S2gRZI8kU/aCqUYz+Nm+gR0ThVj8kP
	 w9Jg6Wo0Aom+HLvKG+/Ln0PYFpNG1nlDwoExXH5QJe3akVaCGGzYTCJ3diYZEsqKrYMPP
	 iv8aBaBREk3M3E0/CCWVg/VMaiz330mNv1qN6DflfKiGeSRMbCDEyp8raBNDU5xPbxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590996;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dqCS52njA2aiVteiRfpDb/yZ504mBEljecH8GRJRMOg=;
	b=zt3JA7p2l4Vyo0ZSDpbN783WaREYegreJSd4uY+KWrLTq5HnSaqgyaNohPpC+HurcSgO
	 4CcmBtAWrc35hYTabHDpVwhdK4h5x2ifr6YQTWSHqVfPuDtQHiSWpd3x2iNEAePGTExC8
	 HTP88vM+8OOr3z6nXM7KTJlwKClKl7Dre1ROTrQuSR9dz+KlF9G/8UdwgYVxOJtaOOhyf
	 yF3jFbXRxGyXKJNSg+ZsYmji7UDH5HXbGb0mSaqBR3+uvbJPbtvVFJjLOStVCp4up2ET7
	 AijQmbB7jC2UIub10eCXQEXKuk4xK4Q947W4of7fjl7V2KFuoAwbwLKvxpMlNzKkD+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCT1quRA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A3607140F
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCT1quRA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB151F000CE
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590996;
	bh=dqCS52njA2aiVteiRfpDb/yZ504mBEljecH8GRJRMOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZCT1quRAUwf/hSib9hKarf/C4aWNH+c0kUQ8fPD7brf16euOOjr+OjXTF+ZlqepoF
	 Ur41qfBxqp+V7vVSNyPqYAV2nO+ILQdwgZWVuNJGSebm1OyZ96rmxIQl2jMha+IabZ
	 mw5g3/Jg6ngHj1T+bUksRh/qxypq1AMBvZKhhfcqNgNugviTQBTnh2lxV+c93BRo0r
	 DC8SBTKgYxYk1S1ZSWWcdz5QdV/hmEldzW9+piOy9pYnIHhg8qoMZOAU1oL6q6DAB0
	 MA7PiKlYeMc9hPKpqKAGzGEJWXFofsDO8YHD1qmOupoHsT+sn4PEhEEK6f4xr3nybk
	 ycGqGzOGAv0Lg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso18266941fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG7o1qHWaf3CA2mXMs16xtSbAWr9+wyL9quK7s3sPqlfTZN6+UBDSuhkmoFMsVquw21PtLQZhhd8tk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kr4GXVFPeKETHg/bD5ssHaMMzEokVKbKRFsjBH8GVyHZzLYfI
	ySOUfi800LGaKGC1ACSNZuSgqBeMPSYtd3P5Zvd+OOWi2wvVorCZKQQ5jOnNk45yfc2kIJMFPPq
	xUaVBQiDaPetqMpWpoAune/HvHbRW+Wo=
X-Received: by 2002:a2e:a543:0:b0:3ad:f04e:d342 with SMTP id
 38308e7fff4ca-3ae2b68c4acmr9609891fa.20.1794590994354; Fri, 13 Nov 2026
 09:29:54 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110085125.2535508-1-johan@kernel.org> <20261110085125.2535508-5-johan@kernel.org>
In-Reply-To: <20261110085125.2535508-5-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:29:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjPPrHOy6iwWt_BubH+QvekgWQYrA+Y7GkvittHU10DA@mail.gmail.com>
X-Gm-Features: AclHuK_IKc6zUppJnoMJ2CNbOeKvfrjfnic31BW-zR148q8dXf7IdOqQfKMoni8
Message-ID: <CAJZ5v0gjPPrHOy6iwWt_BubH+QvekgWQYrA+Y7GkvittHU10DA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] swnode: ignore primary nodes in device_remove_software_node()
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> device_remove_software_node() should only be used to remove secondary
> firmware nodes added by device_add_software_node() but will currently
> drop a reference also if a device has a primary software node.
>
> Bail out early if device_remove_software_node() is called for a device
> whose primary firmware node is a software node and fix up the two
> callers that currently work around this themselves.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/core.c         | 3 ++-
>  drivers/base/platform.c     | 9 ++++-----
>  drivers/base/swnode.c       | 3 +++
>  drivers/i2c/i2c-core-base.c | 9 +++------
>  include/linux/device.h      | 1 +
>  5 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bf97b06337a1..460c7ad1eaeb 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5212,10 +5212,11 @@ int dev_warn_probe(const struct device *dev, int =
err, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(dev_warn_probe);
>
> -static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> +bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
>  }
> +EXPORT_SYMBOL_GPL(fwnode_is_primary);

Not used in modules as Andy said, so need not be exported AFAICS.

>
>  /**
>   * set_primary_fwnode - Change the primary firmware node of a given devi=
ce.
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index be5d2f315fdb..e0b38dbd5acf 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -598,15 +598,14 @@ static void platform_device_release(struct device *=
dev)
>  {
>         struct platform_object *pa =3D container_of(dev, struct platform_=
object,
>                                                   pdev.dev);
> -       bool fwnode_is_software_node =3D is_software_node(dev_fwnode(dev)=
);
>
>         device_remove_software_node(dev);
>         /*
> -        * If the firmware node is a software node, its reference count
> -        * was decremented by device_remove_software_node().
> +        * Must be done after device_remove_software_node() which may hav=
e
> +        * freed a secondary firmware node and cleared the fwnode pointer=
.
>          */
> -       if (!fwnode_is_software_node)
> -               fwnode_handle_put(pa->pdev.dev.fwnode);
> +       fwnode_handle_put(dev->fwnode);
> +
>         kfree(pa->pdev.dev.platform_data);
>         kfree(pa->pdev.mfd_cell);
>         kfree(pa->pdev.resource);
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 5dc2029f9a7b..a90c20cb84e6 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1108,6 +1108,9 @@ void device_remove_software_node(struct device *dev=
)
>         if (!swnode)
>                 return;
>
> +       if (fwnode_is_primary(&swnode->fwnode))
> +               return;
> +
>         if (device_is_registered(dev))
>                 software_node_notify_remove(dev);
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index c55ca14eaad9..af3ae2a83626 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1056,7 +1056,6 @@ EXPORT_SYMBOL_GPL(i2c_new_client_device);
>  void i2c_unregister_device(struct i2c_client *client)
>  {
>         struct fwnode_handle *fwnode;
> -       bool fwnode_is_software_node;
>
>         if (IS_ERR_OR_NULL(client))
>                 return;
> @@ -1067,14 +1066,12 @@ void i2c_unregister_device(struct i2c_client *cli=
ent)
>         else if (is_acpi_device_node(fwnode))
>                 acpi_device_clear_enumerated(to_acpi_device_node(fwnode))=
;
>
> -       fwnode_is_software_node =3D is_software_node(fwnode);
>         device_remove_software_node(&client->dev);
>         /*
> -        * If the firmware node is a software node, its reference count
> -        * was decremented by device_remove_software_node().
> +        * Must be done after device_remove_software_node() which may hav=
e
> +        * freed a secondary firmware node and cleared the fwnode pointer=
.
>          */
> -       if (!fwnode_is_software_node)
> -               fwnode_handle_put(fwnode);
> +       fwnode_handle_put(client->dev.fwnode);
>         device_unregister(&client->dev);
>  }
>  EXPORT_SYMBOL_GPL(i2c_unregister_device);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6b082c638d45..229a15625766 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1280,6 +1280,7 @@ int lock_device_hotplug_sysfs(void);
>  int device_offline(struct device *dev);
>  int device_online(struct device *dev);
>
> +bool fwnode_is_primary(struct fwnode_handle *fwnode);

Could this go to drivers/base/base.h until there is an outside user?

>  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode=
);
>  void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwno=
de);
>  void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> --
