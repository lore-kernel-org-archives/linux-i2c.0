Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E435CB89
	for <linux-i2c@vger.kernel.org>; Thu, 19 Mar 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943156; cv=none; b=CaGxKHf8tQ3GXUnMiVHB3AA015rRm7t5t7WtIMIkK+vLreG7dzW7eiK+Y+Pm8ihksCUvAP8C5TjZyoJ/2AMQmVPh3yJgwU0RNNTY0WDwNl/W7K7bIdn3QKTNg2pBxUJyLA5O0cc51FUIhwFR+2NgNmJx9KZlVSFtrni7S02a59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943156; c=relaxed/simple;
	bh=1qiYzC4e4C5Osb7cyOfG+hx3gfnhgiG4CgnJdnnYqWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8IjJHo/AKaN8J3uimD/N5S6vMw297RJOtITUJVkmK6DoP6sHtJBIHKZHl6ux96ESCXxiDS3F/z+j4DUCeMXt7wAG78GeJK2r3+6Ei48ezAsq69KzG3BJrIMJKcS3sVBo9yX44xw9wyuQNGcAx39gLzwRsftCLmIP+uoP9CjaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VCvptqSE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VCvptqSE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a27bfadca9so1334950e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Mar 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773943153; x=1774547953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=VCvptqSEqbityXIXYjHiXm8FOCf+YNy2WRCYI7MS5KJIiozTtjKRFQmBWkR9FkBgU8
         glLZ0y6rKTdfM4+X/KG1NSdHTwccV/MouCXnhLOWSgcEiO494et41Ww6fctxWe7Wv07e
         u556RCtiYgxNkEM4n9/aTVLluNKr8U6cI5sGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943153; x=1774547953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=tTkPJ7ZMn162flT33AwpOSjyC9OO5Zv90zD2MDw4PyDFQ5OMDKlS7FlG47f3NoHJnN
         12gA5Iyo3EMmqaxm+2tQAc+/kkXve2ia4vVn3zR0qpcZ33ird1lqZ+cVvzvQ71D013gL
         aeFZE7m8ZrZaZCJBr3nehHCNVSntyaGKGunYvQ2JIu34pU4fyGIuB8U8+hDBPbToQmjF
         fmqOxAa+AZ2KZZgGVPR8rXGQ1hVLEJgP0HqBPfS8M++7TgwJJ1pOr91F/XHKVul0CGH7
         tQK9siMwyRtDjmA0KPfYynE1/S2HYLMDdKjjXX6B4owfskbP6taTHh83KpFz6gi60RoC
         SJJA==
X-Forwarded-Encrypted: i=1; AJvYcCXguOfjDRFZMDOOMzfI69JJK4rIy0fr7BLJMqjmgq4d+KHN5mCFQoddOrsqXyKrH0JHfucBOlK0r5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IU8m59wUoOKOl7U3cQY7aeiFV2T7BndRhLf/z6O804dmpLM7
	RHnprPLtA8VGC9JpDXxUTX2tElSDTk3uIVf1CL5BWyLjKCyH8V696F3oex2JGFHLpS+jQEoIsDI
	D3NDDfygM
X-Gm-Gg: ATEYQzy1qUFVGoAg0CU8ynncclDePj+kQ9YfGYPjheDzGbqBaZalSh0PKV4NcR90EL6
	pS5Ms51S39QbA3grEeioRSbNtlisC5f/ohF1bK7/CmBAnnYv/bx1mjluSxBX8788ax4heKmUbVn
	lBz3bzllFX2ovWDbL4ahM0BM+6gP0XlK4fYtZ46CeAY33+IXgh1eWT1VKALy2coXAUd2nfdrU6H
	eSgGVby5PDHOfnS7UI+mSs+0TRyt5rVa81RkxrlEzNeHFeb7ecMbCaQbQkGz1eBrSQV7+nbFkNQ
	ANP/TGYxkoN6a0z0BPZ4aFlntZV6rVHQS9QuqE/r6pVbqb6WVhsg8deCe9M4Vd51A2MwdN9lc5M
	qDZ/oyLiQUcQzMxf6NY8lHAEBQOL9y/5zTwQsT4oWYlIi3Co3kuuul8bqwL3k3h+vSoF07vB9qQ
	RJrAt19a4P+dOgdPPbrmEUtATW7E9ELrl3FF/UaUdqUxSQf09L5URMIsMpdQ7ICZ2kKQ==
X-Received: by 2002:a05:6512:3a84:b0:5a1:34a3:757f with SMTP id 2adb3069b0e04-5a285b440ddmr1146e87.25.1773943152668;
        Thu, 19 Mar 2026 10:59:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2852071edsm45412e87.49.2026.03.19.10.59.12
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 10:59:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so6606801fa.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Mar 2026 10:59:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH0w6rGV3WGl7gniajwWGllsQlPQ6+T3c0m3HKmsRhoWNQrF4DutPFnG6InsH43YSNRY8LFjHAoU4=@vger.kernel.org
X-Received: by 2002:a05:6000:18a6:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-43b6423d90bmr470716f8f.3.1773942745211; Thu, 19 Mar 2026
 10:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
In-Reply-To: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Mar 2026 10:52:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
X-Gm-Features: AaiRm51jE-pJGKyYKekSNJEdkSVtbmzl88hjmcc-VHWIT0EUhGVU2WYljuGhtW4
Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kernel.=
org> wrote:
>
> On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > In various places in the kernel, we modify the fwnode "flags" member
> > by doing either:
> >   fwnode->flags |=3D SOME_FLAG;
> >   fwnode->flags &=3D ~SOME_FLAG;
> >
> > This type of modification is not thread-safe. If two threads are both
> > mucking with the flags at the same time then one can clobber the
> > other.
> >
> > While flags are often modified while under the "fwnode_link_lock",
> > this is not universally true.
> >
> > Create some accessor functions for setting, clearing, and testing the
> > FWNODE flags and move all users to these accessor functions. New
> > accessor functions use set_bit() and clear_bit(), which are
> > thread-safe.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While this patch is not known for sure to fix any specific issues, it
> > seems possible that it could fix some rare problems. I'm currently
> > trying to track down a hard-to-reproduce heisenbug and one (currently
> > unproven) theory I had was that the fwnode flags could be getting
> > messed up like this. Even if turns out not to fix my heisenbug,
> > though, this seems like a worthwhile change to take.
>
> Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks for the review!


> Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> it here, I might be able to take a look at it too (no promises).

I don't _think_ it fixes my bug, but I'm still not 100% sure because
the bug can take a day or so to reproduce and it appears to only
reproduce on official kernels built by the builder. :( This makes it
hard to say anything for certain and also hard for me to inject extra
debug logic.

I did finally capture a ramdump of a device in the bad state and
managed to inspect the state of all the fwnode and fwnode_link
objects.

The problem (simplified) is that I have a pinctrl device:

  max77779_pinctrl {
    pin1: pin1 {
      ...;
    };
    pin2: pin2 {
      ...;
    };
  };

...and then a client of the pinctrl device:

  client1 {
    pinctrl-0 =3D <&pin1>;
    ...
  };

  client2 {
    pinctrl-0 =3D <&pin2>;
    ...
  };

At parse time, we get a link between the "client1" node and the "pin1"
node (and "client2" and "pin2").

In a normal boot (where the bug doesn't reproduce), when
max77779_pinctrl finishes probing, all of the links to its children
(which don't have a "dev" associated with them) get moved to point to
"max77779_pinctrl" (__fw_devlink_pickup_dangling_consumers).

When I detect the bug, the max77779_pinctrl device clearly has
finished probing, but the client devices still point to the child
nodes.

In the debugger, I can inspect things. I can see:
* The fwnodes for "pin1" and "pin2" clearly don't have a "dev" node.
They also don't have "FWNODE_FLAG_NOT_DEVICE" set.
* The fwnode for "max77779_pinctrl" clearly has a dev node (and a bus).
* The fwnodes for "pin1" and "pin2" show zero consumers.
* The fwnodes for "client1" and "client2" _do_ still show suppliers.
* When I look at the fwnode_link between the clients and the pins, the
"supplier" points to the node for the pin.
* When I look at the fwnode_link between the clients and the pins, the
"c_hook" is non-empty.
* When I look at the fwnode_link between the clients and the pins, the
"consumer" points to the node for the client.
* When I look at the fwnode_link between the clients and the pins, the
"s_hook" is an empty list (next =3D=3D prev).

It's a bit baffling because everything looks nice and consistent with
half the link being severed, which doesn't seem possible when looking
at the code. The code seems to always add to a consumer list and
supplier list at the same time and remove at the same time.

I've started to run out of ideas on how it could possibly get into
this state. If you have any, or want me to look at any other data
structures in the ramdump let me know.

-Doug
