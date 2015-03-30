From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: dln2: set the device tree node of the adapter
Date: Mon, 30 Mar 2015 08:09:56 +0100
Message-ID: <20150330070956.GE457@x1>
References: <1427470630-13378-1-git-send-email-octavian.purdila@intel.com>
 <20150327155700.GG27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150327155700.GG27238@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>, laurentiu.palcu@intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Mar 2015, Wolfram Sang wrote:

> On Fri, Mar 27, 2015 at 05:37:10PM +0200, Octavian Purdila wrote:
> > This patch makes sure the platform device tree node is inherited by
> > the adapter device. This allows the DLN2 bus to work with i2c devic=
es
> > defined in the device tree.
> >=20
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>=20
> Applied to for-next, thanks!

Ah sorry.  I read this _after_ sending my Ack.

=46eel free to apply it, or not.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
