From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: rcar: add DMA support
Date: Thu, 5 May 2016 17:06:25 -0500
Message-ID: <20160505220625.GA18367@rob-hp-laptop>
References: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35423 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757890AbcEEWGa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 5 May 2016 18:06:30 -0400
Content-Disposition: inline
In-Reply-To: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org

On Wed, May 04, 2016 at 02:38:23PM +0200, Niklas S=F6derlund wrote:
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
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
=2Ese>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   3 +
>  drivers/i2c/busses/i2c-rcar.c                      | 237 +++++++++++=
+++++++++-
>  2 files changed, 236 insertions(+), 4 deletions(-)

Is DMA actually faster or less cpu usage? I'm doubtful.

Acked-by: Rob Herring <robh@kernel.org>
