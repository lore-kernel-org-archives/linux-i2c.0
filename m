Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8423D1A97
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293259; cv=none; b=k2yEYmeuO7Zqn+7NOWx1hbRSJYMiDCqvwlI5K3zytnSGujDchqO4PxtdCwa6rFMxUicMqv4SuxHkWTD1/zcw2VPonUhQ6akddGIIm25FXegKQMOEE9XuBfBCA9dxAJER0w5eTwipVc2qA966KoUR8xWbAauuid0TJk8Oo3vzT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293259; c=relaxed/simple;
	bh=ZDYzkkV01TlNMexcknblztkA3fz62Et5Z3p/N1TA+Ts=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=dq5IRmfyAlsGQkho8/A1v5dAnNaol9MUzvq/+EtgwrzfQkjX+amLZQI/M5byooEUY/oQIB2dnXkMKwYEuA5SKf/AHeeU0l0oZ0ojg3GHB3fdInYFBbzVRLg82wnS7RCUT2+au7lkgebuBTSi/OJTNA5yC/lDqyx4aN4hxR/wBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=xl0KATs4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="xl0KATs4"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so14661011a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1784293255; x=1784898055; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mREuMlZq5bhR8hA4pRBMcoPSgOGkAtOyAXgmK2FIjzA=;
        b=xl0KATs4mzZF5aMCfaTduII6ljsEbrXN7sVQERLogVugtDqfVGBJ4p7GqyGhmJVVAL
         9OcTY1tDXG9Rn2u4RUf8bsX/UmsTvkii6WlnuyG6/YtH5q525SIt5VRQgzDp7f9AOa8z
         o0MYz4C4L8dd76RSpzWfIaX7veScy0YPZ+8BbT6XRa2AtxBoqD8MbeXRP0ORh5A+TIPr
         RHtpCZtBpjxQYxka/bUwzmRkZFHJ7H84g0rbWc8dP8H1uV/T8FiHa6XK/d+S/bTuznPG
         vc6des9Y8M7A8HjUskKZcXdmLffaqzlUvpEwxZWxji1iSBz29vsgJv/CIepmB45bYTt/
         Dg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293255; x=1784898055;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mREuMlZq5bhR8hA4pRBMcoPSgOGkAtOyAXgmK2FIjzA=;
        b=omlFI2JjNSYaIBv0JiyJRbXzYr6btdBxc4FHk30BtWvrPveSJNZ6S9jZ41db1Fwm77
         LXaL15CW3GwkUpP9zKfiUY7VUwg7K9+YT9prvAWHmK33tC3yY1in4O3Dg71lmaE83cs+
         ZLwUz7kpMu9oYWwjvS2noMZYITRswp6aM491iM8iAFtSpuCYWqKGDeCuT+TTaSb3CnGE
         PcQDmRjVotDpMUZzPtaI+fUnemojzwQYYVL3EKEnx3PkEmpyHK4WUAY57u+AlQNc3qKY
         b8IbLjvatH2BdsYYhOFex4HoJJFt8YDdSFbBuWFGLnHfinkMYzlSha734605iebB91vq
         whvA==
X-Forwarded-Encrypted: i=1; AHgh+RrjemvTksvF23B5TnFs81NNhUO5uVNydLZuVr97EVB7hpCWVqTGWDhA20/+BntOIF7qUeSgyT9DRhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqW4R/8/WC6fPy+VOiLkKAo5XS+vlTwenEta57FwhLi4htSvN
	d0vI6w6V1t5CRsdL+a1SdMCfRTV6w1Atqtdts4fU9ctkbrr5Rwu1HVAfml8BRuotkYginp95+8R
	kjASRgKteoVBXQd89W+ERAddQOn/cSkpfzmfw2sLbUayluTSiC97Vnhju
X-Gm-Gg: AfdE7cnZc8IfrnqUh52nesrOzinzZbs0oc/J4vq5lGCT0IK6cJg440e8FRWduRWEAiZ
	S9xeocQfKLo/fX8xWvT2HFSD+XxwwU3TYOlYqU96YGNFm6diGS7gp/QUSZeDqEe7IHpXBsjIdSb
	Db+sALkZFdpMmT1f7xGhjeQH9ICkb1xlwjSYWeUclzwrg11sC/qVEADcgyyQZqTRI8+fxrNAJB7
	o58xfA7TiYF9eGEOBoECLRiTnh+0dBpZ/xcF63ahXG7IkQ3RW8ip2JZOmQ0RkbbC2JsVlIGzkcz
	lP/5CV1WPSYQ6BYEOSxXuvFFId+55L8Z1zgbhS3VFzvn3y2MOHt4CNnK5I6IuF9/hFzIgm8cfZu
	9PViPxn5Z+HTpgR1i2Tm/KvdoDze7lbaaPL9jTsE5WL2nO/HrcoM/nmUlw3h0z+PtuEn9oWj5NF
	Fohuyxs8W6HWqZF7c=
X-Received: by 2002:a17:907:7ba5:b0:c16:4df6:1768 with SMTP id a640c23a62f3a-c16b47d714emr109862666b.42.1784293255096;
        Fri, 17 Jul 2026 06:00:55 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:80bb:45b1:eab0:f478])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c170591172esm73379566b.15.2026.07.17.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 06:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 17 Jul 2026 15:00:53 +0200
Message-Id: <DK0V64S4JWAS.3PNF8V2ZQEDPY@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de> <DK02UVSWWGTN.2M4XXGFINRT1V@brighamcampbell.com>
In-Reply-To: <DK02UVSWWGTN.2M4XXGFINRT1V@brighamcampbell.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Brigham,

On Thu Jul 16, 2026 at 4:49 PM CEST, Brigham Campbell wrote:
> I agree that `open_i2c_dev_path()` should be inlined, but I don't think
> it would be a good idea to remove its `fprintf()` altogether. How about
> something like the following, which would make the error messages more
> orthogonal?
>
> 	if (errno !=3D ENOENT) {
> 		fprintf(stderr, "Error: Could not open file "
> 			"`%s': %s\n", i2cbus_arg, strerror(errno));
> 		if (errno =3D=3D EACCES)
> 			fprintf(stderr, "Run as root?\n");
> 		return file;
> 	}
>
> 	fprintf(stderr, "Error: `%s' is not a bus number, name, or device file "
> 		"path!\n", i2cbus_arg);
>
> If the i2cbus_arg parameter didn't appear to be a file (ENOENT), it will
> print an error indicating that all three methods failed. If it did
> appear to be a file but couldn't open the file for whatever reason, it
> will print the error along with a suggestion to run as root if it's a
> permissions issue. This behavior reflects the behavior of
> `open_i2c_dev_by_nr()`.

I'm unsure about this: Yes, this reflects the behavior of
`open_i2c_dev_by_nr()`, but we only call that after we have validated
that the input is indeed an adapter number. With the path we don't do
that, we just try to open the input as a path. We know it's not a valid
integer, and not a valid adapter name, but it may still not be a path,
maybe it's a mistyped adapter name.

To that I'm not sure we can conclude that `errno !=3D ENOENT` means it is
indeed a path.

Looking at libgpiod (`gpiod_chip_open_lookup()`), they solved that by
assuming that all paths must start with `/dev/`. Unsure if we want to go
that route as well. It would definitely simplify things and I think for
the sake of progress that whould be fine. Thoughts?

Best,
Gero

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
