From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.30-rc3 i2c build warnings
Date: Sat, 25 Apr 2009 08:43:44 +0200
Message-ID: <20090425084344.2c8c62da@hyperion.delvare>
References: <alpine.LFD.2.00.0904241243270.10096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0904241243270.10096-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Len,

On Fri, 24 Apr 2009 12:45:53 -0400 (EDT), Len Brown wrote:
> drivers/i2c/i2c-core.c:312: warning: =E2=80=98client_unregister=E2=80=
=99 is deprecated=20
> (declared at include/linux/i2c.h:357)
> drivers/i2c/i2c-core.c:313: warning: =E2=80=98client_unregister=E2=80=
=99 is deprecated=20
> (declared at include/linux/i2c.h:357)
> drivers/i2c/i2c-core.c:653: warning: =E2=80=98detach_client=E2=80=99 =
is deprecated=20
> (declared at include/linux/i2c.h:154)
> drivers/i2c/i2c-core.c:719: warning: =E2=80=98detach_client=E2=80=99 =
is deprecated=20
> (declared at include/linux/i2c.h:154)
> drivers/i2c/i2c-core.c:788: warning: =E2=80=98detach_client=E2=80=99 =
is deprecated=20
> (declared at include/linux/i2c.h:154)
> drivers/i2c/i2c-core.c:869: warning: =E2=80=98client_register=E2=80=99=
 is deprecated=20
> (declared at include/linux/i2c.h:356)
> drivers/i2c/i2c-core.c:870: warning: =E2=80=98client_register=E2=80=99=
 is deprecated=20
> (declared at include/linux/i2c.h:356)
> drivers/i2c/i2c-core.c:884: warning: =E2=80=98i2c_attach_client=E2=80=
=99 is deprecated=20
> (declared at drivers/i2c/i2c-core.c:835)
> drivers/i2c/i2c-core.c:884: warning: =E2=80=98i2c_attach_client=E2=80=
=99 is deprecated=20
> (declared at drivers/i2c/i2c-core.c:835)
> drivers/i2c/i2c-core.c:891: warning: =E2=80=98client_unregister=E2=80=
=99 is deprecated=20
> (declared at include/linux/i2c.h:357)
> drivers/i2c/i2c-core.c:892: warning: =E2=80=98client_unregister=E2=80=
=99 is deprecated=20
> (declared at include/linux/i2c.h:357)
> drivers/i2c/i2c-core.c:912: warning: =E2=80=98i2c_detach_client=E2=80=
=99 is deprecated=20
> (declared at drivers/i2c/i2c-core.c:887)
> drivers/i2c/i2c-core.c:912: warning: =E2=80=98i2c_detach_client=E2=80=
=99 is deprecated=20
> (declared at drivers/i2c/i2c-core.c:887)

I am aware of these. The problem is that these functions are exported
and are both used externally (which is deprecated, thus the warnings)
and internally (which is OK, but I don't know how to disable the
deprecation warnings locally.)

When the last few remaining legacy drivers have been converted, we can
stop exporting these functions, and the warnings will go away.
Unfortunately it will not happen in 2.6.30 because the remaining
drivers were converted a little late in the 2.6.30 release cycle [1].
I'm sorry about this, I did my best but I can't forcibly push patches
to maintainers if they don't want them.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2009-April/071008.html

If you know of a simple way to silent the deprecation warnings in
i2c-core meanwhile, I'm all ears. I can think of one method (converting
all these functions to wrappers to internal versions) but this seems a
lot of work for something that will go away in 2.6.31 anyway.

Thanks,
--=20
Jean Delvare
