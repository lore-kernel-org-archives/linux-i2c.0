From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 04/89] i2c: brcmstb: Allow to compile it on BCM2835
Date: Mon, 24 Feb 2020 09:39:14 -0800
Message-ID: <86695f21-367e-7dbc-bdd5-b908f798118d@gmail.com>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <0ec2a26c7492b1ef6554d3bdada7a6fb8b41ab1c.1582533919.git-series.maxime@cerno.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36784 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgBXRjR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Feb 2020 12:39:17 -0500
In-Reply-To: <0ec2a26c7492b1ef6554d3bdada7a6fb8b41ab1c.1582533919.git-series.maxime@cerno.tech>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Maxime Ripard <maxime@cerno.tech>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, Tim Gover <tim.gover@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2/24/20 1:06 AM, Maxime Ripard wrote:
> The BCM2711, supported by ARCH_BCM2835, also has a controller by the
> brcmstb driver so let's allow it to be compiled on that platform.
> 
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
