Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334564;
	b=EwfRDj9oyolRM3nzerIyhoj1XfVQfTM9o83TtZ+7pplP5eziR+Xp56VYOV5PaW02KdQe
	 gI1JCRjKmbjN6/cDYp8MBkVMgsPH+A4Pn0CW5ILQey9ymYvLi6dqgt6mfry+EcsNGRdbc
	 LBje6SYrm21FyGxkBXGJi2HyeqqUM/Thxl4cVsKrFiXjgKBWZtL4fZeqMnS+AXck6eAyY
	 juVNUNuSXkFBHDkyWKXDjCJp8aSItY7pofLpe774n0F1rI30O11PGh+VaCXban9pO+7s6
	 Gr/hSSh+kfR5+ugp23HpWQXHgmJe037FhGVHTZ1mqi0sqe31a8/tIvdRtKtB/s0wzzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z6U6FpbzzvS5LI+ERYtO7UsBLjjGtPf25ssraLozBHE=;
	b=Vdd1vwMVZta+l8U3Od+uWpE7SqaX2/YBIiN8F6aZodx5M85thEEaAe3ahdORkD62EXC1
	 mp6mDU7IOZNFq52FFxwqmtkVNS6IhbkwaIJqG/GfxxqF7HTUUcInVLC4SYc+gl3aZ4bm2
	 1vY7xgqdWQOHEq1ycd8rkEv+1LqRjrOHTt3YuufXOqKTzMVM9rIxovjqVqqK6ryNB/W3u
	 lHkBwyM8UxKRnMS4juBo3J5kkyVyhUqVNZUhL/XpYCZCMgEU9hi3xBfA11azLMF1o1buU
	 hXkw+6tf/fUB5viApc8gXw7DjDkfl3dw2UeFHi6oPxa/8Wl/leHvmZIQeU2CX0vmSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=c5gwBwoi;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E3606A320
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 18:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=c5gwBwoi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so25077255e9.3
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794334561; x=1794939361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6U6FpbzzvS5LI+ERYtO7UsBLjjGtPf25ssraLozBHE=;
        b=c5gwBwoiaIx3CpU67FKoHnOJIzU3r0uBZMy++pMDIzkuP109BnHEHut81orpv25eXa
         aOPaV8UOHApiDKGNAbwoRqkZqKWEn75rOpAFsAHBhF5EiAIE/wdvvP/pYroCPK2Y4F1W
         phGJlfM1wjqWNZL/XRyrkrp296FTW3WNA2W8se6fC1F6m2/RsTAHkIdgbGB8A9aqEa+o
         7qpZNg0d2hAOXhmfo4nkyePHxYjFO4ai0POK1U3PkvQ9JP6K3LjJVSip9Yu9nJrA1Y5L
         3a71Qhv9I3HqYq3Ud8R5jo84pkniAw2fY7u/5Yhduunrwb2bnKKsZy9ldlKsQ1ORNoBt
         PtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334561; x=1794939361;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6U6FpbzzvS5LI+ERYtO7UsBLjjGtPf25ssraLozBHE=;
        b=uHojlmzKPxJcuuxXdcjS9M2vqlUDg3WjGKUQCo0+3kuQK8TVVMjP52Wd/B1lrsHHQ9
         fFKKoMQ5uUPHWhZTxReNXvC8vztiNvEUatZjCsblx5X2NxGExkK/0xd8WQfA+1WzOP0P
         RDr9kM8S4XCoPBgVReoAWQNDuAooI37WI9M8SW6M0+PhcamFaS18LLaHXwYRJjZV1aSu
         1ZBx1teMOJk4fjGtfgRzMjtLeTYldjeZzrTs0YhwRa7OAcntxR6GCu2n2ixcxrgkqFPc
         GcXoUa+we4RMEzpm6l4fN9g7J0s2tj1F2y+VZBqPn3pHINLiJ3xxkwt/YlV3J8K1+1ob
         wYtA==
X-Forwarded-Encrypted: i=1; AL+hErHTSvs+ieVsbpc4rMo4O+fLq+jEoOJoUUebn3LPxpFVu7ur/oGs24BVK/c27o6LuoNh7Yzdp2OWNjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+egnIayRrOMlVYGw62QiH4WIdxXPDEK0foFrZ8PuAEuqJqr33g
	Id8kSRnRR8RdZPqfq+cYvqV2n2prQJFKNupiXOvI0Q2Hi4qaEwaGEQC2yG7riVbQAVD1W7JBlBL
	krUT56xw=
X-Gm-Gg: AYBFou11auBfxuRs/2XsKbtTMKLCK4MfqNdjAL2hRA2jn/AFVsK4GqBFr5Tl5PygYX8
	QyWsdPxEgXO/QTbUF5eq3PhXXVSgZVR5h/ays2XenkjTncv8ljn4SL8P9QzBQ29t1mjBwS50iUg
	WaU5FE4dkwRtA0fgV984pzbeQ+67CZnhmH8qqgepxuOqlPSFuC8AeIhH8USwQ9aTexCrIRASDsJ
	/pLh6/YJuaWZNH8WD1FS+5T8ggMUrTmRbduO2ifKXBkbg/8H2bvPfIcmZl0B9W43x1A/b8f3eKH
	Q3cgXPZA0lPr+3lrVUQ1WrBiluBGmVU0GobY8cfynWx+O4LbmcuHDehYaDA5p1E5iaHBKM3rpML
	A33m4xZQWoq8BdnZRhPZYfdCmaxvxNYwQn6qD3bZpaBMH9Y1IzptWidtpxg0XieGKDTEeFFKRBI
	XgbYns4trKq5QFqMy3/jOtTCN2/q248k/0AlJoZq04Ps7btEqCvmDZbgO+38Z7DWhg/O5qbM5hV
	Mu67wOr6NolA81Dp/btCuA/dViStGrHa5rdDyo+3leVC2owb6Ty5UPNDlgJ/WeNqvQHFXW7csO+
	XqLXiqC36GphKCURnJsjsF3V0SJ+nXTiiqQ=
X-Received: by 2002:a05:600c:46d0:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4ba0233f8famr60939385e9.7.1794334561387;
        Tue, 10 Nov 2026 10:16:01 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-498366c2793sm6345472f8f.45.2026.11.10.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:16:00 -0800 (PST)
Date: Tue, 10 Nov 2026 19:15:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF match table for module
 autoload
Message-ID: <avNe7fvRYxzM8DBe@monoceros>
References: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsphglliahufncpv"
Content-Disposition: inline
In-Reply-To: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com>


--tsphglliahufncpv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF match table for module
 autoload
MIME-Version: 1.0

Hello,

On Tue, Nov 10, 2026 at 05:34:54AM +0000, Arun Iyengar wrote:
> diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
> index 226d722af662..a08abd895412 100644
> --- a/drivers/i2c/i2c-slave-eeprom.c
> +++ b/drivers/i2c/i2c-slave-eeprom.c
> @@ -20,6 +20,7 @@
>  #include <linux/firmware.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/mod_devicetable.h>

Please don't add that include. <linux/i2c.h> already provides
of_device_id without introducing useless build dependencies.

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>

Best regards
Uwe

--tsphglliahufncpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrzX1MACgkQj4D7WH0S
/k4ZuAf6AzDGV+OZfRfecYYUtgK18qNGOGiz9fMIIWQHSs/c4iTYZygLtkO3jI0g
FkqXbzipF6s/RQKiWM5GStlNT2ne6Acg6LAyrRwwn6vMrlbgi1ii8YZNN7bfu9bT
xp2cLTukHThMhNX4kei/zPFfy9lezFZ+kZk3RQ2kI3A9FagFSglpX0aMl/JQv58m
yUQsCTeNO1z2yqVa6Pu+ne9Nukax5qUSAZJczgLct346YJwFKC0MU+hNHtjMX/St
QzyL/80P88O2GfI2IWxEYlSEcNC1Fy00xIiiJ/4C/gcUdePKGJKN3pHO3WGTrYjM
CW9v84TBaNLQo/5iIv0ltA4Kicvxbw==
=ie5Y
-----END PGP SIGNATURE-----

--tsphglliahufncpv--
