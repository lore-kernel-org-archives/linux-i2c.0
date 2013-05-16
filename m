From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/9] Fix Marvell mv63xxx I2C driver
Date: Thu, 16 May 2013 21:29:21 +0100
Message-ID: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, "Mark A. Greer" <mgreer@animalcreek.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This patch series fixes a whole chunk of problems with this driver,
discovered with the Marvell Armada 510 chip on the Solid-run cubox.

Most notable of these is the I2C driver aborting a transaction
because a signal is pending - which might be SIGPIPE or SIGALRM
for the process.  Meanwhile, the calling driver may be in the
middle of a critical read-modify-write cycle on a device register,
causing it to fail.

Other problems are race conditions in the handling of multi-part
messages, where we end up sending multiple start conditions -
sometimes more times than we have i2c_msg's to send.

Lastly is the rather poor probe error handling, which ranges from
non-existent to lacking propagating the provided error code.
