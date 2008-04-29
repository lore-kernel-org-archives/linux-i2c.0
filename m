From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 0/2 v2] i2c: Add support for device alias names
Date: Tue, 29 Apr 2008 12:42:41 +0200
Message-ID: <20080429124241.08e18ae3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Linux I2C <i2c@lm-sensors.org>
Cc: Laurent@ozlabs.org, Sievers <kay.sievers@vrfy.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>, Kay@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

This is yesterday's patch set updated to apply cleanly (and hopefully
work) on top of 2.6.25-git13. Basically the only change since yesterday
is the sync with the rtc subsystem updates, which converted 3 drivers
(rtc-x1205, rtc-pcf8563 and rtc-isl1208).

The plan is to send this to Linus this evening. The more testing it
gets, the better. Thanks to Wolfram and Jochen for yesterday's test
reports!

-- 
Jean Delvare
