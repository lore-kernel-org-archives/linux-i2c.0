From: York Sun <yorksun@freescale.com>
Subject: I2C class bitmask
Date: Thu, 21 May 2015 14:07:31 -0700
Message-ID: <555E4913.9070805@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Lee,

Is there any convention regarding I2C class bitmask? I see only three are
defined for 3.12.19 and four for 4.0

I2C_CLASS_HWMON, I2C_CLASS_DDC, I2C_CLASS_SPD, I2C_CLASS_DEPRECATED

I am working on a clock chip driver (SI5338) and trying to detect them (multiple
chips in i2c mux). It would be a lot easier to have its own class, like
I2C_CLASS_CLOCK. It is trivial to add a line to i2c.h file. Just checking if
this is a bad idea.

York
