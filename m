From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 0/2]  Patches for i2c-stm32 device tree bindings
Date: Wed, 6 Mar 2019 15:11:50 +0000
Message-ID: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-i2c@vger.kernel.org

This patchset provides dt-bindings updates for I2C.

Bich Hemon (2):
  dt-bindings: i2c-stm32: remove extra spaces
  dt-bindings: i2c-stm32: update optional properties for
    stm32h7/stm32mp1

 .../devicetree/bindings/i2c/i2c-stm32.txt          | 37 +++++++++++-----------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
1.9.1
