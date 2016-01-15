From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Date: Thu, 14 Jan 2016 20:03:33 -0600
Message-ID: <20160115020333.GA3139@rob-hp-laptop>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42787 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbcAOCDi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jan 2016 21:03:38 -0500
Content-Disposition: inline
In-Reply-To: <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

On Wed, Jan 13, 2016 at 03:29:27PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> These bindings allow an I2C bus to switch between multiple masters. This
> is not hot-switching because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affecting your use case.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |  23 ++++
>  .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  | 136 +++++++++++++++++++++
>  2 files changed, 159 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
