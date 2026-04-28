Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86212EBBA4
	for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376638; cv=none; b=g5csmYQfoAAJbj9G62JUZ2N6mlUpwVpsw7UeQD37ZahFt4ySzbsqcu755VtXG849EnxzO+0gs0AivoBe6kwirf71N3nQvk8aLGhMmBjEa5lfLBvggS4zdUW9w+S87U0Hx0kHqG2SPMTHNJyHrUj9vldlZMkrmYizShVujuZaImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376638; c=relaxed/simple;
	bh=NGaeY6WS8ulTXBlk0ntcrCJ1LPFjjy4jJwIihI5M12Q=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=GgO63sngnVQRLIwO4ENpAiFShLBL5nvFnc+IkIkM5crqtsqQrlpHkd0eG6IVDsA/mxG4+mhKTjgYq+poB5Go/hOdtGsdCRM6WzrIC7npz+IsWRDz38+a7gAQXuEA2CnsHMqH7ihIHULew7BIEswRlSpJpWUP6p4pzg8D+wNsk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=g1cLHHms; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="g1cLHHms"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba7fd666666so1041777766b.3
        for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1777376635; x=1777981435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :message-id:date:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3OxW9Ndp6xNkAEvlDwG25qHc6+Jw0Tdv+XghrT+p0Y=;
        b=g1cLHHmsy+ru+AEdI14e0jog6NsmiJTFkop2KH3IS70D+iVe2V5RCwWSTF9NuilOV0
         HzkmGDoKPXbISRrgr06HvoiOJyt99jRpJKkb39YFkFY8wyP3hC80YmKI69OHpgLUEV/p
         doXrKOPBYPySHk6rXO4K4+1kGGsBWp7uCUGKO37VoQlPCJce23Q1D+siqNQ8jiVfNMP0
         6v/lHFnxTlqGfuRMtdaEzr5CJ2s240Xr1aYgzTJqKfuNp9XhirFJGwshalWie4atZsYy
         K8BoWrNUsI9Gqj+I5CDb3VELz5IhSQ6Xucfwbgxk77hMSEFIylbpamcWoL6la1ynMZIx
         b/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376635; x=1777981435;
        h=content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :message-id:date:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3OxW9Ndp6xNkAEvlDwG25qHc6+Jw0Tdv+XghrT+p0Y=;
        b=sdO4NWMYD8ZND38N+NyOfNLVtpBEh0PfWIgmM+4WuqVTjNqUgPou+W/DL1duLsI8/P
         A61ZyY2r0+hjcJdsOZcTCAD2XM4WyKu4u8huXDsinCrocqmX1PywccurXqZYODNVv6TG
         fSGE321KJIaG8JIcjOj0LvTb2oaxwtw+nMtfNidvdlgp1BfFfYGx1uLvO05zSYwof+Mp
         GaKcLSQTw58MP53eWyK4monqrPPsfD1RuY5U5NgB2j65d1QjE8JbEaTNklOUAJ4NqJ6b
         fqGdg/WnMfuWWdFlYoZR+FBVMA1SoPdI9zqbZABSRtqAwhQTXH4whRd2XT/lgK1mg2gS
         R6eQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lmViDxmfJjI4e7eYSbEehswic5JXFDbLVJsDnEK8IsruBfjMG5LSoWOaq7bJrftR4dEVPX3pfyik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF9Jt4SUWM+LXVU4uXZUNvFjQaGrcOihnxQz30MOjpUV7Tg8f
	IAtqzlTXMIsAlfz5LL9ScJxThzSEM25miM94ql27MpKPWgY6/V64xmqjtcAjZwfF4hgaJXEStnW
	ixgBFhdPmNddwMYLG4rg4gMfrrJ+2S8Bj/icG4RyuiaPlTJGlYVOxmeFW
X-Gm-Gg: AeBDietRGN8nDSp/lvHAMMIBg7zM4AvhjL4qh/U/IQHs8drZd36GigBqf10I/u4b0X7
	CH0F0hQfzytGY20Qcxcsd2cIJrQW/XcmgLo0x7GeUrji4Vabal7dmU2ULVXziUCXBfCS3rlqtBx
	yo+DsA+x3VlAZy2UXmFlaUG7Ojw1OC9zY0LUMnw+EGC+U18HG8Wpii2LxNixQJFoRV+uBn+/3ob
	LRBak6GHBaRO6t5MV65NsSZxuzpaQVxMHVkxMZ0H+5fP9VU3rStCI204mc0VZOXTMWVUszLZ2Xe
	ZRjY8nqgk3mLCN+Qkkvtqqye3hhO05EttMlj217O3/f9bFx40uzp6JW2D5TI4IPcrZ41+qWXjCH
	ZSBMB3rCQqo6xNj4YDYBp/53rCld43bhUufEaBMMB58yMTWdxfJJORH1Yz9F/YJBR49XikU9NCd
	DI92NgqvKAN3w1l8etNLAX+b3BtFpSq2B3pz0ZUV0HS92E
X-Received: by 2002:a17:907:3e28:b0:bad:f89f:7794 with SMTP id a640c23a62f3a-bb80443d54dmr170685166b.24.1777376634928;
        Tue, 28 Apr 2026 04:43:54 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:36d6:5d81:575:2622])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a35fdasm91004966b.19.2026.04.28.04.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 04:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 28 Apr 2026 13:43:53 +0200
Message-Id: <DI4RFLES1MXN.31HXMQMGXAXF7@sevenlab.de>
Subject: Re: [PATCH v2] i2c-tools: Allow passing device file paths
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
To: "Brigham Campbell" <me@brighamcampbell.com>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260312081808.347978-1-me@brighamcampbell.com>
In-Reply-To: <20260312081808.347978-1-me@brighamcampbell.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Brigham,

On Thu Mar 12, 2026 at 9:18 AM CET, Brigham Campbell wrote:
> I've tested these changes using i2cdetect, i2cget, and i2cset. However,
> I still consider this v2 a work-in-progress. In particular, I don't like
> that the code copies the path from argv into filename for two reasons:
> 1.  It's needless and 2. it introduces another potential edge case in
> the case that the user passes in a path longer than PATH_MAX.
>
> I'm looking for comments and feedback. I'm interested to know whether or
> not you maintainers believe I'm on the right track with these changes
> and what you might suggest. I sense that some slightly more invasive
> changes may help clean up the code.

I see that you're struggling to find a good way to pass the device
information between lookup_i2c_bus() and open_i2c_dev(). How about we
lookup and open the device in one go? Exit paths will have to close the
file, but the rest should stay the same. It's worth to take a look at
how libgpio does the same, see gpiod_chip_open_lookup().

Also, to keep things backward compatible, we should presumably do the
path lookup only after bus number parsing and bus name lookup failed.

Symlink support would be welcome as well.

Best,
Gero


--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
