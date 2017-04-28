From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/5] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Fri, 28 Apr 2017 13:21:48 -0500
Message-ID: <20170428182148.tbpsgnhxssortq3u@rob-hp-laptop>
References: <20170424181818.2754-1-brendanhiggins@google.com>
 <20170424181818.2754-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36072 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756868AbdD1SVu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 Apr 2017 14:21:50 -0400
Content-Disposition: inline
In-Reply-To: <20170424181818.2754-4-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Mon, Apr 24, 2017 at 11:18:16AM -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C busses.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes for v2:
>   - None
> Changes for v3:
>   - Removed reference to "bus" device tree param
> Changes for v4:
>   - None
> Changes for v5:
>   - None
> Changes for v6:
>   - Replaced the controller property with and interrupt controller, leaving only
>     the busses in the I2C documentation.
> Changes for v7:
>   - Changed clock-frequency to bus-frequency in device tree
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

Acked-by: Rob Herring <robh@kernel.org>
