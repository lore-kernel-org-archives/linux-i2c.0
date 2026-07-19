Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD393A5E9F
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475638; cv=pass; b=OgDIdZGFStMw9aCXlK9CTy7hsETm15ImTPWOWN5YzAXosuY4shgPdC73YM6qvmeE2RLSFp0/cT4PSs8DFiJo4RZ68CW7eAaMYwhvzjYh/YWYHf/8z2WKCoQEMEmNvHx74edqioX+JpIeU8YcQhq0ANK+kzHDil7ZDJAAOzuvOqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475638; c=relaxed/simple;
	bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY25POOss62NAQNkiSUwv+IbTwvOBjpGS3b0CWRCsAvwDdXaiU/KgCuUFvfIB5c7GyCBX9QERLJ20YAeL9deTwqj+RDb884YvXdy83r4DRcpdHQyDAdaNu723nbjAtsErM6KPwY9/ieDmvibxVykGAm3M71k18MeK1/PtZTWc2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsT9XESN; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsT9XESN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7fd45465so76471921fa.1
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784475635; cv=none;
        d=google.com; s=arc-20260327;
        b=CJm0OQJUFWJ3SdlSMBgoCn3Op/C+hzM0/A5iRB3Siw+gn3f+TqvlHPhyhKfr10/QWs
         +wMlpJjBvA31ixy9EgXkQcA16soMRVgZrdoNXhFM2OSstzj3GlOoEOFFM4AuvH6AOHX6
         2xLcSc4kyZBaAxpZQ6ZUJN7PhHivVzz7mh0wtOyTmNQx2cmeVSYihtvn5sX5YSH4GUtv
         w7TXKduIV7Gg1QlMHfjtQsTJ6qKdTauz6k8Z4BDHfPLZ8p81wOewDxjBJgKZ0ANbuZom
         ZWy2MSHWkzt+jZnFXbFqPjv73vvA8nq9Cgqd8qR/03SSAMaIYPcM85T0EPK/m6/v2uIF
         g4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        fh=FgHTWkvLpk80Epyzcfzd4AbdmJYChDdv64xlE3SRbVY=;
        b=KVV5dr4oKub3SIYlEsDQWUD2+t3zq4JFNn26JfSGucfqnKBUSLGt/xUtcq4m2D9i2w
         8tjpRfF4i9ZKjC0m56bhVanNkraAIlTqvYeZTgTMNrVoJeXPEEQWrVJ/8RAfb2CoXTAe
         DY9ZXJf9Cef64/nlzm9u/cmH+j+vVB5xdKkvPG2zLWM8i+qX5SUYkNq7PK+U3u6tmsP/
         LdCEVpsKIFGcbH+A11KCyXcz+K5cBkHLSjRFtmcg4cQWcB+H8gb+DQHeQ8PbGYiqH3XF
         TMePYYSvItCrBwYa+BB9fU+6vNoHIjaqBtDBxJTkPO9PB4w4mOk+wR88DLoB52Op+bcq
         957A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475635; x=1785080435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        b=LsT9XESNq0BkgYUzoLK+k/WOKnu320oHbaZf/g6rfQsW3VRCXqT0Fz+KnEQ/mNeE7v
         AXOm2MhlRbEeU7rnYO9c5G48TybmglySa+QR8dwQP/L/NG1woQMnmOiXeAfyCIVe6+8h
         V4CB6qUcT/ACPvlvQouxWwZl68EIy0bR201+rxFP8ieO9VWozXuqYm/nbhL93TgF7YKz
         SgsYHjW0PBvvjw1IinK1y+kVVxtT/769BJhYf6YbXNHGNT30HYEO753OxQ1zqhTda8ZA
         c16BzyHrZrGnbOZCoNz9EaFA/mzP+FM9DDXh6KFswGQPifv7yyG24OsvxA0IU2c7ft+H
         WXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475635; x=1785080435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        b=ajPCJs5eVHpXarIDGfG17gBgeHW1nkQc1fe3uoTKjZcUMoQGg+WqMSAyIoTPhWZVhU
         a+5QkqIqMXOnjk35tX9haQYbyus2T8OsD9dalaqy2aathxfMQ4YpU/DuGadqvUZcB8JF
         ulaZ0CAH/AWVeqBX9rywpkVNZi4tuDEwWfgLq/4QwQDmV5ILYkWvhak5dGsPS4Xt5D7T
         ErBlEE5cMtYFxDCnYmakRpMH9r/tFgC0YQEruiYsVFFfKeelYRc6OulchKT4qGbAaooe
         pdarrmEGZkKGr5kGHWD6WtEoICzCqZjK62RoeXlK6r8MaDiwBFa3BS1z99lCsPl9hkA/
         V0KA==
X-Forwarded-Encrypted: i=1; AHgh+Roj4pbcQDvRzg7iDnhkJYQpPhD1p8q4/AbkGP+x8s9D17NKR67yA2mrkln/pDDM4Ffn6OdDt4WJEo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fKWLVibvUo75qmWvkS+R0VQsMT+IqUWEP5D8D/WTrh8x+SRt
	iFY46z8wY3cy4JmlLRievGmknxmapQuqX4Ot8kfcoUkqe5q3t7ge9ziVgYGN3EfCSWVlg8+GIG2
	0uv/FffWPt8KqElI3/jAtfTlmWLEwko4=
X-Gm-Gg: AfdE7clDbavyW3lKGWaKGBSUMHpuS8i/Gpwu2Du+vfmz8acPgpPBD0UUbWRMTw/YHZz
	mpJOlgNvRgsLDia9Ea9z7d9gQutAsKY+09yP4vYcxKa5qgaB07K7N/VG3mMDkVbb8vMdmxJAq3w
	uWbudW6du723y1WQQWpg6iMVzWaELO9ln0kooLEWF4ULn16JLCwKobKZb/B1OauURWIv4lx4cDo
	3QjlAnkU/NgyxggtSLJuotpv/RGptCetmT2G8ORf9W13biM20ZHgFYbA7yIPs1IuY3FRcd7oeN5
	MUNXvfhSvOp7uizLPFYS5woWW9hT+bs=
X-Received: by 2002:a05:651c:23c8:10b0:39b:bc9:90ac with SMTP id
 38308e7fff4ca-39eb28bca4fmr14571191fa.30.1784475634687; Sun, 19 Jul 2026
 08:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
 <20260718024838.1623-1-brucer42@gmail.com>
In-Reply-To: <20260718024838.1623-1-brucer42@gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Sun, 19 Jul 2026 22:40:21 +0700
X-Gm-Features: AUfX_my2BHAuHKNdQwXk2gMXJotqDpUVBbqWmJkHc40EsH9QN8iS6jWKjJzD0qo
Message-ID: <CAO26r3T1YV_9if9XbooMv0VDzLba0CEgpSf6Nx+_rd2D7_oJ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Bruce Robertson <brucer42@gmail.com>
Cc: Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, jic23@kernel.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Jul 2026 at 09:56, Bruce Robertson <brucer42@gmail.com> wrote:
> For the write side of that rework: I recently posted an RFC with a
> Rust port of the SMB347 charger driver [1], which Igor pointed at this
> series (thanks). I'm dropping my standalone SMBus helpers in favor of
> your Io-based approach.
>
> The SMB347 driver may be a useful early consumer for v5: unlike the
> AS5600 it writes -- a config-unlock write plus read-modify-write
> updates of charge-control register fields -- so it would exercise the
> io_try_write/try_update paths that Igor noted are otherwise easy to
> leave silently infallible. NACK and arbitration loss on a charger
> config write are exactly the failures you don't want reported as
> Ok(()).
>
> Happy to rebase it onto v5 when it's out and report back.

Thanks Bruce. Good to know the SMB347 port can benefit from this too.
The extra write-side coverage would really help, since the AS5600 only
reads. I will CC you on v5.

Coirul
