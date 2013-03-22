From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C: Fix i2c fail problem when a process is terminated by a
 signal on octeon in 3.8
Date: Fri, 22 Mar 2013 11:43:23 +0100
Message-ID: <20130322104323.GF8240@the-dreams.de>
References: <16202598.147281361912922998.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16202598.147281361912922998.JavaMail.weblogic@epml02>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?7Iah7J2A67SJ?= <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2013 at 09:08:43PM +0000, =EC=86=A1=EC=9D=80=EB=B4=89 w=
rote:
>=20
> I've been debugging the abnormal operation of i2c on octeon.=20
> If a process is terminated by signal in the middle of i2c operation,=20
> next i2c read operation which is done by another process was failed.
> So i changed to ignore signal in the middle of i2c operation.=20
> After that the problem was not reproduced.
>=20
> =20
>=20
> Signed-off-by: EunBong Song <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Basically OK, but you have lots of whitespace issues, so I can't apply
your patch. Please resend and make sure it applies.

Thanks,

   Wolfram
