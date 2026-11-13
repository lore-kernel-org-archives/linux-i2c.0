Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591146;
	b=otyYnOq9e0VoYjFxAYvWBTndf1ojzYiIfb8KcE6VDZt/uChQd7IuEFM0ZL54c5AUUXuu
	 GZspzMF6S+pFBpLvq4I+Qdp3zR4I1zxuxu5QybLsq6a4to4kno6jlcf1fA7QYNLdUkKJc
	 ovfUoqS8VMdlu2Y8ByBczb6+0bUejOa3Za3yJHgt076OhIxmrNB4PMXkyTTdngIQeH/PM
	 uTjL401inx8pHb64iGnf37NWhXrwk0pLM8hsvKKYzdPd3jABOqFyxRrDP55qf2lT/mEwz
	 fiKU1RnotcVGkUh/O4GBhp9bzGNqOqgdzNAJfq4gtLKTOL9wtD4iWX6QEBgdY9uWHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591146;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nSptiMb1CVuYUc/SgcCJgKBFQaoryOlduTQ9oVYzLTc=;
	b=hbfJWV4WcxiABICkkvOI8iT/OiN4Nqm55jGDITaMYdrZJH3xTMxBuB9KDnNbfyQcg3a3
	 PugFqXvo0MOd5CY1SKT54U5EUVOOo7iR6UxbTQE/TVDgopBFeesOWbJMcQFjyCtEnOYTY
	 885tsAg1gSFNjVgTlYWeZwZGgMNJWQiiS1ne9exQGcUhTFKlK2FVpw48znuKIzOhkWXD3
	 gSVLq1SLQtpJkTFtoRygYLbAxAiXBMyUeXf/efEcc0pj8N7miAdR1pTuj4vTo8w/7fIeF
	 Xv8aAQXb9V7xcGX+0ZNnTRTK+zPoU5sQK8/vRxmo8UdPUAmE5fDR1A0jA74vqXlmZ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwS4+YW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7036608435D
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwS4+YW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07CB1F000CD
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591146;
	bh=nSptiMb1CVuYUc/SgcCJgKBFQaoryOlduTQ9oVYzLTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fBwS4+YWYjlGM2XruT7oZuYziu8O0IeHH2cqLgir27v+6/kwOyMUls9MDQhorSVyr
	 DvWqxw5rv00g8RoHKX/YBzAVPI2LxuhAuh090kBFMwxkOro1ooLHj3TOGXEVNw0Wbk
	 toCAFS4YjLogX7VNoBpQZ8ppXgLeBwc5DdE81McOJIHEyYgtpUKpzBo8tNtzjn1CHB
	 bvpfWwiIXkHn6UYXsx4mwLkpYaaSK0dj4NvLCCtB2amZJ97a6ncggTwMKancXO1qs4
	 V4NCLHIGUzw/HkiOxMVq8KCroE30mT1iwLxW8aKwFe54M3a1EpH+SSFxq9QPPjgcjm
	 rtvbNieDVCwjw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab46699a09so17159171fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:32:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG4CvQbRa5Ha6zMy0SXElqXrxF1GDToRTI11Oq7IyQZMkVOMFAUy1rGWvsPdtT/m2LEBhlKqJcXsnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AHZYUyga2UeOBxm7qryj+TweJdsPK5Ul0Z3HpDNqBNWiOfHFY
	eWXgxdCU5pQPkpspevfz8kEJK8aG+0GasLMQl2UFuK1qRdw2LHhxzRtddCvOrOkeumhx7r9oGnk
	U6uBfTEyWeV8+blS6O72+dzJaYgapsJo=
X-Received: by 2002:a05:651c:b2c:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae2b5302cfmr9849351fa.24.1794591145071; Fri, 13 Nov 2026
 09:32:25 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110085125.2535508-1-johan@kernel.org> <20261110085125.2535508-7-johan@kernel.org>
In-Reply-To: <20261110085125.2535508-7-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:32:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gZQ1LL8ZizAK-kQdAUxyEL5uBLyzOOnMzi2DDVF4pRtQ@mail.gmail.com>
X-Gm-Features: AclHuK9F5GTbS6yo98TrXJgh2sPuvWLUYJkvQopVJlBgnULLF0J572bpzAoTEkk
Message-ID: <CAJZ5v0gZQ1LL8ZizAK-kQdAUxyEL5uBLyzOOnMzi2DDVF4pRtQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] driver core: platform: tests: fix swnode reuse
 test description
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The description of the software node reuse test is misleading as a
> software node being registered does not prevent it from being reused
> (e.g. as software nodes can be shared).
>
> Fix the description by clarifying that the test would fail if the
> secondary software node is not removed from the device so that the
> reused primary firmware node still points to the software node.

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> Fixes: 397f0a3958c9 ("driver core: platform: tests: add test cases for co=
rrect swnode removal")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/test/platform-device-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test=
/platform-device-test.c
> index 9ce563f76aad..b0cc37d166ff 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -273,9 +273,10 @@ static const struct software_node platform_device_te=
st_swnode =3D { };
>  /*
>   * Check that reusing a software node works correctly. If the call to
>   * platform_device_register_full() fails after adding the secondary firm=
ware
> - * node, the software node must be unregistered in the device's release(=
)
> + * node, the software node must be removed in the device's release()
>   * callback or the subsequent call to platform_device_register_full() wi=
ll fail
> - * with -EBUSY due to the software node already having been registered.
> + * with -EBUSY due to the primary firmware node still pointing at the
> + * secondary software node.
>   */
>  static void platform_device_swnode_add_twice(struct kunit *test)
>  {
> --
> 2.56.0
>
