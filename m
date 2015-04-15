From: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: i2c-davinci build failure with Linux v4.0-3843-gbb0fd7ab0986
Date: Wed, 15 Apr 2015 12:33:57 -0400
Message-ID: <CA+5PVA7Fzw4m1qqj2nHCzP4JJFZnis-6=kQehAbt0a-RJiF73A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi All,

The i2c-davinci driver failed to build as a module with Linus' latest
tree as of this morning.  The error was:

ERROR: "i2c_generic_gpio_recovery" [drivers/i2c/busses/i2c-davinci.ko]
undefined!
ERROR: "i2c_generic_scl_recovery" [drivers/i2c/busses/i2c-davinci.ko] undefined!
ERROR: "i2c_recover_bus" [drivers/i2c/busses/i2c-davinci.ko] undefined!
scripts/Makefile.modpost:90: recipe for target '__modpost' failed

It looks like commit 2e65676f710e (i2c: davinci: use bus recovery
infrastructure) likely introduced this error.  None of the i2c bus
recovery functions are exported from i2c-core.c that I can tell.

Was this commit tested as a modular build?

josh

[1] https://kojipkgs.fedoraproject.org//work/tasks/8758/9488758/build.log
