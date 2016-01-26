From: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: imx: add slave support
Date: Tue, 26 Jan 2016 12:54:23 +0300
Message-ID: <56A7424F.40303@dev.rtsoft.ru>
References: <201601260255.x4ozgiHe%fengguang.wu@intel.com>
 <56A72CC0.1070207@dev.rtsoft.ru> <20160126083609.GB2190@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48307 "EHLO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964887AbcAZJy0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jan 2016 04:54:26 -0500
In-Reply-To: <20160126083609.GB2190@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Syrchin <syrchin@dev.rtsoft.ru>

Sorry, we should have added selecting this in our patch.
The following fixes it:

Subject: [PATCH] Select I2C_SLAVE for i2c-imx driver because it uses the 
generic slave interface.

Signed-off-by: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Signed-off-by: Maxim Syrchin <syrchin@dev.rtsoft.ru>
---
  drivers/i2c/busses/Kconfig | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0299dfa..bc7cbfd 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -587,6 +587,7 @@ config I2C_IMG
  config I2C_IMX
      tristate "IMX I2C interface"
      depends on ARCH_MXC || ARCH_LAYERSCAPE
+    select I2C_SLAVE
      help
        Say Y here if you want to use the IIC bus controller on
        the Freescale i.MX/MXC or Layerscape processors.
-- 
2.5.0




On 26.01.2016 11:36, Wolfram Sang wrote:
> On Tue, Jan 26, 2016 at 11:22:24AM +0300, Dmitriy Baranov wrote:
>> Thank you for testing our patch.
>>
>> Due to using the generic slave interface, It should be enabled in the config
>> file.
>> Please add the following in the config file:
>> CONFIG_I2C_SLAVE=y
> For now, you need to select it to make randconfigs built.
>
