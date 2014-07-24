From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v5 0/2] i2c: add DMA support for freescale i2c driver
Date: Thu, 24 Jul 2014 03:36:34 +0000
Message-ID: <e5547e015bf6447e9b4fc18e82ddce74@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
 <201407231428.01278.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201407231428.01278.marex-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Marek Vasut wrote:
> On Wednesday, July 23, 2014 at 10:24:41 AM, Yuan Yao wrote:
> > Changed in v5:
> > - add "*chan_dev = dma->chan_using->device->dev" for reduce the call time.
> 
> Did you check if the compiler generates different code ?
> 

Sorry, I didn't compare the assembly code. It's a subtle change. 
As you mentioned the "noodle" before.

Old:
dma_map_single(dma->chan_using->device->dev, ...);
dma_mapping_error(dma->chan_using->device->dev, ...);
dma_unmap_single(dma->chan_using->device->dev, ...);
	
New:
struct device *chan_dev = dma->chan_using->device->dev;
dma_map_single(chan_dev, ...);
dma_mapping_error(chan_dev, ...);
dma_unmap_single(chan_dev, ...);

> > - add the test logs.
> 
> [...]
> 
> Best regards,
> Marek Vasut
