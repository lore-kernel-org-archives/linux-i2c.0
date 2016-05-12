From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: add DMA support
Date: Thu, 12 May 2016 23:31:27 +0200
Message-ID: <20160512213127.GA1860@katana>
References: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48975 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbcELVbj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 May 2016 17:31:39 -0400
Content-Disposition: inline
In-Reply-To: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org

Hi Niklas,

thanks for the submission. I was finally able to test this change.

On Wed, May 04, 2016 at 02:38:23PM +0200, Niklas S=C3=B6derlund wrote:
> Make it possible to transfer i2c message buffers via DMA.
> Start/Stop/Sending_Slave_Address and some data is still handled using
> the old state machine, it is sending the bulk of the data that is don=
e
> via DMA.
>=20
> The first byte of a transmission and the last two bytes of reception =
are
> sent/received using PIO. This is needed for the HW to have access to =
the
> first byte before DMA transmit and to be able to set the STOP conditi=
on
> for DMA reception.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnat=
ech.se>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I did regression tests on my Salvator-X trying to trigger previously
known issues. Nothing bad happened. This could be expected since START
and STOP is done in PIO mode, but one never knows :) Also did verify
that DMA is triggered for bigger transfers.

Did you have time to re-measure the threshold? Also, did you try bootin=
g
without DMA and on Gen2? We had a bit of hazzle with !DMA with the
sh_mobile-driver. Boot test and basic i2cdetect will suffice.

Patch looks good, only minor nits:

> +	/* Do not use DMA for messages shorter then 8 bytes */
> +	if (msg->len < 8)
> +		return;
> +
> +	if (IS_ERR(chan))
> +		return;

Make this one if (a || b)?

> @@ -516,6 +738,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapte=
r *adap,
>  out:
>  	pm_runtime_put(dev);
> =20
> +

Unrelated change ;)

Thanks,

   Wolfram
