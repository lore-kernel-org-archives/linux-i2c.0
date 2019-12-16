From: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=
        <zhouyanjie@wanyeetech.com>
Subject: Add I2C support for the Ingenic X1000 SoC v2.
Date: Mon, 16 Dec 2019 18:06:08 +0800
Message-ID: <1576490771-120353-1-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
List-Id: linux-i2c@vger.kernel.org

v1->v2:
Add code to check device_get_match_data(), if it return a NULL ptr,
then print an error message and return -ENODEV.
