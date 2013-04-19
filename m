From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: Fix i2c fail problem when a process is terminated
 by a signal on octeon in 3.8
Date: Fri, 19 Apr 2013 20:30:57 +0200
Message-ID: <20130419183057.GA3702@the-dreams.de>
References: <11412343.361631366270816380.JavaMail.weblogic@epv6ml12>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11412343.361631366270816380.JavaMail.weblogic@epv6ml12>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?7Iah7J2A67SJ?= <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 18, 2013 at 07:40:16AM +0000, =EC=86=A1=EC=9D=80=EB=B4=89 w=
rote:
>=20
> I rewrite my patch because the patch before i sent have many white sp=
ace.
> Thanks!

This should have been below the "---" after the sigend-off.

> ---
> I've been debugging the abnormal operation of i2c on octeon.
> If a process is terminated by signal in the middle of i2c operation,
> next i2c read operation which is done by another process was failed.
> So i changed to ignore signal in the middle of i2c operation.
> After that the problem was not reproduced.
>=20
> Signed-off-by: Eunbong Song <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!
