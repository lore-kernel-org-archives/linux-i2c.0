From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH RESEND v6 0/2] at24: support eeproms that do not auto-rollover reads.
Date: Fri, 8 Dec 2017 10:37:23 -0500
Message-ID: <1512747445-5817-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

v6 resend:
	added Reviewed-by: Rob Herring <robh@kernel.org>

v6:
	added newlines, asked by Bartosz
	no need for braces around ternary operator's condition:
		bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
	but keep the braces anyway, as asked by Uwe Klein-Koenig

v5:
	at Rob Herring's request, renamed devicetree property:
		at24,no-read-rollover -> no-read-rollover

v4:
	renamed devicetree property:
		no-read-rollover -> at24,no-read-rollover
	dt-bindings update now a separate patch

v3:
	rebased against at24 maintainer's devel staging branch:
	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git at24/devel
	clarified some of the comments and wording

v2:
	kbuild test robot feedback: correct
		"warning: comparison of distinct pointer types lacks a cast"
	build warning on some compilers / architectures.

v1:
	original patch

Sven Van Asbroeck (2):
  at24: support eeproms that do not auto-rollover reads.
  dt-bindings: add eeprom "at24,no-read-rollover" property

 .../devicetree/bindings/eeprom/eeprom.txt          |  5 +++
 drivers/misc/eeprom/at24.c                         | 37 +++++++++++++++-------
 include/linux/platform_data/at24.h                 |  2 ++
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
1.9.1
