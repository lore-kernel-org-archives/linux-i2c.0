Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732053BCD2A
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332548; cv=pass; b=jQciKrFR6FlYYusI/g+0zMDnIGM2vLwLxVgq01M4vRkXa5BO27c4q1Bd8TY2z28cLLytKCQd7DSQ8GVtzEWcXui7NyABXynCOz4wm9+81cGs8EfuogaBMOoBcXs8EXXjPfdvzW2T6ccZG0tAL1tGX6ccL8Ao0Kc0Xz71f0PNQG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332548; c=relaxed/simple;
	bh=IFML3rF9djtar7SwsjcOXZQUh4NL6BJakKNcU6x9ydY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpHNCU9xg7fD3mk6rVCBc6AjEYgQbfJWkMiqS2Kdh81Do8m20ngmtLI2ElpMKHyY8FSNec+2AIxHPlOCTw4gpJxu46ORrnrOemMrpvOBUooC4VON5h/7KtV9k6TdPNJF3fJmbLS3E/v9IkWNqx9TRSm4+A4pFHJvlYrADUdNldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W8gWe78Y; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8gWe78Y"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664c535f1a0so3832819d50.1
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 03:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783332545; cv=none;
        d=google.com; s=arc-20260327;
        b=r+asgCfPEj9b7FtniRfkuoLMPJIHV+UwhQnP88rg7ySLVwQHinbAvgP/kA8KyctpYo
         +5PGM9rzFB/tddKGxyVUeOFzioO9yAhZ2zkoSogz4/6YVqfgkpJYaR2YlTauaU9Lamjt
         VNRXbckjOwDZoul00e38FDcUXVtKPFqwsqhE0putA7n98jDzmHcGS1EBq9tgRJUV9R+s
         qi52SVPGeuYBbKnKHAVK21WOhFbUekDJKq602h/v2mjmAQFRoKDvBXFpcpNxMbMkmEjy
         Z4BtMm+BvxKK1OOBvI4nxk0MiEGVRFqC9ODMhZsVYaS2ek6tS1jrFOQV6rxiCEB70PNW
         8Ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        fh=Jit595NfdU141yqzYHr5OGiIESFLI8XmhF4n3Y/BQ40=;
        b=TlNv3nke3b/yp/TuaCMu9kr+ywSktsJXCF3jm3XW6Um5+Gf3WFMiDmfKtASvusjppa
         OX0w+84vlKmlAk4lxyyLKaD/vszeJZkkGVYQrF9pWrPGF/ZAfD4lYqbW7duNFisbiqDu
         KkWhw5tPQEDAwu6mS+TV1PNHkqoZZ/rp9QLTmFPZbs1bitwrS50vBqYpS93itlxCIAwK
         KlS8Vx8RyJZms2Oeg16EHOU3WlH7yuWO5Y504RLO2wQSFON7BhSRQ6RCIZRewhrIdV6O
         AjRXYluTWw8iHRDog9U/2UVKDZ0ezNcEHNBMLIz9HBwVQeE8QLWyqtoPC5qp0V+FbEO3
         5Puw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783332545; x=1783937345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        b=W8gWe78YrA1pTi5GDFMAUKQe0D2iKHK0Vguck/qLEYSo3O+R+m9ayYRo4WZx26FsAp
         35DA2NHhnJ7m6fHEN/ix4oylhpJxi81jfNRT5ytbLsrmJVaATVuC0pEIXRxLGgiFryKo
         WO9E9sa9ijZQbodstMFeBvql79r4HSdJwAE+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332545; x=1783937345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        b=BvwM5XboYFcmM/JHJkn8Dc781jzKcmMxJItyhgRrEaOXHi+yraI2CWt67elOCkUhnB
         jgAqCSqvnlVmCjovRHU92IsOH196DhOjKOncc+lsGAcUOyqp+VCW7HDdaCY7qExffjDV
         Ih8+1gZ0s2oC5DfVwb7Qd/L1lD3UfdWz6XfAvTk490VSCUFCmyLDo02YSNN20UsIL9/n
         Oy7jBsilrEyizJ4GYaR5RwTHHAEWXsAeZ72fRBDLXXh8w72/IUZm7hC+GUFznR9wmhfE
         g4DxPOcraqlJmiKgUJR7fEjBdX2FoQgkO108IHfnjJB/Web74K40pEUeEOJUmi2I2OAz
         N9Hw==
X-Forwarded-Encrypted: i=1; AHgh+RpW0qX1/uvYoOsSRGwbb+QeoKWjSQHDoUSjeJjENMJQNPdgTBdLT8satsv9hv3U3t0hVjh37O1FTs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA3AsNTWJNYjAxy2S9ODExIIKVCDhCTxisizRofSt155y8nye
	AKkrWppDY4qEfcfuP5deL/bFbDWD/0K6XxyBT9Vc8379wXBAEOM59Gur8hpDH7g+LEhvESlb6xE
	bEYh0kpR579oxZ09MTGs2hh16ukD58wIQTAMLdOln
X-Gm-Gg: AfdE7clsAl/HixgjAx4Joy8YoevFrKoBFgj4fNdIt8a1sXpL5TRKBJ/tShjqgHHut9+
	22ehirO9wlju2HrjHNQ2IxGe57r7mwzJkzLs78YxGq/AZFWgB0d+FJFWkTQlh5Fo/BJAzJEofGE
	ipCRuC9k9vmLYNfgLq4xfLRT4MTn47+VcVe+rRNHaqJIif6b9U5lhPaxwX4x0t6kaaDfmW1TeNK
	qyMmDJHfWTyNV5NbZ2oMlybIbTPyu36ebUJH5+z6KGfFMh3mCNc9BXcniJqYu69RR17VCdSrp9c
	ybNEJPfHtQHWWXnEqJGEEK2rNe0=
X-Received: by 2002:a05:690e:120c:b0:652:5567:b3ec with SMTP id
 956f58d0204a3-66652e2416cmr8660052d50.37.1783332545405; Mon, 06 Jul 2026
 03:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703115601.1323491-1-wenst@chromium.org> <20260703115601.1323491-2-wenst@chromium.org>
 <akmZOC_J2ZTl4zLX@google.com>
In-Reply-To: <akmZOC_J2ZTl4zLX@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 6 Jul 2026 18:08:54 +0800
X-Gm-Features: AVVi8CdednA09-ELXrMS4uc6xSUtulA0xKkThvjfCvkhmpOamhA7IkBdQY8wb_E
Message-ID: <CAGXv+5H_SXO0DtN9wjrXyAvuzG+CkYh2-4eMg=biOSsFV=E1=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Input: elan_i2c - Wait for initialization after
 enabling regulator supply
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 7:44=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Chen-Yu,
>
> On Fri, Jul 03, 2026 at 07:55:54PM +0800, Chen-Yu Tsai wrote:
> > Elan trackpad controllers require some delay after enabling power to
> > the controller for the hardware and firmware to initialize:
> >
> >   - 2ms for hardware initialization
> >   - 100ms for firmware initialization
> >
> > Until then, the hardware will not respond to I2C transfers. This was
> > observed on the MT8173 Chromebooks after the regulator supply for the
> > trackpad was changed to "not always on".
> >
> > Add proper delays after regulator_enable() calls. To avoid impacting
> > the boot time of existing devices that have the power rails always on,
> > skip the delay if the regulator supply was already enabled. In this
> > case the regulator is either always on, was on by default at power up,
> > or was left on by some other driver, such as the I2C OF component
> > prober. Either way the controller has had ample time to initialize.
>
> Unfortunately we do not know that [it had ample time]. For this code be
> reliable we need to record the time at which given regulator was turned
> on and then execute/adjust the delay as needed. Until we have it we need
> to assume the regulator was enabled at the time of regulator_enable()
> call.
>
> I am not concerned with increased boot time too much given the driver is
> set up for asynchronous probing.

I'm a bit confused since you raised the issue for ACPI platforms that don't
go through the regulator API. Now you're saying it's not a big issue?

Either way I will add some new regulator consumer APIs to handle this.
This needs to be in the regulator core to prevent race conditions, such
as when one thread deems the delay is enough just when another disables
the regulator.


ChenYu
