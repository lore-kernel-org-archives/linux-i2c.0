Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF343DBD5E
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400089; cv=pass; b=ialD5/6V9N5sHLsRq4HkWYmJQsBz574Ro0anGm9JlzsdGC/VC+NlMhyOJUGzy4nzXBu+gqNHZk581PFuU1H4f9ZT6deoDNEtHqrgOp320JQ8Xb4Rk5xdVXk9NBAxI60OZaqj5S9QMazQ86wCuVnfMn97GENtiFvc7Q/OFqAVmZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400089; c=relaxed/simple;
	bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pbY18H0qhL6bMsYJe6qEwekSVBv1NKsTDzmO3SwBgvA/vINvS/Cs3tPUD2SAqt4lzYAtFTNL47UR5tXTZbDMPnnxtUEd9enQpNcLdGw9yh+H4mlESi0+uu64fCgLmWD5wpbToXwTDhvQd5y6QaTIP3uuAVKNlgfJnJHJkNI9w5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSv+Mrsa; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSv+Mrsa"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec49f7e35eso537864966b.2
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 08:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782400087; cv=none;
        d=google.com; s=arc-20260327;
        b=IVy+GZyFJxXQhsRNtHuhTB+PhsbPejoZATl5JIGglsmzD+C+z0bxfHeB9Rc20YFWil
         ZdIeUO0xp6eY9VYqz3q6/bfOptVgICptwBEa72e6O/gjaTbRcAX+GCf8PPnVCmvHO+mQ
         6ESTneaSaN7OJusCX2WDPG/mDkYNq2OHnk9GGxDTCYmJq9y07O7XJOum2t4Jf5hj4qLi
         JAF9so5EHfnAK9DMbsCWiOXuRbp8WtVrb/jrgq2SWrWFqQvpJl2L8KdXPEq7ZiBZgX9h
         zIT6+ERzj3E/iPzLAprF/n3H61T0dL5Wg5w+lbrMjRYXQMgloHKXs5SApxwlbOzlZHzy
         9nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        fh=7AXMIMF4XIWZuo0YU2P1qBqbfrg3OlfANadm4cN4U84=;
        b=fa2Sgo4b8OhjKgpG3PYX1Cm1reIbLBv4RqVrmOaCJP/CdaglgIkMDeYFoSJgcw+Ax2
         jH0aTV8EX8A7fQb9SZe9BPDc46L62X+mvehQ9SXpmkDEaL5Pe+/zflJDmz7Yq62ShJxG
         4KfOGh1xLLM4OawuhsXxVEst35eCr+V8wLoAC7eEOE7JYez4xxgpWQocvjxZGPTAKz5H
         snwMFsWCzCF590vf0CSHBeTvHtzTzha0GQUVroEw6NFF7a9LmNK2thwHiucdbCVO0Xgx
         dr4PdUIUxogRr642Im3sZtMIOnc1Jium5F/bf56NzIhkoH8CgN7rFr4YWc7PM8gNj7Ar
         hyfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782400087; x=1783004887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        b=fSv+MrsaWE7mMOXMXnZPNUDyQDVQ4Tz0enLSDwkuya+4W5n31sedpmamaKaqZN3drp
         sUVd3x4xxh9iegn8jxY49mMy1lRxI0owIqMTtYjP9jwscuaR4BzMrbXToBgfAmpscNKP
         z/dSBgYbmFIQofzkXSOSYguNsyQhR6lT0FYOOcYs/L8k7b/2fp6fYydymPZfzgHGU8tW
         mqrk4WmqodTr4Yc/Ab3AexbC5JRo/qFI7WO228bXeBJae+asrZBxA0TD7tVtX/lRhpjB
         hjC7B+HgZ7el7oNgCjJGSgRlZRSxwb0JCnJ31OOJI3Jq5GHKPRCIdq5FgV0PSc5YVYxe
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400087; x=1783004887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkO3fCXc1ZaOKiTnsnssleSvXkY2yN/+fGVR08qjueQ=;
        b=tDLddKY0vlivyAtAXKamO5ej4+x0pKnIv/GBj8GjIgFwI6mdaYFofaSGBwOdt+qH6f
         AJ2j1Bh1sq+hGD/0bxaghEFM9RBsbuKmyt0kd5AU84IEI8go1xMX17lGDjgSxetdu5vY
         rX4h76T+3VpQSgiFkfPgVnHsBGTDtdb/BWdODajSaxhpCRa1JMfDb3ec5/5cMb/ak27/
         8bAifT6eEXt04fJuhx3B93UQxXq5p3CIEXzPMxS3605e89Vc0tzMvmKvZ9vYx7YPpPfS
         M70B0HNtbPneJqPV4ZwQql5V5Tq6niJizWG37hvgtC8XzdN7luBxg4vX5LcIcSGmsz3X
         vwSw==
X-Forwarded-Encrypted: i=1; AHgh+RpTscfBeJQwUGw6GABE0mpYjqpMxB3afpKZFs/3kY2qaDFDlTj8Yzta2/aB6gcm4oy8TuUNMirK3eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBsn13dg+bN7IFgsVJi3yu1iG2s0OAdcCk7Fa9cMuf2cDqjoQ
	7TZVpIYLiSt2jA5+KV3WOXtFH8TnA8mqvx0sjXUo/qIqbhR0Sr4F5rtVhLM7wUbtzM2IUlrRW6F
	rAkgIiWzKG8C5InarzGqDpOhJglrDU+k=
X-Gm-Gg: AfdE7cltqs5VfxjCuNq7JA7p8y5DRonn/LagMUqyaiowBmmJhimxY1AKgtpajJLmwSe
	+5AMbOPcUo6UfhAy5IIQW4YMkI9B4OmU7fLGih4hcW14azZIIWc7oXSixEAvn0zJGYG4EecfhxN
	ogJFjTHQL0C48tvJi8ZpEshU3vyo3X+OInpAmbSm5HyT2/BWT3HMz0xZJV+cyED2r7UQmEhKo2a
	GXmhYhoPpgmkuCA3YW2jChpEr4kU7+ABjC3og9kU/yTBve9FGNUHqV0MgNESrB0Pc/++mMj
X-Received: by 2002:a17:907:8d8e:b0:c0c:2033:c078 with SMTP id
 a640c23a62f3a-c1205ef178dmr223399166b.26.1782400086250; Thu, 25 Jun 2026
 08:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liem <liem16213@gmail.com>
Date: Thu, 25 Jun 2026 23:07:54 +0800
X-Gm-Features: AVVi8CdXewmKMx24Id0KrC4KlPydUzifiJZC1utFI6DQTmNGydZ-bYS7JAqj14c
Message-ID: <CABoz+=2PHMv0mqxPwHyR5rBOhT7xFxGVok69JoYhadQTuNnsdQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: imx: Fix slave registration error path and missing
 NULL check
To: liem <liem16213@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Andi Shyti <andi.shyti@kernel.org>, Biwen Li <biwen.li@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org, 
	Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,Carlos!

Thank you for your review.

Q: Have you meet the issue on one real platform?
A: No,I just noticed the error while reading the code.

I think your idea which cancel the slave timer and wait it finished
after disabled IRQ is better.

I'll fix the issues and send a v2.Thank you again!
