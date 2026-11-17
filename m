Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929185;
	b=eOVlcr4fukgcX0QXxil5s1Yy+pH+GxLEd2w1VrsCFQQSZm50JBfEC4cwIpiDMWLcL+iu
	 QVt7Mm+1BZRSywZQ7N1Gqb2IytG6vBrNX3oT2C7f9bGKxai1EFCduamhE37hazBmhPByr
	 zc834EXiGQC7O0VPhjjJKdl+mfnR3MMSS9aeUXQ9B/eTjXFj1mEG9yK23GXIxY03utqpz
	 9nqK0ZpaYIPFEoIy74ISTdfYRR9LSmMlj7aTtPAQpFpt5GSXALeBg300zVN7sCdVbHV6z
	 hG+UQlxlWil4QJbt6lxSIPzaxr1I1Zz4EdLgADecGzYyCzDoWQ+EUN/0iRnZh8lPGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929185;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=++06PQJflKig+6hQln7vv+bAUJFdci8/kWBunR+qCrE=;
	b=XfYR4u0BKhTZyFrdW+u8rJIcNN/0eKQVSLW5jUIN3Wc5UmZhX87ZcDPzMXxtP8Lr4hCw
	 JQLuJcq50FnycN9HcvImer/JscfIcTXZ7Ab47y3vsJDnsg0+vZ+Y5H3L1LpZMhCwTy3L5
	 31VSk3LOgkvn98AKPyqHVxjh/JAP4b3R0Ed0oZo0kLTaN18ubVw3x+acAzqqKh4gfGIbL
	 Kju8gdhwvapCWe2kN0xjCvr/GdQaB4Pg2n0szgXWxevNk6PES4V1gIUxarM14tO+9JiNZ
	 RuQk8IXtaRs66aMg3wW719uQO5vNSg0l4GPyFP/wZ+nMwH+fdtZefDHdKFaSpxFBdMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fDiYjYi/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287E606A333
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDiYjYi/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B11F000CF
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929184;
	bh=++06PQJflKig+6hQln7vv+bAUJFdci8/kWBunR+qCrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fDiYjYi/FXrZfOf7lvpYHSAFwq4OjV9SzMBCOyo2K4WmqTSeimz6j1Tx1tIRCxepQ
	 mCvUm3tXyn40runumrRvF5U9+SaLcr25EIDkyei+b2NJxIFhpeGYX9ceM3xFsDDiuM
	 7mkq8Cu0w4nk/tuIJo923Gb81kHrTArg2fHdcNQsgp+y6dXaw1bi0yLGiQJGlWu2l0
	 /brXR7qNzzzlZW3+dgjUFFYxQ0gwhi/v2hm2o1+KioIgw3wVwQ8HXZcaNS6DVGJQnf
	 lQ3Lu8TQ8C8rb6wG22bN5RgxCEqYQUyUTK0szeg1V23W7N7QrYYocAn3taegaCuWyQ
	 RFcMQv7Ci0NQg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c126f80426so4381128e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 07:26:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHQHpBmwqYw7vxdtXp7Mp1ip5tHMJOhKEDNfZLkV/+a0f1rCyHMAJwusPjyzYEs8aL27TieayliyDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aYlsIfswycFoNUUP54n+5V9GfWgGBvBja0gBeF4XqhiO9VUFj
	SFBXtWcvrsy2mf4hUa2CQyKg1mO4So7BDOxydOHOhRhbvB15ZI93SRhgWRFi1fPvK22GCcu93om
	pjexcgChcTAAP5O1W9U3+8vW2VUHV74Y=
X-Received: by 2002:ac2:4bd3:0:b0:5c1:4f8a:8f5 with SMTP id
 2adb3069b0e04-5c170771fbamr6263013e87.25.1794929183274; Tue, 17 Nov 2026
 07:26:23 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117101336.980216-1-johan@kernel.org> <20261117101336.980216-9-johan@kernel.org>
In-Reply-To: <20261117101336.980216-9-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 16:26:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipadLX1yUwi6Ei4o8+b9YtsyXsprXfA-8xDaE5uY4+7A@mail.gmail.com>
X-Gm-Features: AclHuK9P-eL5qUVo7UHG-qeLLKO9_Qsiw7_oDS5I9OT8qh0o6GqsYRVlxAXrvE4
Message-ID: <CAJZ5v0ipadLX1yUwi6Ei4o8+b9YtsyXsprXfA-8xDaE5uY4+7A@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] device property: fix fwnode_get_next_child_node() comments
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> The parent pointer in fwnode_get_next_child_node() may not point to a
> primary firmware node so update the comments to reflect that.
>
> While at it, fix an indefinite article in an earlier comment.
>
> Fixes: 190069255582 ("device property: fix infinite loop in fwnode_for_ea=
ch_child_node()")
> Cc: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/base/property.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 51109794d727..bfc424a193b8 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -810,7 +810,7 @@ fwnode_get_next_child_node(const struct fwnode_handle=
 *fwnode,
>
>         /*
>          * If this function is in a loop and the previous iteration retur=
ned
> -        * an child from fwnode->secondary, then we need to use the secon=
dary
> +        * a child from fwnode->secondary, then we need to use the second=
ary
>          * as parent rather than @fwnode.
>          */
>         if (child) {
> @@ -822,12 +822,11 @@ fwnode_get_next_child_node(const struct fwnode_hand=
le *fwnode,
>         if (IS_ERR_OR_NULL(parent))
>                 return NULL;
>
> -       /* Try to find a child in primary fwnode */
>         next =3D fwnode_call_ptr_op(parent, get_next_child_node, child);
>         if (next)
>                 return next;
>
> -       /* When no more children in primary, continue with secondary */
> +       /* When no more children, continue with any secondary node */
>         return fwnode_get_next_child_node(parent->secondary, NULL);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
> --
> 2.56.1
>
>
