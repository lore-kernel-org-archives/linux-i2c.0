Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4F47CA84
	for <linux-i2c@vger.kernel.org>; Thu,  8 Oct 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497818; cv=pass; b=kMZBJ6w9dWUzYc3Nh1aRI50WmosP9pBqsHKfVZGAUyDte76AHu+hVwtlDpDNIOidpwYcdWeGjHNsmz654sFm4I8m+BEz7aUc741IjYVgpEcLNcmQbHbJ7IZTkkU1gB2WAv7RPlq00o+waW0Ofkx5UOs+O8RyPl9TiPgvCo//7Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497818; c=relaxed/simple;
	bh=hRz2Up5ISD2OXp/YSfpaI4bBnwMkonIsXu4OzAHa+tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbYLeEf1PZ0jzwCrzK1FUAY9CyL5B9wz4kprG/jSaHC+zZHdJE6B1aumedlCqAImbw7iZE3dyAz1DasZ1SsvMxQDw7rYHB7pL9/QGV60rRNpxnBARUi6hBeTiE8JbDvUoDVZOMhLuEW9E97yYJrQBTwJTcGwMekpZnjeVXDZLkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gVcDmcFd; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gVcDmcFd"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-351f7a0b13bso710320eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 08 Oct 2026 15:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791497817; cv=none;
        d=google.com; s=arc-20260327;
        b=AxwI2vlSgpcJJzQDQO4/8asa7qdAzp4KZ9OBjqx5JSxcnwKarfWscAJCfJu+jCMlFM
         R0O9B38eF2XwOubqt/ZM1Ioy3Y4rPFN9cgOc4uJqvobcuFiSMSU9Qz8JBH7YQMSjM4k7
         khltSLXWWfhwQIMFyFxMcPboS9N609DF8pY5s8Bir038szCvzhRsBF9FJUW5DdGb4rKn
         po/gRxwgCU4vak6hMIyedz/VTda78oBbZxEpc4bDDGQQisJVgAMYewALeYr/RYRyA5Nb
         Zo8xPJJWAEG6H841hi6DrXNtC1Of/bZZhq9TpprRA57BtW9CR/M63A23V0OE74oZoNXD
         qxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        fh=BdT8gNAOPfHgl3F3wYGRUOlZowr5KY/Qyx+h4aodMKw=;
        b=UeXRthGoxmT2FIn6s5LY2hwHNdp7d/2bPcDMCw96iBaxakCd7TvNnCFz4ZqFTUx5Li
         bKkdGxWijMKfGSl4VUbe7bIJI6OHtiKr32ZZ3nsQ2Z2o5vE83M3j96oJ5sgvPEjIObjo
         hYnC+0qHk3pYdzvteSebAS3bf3fTmFRHePY/PaHJZV29HGUHcGDHMY9JzkBVQa802iAz
         jt5Nkq4YUb1gK0pAY4jUWwnA7YZgxCtGi7bI6EL46pt6bsRUHhQDPqS+3jme17cWF9F7
         Frdck4F4jZN/2ZqlkX9145211hsbLb2FbLHLAQWQTK+0CkvPStHJ1TN+T4H5O3qnu7Af
         zvYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791497817; x=1792102617; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        b=gVcDmcFd0mcmAwWE0aet7pLllHwOmQURXOTcNwRkBJTOd4yH3kQoNhaZnzHFyIVH1h
         jU8YcHev3kfsI2pZRJ7OTVaN3AeBo1ZeHBQvORQPqxbV5JvDbkb6s5Vfdpl0BnCT6mHC
         OmJxaRz7SqCB2bdkTOakmsm30buqE+7cLcUBBBAkyiKuZ2VF2BBhquL3oGGIAOiv2onM
         t0xvu3by5JmUWQsUAWtPreGq8CnK/WlhOzH5EOHmporIaU9qqzKmHuviGN9/Tu7/G1ev
         bV4sjWz7vGw1Y98BylCeTgtmLmISeE8SCJCMn2hatOYg/zPgDdTiKcqiE54sb8IntrH6
         uURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497817; x=1792102617;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HVDKkJhQMONwczHs0ftCK6WjzDumHDVk9DP6ZY0LChU=;
        b=jnyANJneYwuS5wC+oD1QlEo2IhqMKnrVwius3Ow/IhN5MaGeqEHLsXSSXDmHGz1rnV
         4c86R6y64q6ys/BYorFLIailXvlkw+hF+ecQGpt+zCUcqNoRW9WjrGq+FnCzrgCFaxGe
         cOBQeRJffbtAl8KHbzJWNLbIJCVL4gKZm++fjIq09Q6c6fsHSrH8OjomnYHPEESGHnIq
         sowqrIVWBNW2EwRMdAgV9Q4gsVZQ8Qh5WDgdar1rjOCUCKvpWb83yz/w+l4VRKsou3lW
         2MEZwEXqcMmQkQ7P4XwB7atNgGALZLkrxDt9DIvoijXmYOfEH45ACpcVwB48t7xxaVQ+
         YJZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4prCWqkpyYqpflUEQYuLOGAr0E5K1437MZe8U2J/E1u7XtN/ZFcKhz2Dom7VUB42yr+ShAk4mWRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKDnWwaMY+/HxzxzZiOZ8lv6/b+p8YSOiMCQkPVb5FPpn845Fz
	+snp15VrN1EkQNz+hjlPB7Vp0HDs970sitqCRHP9K2PGCPZR4hhfsXH2wVucgmRdCcpl+Ya41Hz
	OEn9VbS60DiFo/OqoFpssgNwzJEfBiBVTScMyLRsW/mP+P/uRxTl9ZwyRJQ==
X-Gm-Gg: AYBFou3NHS6DqrQDZoIpHmetGxcXuKwL2EYUjHjCcBiYEQa5KkiG90DYuurYvpBLOiD
	PQUGx4B6kyVNDnZvDTsSFKoMYvnJkFSMWCoDMVmKnDe3Ia/ElyuAEY8zPoDyLv06q3EWN+w//gb
	zu6e4HqYYdH6PVaYUpKL9sHS0q2V2hqwHPjrZJAZ9KLGOHRam1hWDgYKl2lkQef+HaPdLqx1SBQ
	a1I3kCEMEIJCjGWHFvJhLRnCYEZ86jGCaxgXWb4FiCzGmgFn77WmjU52lorG/pukGyqc6bKxJg6
	g3IXyrPEwV20ZFDW2QAM4a+d+SJGMmvyr9VPf/G7uMB+IEt9PjwYkPQ=
X-Received: by 2002:a05:7300:c389:b0:34e:2150:e5a4 with SMTP id
 5a478bee46e88-3536c58dbf2mr892218eec.16.1791497816699; Thu, 08 Oct 2026
 15:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai>
In-Reply-To: <20261008-i2c-xiic-block-read-nack-v1-1-94882af6e598@nexthop.ai>
From: Siddarth Chilukuri <siddarth@nexthop.ai>
Date: Thu, 8 Oct 2026 15:16:44 -0700
X-Gm-Features: AclHuK-e4AvKn1DVj6sz0TdknScpn3tml46-rFF4J0_u7LxyuEEllK9h95XoXnw
Message-ID: <CABAykkvoTxq=mDvpfUnN3H0O9oX-8D+DhWi9SqzrW0f7kRSFDg@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: NACK the last byte of an SMBus block read
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2026 at 9:02 AM Abdurrahman Hussain
<abdurrahman@nexthop.ai> wrote:
> +                     if (tail == 1) {
> +                             u8 cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
> +
> +                             xiic_setreg8(i2c, XIIC_CR_REG_OFFSET,
> +                                          cr | XIIC_CR_NO_ACK_MASK);
> +                             rfd_set = 0;
> +                     } else {
> +                             rfd_set = tail - 2;
> +                     }

Thanks for chasing this down!

Small nit: it looks like the tail == 1 branch can't be reached. The
padded branch above already takes 1 + rxmsg_len + pec_len <
SMBUS_BLOCK_READ_MIN_LEN (i.e. tail <= 1), so this else branch only
sees tail >= 2. It could just be:

        rfd_set = rxmsg_len + pec_len - 2;

With that:

Reviewed-by: Siddarth Chilukuri <siddarth@nexthop.ai>

Thanks,
Siddarth
