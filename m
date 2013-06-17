From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] i2c: designware: fix race between subsequent xfers
Date: Mon, 17 Jun 2013 11:01:33 +0200
Message-ID: <20130617090131.GC19380@ab42.lan>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <1370595083-801-1-git-send-email-christian.ruppert@abilis.com>
 <20130614143740.GD2929@katana>
 <20130617081931.GB19380@ab42.lan>
 <20130617103336.354022c2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130617103336.354022c2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 17, 2013 at 10:33:36AM +0200, Jean Delvare wrote:
> On Mon, 17 Jun 2013 10:19:33 +0200, Christian Ruppert wrote:
> > On Fri, Jun 14, 2013 at 04:37:41PM +0200, Wolfram Sang wrote:
> > > BTW since I am currently here: i2c-designware-core should be in t=
he
> > > 'algos' directory, no?
> >=20
> > At the risk of passing for a complete moron: What exactly is the
> > difference between I2C algos and I2C bus drivers?
>=20
> The i2c/algos directory contains abstracted code which is common to
> multiple hardware implementations. The most popular of these is
> i2c-algo-bit which implements software-only I2C over virtually any pa=
ir
> of controllable pins (parallel port, GPIOs, etc.)
>=20
> As a general rule, i2c/algos should only contain reusable, architectu=
re
> and platform independent code. All the actual hardware access should =
be
> delegated to the bus drivers, through callbacks. If this can't be don=
e
> easily then i2c/algos is not the right place.

In this case, busses is the right place for the i2c-designware-core. Th=
is
file contains the actual driver implementation (i.e. register access,
interrupt handling etc.) for a dedicated I2C bus driver hardware block
used in SOCs.

Greetings,
  Christian

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
