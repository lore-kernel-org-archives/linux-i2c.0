From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 0/2] Remove smbus quick cmd and update adapter name
Date: Thu,  8 Aug 2019 09:07:51 +0530
Message-ID: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

This patchset contains following changes:
- Remove SMBUS quick command support
- Update full name of dt node to adapter name

Lori Hikichi (2):
  i2c: iproc: Stop advertising support of SMBUS quick cmd
  i2c: iproc: Add full name of devicetree node to adapter name

 drivers/i2c/busses/i2c-bcm-iproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.9.1
