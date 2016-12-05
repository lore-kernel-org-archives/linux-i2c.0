From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Mon, 5 Dec 2016 16:28:26 -0600
Message-ID: <20161205222826.brehi3nbcg3exwum@rob-hp-laptop>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-3-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34004 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcLEW2a (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Dec 2016 17:28:30 -0500
Content-Disposition: inline
In-Reply-To: <1480467618-7497-3-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, vz@mleia.com, clg@kaod.org, mouse@mayc.ru, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, openbmc@lists.ozlabs.org

On Tue, Nov 29, 2016 at 05:00:18PM -0800, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C controller and
> busses.
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
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

Acked-by: Rob Herring <robh@kernel.org>
