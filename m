From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Mon, 26 Oct 2015 15:00:48 +0000
Message-ID: <20151026150048.GO597@x1>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
 <20151026143236.GK597@x1>
 <20151026144425.GA5588@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35247 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbbJZPAy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Oct 2015 11:00:54 -0400
Received: by lfbn126 with SMTP id n126so116812118lfb.2
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2015 08:00:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151026144425.GA5588@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

On Mon, 26 Oct 2015, Wolfram Sang wrote:
> On Mon, Oct 26, 2015 at 02:32:36PM +0000, Lee Jones wrote:
> > Regarding your address list -- it's too big.  Most of your addresse=
es
> > don't care about this patch.  Please be more selective when sending
> > patches to people, most of us have enough (relevant) mail as it is.
>=20
> Probably more effective than to write every user of get_maintainer.pl=
:
> Patch it to not use git history by default and win the fight ;)

Geert wrote to Joe today.  Let's see if he can improve things.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
