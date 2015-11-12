From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 01/10] i2c: rcar: make sure clocks are on when doing
 clock calculation
Date: Thu, 12 Nov 2015 22:16:48 +0300
Message-ID: <5644E5A0.9040504@cogentembedded.com>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447338715-9955-2-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

Hello.

On 11/12/2015 05:31 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> When calculating the bus speed, the clock should be on, of course. Most
> bootloaders left them on, so this went unnoticed so far.

    s/them/it/.

> Move the ioremapping out of this clock-enabled-block and prepare for
> adding hw initialization there, too.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[...]

MBR, Sergei

