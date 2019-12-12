From: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=
        <zhouyanjie@wanyeetech.com>
Subject: [PATCH 0/2] Add I2C support for the Ingenic X1000 SoC.
Date: Thu, 12 Dec 2019 23:50:48 +0800
Message-ID: <1576165850-20727-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, paul.burton@mips.com, paulburton@kernel.org, sernia.zhou@foxmail.com, zhenwenjin@gmail.com
List-Id: linux-i2c@vger.kernel.org

*** BLURB HERE ***

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: I2C: Add X1000 bindings.
  I2C: JZ4780: Add support for the X1000.

 .../devicetree/bindings/i2c/i2c-jz4780.txt         |   4 +-
 drivers/i2c/busses/i2c-jz4780.c                    | 159 +++++++++++++++------
 2 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.7.4
