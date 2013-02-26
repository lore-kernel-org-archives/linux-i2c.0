From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C: Fix i2c fail problem when a process is terminated by a
 signal on octeon  in 3.8
Date: Tue, 26 Feb 2013 12:07:47 +0100
Message-ID: <20130226110740.GA3962@katana>
References: <88.A5.02716.F6CB6215@epcpsbge3.samsung.com>
 <alpine.LNX.2.00.1302261101250.2128@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1302261101250.2128-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: =?utf-8?B?7Iah7J2A67SJ?= <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2013 at 11:02:17AM +0100, Jiri Kosina wrote:
> On Fri, 22 Feb 2013, =EC=86=A1=EC=9D=80=EB=B4=89 wrote:
>=20
> >=20
> > =C2=A0
> >=20
> > I've been debugging the abnormal operation of i2c on octeon.
> > If a process is terminated by signal in the middle of i2c operation=
,
> > next i2c read operation which is done by another process was failed=
=2E
> > So i changed to ignore signal in the middle of i2c operation.
> > After that the problem was not reproduced.
>=20
> This is not really material directly for trivial.git. Adding maintain=
ers=20
> to CC.

Yes, this should not go via trivial. Please resend to i2c list. Patch
looks okay from a glimpse (and fixes an issue we have seen before and
fixed the same way).

Thanks,

   Wolfram
