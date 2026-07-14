Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F93441617
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022170; cv=none; b=ayARgpCs3k6yShPScPGwFK+ylrfyT+011swbdGapdFLoujAWz3LSN5XkXtZpVX0ePBlTHigZ+g9rJOliTI9RczV6NJ0+gOKndgRQiKx5RVCwUZHPNunSu/Qf6jJnbdWXBVLRRuOi++58t7X5i27lYIL1TC38XrepNkbJhAYwlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022170; c=relaxed/simple;
	bh=yILbrkcQncKEV+c5sQ7ENKbV0x1P+vXurSxqq5vSJc4=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=LfWpGJXm9r3RRSYZEAHXP+O8lhkMvcJIOnlCD+YzdzzsXA9bSDM48L8vzXC2KlCqGMlnHKO8pM8lsdEaeDogm7dDBQuYEvRhzJg1swyhsJfLIMbYoyJ96QdAOEFw/iR83ZicllC/AWqqPk9G1j6lXde9rVle/UqIPbPM0AwWqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=UtS9v4HR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="UtS9v4HR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-476d8e647e9so4061900f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1784022158; x=1784626958; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yILbrkcQncKEV+c5sQ7ENKbV0x1P+vXurSxqq5vSJc4=;
        b=UtS9v4HR8Kvzs+ImJ1oN8Gl7NiDq3oFCPKMETrC9Zy/TfmXiD3xxbuNpv2tKEU4HoG
         kLA2TXw8y5WL3U8BLdVO1O26RpMXasYRnEIU44LJNBncqLbpTDN6c4bk6xrA01ZEgun3
         rBbea2xj3kG0IwARk1ZtZoRVJ6iZ8tNa4ibkcS/KUrS0vmqjedTbXg3oTokL6x+z8bgG
         EUyErm3D65acRLWNbeWXnRWbnE34if4vcDObGDvmAU/2gHX4TqAaAQKxx13SKF7XQvJt
         Rygyr01NHrbbDBXdQ+Qn1z7KOFUC5kN/89YjuX/Fs6otIEDNTKUSWfZkYJSh6He9eiNI
         03dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784022158; x=1784626958;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yILbrkcQncKEV+c5sQ7ENKbV0x1P+vXurSxqq5vSJc4=;
        b=KkQuoDPS0rZatkUe3ENoI9e7TKI4ESYuHpEm9w/NQax/aJ5TxeCBrAWGxmdZknAz9P
         +IGTO8XS42Lfq0AGRuWohVGa4fz/RlKbVPg4+BVqJ+4fax2q7iMdsU3Fu7xfJvloxPyL
         Z1puYA6fM6KK/ngaKcqGohwffm8Fp7OWfE4bsoWy5MIX8iDz+9M5Ozdfak5hECX4PR7c
         H7YR4NNVgTCwrMHWM7hZUaA+iiP3JhLDAqBd4sJIP3W1hVA659yrZ6zL1PZQFl7IQXcQ
         6t/P0cc6zz9NWpRBdNol4ln77ohFIPZZIT60kZeaz/qqUwFPJ0yNwRywrmeQji7DGUU+
         6fpQ==
X-Forwarded-Encrypted: i=1; AHgh+RowBEWl/oZFGuWkEnn9ZSTiHBGYHN0Kv3iIcxt8qFxtKNBE1aWtqeYqhZP8UA0NbSGBi2BZ58TLlpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufPqaBuaqHq0d5iz1IrquerWmNZGTb/fUuoq60nznefXqLl0C
	H3IzjdHe8UEvVELZuv3MnhzD/XekgvKAMRhQGuCQdnuCGDttM/vPIMqqiMjNKzZ2FYPd/9nFq7J
	Wk04hG9gWb/BIFW72CcQ+FMRaWVGYPavm2CFREs+JLANttki2gjuuZ2ws/dEZv+OY1a9sGg==
X-Gm-Gg: AfdE7clUQenE+3YH0KI4XRNVlLTzBEh8058K1iLnKbLZJZewVIYQcMV5VNS7JZ42jvP
	ydszRgrDrHZ6l2yK/6D0Y/YYFilI09fE4zi05o3dTowwyegf2uRQ8dGIaozHAtIZvvkbyww08eP
	nsnsIUimvDkWiiaUCc5m30L9bET2+n/dtFXlb7Zd0MmhL70vCwRUvEhs+N8rWkbayqG5dPMwjWC
	dRq66BZfcKZ1ilxXVI3RTm1QU/Gqv05L12ujMhxUKxbq7dbzlnqqrTw37zGrlX2qrhJ/EieH0fL
	8J4vtahhh7DsnRyBJfKen2zuyM1oYUlNZdcDBt7ccFAh7WFCXB5w77IXid3bNLfUZFsEutZcR+T
	/ME0gTPQn2pbxh+A4qyJyIM1piCtmH4XPCWo8SB1wJDgFc7iXX9tNzm2+mTSzepRI+mp0zl9+ky
	GtBhdWnitB6dphVxnyMxVDeujy
X-Received: by 2002:a05:6000:4709:b0:474:6301:3e3d with SMTP id ffacd0b85a97d-47f48848568mr2118363f8f.11.1784022157869;
        Tue, 14 Jul 2026 02:42:37 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:4076:3d5f:87e8:a363])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm7307967f8f.3.2026.07.14.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 14 Jul 2026 11:42:37 +0200
Message-Id: <DJY72ONUKYLD.3D0U14SM219BI@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJXCC2TLMKGV.GQPIOKMUNXD4@sevenlab.de> <DJXK0VTX8680.10EZPJHF4UJN6@brighamcampbell.com>
In-Reply-To: <DJXK0VTX8680.10EZPJHF4UJN6@brighamcampbell.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Brigham,

On Mon Jul 13, 2026 at 5:38 PM CEST, Brigham Campbell wrote:
> I was not interested in avoiding the cost of copying 20 bytes. I expect
> the biggest performance overhead would be the actual i2c transaction
> itself, followed by enumeration of sysfs in gather_i2c_busses. I'm not
> at all worried about a single strcpy.
>
> I was actually interested in accounting for the fact that because this
> patch allows users to pass in symlinks, users may very well pass in
> paths which are longer than 20 characters. In this case, the filename
> buffer isn't big enough. Rather than allocate a new buffer and copy the
> string over, I simply copied the pointer to the path in argv.

Very good point, I missed that intent.

> Maybe it would be easier to understand an approach which simply
> increases the size of the filename buffer to PATH_MAX from limits.h and
> just copies the path directly into the buffer via strcpy? I had
> considered this approach. In this case, I might consider moving the
> (much bigger) buffer from the stack to the heap so as not to overrun the
> stack frame...

hm, simpler to understand indeed, but 4k is a significant allocation for
smaller targets. I'm a bit torn. In the end both are valid options, but
I think your implementation is fine as is. Maybe just add a comment why
we assign the pointer instead of copying into the buffer, so the intent
is made clear.

Best,
Gero

> Thanks for your thorough reviewal of the code! I appreciate the feedback
> I've received from you and Gero. I'll try to respond to some more of the
> feedback tonight.

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
