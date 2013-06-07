From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: make i2c xfers non-interruptible
Date: Fri, 7 Jun 2013 09:55:29 +0200
Message-ID: <20130607075527.GB11875@ab42.lan>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <1370526216-10060-2-git-send-email-christian.ruppert@abilis.com>
 <20130607052555.GC11878@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130607052555.GC11878-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 07, 2013 at 08:25:55AM +0300, Mika Westerberg wrote:
> On Thu, Jun 06, 2013 at 03:43:36PM +0200, Christian Ruppert wrote:
> > When the process at the source of an i2c transfer is killed in the
> > middle of the transfer, the transfer is interrupted. Interrupted
> > transfers might cause buggy slaves on the bus (or higher level driv=
ers)
> > to go haywire.
> > This patch forces ongoing i2c transfers to finish properly, even if=
 the
> > initiating process is killed.
>=20
> I already sent a similar patch ;-)
>=20
> https://patchwork.kernel.org/patch/2601241/
>=20
> However, it is not yet picked by Wolfram.

Oops, this looks like a human race condition :) I checked main line and
Wolfram's git but didn't think of checking patchwork. I'll rebase the
second patch on yours.

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
