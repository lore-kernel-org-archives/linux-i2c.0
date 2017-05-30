From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed
 I2C Interrupt Controller
Date: Tue, 30 May 2017 16:34:30 -0500
Message-ID: <20170530213430.vlxioxzzuzbjojhj@rob-hp-laptop>
References: <20170525064925.16867-1-brendanhiggins@google.com>
 <20170525064925.16867-2-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36215 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3Vec (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 May 2017 17:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20170525064925.16867-2-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Wed, May 24, 2017 at 11:49:21PM -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C Interrupt
> Controller.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Added in v6:
>   - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
>     what it actually does.
> Changes for v7:
>   - None
> Changes for v8:
>   - None

I already acked this. Please add acks when posting new versions.

Rob
