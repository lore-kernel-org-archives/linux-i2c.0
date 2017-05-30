From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/5] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Tue, 30 May 2017 16:37:12 -0500
Message-ID: <20170530213712.sspigq7xtrdcfabb@rob-hp-laptop>
References: <20170525064925.16867-1-brendanhiggins@google.com>
 <20170525064925.16867-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33559 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3VhO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 May 2017 17:37:14 -0400
Content-Disposition: inline
In-Reply-To: <20170525064925.16867-4-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Wed, May 24, 2017 at 11:49:23PM -0700, Brendan Higgins wrote:
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
> Changes for v8:
>   - Added multi-master property to device tree
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

Acked-by: Rob Herring <robh@kernel.org>
