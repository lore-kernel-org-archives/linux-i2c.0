From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] generic timeout handling for Renesas drivers
Date: Sun, 21 Jun 2015 23:34:49 +0300
Message-ID: <1851447.dNWUaLUAqi@avalon>
References: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank you for the patches.

On Saturday 20 June 2015 21:03:18 Wolfram Sang wrote:
> Here is a small patch series to make I2C timeout handling easier for users.
> It is not so amazingly huge anymore and it can be modified via i2c-dev if
> wanted. While at it, fix the type of the timeout variable to the proper
> one. This time build-tested twice!
> 
> Wolfram Sang (4):
>   i2c: rcar: use adapter default for timeout
>   i2c: rcar: use proper type for timeout
>   i2c: sh_mobile: use adapter default for timeout
>   i2c: sh_mobile: use proper type for timeout

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/i2c/busses/i2c-rcar.c      | 5 +++--
>  drivers/i2c/busses/i2c-sh_mobile.c | 9 +++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
