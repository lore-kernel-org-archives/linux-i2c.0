From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [GIT PULL] i2c fixes for 2.6.36
Date: Fri, 1 Oct 2010 22:38:46 +0900
Message-ID: <AANLkTi=aKWP3_KhD88ebGB04xAM9Pc7eqw1LBr2EJNS_@mail.gmail.com>
References: <20101001140619.28d96040@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101001140619.28d96040-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Even though it's not yet acked from Ben. It should be fixed for
correct operation.
Without this patch, some I2C device doesn't work correctly.
http://www.spinics.net/lists/linux-i2c/msg04016.html

Thank you,
Kyungmin Park

On Fri, Oct 1, 2010 at 9:06 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote=
:
> Hi Linus,
>
> Please pull i2c subsystem fixes for Linux 2.6.36 from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2=
c-for-linus
>
> =A0drivers/i2c/busses/i2c-cpm.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++
> =A0drivers/i2c/busses/i2c-ibm_iic.c =A0 =A0 =A0 | =A0 =A03 ++
> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/i2c/busses/i2c-pca-isa.c =A0 =A0 =A0 | =A0 12 +++++--
> =A0drivers/i2c/busses/i2c-pca-platform.c =A0| =A0 11 ++++--
> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 54 ++=
++++++++++++-----------------
> =A0drivers/misc/bh1780gli.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/regulator/ad5398.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/regulator/isl6271a-regulator.c | =A0 =A02 -
> =A0drivers/rtc/rtc-ds3232.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 -
> =A010 files changed, 48 insertions(+), 44 deletions(-)
>
> ---------------
>
> Grant Likely (1):
> =A0 =A0 =A0of/i2c: Fix module load order issue caused by of_i2c.c
>
> Rajendra Nayak (1):
> =A0 =A0 =A0i2c: Fix checks which cause legacy suspend to never get ca=
lled
>
> Vishwanath BS (1):
> =A0 =A0 =A0i2c: Fix for suspend/resume issue
>
> Wolfram Sang (1):
> =A0 =A0 =A0i2c: Remove obsolete cleanup for clientdata
>
> Yegor Yefremov (1):
> =A0 =A0 =A0i2c-pca: Fix waitforcompletion() return value
>
> Thanks,
> --
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
