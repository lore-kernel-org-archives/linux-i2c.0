From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: i2c-mpc.c clock/speed
Date: Wed, 05 Mar 2014 10:29:28 +0100
Message-ID: <5316EE78.2080808@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: gsi-ynQEQJNshbs@public.gmane.org, agust-ynQEQJNshbs@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

in mpc_i2c_get_fdr_8xxx(), we have:

...
if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
	prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
if (!prescaler)
	prescaler = 1;
...

By restricting to "fsl,mpc8544-i2c", measured I2C speed on fsl p2020 is
only half as fast as configured (w/ prescaler = 1).

In DT (arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi), we have "fsl-i2c"
(i.e., generic), for Freescale boards.

What would be the best solution here? Additional "compatible" strings,
e.g. "fsl,p1020-i2c" and adjusting i2c-mpc.c and DT? Or removing the
restriction to "fsl,mpc8544-i2c", i.e. calling
mpc_i2c_get_sec_cfg_8xxx() unconditionally?

Thanks in advance,

Roland.
