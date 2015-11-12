From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 04/10] i2c: rcar: remove spinlock
Date: Thu, 12 Nov 2015 18:04:27 +0300
Message-ID: <5644AA7B.6090802@cogentembedded.com>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hello.

On 11/12/2015 5:31 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> After making sure to reinit the HW and clear interrupts in the timeout
> case, we know that interrupts are always disabled in the sections
> protected by the spinlock.

    What about SMP? Spinlocks are mostly necessary for the SMP support, their 
tole isn't limited to disabling interrupts...

> Thus, we can simply remove it which is a
> preparation for further refactoring. While here, rename the timeout
> variable to time_left which is way more readable.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[...]

MBR, Sergei

