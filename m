From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for
 regmap
Date: Mon, 22 Feb 2016 08:42:50 -0800
Message-ID: <56CB3A8A.9040401@gmail.com>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33774 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbcBVQmx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Feb 2016 11:42:53 -0500
Received: by mail-ob0-f173.google.com with SMTP id jq7so170178307obb.0
        for <linux-i2c@vger.kernel.org>; Mon, 22 Feb 2016 08:42:52 -0800 (PST)
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

Le 21/02/2016 06:16, Wolfram Sang a =C3=A9crit :
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

=46ixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c
controller driver")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
--=20
=46lorian
