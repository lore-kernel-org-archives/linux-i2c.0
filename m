From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2] i2c: rcar: add DMA support
Date: Wed, 18 May 2016 15:23:07 +0200
Message-ID: <6110679.RmWR1Poicp@wuerfel>
References: <1463228228-32560-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59692 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbcERNXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 18 May 2016 09:23:18 -0400
In-Reply-To: <1463228228-32560-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org

On Saturday 14 May 2016 14:17:08 Niklas S=F6derlund wrote:
> +       chan =3D dma_request_slave_channel_reason(dev, chan_name);
> +       if (IS_ERR(chan)) {
> +               ret =3D PTR_ERR(chan);
> +               dev_dbg(dev, "request_channel failed for %s (%d)\n",
> +                       chan_name, ret);
> +               return chan;
> +       }
>=20

I think you should now use dma_request_chan() for new drivers.

	Arnd
