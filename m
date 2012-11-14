From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/3] i2c: at91: add dma support
Date: Wed, 14 Nov 2012 17:44:50 +0100
Message-ID: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Hi Wolfram,

Here is the third version taking into account your feedback.

Patch 1/3 should go into v3.7.

Regards

Ludovic

Changes:
- v3
    - introduce two new patches: one to fix a compilation warning and one to
    fix indentation
    - introduce a threshold to use dma transfers
    - use dma wrappers to clean code
    - remove dma cookie since it is no more used

- v2 (based on Russell feedback):
    - replace DMA_TO_DEVICE/DMA_FROM_DEVICE by DMA_MEM_TO_DEV/DMA_DEV_TO_MEM
    - don't check for tx_submit errors
    - atmel dma header location has changed


Ludovic Desroches (3):
  i2c: at91: fix compilation warning
  i2c: at91: change struct members indentation
  i2c: at91: add dma support

 drivers/i2c/busses/i2c-at91.c | 338 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 314 insertions(+), 24 deletions(-)

-- 
1.7.11.3
