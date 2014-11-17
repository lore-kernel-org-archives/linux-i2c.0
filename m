From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] i2c: dln2: simplify return flow for dln2_i2c_enable
Date: Mon, 17 Nov 2014 14:56:51 +0000
Message-ID: <20141117145651.GR24004@x1>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
 <1415708457-18798-3-git-send-email-octavian.purdila@intel.com>
 <20141113162315.GC1275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141113162315.GC1275@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>, laurentiu.palcu@intel.com, johan@kernel.org, julia.lawall@lip6.fr, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 13 Nov 2014, Wolfram Sang wrote:

> On Tue, Nov 11, 2014 at 02:20:57PM +0200, Octavian Purdila wrote:
> > This fixes the following kbuild test robot warning:
> >=20
> > >> drivers/i2c/busses/i2c-dln2.c:70:1-4: WARNING: end returns can b=
e simplified if negative or 0 value
> >=20
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> >=20
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>=20
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Lee, I think it is easiest if you simply add it to the branch you hav=
e
> for this driver. OK?

Octavian indicated that he needs to send a v2 of the second patch.  I
assume he will add your Ack to this patch when he does with a note
saying that it needs to be added to the I2C IB.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
