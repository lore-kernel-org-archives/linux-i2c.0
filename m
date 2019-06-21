From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v2 0/2] i2c: bcm2835: Fixes for clock changes in probe
 function
Date: Fri, 21 Jun 2019 19:11:48 +0200
Message-ID: <7d23a83f-4e3a-5186-78b2-2183e636b0af@gmx.net>
References: <20190621105250.19858-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621105250.19858-1-nh6z@nh6z.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>, eric@anholt.net, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com
List-Id: linux-i2c@vger.kernel.org

Am 21.06.19 um 12:52 schrieb Annaliese McDermond:
> An issue was reported in [1] and [2] that the latest version of the i2c
> driver was not properly loading.  After analysis it was determined that
> the new clock code was failiing because the i2c driver was trying to
> load before the bcm2835-clk driver when not loaded as a module. This is
> fixed by actually attempting to grab a reference to the clock and failing
> out with a EPROBE_DEFER if it's not there.  This gives the other drivers
> an opportunity to load.
>
> This series also fixes a related bug where the clock setup code in the
> probe function could cause an issue where the IRQ would be requested
> by the driver and never freed in case of some clock setup failure.  The
> patch moves this IRQ code to the end of the probe function where it will
> not cause this issue.
>
> [1] - https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=242856
> [2] - https://archlinuxarm.org/forum/viewtopic.php?f=23&t=13719

This whole series is:

Acked-by: Stefan Wahren <wahrenst@gmx.net>
