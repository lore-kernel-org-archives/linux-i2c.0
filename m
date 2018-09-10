From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [RFC PATCH i2c-next 0/2] i2c: aspeed: Add bus idle waiting logic for multi-master use cases
Date: Mon, 10 Sep 2018 14:45:17 -0700
Message-ID: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In multi-master environment, this driver side master cannot know
exactly when peer master sends data to this side master so a case
can be happened that this master tries to send data through the
master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent state corruption in the case, this patch adds checking
if any slave operation is ongoing and it wait up to the timeout
duration before starting a master_xfer operation.

Please review this patch set.

Thanks,

-Jae

Jae Hyun Yoo (2):
  dt-bindings: i2c: aspeed: Add 'idle-wait-timeout-ms' setting
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    | 10 ++-
 drivers/i2c/busses/i2c-aspeed.c               | 70 +++++++++++++++----
 2 files changed, 62 insertions(+), 18 deletions(-)

-- 
2.18.0
