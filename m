Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1426FDBF
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199657; cv=pass; b=Qn2YvtiqVLe8VU+IiWY1MgJh6RQlQz4UXj9NVIUvI4sELozWU7q9kRidb83eSvWF03NrRDASNrfoeASEcjdQNzQaiHmyLlmSxKm6JPCnl0o9SPePTTFADJ2H8jlvmtjHWXxyWvIu99whswcb60F/hu/cRaROtF3blbPJH7fW8oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199657; c=relaxed/simple;
	bh=vQOrE4BFDHHSwjLrmKkjMbw7MUqwN8AD4YKiz6VqtBw=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArPMP09ioEBGfG7WZwuc3F2VzdashMW6e9rDzgCFPW+qTc6WdKV2qdlihv3W/YJOLxC507lZQUipXx16uxmyx8K+2L/jcaSf1PA6vxPD8LUmk+9G3Bwr2RKsfTA2lWkuj7Bab8MvEtHdJYMrFAuzyj84JnRlIwJ5eM2iCpvnpHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=O5rnrIPl; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="O5rnrIPl"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6446d7a8eadso2360189d50.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 12:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769199655; cv=none;
        d=google.com; s=arc-20240605;
        b=H0cJ6IYuXPpBSeVY8UiRaMv6NgVvZ/JSlnkcWtRgS7T0wowtPtxO9Z8kQVGPn9lRvZ
         4tzLJ4h2EQVdjXNHGp0P+zFFsgkT0YiAHmCaRS6CYYRix/Nf0+bVX7dHaNNMPQCwMHKN
         jwK+oqmKrSR7aqpR40uSzx1F2p6Jc+Q0cMl/JY4dX6DS7qGvBTgRQskDJXCweDzDS97S
         vF8ldx6P9XbLX3gOkVg4yIZrSXGFKHCOuM9Ey08WdN6VGuarlJax6c9HDSWcKwyeL1da
         VtWQdF8MdBjxpUnaWQeMW11SkpYPTjOTEYiQ5/fmCmy2yJgNI00r7HAZum5AuD7y1VjZ
         jCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=fOLtwIvEzSJeTJDxSVUUCF+YVxNJQUiDB9WDvPnOGm0=;
        fh=SzzeoAJU6gCaj/Bl5483ciwrMJUoidmyQcx10TFHk5M=;
        b=CY1bLDmlA7ZPBdlciirnyDol8jcmoaGPSEGMIQanx3Ff6R3KvEt+3MimOqprE1hnyl
         6WdtrwxagRV+3gffSfQ/2DsSEa3Rm+prVqM6NJ9I6qhodEKlZ078ddOnJwq6J+ywJhDI
         jwPN5eTgXpw7NfzQ4mhxmjKLhYmPWL5UWuZiCzNGCc4HGArlzrpN/VcNwAdQ6eeBRGSs
         zgiGPktV9144DJyfLGlq4IujQFdfkAE5KGdWjxUhNejJQ+zUfklKlxY94x0bvHT/Bg1+
         4EkhyOJyRODmloYYHCnm6vqnnSX5RSPtyEgHCQlG0IdZ8af2WqrzgyERphKqE9h/VOyY
         axWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769199655; x=1769804455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fOLtwIvEzSJeTJDxSVUUCF+YVxNJQUiDB9WDvPnOGm0=;
        b=O5rnrIPlzzJumq1ca2F3tX49wSkNQH2zB0dksEvBgqMLIe1iICt2bUjQCcVyoU7VvR
         rS+ipeqCDparHWc6QRC9e16+MEn9UcMHQt7WK5H61htZqf4jss4BlwX+WstEdbkTdsZR
         Hy43kPgeRsdgFRi1q0ERLB3gGEo7Jj1BGQcx8yd2tIiC1Ko1Us7FoRUbXThXWamUH1WA
         D+OpV8e+CkeNInFMlm+7pm5cpjTHujYLhtTH5cj4n4Dr0gLZCeoleIsdqdeK9Hj/5ocb
         wr1wPHjwrLfz9pvzDIiYsW5ow9vgZOCvMAA9exMeFDDNX8jXNEw5y1E9xeDmHkW2dCts
         f/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769199655; x=1769804455;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOLtwIvEzSJeTJDxSVUUCF+YVxNJQUiDB9WDvPnOGm0=;
        b=kgCqcDTN/MlO8k+5zDDXU5ApYnqmVhL8yE7vHU66omb42pJz9hE3E5rOjBsZJwUTOO
         8jxA9v4i2U6TWFEfhhhPaZ99QxLi3Y4lcmsrJr59XdBjE5uv86tk2GFN6v9P5LA3qZV3
         s4N0/MIu47YT/tQ4sZYVzJenfIchdMFbhefH1SWnjwlhNmPsn/bQ2CApMlJ2x//IWoAi
         Y8XxqoxR5idlLY+FOjM6dv1Xzh6On6D2hX/5daFo4QBahpyYNHUzL3E7ziNrF0JKelHn
         bHWYFG4G4BU0cWanuw4oMbtmSkzCF7bOS8gY+I9jv00KaR38vvLY0801wx+ZqIiFa1Vz
         BRCA==
X-Forwarded-Encrypted: i=1; AJvYcCV6DOdxb+JGiFSr1FeEHf91GkviYhM+i1QepCCDCWdL/X0oRmRV3feCUYPK6QYWv4fO3iaSYKuVv1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxX9DjzcTUod+nJb6Nnj9334P6jdmusQ5yn5FK6JbW4AU8Q7LP
	WuBWTaA/YB6rO0ElZd6SiFYZMe4kUlYPV1aMgILOeY1mh5jJ8yprKuEOBSzV7ot0RFRJY/Yjdbt
	DOOna4QXWtBRdCgfFGUz4ePEJ07E/tSGaxa9FweL6haBWWfyOlYAY
X-Gm-Gg: AZuq6aItoM1PSPW1bj+Z2q8nOHqQNNT0Z60cpwvxtgkI2cKMt+K22E4U94BDy9V9znz
	wxtmgvG4O9IjKsfjDVu/93rpJpc6xV704STBskmWimc2nKxx0BFHWlAZat/wPh5vNR/Qwk1Pcv/
	JCIbQX9O76uHw3NE3O3ApIUBgeaah4ZJKACPqy1lebudJrlMC5Rv1PPNVeh9NJNYxxiE6bmRZ6u
	5hAKT5o8BWoqPZy5VVFVvn2wr0PwR8At/ltkakcettGoxFzO0ypDGdq1d6JENm8xDmTy1Guo50h
	ukN/mLE=
X-Received: by 2002:a05:690e:1241:b0:640:e352:4e37 with SMTP id
 956f58d0204a3-6495be6c085mr3379487d50.20.1769199654937; Fri, 23 Jan 2026
 12:20:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 12:20:54 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 12:20:54 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai> <efe4e155-e307-481f-8332-783cca8a098a@lunn.ch>
In-Reply-To: <efe4e155-e307-481f-8332-783cca8a098a@lunn.ch>
Date: Fri, 23 Jan 2026 12:20:54 -0800
X-Gm-Features: AZwV_Qhbvq6z6hp2KqC8x4j06_32gAkr1p6swgMTlxYCorOJpvUjhPgbmP-suPU
Message-ID: <CAGYn4vz3YuJ251JZFk7M=wsJr=bMY0Wq7x4Er=mjS_spyT5jLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
To: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri Jan 23, 2026 at 7:22 PM UTC, Andrew Lunn wrote:
> On Fri, Jan 23, 2026 at 08:02:45AM +0000, Abdurrahman Hussain via B4 Relay wrote:
>> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>
>> Simplify the error path by switching to a managed version of mutex_init.
>
> How does this simplify the error path? You don't remove anything from
> the error path.
>
>     Andrew


Thank you for the feedback. In v4, as suggested by Andy, I introduced managed
versions of the pm_runtime_ functions which do simplify the error handling.
I apologize for submitting v4 prematurely before allowing sufficient time for
review of v3.
