From: Craig McQueen <craig.mcqueen-5IW6GhIdNBM/ppqrhe30yRZCeNDtXRbv@public.gmane.org>
Subject: i2cget with 16-bit address, 16-bit data
Date: Thu, 23 May 2013 04:27:20 +0000
Message-ID: <DB8F1B3EEF94C3439BFFE674EB05E3CC23FFBCB5@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-AU
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I'm trying to read data from a SGTL5000 audio CODEC, which has 16-bit addresses and 16-bit wide data registers.

Unless I'm missing something, it looks impossible to read these registers using i2cget, because it only supports 8-bit addresses. Is there any other similar tool, or should I patch i2cget to support 16-bit addresses?

Regards,
Craig McQueen
