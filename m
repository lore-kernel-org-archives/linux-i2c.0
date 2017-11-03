From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [PATCH RFT 0/5] i2c: sh_mobile: refactor HW init/deinit
Date: Fri, 3 Nov 2017 10:15:33 +0100
Message-ID: <20171103091533.GE23381@w540>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48635 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbdKCJPh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Nov 2017 05:15:37 -0400
Content-Disposition: inline
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

On Thu, Nov 02, 2017 at 01:47:26PM +0100, Wolfram Sang wrote:
> When clearing the ICE bit, all registers fall back to their defaut value. That
> allows for some simplifications in the code.
>
> Tested on a Renesas Lager board (R-Car H2) doing a bunch of consecutive
> commands. No spurious interrupts have been observed and the signals look
> exactly the same when visualized with sigrok.
>
> According to the docs, the ICE bit behaviour is the same since the beginning of
> this driver (sh7722) for the migo-r board.
>
> jacopo: can you please test this series while you work on migo-r anyhow? Thank
> you a ton for that!

I have applied your series on top of my developments on Migo-R

------------------------------------------------------------
57d007c i2c: sh_mobile: shorten exit of xfer routine
67dfa18 i2c: sh_mobile: use direct writes when accessing ICE bit
f44a2df i2c: sh_mobile: manually "inline" two short functions
5d656b6 i2c: sh_mobile: remove redundant deinitialization
9d2b8cc i2c: sh_mobile: remove redundant initialization
cac9723 arch: sh: migor: Use new CEU camera driver
...
------------------------------------------------------------

And I can successfully probe the camera sensor

------------------------------------------------------------
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
ov772x 0-0021: ov7725 Product ID 77:21 Manufacturer ID 7f:a2
------------------------------------------------------------

As well as set format on it without noticeable errors

------------------------------------------------------------
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
i2c i2c-0: master_xfer[1] R, addr=0x21, len=1
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
i2c i2c-0: master_xfer[0] W, addr=0x21, len=2
------------------------------------------------------------

I cannot try capture, as I currently have issues with mmap on SH4 :(

If you want me to run some specific tests, let me know.
Otherwise you can add my

Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Cheers!
   j
>
> Looking forward to other comments, as well...
>
>
> Wolfram Sang (5):
>   i2c: sh_mobile: remove redundant initialization
>   i2c: sh_mobile: remove redundant deinitialization
>   i2c: sh_mobile: manually "inline" two short functions
>   i2c: sh_mobile: use direct writes when accessing ICE bit
>   i2c: sh_mobile: shorten exit of xfer routine
>
>  drivers/i2c/busses/i2c-sh_mobile.c | 50 +++++++++-----------------------------
>  1 file changed, 12 insertions(+), 38 deletions(-)
>
> --
> 2.11.0
>
