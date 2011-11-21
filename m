From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Still problems wit egt20 i2c driver
Date: Mon, 21 Nov 2011 10:48:57 +0100
Message-ID: <CAH9NwWf-Dgme+SBR4vwrVux5C12nTTe5sJuCpusdw8LqeVD+xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I still have some problems with the egt20 i2c driver. I am running a
3.1.1 kernel with the following
patches applied to it:

* [PATCH 1/7 v4] i2c-eg20t: Fix bus-idle waiting issue -
https://lkml.org/lkml/2011/10/12/3
* [PATCH 2/7 v4] i2c-eg20t: Modify returned value s32 to long -
https://lkml.org/lkml/2011/10/12/1
* [PATCH 3/7 v2] i2c-eg20t: Fix 10bit access issue -
https://lkml.org/lkml/2011/10/12/7
* [PATCH 4/7 v4] i2c-eg20t: Separate error processing -
https://lkml.org/lkml/2011/10/12/6
* [PATCH 5/7 v4] i2c-eg20t: add stop sequence in case wait-event
timeout occurs - https://lkml.org/lkml/2011/10/12/5
* [PATCH 6/7 v4] i2c-eg20t: Fix flag setting issue -
https://lkml.org/lkml/2011/10/12/2
* [PATCH 7/7 v4] i2c-eg20t: Add initialize processing in case
i2c-error occurs - https://lkml.org/lkml/2011/10/12/4
* [PATCH] i2c-eg20t: modified the setting of transfer rate. -
http://marc.info/?l=linux-i2c&m=131702145913299&w=2

I have a PCA9555 (drivers/gpio/gpio-pca953x.c) at i2c addr 0x48.

[   21.505138] pca953x 0-0048: probe
[   21.505157] i2c i2c-0: master_xfer[0] W, addr=0x48, len=1
[   21.505168] i2c i2c-0: master_xfer[1] R, addr=0x48, len=2
[   21.505180] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
:adap->p_adapter_info->pch_i2c_suspended is 0
[   21.505190] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x0
[   21.505206] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
390 msgs->len = 1
[   21.505220] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 390
[   21.505353] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.508667] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 2
to Data register
[   21.508772] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.510043] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL = 3b0
[   21.510058] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=1
[   21.510068] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x1
[   21.510209] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.517833] i2c_eg20t 0000:02:0c.2: pch_i2c_sendack :I2CCTL = 3a0
[   21.517962] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.517992] i2c_eg20t 0000:02:0c.2: pch_i2c_sendnack :I2CCTL = 3a0
[   21.518114] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.518230] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL = 3a8
[   21.518251] i2c i2c-0: master_xfer[0] W, addr=0x48, len=1
[   21.518261] i2c i2c-0: master_xfer[1] R, addr=0x48, len=2
[   21.518271] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
:adap->p_adapter_info->pch_i2c_suspended is 0
[   21.518281] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x0
[   21.518296] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
398 msgs->len = 1
[   21.518311] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 398
[   21.518442] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.520533] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 6
to Data register
[   21.520627] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.520709] i2c_eg20t 0000:02:0c.2: pch_i2c_repstart :I2CCTL = 3b8
[   21.520721] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :return=1
[   21.520731] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x1
[   21.520868] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.522841] i2c_eg20t 0000:02:0c.2: pch_i2c_sendack :I2CCTL = 3a8
[   21.522968] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.523533] i2c_eg20t 0000:02:0c.2: pch_i2c_sendnack :I2CCTL = 3a0
[   21.523660] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.523785] i2c_eg20t 0000:02:0c.2: pch_i2c_stop :I2CCTL = 3a8
[   21.523807] i2c i2c-0: master_xfer[0] W, addr=0x48, len=3
[   21.523817] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer
:adap->p_adapter_info->pch_i2c_suspended is 0
[   21.523827] i2c_eg20t 0000:02:0c.2: pch_i2c_xfer :After invoking
I2C_MODE_SEL :flag= 0x0
[   21.523842] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :I2CCTL =
398 msgs->len = 3
[   21.523856] i2c_eg20t 0000:02:0c.2: pch_i2c_start :I2CCTL = 398
[   21.523988] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.524570] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 4
to Data register
[   21.524677] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.524791] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 0
to Data register
[   21.524899] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 28
[   21.524948] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :writing 0
to Data register
[   21.525056] i2c_eg20t 0000:02:0c.2: pch_i2c_cb :PCH_I2CSR = 9
[   21.525666] i2c_eg20t 0000:02:0c.2: pch_i2c_getack :return-71
[   21.525746] i2c_eg20t 0000:02:0c.2: pch_i2c_writebytes :Receive
NACK for slave addresssetting
[   21.525760] pca953x 0-0048: failed writing register
[   21.525829] pca953x 0-0048: interrupt support not compiled in
[   21.526029] i2c-core: driver [pca953x] registered
[   21.526380] pca953x 0-0048: uevent


What informations do you need to get this fixed?

thanks
--
Christian Gmeiner, MSc
