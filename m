From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH v4 1/2] wire: export w1_touch_bit
Date: Sun, 27 Aug 2017 10:21:30 +0300
Message-ID: <1192111503818490@web4g.yandex.ru>
References: <20170719201409.5968-1-jjj@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719201409.5968-1-jjj@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux-I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi

19.07.2017, 23:14, "Jan Kandziora" <jjj@gmx.de>:
> The w1_ds28e17 driver from the next part of this patch needs to emit
> single-bit read timeslots to the DS28E17. The w1 subsystem already
> has this function but it is not exported outside drivers/w1/w1_io.c
>
> This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
> same as the other exported symbols in drivers/w1/w1_io.c
>
> May be also useful later for writing drivers for other Onewire chips
> which do single-bit communication.
>
> Signed-off-by: Jan Kandziora <jjj@gmx.de>
> ---
> Changes in v4 against v3 in this subpatch:
>   - adapted to linux-4.12.0

Greg, please pull this patch series into the tree, it has been adopted to the latest vanilla tree to date.
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
