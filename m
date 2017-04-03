From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/5] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Mon, 3 Apr 2017 09:22:15 -0500
Message-ID: <20170403142215.zvj3aypoarczf2ok@rob-hp-laptop>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-4-brendanhiggins@google.com>
 <1490691283.3177.112.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34235 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdDCOWR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Apr 2017 10:22:17 -0400
Content-Disposition: inline
In-Reply-To: <1490691283.3177.112.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Tue, Mar 28, 2017 at 07:54:43PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:
> > Added device tree binding documentation for Aspeed I2C busses.
> > 
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> 
> > +	i2c0: i2c-bus@40 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		#interrupt-cells = <1>;
> > +		reg = <0x40 0x40>;
> > +		compatible = "aspeed,ast2400-i2c-bus";
> > +		bus = <0>;
> > +		clocks = <&clk_apb>;
> > +		clock-frequency = <100000>;
> 
> For busses it's more traditional to make this "bus-frequency" but
> that's a nit and Linux/fdt has not respected that tradition terribly
> well. If you respin, it might be work changing.

Makes sense, but that's news to me. I'm still new to this DT stuff.

> The clock-frequency tends to be the frequency of the controller itself.

The clock binding has largely replaced that.

Rob
