Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929158;
	b=4UfsJbVSmJ/JSb32RU6kewv0Dc+OxA3SqSmJWnTQ+BHe//QUGj+AZCJnURQcg81jwuYx
	 zThY9x01LsyEHbTTTT1/85iip/0N1NrgbC5MqzRp22rjj9vVsiUDkV07XR5w3pTokkqLO
	 wybjtYsb/shBAhMXLa7MNAaU5+KXmOGooqZRwxhsF1X4HSlMOysPVk6dIDWBRm4In7600
	 hJlDYRW2Ub6bzDmaH/CXuiY4aLw1SpcDg/VQ2C5Con5JlAHydANxVzjqUOpPpLEgT1NUJ
	 6AW3lIP6iSJtZUJ8fWs31Q5VLMZ2SALUqS7HlsRdxNRX4kT8ZQRwigDyNFsZkAMRo0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929158;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KBdVW29HVJ4wR0PbCoFLY5q8sXCExkR+hunNaQ0mJo8=;
	b=lvPMExMQSGPyhoHJ5XCUnFkcMyLbGosJHWhvaVycFFowFNdrte+AHobaE7i1gVbixWA4
	 bvGG8ZSOZKWHoM3hXVFmNJ+aQ9Ked/SnRsddtTpcqglWtKgM5ilFi3PO/dL2mxvjAJ38F
	 jDebw3Vz+8YY0oOFRUSiBh9tkUqh6U/HPMFIbUjEiAN/Wt0TQFIGcP7imxJGGMVS94jO/
	 XTQnF0n7bfhomzycOELb2q5vnIXsfoxbl8FAgEY4/5kGpv5IFrv6yrRUDzcGCcqmsShQ3
	 nO5s16WY81JpCrFJm6l6MGGJB+cXdAAZDjqYaOT6i2/dzd9Hreg1e1Jt3XeFuCY2c6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnIRjXwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAD606A330
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnIRjXwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29861F000CE
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929157;
	bh=KBdVW29HVJ4wR0PbCoFLY5q8sXCExkR+hunNaQ0mJo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CnIRjXwRpNVUgqYvQWE4WOgRijmCokWzHFBLSjBGVSNTb8cHLqhJGaC8kBn8ZRi7A
	 6cXpGyWmj2XAp0X/TQi1kD2I1ZHD8R1y5slWiBHHHLk/iqBzmZedeXzjKPuTsYikWt
	 /9PaMJGaJhRf3y9xLHljY7HtWOOu1/T/xuvn6/Q+sWpu9ORWo4ncMpsl69W9HNloAV
	 XUe2L6gt4MR/hgoMamFRE8FEJ+SshFmoi3dnkuTE9wAXTjKDNe/WF5x8dc4RZAR8OW
	 0TvSt473tr+zU0I2BCYNcfkNbaMPkGq9KC7zrb4IM2uaXQ2erNsn8G0F2oZYU0TjOj
	 ZGPCzjAqwnpcg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so4751450e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 07:25:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFZ7pmr5tiGInTb8Sl2nImum7wd5ZkV4Vw8Qj/92oa9qy5P+t2jGHR/c3VgtqFvEpfPTOrQEOAgbmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OuRMaNMMM6YOUF/ukVKMHZKXNQEZFDTIw1l2Dx+K9zCbXaAxr
	sKIBm7HVwc0bRjQXUmYSliEbRAlHJEj5RMV6gpRrQVwSLZfHrepNNM8k5QxGaWIAEt8tzCM8KP2
	utkGcxcFSODEkg0J+iCEwyCw59/NH8u0=
X-Received: by 2002:a05:6512:3c9b:b0:5bf:d54c:1fb6 with SMTP id
 2adb3069b0e04-5c170b669a5mr5364150e87.44.1794929156283; Tue, 17 Nov 2026
 07:25:56 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117101336.980216-1-johan@kernel.org> <20261117101336.980216-8-johan@kernel.org>
In-Reply-To: <20261117101336.980216-8-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 16:25:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j2DAPFBPA206VmWEiyUub7yuXFQeAvUtg95J=DwmKTDw@mail.gmail.com>
X-Gm-Features: AclHuK-hF4u064HXJHyD_Ul8WiKkjgi6nackBFOWJTHQRR2q8VH5bYUJg9XjRV0
Message-ID: <CAJZ5v0j2DAPFBPA206VmWEiyUub7yuXFQeAvUtg95J=DwmKTDw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] software node: fix software_node_notify() primary
 node comment
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
> The firmware node pointer in struct device may point to either a primary
> or a secondary firmware node and driver core sets the dev pointer of
> that node when registering devices.
>
> Fix the comments in software_node_notify() and
> software_node_notify_remove() which incorrectly suggest that driver
> core only sets the dev pointer of primary firmware nodes.
>
> Fixes: 37e586675993 ("software node: add fw_devlink support")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/swnode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 95283d8bda26..78e224539b02 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1162,8 +1162,8 @@ void software_node_notify(struct device *dev)
>                 return;
>
>         /*
> -        * When the software node is the device's secondary firmware node=
,
> -        * the core only records the owning device on the primary fwnode
> +        * When a device has both a primary and a secondary firmware node=
 the
> +        * core only records the owning device in the primary node
>          * (see device_add()). fw_devlink resolves a supplier device thro=
ugh
>          * fwnode->dev, so without this a consumer referencing the softwa=
re
>          * node could never find the supplier device and would defer fore=
ver.
> @@ -1198,9 +1198,8 @@ void software_node_notify_remove(struct device *dev=
)
>         sysfs_remove_link(&dev->kobj, "software_node");
>
>         /*
> -        * Drop the device pointer mirrored onto a secondary software nod=
e in
> -        * software_node_notify(). For a primary software node the core o=
wns
> -        * fwnode->dev and clears it in device_del().
> +        * Clear any device pointer set in a secondary software node in
> +        * software_node_notify().
>          */
>         if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.=
dev =3D=3D dev)
>                 swnode->fwnode.dev =3D NULL;
> --
> 2.56.1
>
>
