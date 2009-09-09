From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Removing deprecated drivers from drivers/i2c/chips
Date: Wed,  9 Sep 2009 23:22:47 +0200
Message-ID: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, uclinux-dist-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
List-Id: linux-i2c@vger.kernel.org

Hi,

continuing the quest to clean up and ultimately remove the drivers/i2c/chips
directory, this patch series removes three drivers for GPIO-expanders which are
obsoleted and marked as deprecated for more than a year. The newer (and better)
drivers can be found in drivers/gpio.

As it is ensured that the newer drivers cover the same i2c_device_ids, all
platform_devices will still match. Some defconfig updates may be necessary
though, but according to [1] this is left to the arch|platform-maintainers
(also as most defconfigs are quite outdated). For that reason, I put the
relevant arch-mailing-lists to Cc. Comments are welcome.

Regards,

   Wolfram

[1] http://lkml.org/lkml/2009/5/7/34
