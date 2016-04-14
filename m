From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC] I2C: i2c-smbus: add device tree support
Date: Thu, 14 Apr 2016 11:10:12 -0500
Message-ID: <20160414161012.GA20532@rob-hp-laptop>
References: <1460536591-12573-1-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42240 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbcDNQKS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 12:10:18 -0400
Content-Disposition: inline
In-Reply-To: <1460536591-12573-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>
Cc: jdelvare@suse.de, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 13, 2016 at 10:36:31AM +0200, Andrea Merello wrote:
> According to Documentation/i2c/smbus-protocol, a smbus controller driver
> that wants to hook-in smbus extensions support, can call
> i2c_setup_smbus_alert(). There are very few drivers that are currently
> doing this.
> 
> However the i2c-smbus module can also work with any
> smbus-extensions-unaware I2C controller, as long as we provide an extra
> IRQ line connected to the I2C bus ALARM signal.
> 
> This patch makes it possible to go this way via DT. Note that the DT node
> will indeed describe a (little) piece of HW, that is the routing of the
> ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).
> 
> Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
> with address 0x0C (that is the alarm response address), and IMHO this is
> quite consistent with usage in the DT as a I2C child node.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
> new file mode 100644
> index 0000000..da83127
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
> @@ -0,0 +1,20 @@
> +* i2c-smbus extensions
> +
> +Required Properties:
> +  - compatible: Must contain "smbus_alert"
> +  - interrupts: The irq line for smbus ALERT signal
> +  - reg: I2C slave address. Set to 0x0C (alert response address).
> +
> +Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
> +a smbus controller directly support smbus extensions (and its driver supports
> +this), there is no need to add anything special to the DT. Otherwise, for using
> +i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
> +route the smbus ALARM signal to an extra IRQ line, thus you need to describe
> +this in the DT.

Seems like you are designing the binding around how the module is 
currently designed and creating a virtual device that doesn't exist.

A "smbalert-gpios" property in the controller node would be sufficient 
here. Alternatively, an interrupt and standardized interrupt-names value 
could be used.

Another option would be add a boolean property to each child node 
smbalert capable and the childrens' interrupt properties would all be 
the shared interrupt.

Rob
