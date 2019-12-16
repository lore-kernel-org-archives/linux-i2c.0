From: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=
        <zhouyanjie@wanyeetech.com>
Subject: [PATCH v2 0/2] Add I2C support for the Ingenic X1000 SoC
Date: Mon, 16 Dec 2019 18:06:09 +0800
Message-ID: <1576490771-120353-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576490771-120353-1-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1576490771-120353-1-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
List-Id: linux-i2c@vger.kernel.org

v1->v2:
Add code to check device_get_match_data(), if it return a NULL ptr,
then print an error message and return -ENODEV.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: I2C: Add X1000 bindings.
  I2C: JZ4780: Add support for the X1000.

 .../devicetree/bindings/i2c/i2c-jz4780.txt         |   4 +-
 drivers/i2c/busses/i2c-jz4780.c                    | 155 +++++++++++++++------
 2 files changed, 118 insertions(+), 41 deletions(-)

-- 
2.7.4
