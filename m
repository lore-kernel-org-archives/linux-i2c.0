Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CFBC433FE
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Mar 2022 17:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiCRRB2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiCRRB0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2022 13:01:26 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF512C57AC;
        Fri, 18 Mar 2022 10:00:06 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8744F1C0005;
        Fri, 18 Mar 2022 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647622804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwommDYWujYAkS12uhV+76cfeQxEyafiZsBFh8MY/ao=;
        b=VHjoF/lZHoFlunNwxnZPdl6qo8e9bKkcfOX6tg4Q9OWsLKGMr+3hAVk8vyv3RE4HMoSjFs
        +llSGc+J/EC23te7mFR2SHWP7yMXvd4IU+BXRr0LUDCtDYusvQ3zNAuwf/xO1HNJj691l/
        Z926XEs47wdPkT+lggi/2eJ8RruA/7hJRlvve8KAHx60gfFzLDEEVzyH8AQ71ohy3xtvt6
        LwFL7ZUKv8y+bPG/wee2r5aGek2D4C3QGPBg1JTcojFzU7ko/kkWqken0v8gvzyaLkHFqO
        ukI81sebn22m53QZJEZMBiV/didOAEins0CxI1s7TAe9Xzoy0JpErlzvpIQj0A==
Date:   Fri, 18 Mar 2022 17:58:37 +0100
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
Subject: Re: [PATCH 6/6] net: sfp: add support for fwnode
Message-ID: <20220318175837.5fefba5b@fixe.home>
In-Reply-To: <YjS0EbKOUb4Q++mF@smile.fi.intel.com>
References: <20220318160059.328208-1-clement.leger@bootlin.com>
        <20220318160059.328208-7-clement.leger@bootlin.com>
        <YjS0EbKOUb4Q++mF@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Le Fri, 18 Mar 2022 18:32:17 +0200,
Andy Shevchenko <andriy.shevchenko@linux.intel.com> a =C3=A9crit :

> On Fri, Mar 18, 2022 at 05:00:52PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > Add support to retrieve a i2c bus in sfp with a fwnode. This support
> > is using the fwnode API which also works with device-tree and ACPI.
> > For this purpose, the device-tree and ACPI code handling the i2c
> > adapter retrieval was factorized with the new code. This also allows
> > i2c devices using a software_node description to be used by sfp code. =
=20
>=20
> > +		i2c =3D fwnode_find_i2c_adapter_by_node(np); =20
>=20
> Despite using this, I believe you may split this patch to at least two wh=
ere
> first one is preparatory (converting whatever parts is possible to fwnode
> (looks like ACPI case may be optimized) followed by this change.
>=20

Indeed, I had hesitate to do so but is seems more correct not to mix
everything.

Thanks for the review.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
