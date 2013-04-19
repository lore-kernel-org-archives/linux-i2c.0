From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: i2c-mxs woes
Date: Fri, 19 Apr 2013 13:37:47 +0200
Message-ID: <51712C8B.7070302@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

I'm having some issues with the i2c-mxs driver in 3.9. Marek already
pointed me to the patches from Lucas and that greatly improved the
situation.

For the context, my board has three nau7802 adcs, connected to a gpio
i2c-muxer, connected to i2c1.

Here is what I observe:

On 3.9:

# time cat /sys/bus/iio/devices/iio:device1/in_voltage0_raw 
2620
real	0m 7.08s
user	0m 0.00s
sys	0m 0.02s
# time cat /sys/bus/iio/devices/iio:device1/in_voltage1_raw 
2623
real	0m 6.07s
user	0m 0.01s
sys	0m 0.01s
# 



On 3.9 but using i2c-gpio to bitbang on the bus:

# time cat /sys/bus/iio/devices/iio:device1/in_voltage0_raw 
2661
real	0m 0.08s
user	0m 0.00s
sys	0m 0.06s
# time cat /sys/bus/iio/devices/iio:device1/in_voltage1_raw 
2270
real	0m 0.08s
user	0m 0.00s
sys	0m 0.05s
#



On 3.7, i2c-mxs:

# time cat /sys/bus/iio/devices/iio:device1/in_voltage0_raw
2643
real    0m 0.06s
user    0m 0.01s
sys    0m 0.02s
# time cat /sys/bus/iio/devices/iio:device1/in_voltage1_raw
1546
real    0m 0.05s
user    0m 0.00s
sys    0m 0.02s
#

Any input would be appreciated.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
