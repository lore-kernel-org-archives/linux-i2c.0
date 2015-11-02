From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH 0/2] Mediatek I2C driver fixup
Date: Mon, 2 Nov 2015 14:35:06 +0800
Message-ID: <1446446106.12497.6.camel@mtksdaap41>
References: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:46002 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751529AbbKBGfL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Nov 2015 01:35:11 -0500
In-Reply-To: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Xudong Chen =?UTF-8?Q?=28=E9=99=88=E6=97=AD=E4=B8=9C=29?= <Xudong.Chen@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2015-10-27 at 16:59 +0800, Liguo Zhang wrote:
> This series contain two patches, first is to optimize Mediatek I2C driver to use WRRD
> if hardware support auto restart. Because auto restart will issue auto restart
> interrupt, change to use WRRD can reduce interrupt latency. The second is to fix
> multi transfer error in high speed mode. If hardware support auto restart, need driver
> to send master code first.

Please fix checkpatch warning in 2/2, then you get my reviewed-by for
this series:

Reviewed-by:Eddie Huang <eddie.huang@mediatek.com>

> 
> Liguo Zhang (2):
>   i2c: mediatek: add i2c first write then read optimization
>   i2c: mediatek: fix i2c multi transfer issue in high speed mode
> 
>  drivers/i2c/busses/i2c-mt65xx.c | 77 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 6 deletions(-)
