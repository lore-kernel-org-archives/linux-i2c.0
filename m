Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B925FA05
	for <linux-i2c@vger.kernel.org>; Sat, 21 Mar 2026 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062941; cv=none; b=uHyR9Cc9WiB1DreDDvUPx/MDtaPMsdqBTxkGgqg3ggK3q8fMvOYLn3smmEFnnSVB/o8FNob11fLYCIkN7S8DuMrZsFxtdFCiD+yulcXkQpewReFTVzpIex6KW75Szu9rO/ecXEzGe+QHLBlGhGc+0dPTXPxRAJbRQ+cbuDcWunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062941; c=relaxed/simple;
	bh=KCouMn/Dg6hm0eYmov7z8hH1AZtJwHW0P50SCpJ5vto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQf9X+ecJpM6xYkh6CLydAct8oM8dg5dNUTuaRRAfkj+Ix3iy88qzeRdiOKipRPNj5U5vJgE7BuvfBtIQjSbB0fJG/HQzAlZJcz8K55spGjxgikKAtcW8ySiMZ/dt6dl2Xn+VF5wnZGTFUercc5ZDGMH04+iLMXHpVyiCaB8MB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B54pTIJC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B54pTIJC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38bf132993dso18214091fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 20:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774062938; x=1774667738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=B54pTIJCtGZfWgvFwCeAIlrMzdFO6gQRq6V3jb+pq2AkrEJzgdeRtE7BfT4B99sYPy
         WYpH0wPgGQw+kVk4x3vnuXIOTDyCFRPo0tokY/hsaDTJMUiDTsRK7wyKbNh8N566kiJ6
         WW+iNv9Sh7bkKf7EYlBBkPIhD9qF40F8Fnxdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774062938; x=1774667738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=Wl6roCZ7PQLd11iV8I2kV2+WHJuHHlesoCHhuSl395ILudYE6OxXgRVfd7U6VETqoX
         mLJdX4WvZBFDDFfbPJVKHf+/NYyqTh4oGCtAnOlnf3xpY/jINWb0FrDfA+S0hmsfiMON
         L5MNzADcMyTCYN9Tnk/v4ir48Nq8W/g78d6WLSXn/iUw6zwseoCXlTth12qiL/wKZ0kI
         JE6OM0dv5R/36Fcx6KqrXkwlRra28KqGqCHd1UQVsHm4d2Nf3kfoF3Fq4MYZqApsliTX
         zAzObZWvYGfYC/+MZVn1TL4JMs3XbnL5WB4AmZyV0C+AwgdkuN69A+HcuGD+CAL1tW04
         Bsqw==
X-Forwarded-Encrypted: i=1; AJvYcCX0zva+WaCGPTuloHP7NeBNfasfn/EW7lhqA1yCn6JWY+kHQ/sgzWtKsYG/GCmHZsd3KnPvr0V8+Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5m/GUgwjtgHUClOczDhB9xwxSYRNohfB0IjndTgpxkQHATMOz
	Jo539f2/NA6oW1kOu57GoRmYjetX4ybWG9iWQ7MQ4rAAOwwd1N3IP21sLMjxx5KSFryt0ID9NME
	lBzduu/yd
X-Gm-Gg: ATEYQzws1ljHmaWMOxLhrRfmdJyq8gbAytzVi9/5Auj2C2rJClTeHs+/CGXuMSss0nQ
	l+h2NgZJVLQjqmKmK7zr6XcWpVzPSB97QwDqcx0KGt2pVKJ9ZQsbCdJ4ncTJq1cMJN4V+zNAYel
	+XXV2GhKtgcggKHmI7Oo0Yl4NsMn2IVm9yqmhJbVokdwaUR+0EDgSDsg1buH8FYoSI9mwW5WGEd
	//yvaawg13d6OpsVZLqgbI1QI7u5biRql620QBmUFiVRwBCaQe0idtW8ZyEh15BXknG5m+tAAjo
	N28apfaE4skkYCUrS+vOIKYafSFqcqdiK6Olk89kCXdKtX6ZIIWb9yo0gYMCGKPAeE6Ptbx3aHw
	k7HCbYfmG25QwFsvFaJpfSZ99dd/OIz9vKcxOMLgIGzJeWaG7ewGnmspRTYEz8dlQ+eUJw/W4Hz
	Ldws2+Gj2rKGi4wDrwcVjvSZWB8baTFDiAvdzArsXOOOgK+OJ4OR7r76IMLEg1Ig==
X-Received: by 2002:a05:6512:158c:b0:5a1:1b06:7e81 with SMTP id 2adb3069b0e04-5a285b5d9e9mr1825193e87.42.1774062937863;
        Fri, 20 Mar 2026 20:15:37 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e23sm916759e87.69.2026.03.20.20.15.37
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 20:15:37 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so3305204e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 20:15:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhziByYEui9xbIIetWUW8Ri2erHCkaNamoz+NqLidwPSMGr6s6byTwgp6yQm4v3YGtOzC3DRJlLZY=@vger.kernel.org
X-Received: by 2002:a05:600c:8119:b0:485:345b:ccb1 with SMTP id
 5b1f17b1804b1-486ff031f5dmr63989995e9.27.1774062615176; Fri, 20 Mar 2026
 20:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com> <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Mar 2026 20:10:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
X-Gm-Features: AaiRm53JJySLwTXCCA6qh8x4Qo2JwYxEnfOViwtwDhVjyjDx4WswvOZrKm9fsCw
Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
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

On Thu, Mar 19, 2026 at 10:52=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kerne=
l.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > In various places in the kernel, we modify the fwnode "flags" member
> > > by doing either:
> > >   fwnode->flags |=3D SOME_FLAG;
> > >   fwnode->flags &=3D ~SOME_FLAG;
> > >
> > > This type of modification is not thread-safe. If two threads are both
> > > mucking with the flags at the same time then one can clobber the
> > > other.
> > >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> > >
> > > Create some accessor functions for setting, clearing, and testing the
> > > FWNODE flags and move all users to these accessor functions. New
> > > accessor functions use set_bit() and clear_bit(), which are
> > > thread-safe.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > While this patch is not known for sure to fix any specific issues, it
> > > seems possible that it could fix some rare problems. I'm currently
> > > trying to track down a hard-to-reproduce heisenbug and one (currently
> > > unproven) theory I had was that the fwnode flags could be getting
> > > messed up like this. Even if turns out not to fix my heisenbug,
> > > though, this seems like a worthwhile change to take.
> >
> > Reviewed-by: Saravana Kannan <saravanak@kernel.org>
>
> Thanks for the review!
>
>
> > Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> > it here, I might be able to take a look at it too (no promises).
>
> I don't _think_ it fixes my bug, but I'm still not 100% sure because
> the bug can take a day or so to reproduce and it appears to only
> reproduce on official kernels built by the builder. :( This makes it
> hard to say anything for certain and also hard for me to inject extra
> debug logic.

Just in case anyone out there was wracking their brains based on my
description of the bug...

I've made progress in getting the issue to reproduce even with debug
information added. With that, I've found that
device_links_driver_bound() is getting called where `dev->fwnode->dev`
is NULL. That prevents it from running the ever-important
__fw_devlink_pickup_dangling_consumers().

I can see that device_add() has started, but it just hasn't made it to
the `dev->fwnode->dev =3D dev;` line yet.  My printout next to that line
shows up _after_ my printout in device_links_driver_bound().

So obviously something can happen to cause the device to probe before
the call to bus_probe_device().

OK, I managed to get a stack crawl for when `dev->fwnode->dev =3D=3D
NULL`. It looks like this (FWIW, it's a 6.6 kernel but issue also
reproduces on our 6.12 kernel, and I see no reason it wouldn't
reproduce on mainline):

  Call trace:
  dump_backtrace+0xe8/0x108
  show_stack+0x18/0x28
  dump_stack_lvl+0x50/0x6c
  dump_stack+0x18/0x24
  device_links_driver_bound+0xa4/0x4b4
  driver_bound+0x48/0x1c4
  really_probe+0x244/0x374
  __driver_probe_device+0xa0/0x12c
  driver_probe_device+0x3c/0x218
  __driver_attach+0x110/0x1ec
  bus_for_each_dev+0x104/0x160
  driver_attach+0x24/0x34
  bus_add_driver+0x154/0x270
  driver_register+0x68/0x104
  __platform_driver_register+0x24/0x34
  init_module+0x20/0xfe4 [max77779_pmic_pinctrl
e09198e651272bc5df70245355346d6eb1ba3a8f]
  do_one_initcall+0xdc/0x360
  do_init_module+0x58/0x23c
  load_module+0xffc/0x1130
  __arm64_sys_finit_module+0x260/0x300
  invoke_syscall+0x58/0x114

It looks like what happens is that immediately after device_add()
calls bus_add_device() there's a possibility of another thread
inserting the module holding the device driver. That means that the
driver can start probing much earlier than we expect.

I've posted an RFC patch to fix this. If folks are interested, please revie=
w it:

https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabc=
ead688d0d8c17@changeid

Given the stack crawl I got, I'm fairly certain that this will fix the
problem, but I'll also let reboot tests run over the weekend to
confirm.

-Doug
