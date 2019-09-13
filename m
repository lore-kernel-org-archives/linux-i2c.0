From: Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] i2c: Aspeed: Add AST2600 compatible string
Date: Fri, 13 Sep 2019 11:35:08 -0500
Message-ID: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, brendanhiggins@google.com, joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org, Eddie James <eajames@linux.ibm.com>
List-Id: linux-i2c@vger.kernel.org

Update the Aspeed I2C driver with the AST2600 compatible string. The default
driver behavior works fine with the AST2600. A new compatible string is needed
to avoid the AST2400 and AST2500 behavior.

Eddie James (2):
  i2c: Aspeed: Add AST2600 compatible
  dt-bindings: i2c: Aspeed: Add AST2600 compatible

 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 ++-
 drivers/i2c/busses/i2c-aspeed.c                      | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.8.3.1
