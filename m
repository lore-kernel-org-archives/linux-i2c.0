From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Mon, 14 Nov 2016 09:57:31 -0600
Message-ID: <20161114155731.p4kxmefqevplphtd@rob-hp-laptop>
References: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
 <1478311099-6771-3-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35269 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbcKNP5e (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 10:57:34 -0500
Content-Disposition: inline
In-Reply-To: <1478311099-6771-3-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, openbmc@lists.ozlabs.org

On Fri, Nov 04, 2016 at 06:58:19PM -0700, Brendan Higgins wrote:
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
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

Acked-by: Rob Herring <robh@kernel.org>
