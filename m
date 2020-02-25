From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 02/89] dt-bindings: i2c: brcmstb: Add BCM2711
 BSC/AUTO-I2C  binding
Date: Tue, 25 Feb 2020 12:15:00 -0600
Message-ID: <20200225181500.GA538@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <9e427ff22fa40b7146b44aee6468559499deb1f1.1582533919.git-series.maxime@cerno.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38873 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYSPC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Feb 2020 13:15:02 -0500
Content-Disposition: inline
In-Reply-To: <9e427ff22fa40b7146b44aee6468559499deb1f1.1582533919.git-series.maxime@cerno.tech>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Tim Gover <tim.gover@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Phil Elwell <phil@raspberrypi.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>

On Mon, 24 Feb 2020 10:06:04 +0100, Maxime Ripard wrote:
> The HDMI blocks in the BCM2771 have an i2c controller to retrieve the
> EDID. This block is split into two parts, the BSC and the AUTO_I2C,
> lying in two separate register areas.
> 
> The AUTO_I2C block has a mailbox-like interface and will take away the
> BSC control from the CPU if enabled. However, the BSC is the actually
> the same controller than the one supported by the brcmstb driver, and
> the AUTO_I2C doesn't really bring any immediate benefit.
> 
> We can model it in the DT as a single device with two register range,
> which will allow us to use or or the other in the driver without
> changing anything in the DT.
> 
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-i2c@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml | 40 ++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
