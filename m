From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-core: Fix for lockdep validator
Date: Sat, 8 Sep 2012 09:31:05 +0200
Message-ID: <20120908093105.2447620d@endymion.delvare>
References: <20120907225844.2c935ac9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120907225844.2c935ac9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Sep 2012 22:58:44 +0200, Jean Delvare wrote:
> If kernel is compiled with CONFIG_PROVE_LOCKING the
> validator raises an error when a multiplexer is removed
> via sysfs and sub-clients are connected to it. This is a
> false positive.
> Documentation/lockdep-design.txt recommends to handle this
> via calls to mutex_lock_nested().
>=20
> Based on an earlier fix from Michael Lawnick.
>=20
> Note that the extra code resolves to nothing unless
> CONFIG_DEBUG_LOCK_ALLOC=3Dy.

=2E.. which in turn causes a compiler warning if CONFIG_DEBUG_LOCK_ALLO=
C
isn't set.

drivers/i2c/i2c-core.c:639:21: warning: =E2=80=98i2c_adapter_depth=E2=80=
=99 defined but not used [-Wunused-function]

Not sure how I missed that yesterday. I'll make the function inline,
that should fix it, and that's what gcc ends up doing anyway.

--=20
Jean Delvare
