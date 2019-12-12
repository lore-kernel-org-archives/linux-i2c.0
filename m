From: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=
        <zhouyanjie@wanyeetech.com>
Subject: (unknown)
Date: Thu, 12 Dec 2019 23:50:47 +0800
Message-ID: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, paul.burton@mips.com, paulburton@kernel.org, sernia.zhou@foxmail.com, zhenwenjin@gmail.com
List-Id: linux-i2c@vger.kernel.org

Add support for probing i2c driver on the X1000 Soc from Ingenic.
call the corresponding fifo parameter according to the device
model obtained from the devicetree.
