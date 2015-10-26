From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Mon, 26 Oct 2015 15:00:09 +0000
Message-ID: <20151026150009.GN597@x1>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
 <20151026143236.GK597@x1>
 <562E3C20.10902@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38636 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbbJZPAO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Oct 2015 11:00:14 -0400
Received: by wicll6 with SMTP id ll6so118607918wic.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2015 08:00:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <562E3C20.10902@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

On Mon, 26 Oct 2015, Michal Simek wrote:
> On 10/26/2015 03:32 PM, Lee Jones wrote:
> > Regarding your address list -- it's too big.  Most of your addresse=
es
> > don't care about this patch.  Please be more selective when sending
> > patches to people, most of us have enough (relevant) mail as it is.
>=20
> This is just what get_maintainer.pl is returning you. And I do use
> patman (uboot tools) for ages and none has any problem with it. That'=
s
> why I am curious why you have the problem with it.

git_maintainer.pl is best used with the --no-git-fallback flag.  If
you don't it tells you about everyone who adapted, looked at, opened,
and/or breathed on the file.  The only people that are likely to care
about your change is either the original author of the specific hunk
you are changing and the Maintainers/Supporters.  To everyone else
these emails are spam.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
