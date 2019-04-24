From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Date: Wed, 24 Apr 2019 15:34:09 +0300
Message-ID: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The main idea of this patchset was to add the dt-based GPIOs support
in i2c-mux-gpio driver. In particular we needed to have the full GPIOs
specifier being handled including the dt-flags like GPIO_ACTIVE_HIGH,
GPIO_ACTIVE_LOW, etc. Due to using a legacy GPIO interface the former
driver implementation didn't provide this ability.

On the way of adding the full dt-GPIO flags support a small set of
refactorings has been done in order to keep the platform_data-based
systems support, make the code more readable and the alterations - clearer.
In general the whole changes might be considered as the plat- and dt-
specific code split up. In first patch we unpinned the platform-specific
method of GPIO-chip probing. The second patch makes the driver to return
an error if of-based (last resort path) failed to retrieve the driver
private data. The next three patches is the sequence of initial channel
info retrieval, platform_data-specific code isolation and finally full
dt-based GPIOs request method introduction. The last patch does what
we inteded this patchset for in the first place - adds the full dt-GPIO
specifiers support.


Serge Semin (5):
  i2c-mux-gpio: Unpin a platform-based device initialization
  i2c-mux-gpio: Return an error if no config data found
  i2c-mux-gpio: Save initial channel number to the idle data field
  i2c-mux-gpio: Unpin the platform-specific GPIOs request code
  i2c-mux-gpio: Create of-based GPIOs request method

 drivers/i2c/muxes/i2c-mux-gpio.c | 224 ++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 78 deletions(-)

-- 
2.21.0
