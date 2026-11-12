Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470589;
	b=AwD6dECLlkduZ0Ww15ipA3MP2hBGyYXAp4IrFqxAeqTQbKefWmxvbvP/jCUiGmpdoqbs
	 lnYxgseFJYXr5ZrG89XGbpaAE3sj0tb8rl4/pHXlpigQ3eeDvLBPDPkbvpsYDH+UDFOeS
	 ueQUZwgyuA4eOi5uDqTsMqziyajf4sHZWzvF22aguAe/q59fGBJc+J+bUEqID5GjbjFJr
	 amB4ML93+ZdpEyXF50oR8mmmi5Fe/maJqJoQjsn/QPBL7Yz+J0FuZuSEUYexhm+xwqXtX
	 FgvgXdEHNZo6tKVBlZ6ts2p1ZRXtKZ6y+d+llt25G9cdvBrGd/s7o9bOWhrvB42vbIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vg5Ht+MKDWTS/SngbatC7TH8UxuMGp7fVzqLJKIBOgI=;
	b=VhuXY1C3mLoWIVxC2OIGGLt1QdNhgobrRZSkOjmNeIotvA1qs6PVxVbTQZKZwvgpy0x/
	 8yug+OZF+Yavyn6djhydxHmlWr4KNe0/lNvtKO5CYPRK6EJRnlm5NUrQuAdd6t/TnthOo
	 JfNL1Ly6VnIDFPIfzzXng4n1VcINU5DB+u+oE84wCUhv+KbBnct9k5LZ4pJFerWZmmSWp
	 MdU2z7nWr0VvT228QCyumIt0fEwVvnjEzUzz+qp3ZqvXiulU3KtMcZ6Z5JFYJtKqsgjEK
	 3AksLcKDjmAg1t0kIHBK/8lflXAO1fFSvduSIHW48QK4BH58Q+ETsN/LIWGuncxFkFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i1fHBNyM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C741606A334
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 08:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C741606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i1fHBNyM
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab3cb83f54so1320461fa.0
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 00:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794470587; cv=none;
        d=google.com; s=arc-20260327;
        b=gmEutacSiNK+91TE6nvGPUJcZOSRjIMAWRMzQFCZQlhDkLL8xDam+M+V/fqzD/higX
         BK6SO7hR9Vj62b4oKO7Yatjo5j+1F8pcQSUvDboP8wKYgcyOvpf7tRItnJSyC+zZEPVl
         YUsM4epKe7o4egKuGq4IZUWwaHcKlnQHIMoRDfcJBYhAMSplMwuL8iANfK8JK5z3s3AZ
         127yvwJCPNcAEplRkFly2GF2Nozw7K8fwRX59ChThCUvWuZw9y6i2ZV9C2vgAwVGU1KY
         f/K7PXbwWYc5zWCBcazQhinzs+/K+cvhNf4xjp2hje9AG1QnvQendVNXzaoCcgVtu+k1
         KB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vg5Ht+MKDWTS/SngbatC7TH8UxuMGp7fVzqLJKIBOgI=;
        fh=Z7eQUKtPBgJQCwS1BsJRz9pzBL6oRgq1ZMAR2W1dxw0=;
        b=RyP7OjRGIarOakAXbIWvLgmGxkaJ20mIsUfMlngNv/9O1KYgd68oIEEyuQj/XYPXxM
         h1zVo2GbSaoMguzpJoxBBIPv4A3C21W7U/qce0Yejo9Dk+hllO54eqFqNgRBvcrBiaJI
         OEyKdEfYyismDs424FaYhzCITJeOPClQDrqbRwaRb8Boo8YUb37R5wJKEeUVDMPaCGYS
         SJlxgHvJO1rMzlstqqqiu12Mx1kZdn6E+3wCzWt3spBQqIOKZZzCOGVND12J8UDToMRW
         2CYcSnKXiVAWMvRSNEFtqxkz9b0K8Ibh9Hiyma1349onOSSmGUtdR3V5S/BUrvbem2/D
         8R+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794470587; x=1795075387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vg5Ht+MKDWTS/SngbatC7TH8UxuMGp7fVzqLJKIBOgI=;
        b=i1fHBNyMwHeFsIC++MN53coC7qM3nebIEqBImwIlUrqxlHYgMYg7YkZvynV7vsQ9Vs
         tKihkMXh5tPa5ZZUFwWgg+psnR89c3fZSNg203PdNXxEvt3QypnGbnKdwK6d6VJorBua
         eFHvd6RVtIZdxu0f/sIkijjKImlwqoUjUeUpEc1/8fXQJq8kDwReC1RvSv5asDqV2eXb
         9q6z4VM9Jtca9NzyUEPXjrjauR1lHpKpnZGu8QZgIcSkxaIQfb4JE5WBADIV50cvy5gJ
         Kn1sbLQosOCZGyM1iXgsx2WATY9AXSI2qw1q8iUPLlinGsP61rUTs2rwKJIQ101Fo/dT
         FCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470587; x=1795075387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vg5Ht+MKDWTS/SngbatC7TH8UxuMGp7fVzqLJKIBOgI=;
        b=PyMIawBzCTpHOYooym+dlpLte4rRb0lpYCPBRldxe5lu/3a7XeyCNpftBi3Vn66Zul
         dwT5vif6k0hVyqvAD5gmGozWcc4P3ck2xqFDapKNlEUEmWjql8hKwvr3EmchXfR/+1U3
         AfAm5e0zDUVVWC/fjrx+qFz/peSdzNbThCQqEaUcoP0XJl4hMHt5SvRT077hm2K/qrB2
         Upw7qe3LOdZSmYSpjl+V1x7SLU6oY+pAnm1kwmNHeevbacbuuk0Q5RFVxD1iiRWdmi8f
         nZzGbfAaw1YU7ln5xo3/I8l9yyPCKI1ZHF1QEKIFzn595NJ39TlrBGxNvpyEtvsm0FFu
         0Rfw==
X-Forwarded-Encrypted: i=1; AL+hErE2kIF2fkfmpvBNOFI0pm5z9d/rbiLeBB44vmycsPV1fnjBYoW/CANBcxxSvIXFmpSsBKiIfvwYLQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z//5u/pF2YqHhcZI/EFkosijYb5C9Adh8QpLNC3Cmpu3mac2Hku
	iiUFTOxwPZoeHgft2RDN9YW4y9bv52vTd0ZVaI7tmVVpLeATNZpzV3twfYk9sXLdEPg1Fs1QQzs
	2TOBRrN30fN+mEeWdgdNC9GNKeIKvsVnbIzdbIcwMVw==
X-Gm-Gg: AYBFou0XQI8qdGrZem5iHfE+pGIte/GhXjPxnPn9oB7MFLto+pwVGgU9+6PtFFi868D
	5V+riBYPo2OGguAzh6EGA8kpujDD1WMq0Fdl5bqzlvglS/Qaff+3htt9q8sKSITYEaVhVK8OwGi
	WiNeOTdqxxHr+8ILytRBYWPJv3FuNuTPC9KADpXVOZu/ayIi/GNHL5QeD9FxxrmUF1xrO7741kG
	Q2iCngIItZoN5n8e7fCsd0IoR2jPNMG0tiaS3wtTLvuTXifsyYwes8uPFcksaR1xow8veQvIDXs
	DFjq7FSyTBpeGDfK+ZobjIjsy4bZy1v7IFmeFbQ4V2OoOQZrKnx2hdpEWRjF5w25pUWMGLpLJqJ
	JkohiV5s00j5BEx9sUGw8whWiGWqSus0bU7G6jvxBW2VaObcEbHVwD9iRrFOL00UlBqgpNEo=
X-Received: by 2002:ac2:51cc:0:b0:5c1:5488:f57d with SMTP id
 2adb3069b0e04-5c15d632082mr1648903e87.4.1794470585944; Thu, 12 Nov 2026
 00:03:05 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com> <avQ8z7jFK3T4uZ_1@shikoro>
In-Reply-To: <avQ8z7jFK3T4uZ_1@shikoro>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 00:02:53 -0800
X-Gm-Features: AclHuK-jjur6lWiQKOO6c8Eho1dOCCFd80BnO5zfnEwPN1oz16TOLteZYqIO2Jg
Message-ID: <CAEy9hNWPYM5koXgXdzTNwyPYAnaxAGYoNX_sAo+CL8KXRmCEQA@mail.gmail.com>
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF match table for module autoload
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Nov 11, 2026 at 11:00:51AM +0100, Wolfram Sang wrote:
> > The slave backends have no DT binding (they are debug devices, as
> > Documentation/i2c/slave-testunit-backend.rst says)
>
> So, why are you adding them then?

Fair question, and that note was badly worded. Only the testunit
document calls itself a debug device without official bindings. The
eeprom backend simulates an EEPROM, and I should not have lumped the
two together.

The patch does not add a new way to instantiate the backend. Creating
it from DT already works: the i2c core names the client after the
compatible (without any vendor prefix), so "slave-24c02" matches the
i2c_device_id table, and reg =3D <(0x64 | I2C_OWN_SLAVE_ADDRESS)> sets
I2C_CLIENT_SLAVE. The backend also reads a "firmware-name" device
property to preload data, which slave-eeprom-backend.rst describes as
"DT or ACPI only". With the backend built in, such a node binds today.

What is missing is module autoload. A client with an of_node announces
only an of: modalias (of:N...Cslave-24c02), and the module has only
i2c: aliases, so udev never loads it and the client stays unbound with
nothing in the log (since af503716ac14, "i2c: core: report OF style
module alias for devices registered via OF"). For the nodes that bind
today the OF table changes nothing; it only adds the of: aliases. (It
also lets a node match that lists one of the names as a fallback
compatible. v1 gets that case wrong: such a client has no i2c id and
probe dereferences NULL. That is fixed for v2.)

My use case: on an Orange Pi Zero2 (H616), a DT overlay puts a
slave-24c02 on TWI3 so that the board shows up as an EEPROM to another
host. I found this because the client stayed unbound after boot. To be
clear, target mode for the H616 controller (i2c-mv64xxx) is a local
patch, not mainline, but the autoload problem is the same for any
target-capable controller with the backend built as a module.

I have since found Bj=C3=B6rn Ard=C3=B6's 2021 patch for the same problem
(https://lore.kernel.org/r/20210504135209.4757-1-bjorn.ardo@axis.com),
where you asked for a YAML file. Is that still the condition? If so, I
can add a binding for the names the driver already accepts (as ipmb-dev
has one) together with a v2 that has Uwe's include fix and the probe
fix. If you prefer that this backend stays instantiated via new_device
or built in, I'll drop the patch.

Best regards,
Arun

On Wed, Nov 11, 2026 at 2:00=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > The slave backends have no DT binding (they are debug devices, as
> > Documentation/i2c/slave-testunit-backend.rst says)
>
> So, why are you adding them then?
>
