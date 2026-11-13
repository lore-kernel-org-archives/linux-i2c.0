Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592208;
	b=cU1vMCOcsDCqmD3htkAu0qRvrsDjtMN5mTofrA3id+neAGSWL5yV/oFnuRL1wqxaYmFf
	 MciWbNnqwer6OUPXwi0FYJU1O7aOSk7fyyJpZuIsrQ4mJfjihMJnh7MrMnmAUOnOBP9xS
	 8cxnKjCGO6wpjEbPoh7vorv+qFFlgzkL1CNgroSDfknzLRRrmqRPz4JMZ1G4zLuhDH25I
	 RIbaNaj9AtwMjBKUo/3LOa799jj+iAq4kslfjYjypmmt2RHwf7VPX6bdXNOGxYQlWDB17
	 jVtGxNlORgNmyWPdV/8+LUw61ihmpPPgJYy5w1c3aey4deoA/ubwcvoDrXi71mc1fPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592208;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EU1uYM/NmLFZaI8ig83tMQonoDZ93Lw71raJgl086sU=;
	b=oZ+SqqD+0IYYPMLPlcgVh4K2q9/gpyDkwlbm2RYUzn7t475HH2QZxl39dB5dAcSerFhw
	 vhDp1KQJSzMHM1PkPqoy6uJPIfh+744IL6K+H9cYbrKu1syyIXTZBcVDXmMpZE9vwQ7xi
	 Imq45xn28t8pROQ+LfM0+t5R2sm+e4GFyUHZph7Wj4pr+0+oH4Z/qud50jBEzutpM8q3Q
	 ZUdI66BZiLEsUxpTWkwx1dHx6NWwlQ5/XuieR06BEIyk+z9AAfmmSxTdrU4hC0WZmBsBt
	 ihz6QaGDJbRUzYB+YDcASuStJRXc0UeGLTvMPHGKHagwIO/411GPZ44loVpvfxnyAFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oe2bngzq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710A606E200
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oe2bngzq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42AC1F000C5
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592207;
	bh=EU1uYM/NmLFZaI8ig83tMQonoDZ93Lw71raJgl086sU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Oe2bngzq4C8gbD+i78EHwnVvNOgsuhw774fp5I4cEfe8PABs/x8esZV2Mm3DBh76r
	 DeA2YUqWAJRoY5OBi0zbUJrroJ5+FutHwPbhSZzRhU8pNPSdMVtxnbOo3yzPU/aMD/
	 b1kKzTSO6SI2Cge1RcTLVBA99PSYmbYGCbYQRW5l8MY1wZjud8QKAn8oylC2yHl99w
	 Pc/9D3RfR157Mt8HtqMWkIFF6zUen49Mg+c+bHYKOTyqVYbyeldb7wCmUEBF5i7ScA
	 FLLN55pbrEN+/NF5uP8/4Lgna+eWR5gcNKpde3XlAl0e0arWd/buXECd8KUQUoKMu2
	 Pzv/mNxLeayig==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c1593fd141so1681609e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:50:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGt78QYXATr5AW77+ewCPbKqA3JQAPC2WEFZCzkcdxfL84Krbyby6lw5/AkS3j6WnvjhBoV3oEOTpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z919S0B8Uh123dpjkmHv0NgRoRf/7m8nUQjgrtqdiLk19RxNLSC
	/P5TWIX9oJLTZ22QpdKrHmP8nPKSaFpis/NzTrZzqRLat1OZ2I6q7EMHrZBsfDR108o7Hjw0BO5
	o+TPahgM5cV3S1L6swl9TeONaBMViLGo=
X-Received: by 2002:ac2:5683:0:b0:5bf:dd04:8d7f with SMTP id
 2adb3069b0e04-5c17075c348mr1704210e87.11.1794592206322; Fri, 13 Nov 2026
 09:50:06 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110085125.2535508-1-johan@kernel.org> <20261110085125.2535508-9-johan@kernel.org>
In-Reply-To: <20261110085125.2535508-9-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:49:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g+X0etuZSoTrFr2OXgF9o0q+LLLTcQSfvo0A3dib9M4Q@mail.gmail.com>
X-Gm-Features: AclHuK8FkWmm3X6Ez4fQpYts4d02b-gmJ11NIGOgqEPyiws4gYW8Iu7-IoWq1Cs
Message-ID: <CAJZ5v0g+X0etuZSoTrFr2OXgF9o0q+LLLTcQSfvo0A3dib9M4Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] device property: fix fwnode_get_next_child_node() comments
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The parent pointer in fwnode_get_next_child_node() may not point to a
> primary firmware node so update the comments to reflect that.
>
> While add it, fix an indefinite article in an earlier comment.

s/While add/While at/

> Fixes: 190069255582 ("device property: fix infinite loop in fwnode_for_ea=
ch_child_node()")
> Cc: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 51109794d727..32df0c6724ac 100644
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
> @@ -822,12 +822,12 @@ fwnode_get_next_child_node(const struct fwnode_hand=
le *fwnode,
>         if (IS_ERR_OR_NULL(parent))
>                 return NULL;
>
> -       /* Try to find a child in primary fwnode */
> +       /* Try to find a child in parent */

I'm not sure if this comment is still useful after the change, so
maybe drop it altogether?

>         next =3D fwnode_call_ptr_op(parent, get_next_child_node, child);
>         if (next)
>                 return next;
>
> -       /* When no more children in primary, continue with secondary */
> +       /* When no more children in parent, continue with any secondary *=
/

What about

  /* Direct children exhausted, go to secondary */

>         return fwnode_get_next_child_node(parent->secondary, NULL);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
> --
