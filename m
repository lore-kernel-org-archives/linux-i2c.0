From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH_V2 0/2] i2s: jz4780: Add Ingenic JZ4780 i2c driver
Date: Wed, 25 Mar 2015 15:54:58 +0000
Message-ID: <5512DA52.1070202@imgtec.com>
References: <1426084004-10364-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426084004-10364-1-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Just wondering if this has gotten lost in the archives?

Regards,
ZubairLK

On 11/03/15 14:26, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> Here we have two patches that add support for the i2c 
> controller present in the Ingenic JZ4780.
> 
> V1 - > V2
> Rebased to v4.0-rc3
> Minor tweaks/fixes. Details in individual patch commits.
> 
> Feedback welcome.
> 
> Thank-you
> ZubairLK
> 
> Zubair Lutfullah Kakakhel (2):
>   dt-bindings: i2c: Add dt binding documentation for ingenic jz4780 SoC
>   i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780
> 
>  .../devicetree/bindings/i2c/i2c-jz4780.txt         |  35 +
>  drivers/i2c/busses/Kconfig                         |   9 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-jz4780.c                    | 839 +++++++++++++++++++++
>  4 files changed, 884 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
>  create mode 100644 drivers/i2c/busses/i2c-jz4780.c
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
