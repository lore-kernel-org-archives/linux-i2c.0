From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc: add support for DS3232 RTC
Date: Mon, 5 Jul 2010 09:22:31 +0200
Message-ID: <20100705092231.2780a1b8@hyperion.delvare>
References: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278312326-19022-1-git-send-email-tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roy Zang <tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, srikanth.srinivasan-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Roy,

On Mon,  5 Jul 2010 14:45:26 +0800, Roy Zang wrote:
> This patch adds the driver for RTC chip DS3232 via I2C bus
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Jingchang Lu <b22599-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Roy Zang <tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Tested on MPC8536DS and P4080DS board
> 
>  drivers/rtc/Kconfig      |   11 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-ds3232.c |  466 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 478 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-ds3232.c

You're sending this patch to the wrong list. Please read MAINTAINERS
again.

-- 
Jean Delvare
