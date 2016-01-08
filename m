From: liguo zhang <liguo.zhang@mediatek.com>
Subject: Re: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek
 MT2701 soc
Date: Fri, 8 Jan 2016 09:12:08 +0800
Message-ID: <1452215528.2088.0.camel@mhfsdcap03>
References: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
	 <20160104095511.GB1524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:47880 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751357AbcCGH0I (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 02:26:08 -0500
In-Reply-To: <20160104095511.GB1524@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

On Mon, 2016-01-04 at 10:55 +0100, Wolfram Sang wrote:
> On Mon, Jan 04, 2016 at 02:15:37PM +0800, Liguo Zhang wrote:
> > Add a dt binding for the MT2701 soc.
> > 
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> This should probably go with the other patch via arm-soc, or?

The patch about i2c dts info for MT2701 depends on the MT2701 clock
patch. After the MT2701 clock patch is accepted, the i2c patch for
MT2701 may be accepted.

The MT2701 clock patch:
http://lists.infradead.org/pipermail/linux-mediatek/2016-January/003489.html

> 
> In that case:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
