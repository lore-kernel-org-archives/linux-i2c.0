From: Pavel Machek <pavel@denx.de>
Subject: spurious warning from of_i2c_register_device with fixed_regulator?
Date: Wed, 16 Mar 2016 12:01:56 +0100
Message-ID: <20160316110156.GC21259@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34961 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966664AbcCPLB7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Mar 2016 07:01:59 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: pavel@denx.de
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, robh+dt@kernel.org

Hi!

We are getting this in the logs:

i2c i2c-0: of_i2c: invalid reg on /soc/i2c@ffc04000/vcc3p3-regulator

In the dts we have:

socfpga_cyclone5_sockit.dts:
        regulator_3_3v: vcc3p3-regulator {
	                compatible = "regulator-fixed";
		        regulator-name = "VCC3P3";
		        regulator-min-microvolt = <3300000>;
	                regulator-max-microvolt = <3300000>;
        };

Which seems to trigger

drivers/i2c/i2c-core.c:
      addr_be = of_get_property(node, "reg", &len);
                  if (!addr_be || (len < sizeof(*addr_be))) {
                       dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
...
		      
But we have fixed regulator there, it does not have "reg" property.

Git blame says: a430a3455f2c48995e06b359a82a1109a419e9ef. (And no, I
don't have exactly mainline kernel here, but it should be close enough.)

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
