Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A917C433EF
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Mar 2022 17:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiCRRCi (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiCRRCh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2022 13:02:37 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D62F24EF;
        Fri, 18 Mar 2022 10:01:18 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 59B7F1BF20F;
        Fri, 18 Mar 2022 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647622877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkdRGvyO9plO1yMYexA5wxYYbMPNxoTpW+YrctxXuzM=;
        b=aIh7azmQhoqfwnVQW8LdwjMctwRFoLCJykZMzHJP/MW/Uh7WlkBzcrh9Pwqs9nOrxImYny
        vsrPOpKKwyU4GXjzGVOsAPSCWaMfJCTLMGN4LFPUM4UGJe6HE4wu288QmesZGRLzQAq/0S
        BMIF+PpmbJDTV8HHfs53LlwxR2NtQvi7LcMIxXx93aq1rB4VDNq1+/yHv7g1Win0S2XVBa
        fM5IxkwS4BmCr1FO3okPA//TF3Sgmy+WCWO2cx4PZRdUYSa342hm0MJIDVhuRaNKAT4jh8
        E1hd8EA9+EVYSC5NPYh+2ipSMeEwwVbqC1mdbeTXO5lY0S9uzMSIRKTXTUok3w==
Date:   Fri, 18 Mar 2022 17:59:52 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "'Rafael J . Wysocki '" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/6] introduce fwnode in the I2C subsystem
Message-ID: <20220318175952.449ff4fb@fixe.home>
In-Reply-To: <YjSyJaUa+uuv3+zc@smile.fi.intel.com>
References: <20220318160059.328208-1-clement.leger@bootlin.com>
        <YjSyJaUa+uuv3+zc@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Le Fri, 18 Mar 2022 18:24:05 +0200,
Andy Shevchenko <andriy.shevchenko@linux.intel.com> a =C3=A9crit :

> On Fri, Mar 18, 2022 at 05:00:46PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > In order to allow the I2C subsystem to be usable with fwnode, add
> > some functions to retrieve an i2c_adapter from a fwnode and use
> > these functions in both i2c mux and sfp. ACPI and device-tree are
> > handled to allow these modifications to work with both descriptions.
> >=20
> > This series is a subset of the one that was first submitted as a larger
> > series to add swnode support [1]. In this one, it will be focused on
> > fwnode support only since it seems to have reach a consensus that
> > adding fwnode to subsystems makes sense.
> >=20
> > [1] https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/=
T/ =20
>=20
> I have got two copies (?) of the series. I have no idea which one is corr=
ect.
> So, please take care of it and send the version we are supposed to review.
>=20

Sorry for that, both are identical and were unfortunately provided
twice to git send-email...

I'll be more cautious next time.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
