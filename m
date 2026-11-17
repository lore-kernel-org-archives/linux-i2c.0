Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927994;
	b=gRFSgWFiG5JHWXG0hVKxnrdKfvqAtPmvZIVebjD4lrRLCJFx1t4f7fSBZ433//fsv1Q8
	 mXnwTNM+erGXg4ua6XLq+ayB/Qr1ICBMi+bGZKiQMbLWIbiaTyid7BIr9cTc3qnMo9YoS
	 wcGqX0SlgMEfnvTA2ovK95DFvCMHXyLog8CUa5Ah83jjWqg/uBD99kIjEw0fa7/gVgsYX
	 tt2xRAps8cuM3B+L72SSS31KeJALYSnjXS+mhHnipd5T3sWbf0qlidpyO8fOhH8C59u0l
	 JBe3imTLsCKGZHOrlhorjND8V9w5nY0RxwQIyCEYzSBIlG5RATKNuGdM+2vdME23LSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927994;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=97CCOpTWarpZiKxPkFrwJzakzwDUQ3GnMlQehIooZrA=;
	b=gD3ZRy76XcSL+3bNAeXRSR4UYQSow0vIAymAfy6nsGOwspE3CfKa/o8YSVdEKwcW1jm5
	 VSTx4LmH8ChaBUepDbXJdfAdbRb7Nmry0rlcFasS2YljERg1NIb6XWZIuG1Yp5ZmaWtAz
	 CaZIn+zS7YceCqWOHZKZKKteEmPeNhM+sm4/f/Th4zT5xdSoRJf/q1WVqdP5Hx2C3gKN/
	 uQkDJ3ub12+EomHDAZgHiafP7W+88TZ0B7FivdV4+8Tm8qdqdbFSAyEPm0j+tvudmWdLA
	 UuNC3/7/zQHhd4HcK9Sme/vnbHymBQ4YSIUJcNCB0OGUqSGzqm14uGj0vwDSfjnGoug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrmZGLUT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B9606A32C
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrmZGLUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C01F000C4
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927994;
	bh=97CCOpTWarpZiKxPkFrwJzakzwDUQ3GnMlQehIooZrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MrmZGLUTapAv9feCJ3fWTnwJgToCRTjv6EMy8wRwrxkbM765SW+d4PIlFy2bDus/m
	 UWl/kc/+lADBQ0iLALpGj6v58ORy6f7MYlUXHG4xBa3FN8tQHifPxbtnGae/AqL8gl
	 12S7T6aN9wEDPthnpZXgAYE8tKgbYBO+Z00p52hZWd2EJmnogd6gGrTG2TvTXt4vt1
	 2rZiCJRgIPgTRzmwHMmVyhFbvvtngElU1vDUxqRi96MsFklwiKqIZUy04zNdLgZ4Y9
	 0LcCZUct7GJc/C4IQQ+xqgv76cLU/cEcoO1qwjLydfO3bhB4NguJBXA5Z8ACAUsmMw
	 I5Pr7vTkxOySg==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so4543952e0c.2
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 07:06:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHhhh3H+0jvhR3zd+M4JRqDmW3hLuzZPxxPdJhupEjebfqbKZpjN1W/PVtkklTy/McUdfAXRsFXSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EcM+jrTMNx4W9+lxZDqo9eZLYfTX4n1wUlUwXuZoBcofoASnn
	WWGnzyXWj0e5tc8cgTGqDcTfbh4eTiErLxgyPqaQ3AKx7rDiMPHq15qiiVD8IAcA1Lcfoh7rx+L
	03yPItD2/tixqewm8ctJhMbK9xt8op2c=
X-Received: by 2002:a05:6122:793:b0:5ea:e223:5437 with SMTP id
 71dfb90a1353d-5ee34a98485mr5810657e0c.12.1794927993719; Tue, 17 Nov 2026
 07:06:33 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117101336.980216-1-johan@kernel.org> <20261117101336.980216-4-johan@kernel.org>
In-Reply-To: <20261117101336.980216-4-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 16:06:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsOZUMvkRSqh+YX8uwWC+AoFTxszZSxYveLQf9rPtADQ@mail.gmail.com>
X-Gm-Features: AclHuK8Y65J3pDRJficJKbngOd5x13CYfD7qFXi0LQorI5YXYtk7K3ylF3ijT5o
Message-ID: <CAJZ5v0jsOZUMvkRSqh+YX8uwWC+AoFTxszZSxYveLQf9rPtADQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] software node: fix device_add_software_node()
 kernel doc
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Software nodes added to a device by device_add_software_node() are
> always secondary firmware nodes even if they may be stored in the
> dev->fwnode pointer.
>
> Fix the kernel doc which incorrectly claims that a software node added
> using this interface "could become the primary node".
>
> Also clarify that device_remove_software_node() should only be used to
> remove software nodes added by device_add_software_node().
>
> Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()=
")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/swnode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index ce4efc506b9c..b2593b2fcada 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1048,9 +1048,8 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
>   * @dev: The device the software node is meant for.
>   * @node: The software node.
>   *
> - * This function will make @node the secondary firmware node pointer of =
@dev. If
> - * @dev has no primary node, then @node will become the primary node. Th=
e
> - * function will register @node automatically if it wasn't already regis=
tered.
> + * Register @node if it was not already registered and make it the secon=
dary
> + * firmware node of @dev.
>   */
>  int device_add_software_node(struct device *dev, const struct software_n=
ode *node)
>  {
> @@ -1091,7 +1090,8 @@ EXPORT_SYMBOL_GPL(device_add_software_node);
>   * device_remove_software_node - Remove device's software node
>   * @dev: The device with the software node.
>   *
> - * This function will unregister the software node of @dev.
> + * Remove a software node added by device_add_software_node() and
> + * deregister it if this is the last reference.
>   */
>  void device_remove_software_node(struct device *dev)
>  {
> --
> 2.56.1
>
>
