Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C1490BF1
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596448; cv=none; b=gicWqgShDuk/keoUYz4fXKuMQzcr15SBD+gYklUTOg8X9OPyVxj1wiLIh3gzgz5WQzPN4QJb4r5n6FVwwN8fwL2635raUcmXs6jNkNjGdv+NKZndpvn7Yy6hJwTyJZ7j9gVlewK3vsRK701jjw5KVxvBmTJ1MN0+9eCfe0pz440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596448; c=relaxed/simple;
	bh=lt3BikJB93Zkg8UHHA0fVUsHS8vy+oVkjtAS1xezz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg8CaGH7iplqJQ8R+Y7Q4yxQM1RDMq1M2rvzSAsjltRonclXNLxTkMTFy8wWHPlPRzf6k1y95zQr06pPb4my68QHGj1BQuVtpbIP9W9I3nZ6HVauHXs8tV2ttKCBfQ0yD8CYXs9+HQKi9laidRJI5Bd3Y8kUfT5BV1NOyvVUF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GLgS4xk3; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLgS4xk3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so35631666b.0
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789596433; x=1790201233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRx2j1EfmgsLJaRhKgwq7WbmeY6pd50RmhdABMQZV3M=;
        b=GLgS4xk3XkW12Zm5GjPB8ifKd8UTHR2JfNHncScZlvGsMUJm4Uw19wFXBApD93N9yL
         ubjTU0klz2DgqJE4D8y2RScEfhqVaA96S3KRAOZ4KISxXxVVNcaCw4S0a8FesN5DzByM
         mag7oZYQJFnuwCbOnKeULDIhfl5SvO3kRNw4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789596433; x=1790201233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRx2j1EfmgsLJaRhKgwq7WbmeY6pd50RmhdABMQZV3M=;
        b=ArUkBwsa/RRJVPI2gmIl5BFnDlrJQFUVeZSqA9zh70fVS7RvluD82hAC2xasOWM9om
         vtZIZ+n9ZUUwxVhxA0F4V9nVLxuKRVrkuhADvjnqZljcjHjyp/jhkZIp1Bl8pMjMHvO4
         GYwjHzRKJicWzEm8rMsBevWDx1e0g4C2lSUQ3IEEcIBmSlrzxEhhTNlrfHP3UizRoDPq
         Su4Kq/wE854sBUgdhKPRRhhoEmMfrx8g3p4Nn7+WaIOEvATGomttrAyGjpGz1S+95jGC
         QQp7xhDP3YM+6ZZTIKckYR6l7KH95FJsnQlKPJq2dSDdKrQuGgdWite/EkZSUiZnsI5U
         UWoQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9OD/+uvNkhcbQiHQVaSsHmvcdUuNQecatJIeZ21S/rW2ZNagEe5Golku4bCt1z6IZVxB09Nf4pnI=@vger.kernel.org
X-Gm-Message-State: AFuF++lwGO5S4cC7T7vAYhyZqahRrLtWJ6L9mj9t4DJDvVriR4Qlk2JM
	8LSaPRVr9r+XQeXQP4Ur3uYldE74zuXYqoP9kLP71gED5zvpiHWTxgKGJdP2ZOZHdsypJTwSRiS
	JE/k=
X-Gm-Gg: AYBFou2P08OorqzTqOtTt+6VdImApI8FjF+2KBoXOS5XiUUeDjXH4+kl6j+mqqAzsvF
	ZPh+ewzxeGleCqbnRl6plQeot85Yl0MvTykL7WfgNeAV97uy3IU5p7fKsJ1+DdW9bGvbjhgec9h
	5X7iWHvdXHvZfHeOp9mn7zcFHm2XiS/PY5A8xvq0VPG8Dnqc6MU83bRvo2hQJwUwO8CCxeBGLAv
	mR+VTDsldCsvg2hHPQNyqHH0CpAW2rDbyBgVIvx1lzJVEqKGYX1NBfwIuhAkNTRWK9IE4eRMKW5
	rYKSCMDKGFu9fZnmCQ0gxooPlfmyUhj+ZRM21Xlt+L3vacB/yHoUQfwxMx05iLN9aWs3vc5dTi9
	ISmp1/ksuEjRbui6DIPA615iaHKoTuGzuqofSjTfbl/53qhwptUqOyi6AWE+ReNDdgrKT1kWbLO
	okt3BEeI/EGdr8mGV+5tLCoJIJk/3zPGxKF0T/Om/MzXqHLM4wdnLKaSxiTLUh6BYiNe8Va270d
	IXcCTN1F7Zb+uHEhbvPDW57/nQOBzy/XxTTZT4=
X-Received: by 2002:a17:907:9447:b0:c29:c213:1ec9 with SMTP id a640c23a62f3a-c29e51b2eb6mr470788266b.9.1789596432666;
        Wed, 16 Sep 2026 15:07:12 -0700 (PDT)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com. [74.125.225.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5b22b2sm195945966b.36.2026.09.16.15.07.10
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 15:07:11 -0700 (PDT)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so1146435e9.3
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 15:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLzXFZkY6B/HzHX7bj7x2L/bG2Y036vr8NbwUoqsKA1fbneS3PrQuEmNuSkNoXfzY8k89gvJu/nNk=@vger.kernel.org
X-Received: by 2002:a05:600c:3b0c:b0:49f:bc28:e8b1 with SMTP id
 5b1f17b1804b1-49fbc28e978mr56379705e9.14.1789596429113; Wed, 16 Sep 2026
 15:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916155730.2077434-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916155730.2077434-1-vulab@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Sep 2026 15:06:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WU7yOQWBW4SEMcHTwXxvNTMqO4P0DABaeQ6mBw7h=+Bw@mail.gmail.com>
X-Gm-Features: AcwNN1W4bKNukAgg1BwCpMhcUy96SsDz__HwTsvy2JJtukIrTrTDwRV8nOIqNGU
Message-ID: <CAD=FV=WU7yOQWBW4SEMcHTwXxvNTMqO4P0DABaeQ6mBw7h=+Bw@mail.gmail.com>
Subject: Re: [PATCH] i2c: of-prober: Fix device node reference leak in i2c_of_probe_simple_enable()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, angelogioacchino.delregno@collabora.com, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenst@chromium.org, 
	wsa+renesas@sang-engineering.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 8:58=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> of_get_compatible_child() returns the child node with an incremented
> reference which the caller must drop with of_node_put(). The error
> paths release it via the out_put_node label, but the success path
> returns without doing so, leaking the node reference.
>
> Release the node before returning success.
>
> Fixes: 897261149d25 ("i2c: of-prober: Add simple helpers for regulator su=
pport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/i2c-core-of-prober.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> index 6a82b03809d4..603de487ee2d 100644
> --- a/drivers/i2c/i2c-core-of-prober.c
> +++ b/drivers/i2c/i2c-core-of-prober.c
> @@ -354,6 +354,7 @@ int i2c_of_probe_simple_enable(struct device *dev, st=
ruct device_node *bus_node,
>         if (ret)
>                 goto out_disable_regulator;
>
> +       of_node_put(node);
>         return 0;

Sure, looks fine. I guess alternatively we could use
'__free(device_node)' for cleanup, but it doesn't seem critical to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
