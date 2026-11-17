Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929092;
	b=uodfOEF3mkCDcsraSG8fRnx4NKkBZjUHK06EVb6Z/1ccos4QkSmy+FwygeCWkQeaWIIi
	 7/yzrYyM+N2hMlISy1ByWDTN5ByQtyRiAkjwIP9VIQ8Nm/sAfg9xQyxqNXaZ8hghJOzks
	 GNDoovfA76sZZWWLNq+AdOLj62BqU5nRJx+hxMpq3WpMptBR9f0EXgAcPIR403WHjrlkn
	 qFdxAVLc7XxZqgLYAF2WHEZRoaDejzkjoFmt08lvePUNO+JeXKuoofb6HLiuw96aRlJv5
	 rT21XhuSKKGjfq1ZzRBbVQev+qYeeZ1GSOZQfvt+USrXjeLOeLxbr+pjp8T4/ZrZ2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929092;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=owUxkx0waQYLHyGdkFtlGZQfGLiII76Q0xu/x3d+nRw=;
	b=mBs/zgAlQR4VUUjD2vsdhYAdNdLtdWxQFWm+ddBpDo6EhWgyv20Gad9zeJFYDN1IMJ64
	 ToLYCF3U+f0J+bwMpLb5NuAcpHt832dYkhBOgiayezRRuIRghZ+ssQLusBR7pN8BfGpuV
	 OY2I6ep4zLuuEWCcHLEVmbwDIV59kv0Eu4kV2cWi5xW3KWg2Wxvb6SrEJJ9FvMxfJ/Onn
	 ANx8jL0THytw2nWcLcwGM8TQ/Y6xe52a883+/5jeDIWjN+7BG1SeirJfbFdR8Cp0+qHIJ
	 QYoJBuuZQ0OGqfSGBvAqIw8/Zyp924dcIckMF5aPWLJIgAr+zvcLCpKnYTLRHNpijhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPXWqmgB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DF606A334
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPXWqmgB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AEC1F000CA
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929092;
	bh=owUxkx0waQYLHyGdkFtlGZQfGLiII76Q0xu/x3d+nRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OPXWqmgBgZOxpK6QofRA+AYEy7YqwjRQmH+GgpqtW5jLIIh276sYWaL7z4xEF107x
	 qJfrvGyb+T3oy7U20NAADKHAEQiiRl02MILK17RY9hBt2XBh3b4x8DkzdTlLQr4MtG
	 B82VWTm4Xpsq/hH2N+Qhf4mBtptNM90t3/Ql0GWvFagvj9AZYLhl1yKpTCzxEZQlxH
	 8hAXXDwSYIfnIinKiIxd4HPbqIhj4nnreQqAtJ/jPxCjS9+BS1IPZzA80ux07TyLCG
	 NgXVegj+OILymFq+6dYeirBn1KV3LS+NFwgJG1pZQuSA9MNpmHJERzcNnlIALtNAQT
	 TSFlIi7tPvTAw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae0d0b9db2so45745991fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 07:24:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGmsRpXjsGp9QRxsKUaWeUXs5jXBgOOARrOfNNSJacKFuCAMh3nD6sjAv5O3OcgXJmk6tq+QU2Kg2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dPUoPTA5lqgismBQsQzt36gX+Vg794UAgW7EuZyHi77N3Akia
	Gr6P0fGF5jgLaJ9zQBMVzyB1CYw+pCGdAp8ECW80O27hfVRwKS4dAQDXqFDaVyC+tLZRRJX8dLl
	rEfPGlxvzUVf26GUVnn+vkO3+F2Q2dII=
X-Received: by 2002:a05:651c:a349:b0:3ab:3607:df9e with SMTP id
 38308e7fff4ca-3ae2b55b51dmr43508751fa.13.1794929090359; Tue, 17 Nov 2026
 07:24:50 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117101336.980216-1-johan@kernel.org> <20261117101336.980216-6-johan@kernel.org>
In-Reply-To: <20261117101336.980216-6-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 16:24:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gqzdTE6DcqDf_cVh5t4h5rgRN8CZuHxnBrf-rbcu3bCA@mail.gmail.com>
X-Gm-Features: AclHuK-EMNJERpEtRyMX7j8M3ufXfjpr3tV94hB12B8ho6-cZ5LQAbTgYt7J0Tc
Message-ID: <CAJZ5v0gqzdTE6DcqDf_cVh5t4h5rgRN8CZuHxnBrf-rbcu3bCA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] driver core: platform: warn on bad fwnode assignment
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Commit e6054f410c97 ("driver core: platform: amend the API contract for
> fwnode setters") added a warning to platform_device_set_fwnode() in case
> the current firmware node pointer points to a software node as that may
> prevent software_node_notify_remove() from being called.
>
> This is only an issue if the platform device has been registered however
> as software_node_notify() is only called for registered devices. A
> bigger issue is that a secondary firmware node assigned before the call
> may be silently lost (and leaked in case of software nodes) as these
> helpers do not use set_primary_fwnode().
>
> Amend the current software node check, which fails to trigger if the
> device also has a primary non-software node, with a warning in case the
> device already has a secondary firmware node assigned to catch any
> (hard-to-debug) issues due to a secondary node being assigned before the
> call.
>
> Note that this also avoids making claims about the device firmware node
> pointing to the primary firmware node, which is not the case when the
> device only has a secondary node.
>
> Fixes: e6054f410c97 ("driver core: platform: amend the API contract for f=
wnode setters")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/platform.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index e0b38dbd5acf..06ce980b57b1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -708,9 +708,10 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
>   *
>   * Assign an OF node to this platform device. Internally keep track of t=
he
>   * reference count. Devices created with platform_device_alloc() must us=
e this
> - * function instead of assigning the node manually. This function must n=
ot be
> - * called for a platform device that already has a software node as its =
primary
> - * firmware node assigned.
> + * function instead of assigning the node manually.
> + *
> + * This function must not be called for a platform device that already h=
as a
> + * software node or secondary firmware node assigned.
>   */
>  void platform_device_set_of_node(struct platform_device *pdev,
>                                  struct device_node *np)
> @@ -726,21 +727,24 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
>   *
>   * Assign a firmware node to this platform device. Internally keep track=
 of the
>   * reference count. Devices created with platform_device_alloc() must us=
e this
> - * function instead of assigning the node manually. This function must n=
ot be
> - * called for a platform device that already has a software node as its =
primary
> - * firmware node assigned.
> + * function instead of assigning the node manually.
> + *
> + * This function must not be called for a platform device that already h=
as a
> + * software node or secondary firmware node assigned.
>   */
>  void platform_device_set_fwnode(struct platform_device *pdev,
>                                 struct fwnode_handle *fwnode)
>  {
> +       struct fwnode_handle *old =3D pdev->dev.fwnode;
> +
>         /*
> -        * If we call this function for a platform device whose primary
> -        * firmware node is a software node, we'll never end up calling t=
he
> -        * symmetric software_node_notify_remove(). There are no users fo=
r this
> -        * right now in the tree so just disallow it.
> +        * A secondary firmware node may be lost as set_primary_fwnode() =
is
> +        * not used here, and software_node_notify_remove() is not called=
 for
> +        * a registered device with a software node, warn for now.
>          */
> -       WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
> -       fwnode_handle_put(pdev->dev.fwnode);
> +       WARN_ON(old && (old->secondary || is_software_node(old)));
> +
> +       fwnode_handle_put(old);
>         device_set_node(&pdev->dev, fwnode_handle_get(fwnode));
>  }
>  EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
> @@ -751,15 +755,19 @@ EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
>   * @dev2: device whose OF node to reuse
>   *
>   * Reuses the OF node of another device in this platform device while
> - * internally keeping track of reference counting. This function must no=
t be
> - * called for a platform device that already has a software node as its =
primary
> - * firmware node assigned.
> + * internally keeping track of reference counting.
> + *
> + * This function must not be called for a platform device that already h=
as a
> + * software node or secondary firmware node assigned.
>   */
>  void platform_device_set_of_node_from_dev(struct platform_device *pdev,
>                                           const struct device *dev2)
>  {
> +       struct fwnode_handle *old =3D pdev->dev.fwnode;
> +
>         /* See platform_device_set_fwnode(). */
> -       WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
> +       WARN_ON(old && (old->secondary || is_software_node(old)));
> +
>         device_set_of_node_from_dev(&pdev->dev, dev2);
>         pdev->dev.fwnode =3D of_fwnode_handle(pdev->dev.of_node);
>  }
> --
> 2.56.1
>
>
