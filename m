From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 0/3] i2c: Use the standard, alias-based device/driver
	matching scheme
Date: Mon, 21 Jan 2008 11:25:17 +0100
Message-ID: <20080121112517.6fe35a89@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Linux I2C <i2c@lm-sensors.org>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

Here comes a patch set, based on earlier work by Jon Smirl, that
updates the i2c subsystem to support and use the standard, alias-based
device/driver matching scheme that most other subsystems are using.
Contrary to Jon's patch set, this one only supports Linux names and not
OF names, although it might be added later (just not sure how exactly.)

Patch 1/3 adds support for this standard matching scheme, patch 2/3
converts all the in-tree drivers to make use of it, and patch 3/3
removes the old driver_name/type matching scheme that has no users left
at this point.

This new approach makes the i2c device drivers smaller in general
(because the name matching code moved to i2c-core), the exception being
drivers which support only one device, for which the device ID table
adds a small overhead (88 bytes on x86_64).

The key benefit compared to the original matching scheme is that
platform code no longer needs to know which driver supports which
device. This means that support for a given device can move from one
driver to another without changing the platform code.

Note: all the arm and powerpc stuff is untested.

-- 
Jean Delvare
