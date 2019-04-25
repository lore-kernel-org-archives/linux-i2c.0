From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 0/3] i2c-mux-gpio: Split plat- and dt-specific code up
Date: Fri, 26 Apr 2019 02:20:25 +0300
Message-ID: <20190425232028.9333-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The main idea of this patchset was to add the full dt GPIOs specifier
support in i2c-mux-gpio driver. In particular we needed to have the
full GPIOs specifier being handled including the flags like GPIO_ACTIVE_HIGH,
GPIO_ACTIVE_LOW, GPIO_PUSH_PULL, GPIO_OPEN_DRAIN or GPIO_OPEN_SOURCE.
Due to using a legacy GPIO interface the former driver implementation
didn't provide this ability.

On the way of adding the full dt-GPIO flags support a small set of
refactorings has been done in order to keep the platform_data-based
systems support, make the code more readable and the alterations - clearer.
In general the whole changes might be considered as the plat- and dt-
specific code split up. In the first patch we unpinned the platform-specific
method of GPIO-chip probing. The second patch introduces a new initial_state
value field into the "gpiomux" structure. The third one is responsible for
GPIO request loop isoltaing into a dedicated function. At this stage common
it is a common function for both dt- and plat- code paths. Finally last
patch introduces a full dt-based GPIOs request method, which uses
gpiod_get_from_of_node() method in order to parse the corresponding dt GPIO
specifiers with their falgs. The last patch does what we inteded this patchset
for in the first place - adds the full dt-GPIO specifiers support.

Changelog v2
- Remove fallback pattern when selecting the dt- or plat-based code paths.
  (Cause the patch "i2c-mux-gpio: Return an error if no onfig data found"
   removal.)
- Use a dedicated initial_state variable to keep the initial channels selector
  state. (Causes the patch "i2c-mux-gpio: Save initial channel number to the
  idle" removal.)
- Mention open-drain, open-source flags in the patchset descriptions.


Serge Semin (3):
  i2c-mux-gpio: Unpin a platform-based device initialization
  i2c-mux-gpio: Unpin the platform-specific GPIOs request code
  i2c-mux-gpio: Create of-based GPIOs request method

 drivers/i2c/muxes/i2c-mux-gpio.c | 226 ++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 80 deletions(-)

-- 
2.21.0
