From: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: imx: add slave support
Date: Tue, 26 Jan 2016 11:22:24 +0300
Message-ID: <56A72CC0.1070207@dev.rtsoft.ru>
References: <201601260255.x4ozgiHe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:33116 "EHLO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbcAZIW1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jan 2016 03:22:27 -0500
In-Reply-To: <201601260255.x4ozgiHe%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Syrchin <syrchin@dev.rtsoft.ru>

Thank you for testing our patch.

Due to using the generic slave interface, It should be enabled in the 
config file.
Please add the following in the config file:
CONFIG_I2C_SLAVE=y



On 25.01.2016 21:09, kbuild test robot wrote:
> Hi Dmitriy,
>
> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.5-rc1 next-20160125]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Dmitriy-Baranov/i2c-imx-add-slave-support/20160125-225538
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
> config: arm-imx_v6_v7_defconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All error/warnings (new ones prefixed by >>):
>
>     drivers/i2c/busses/i2c-imx.c: In function 'i2c_imx_slave_threadfn':
>>> drivers/i2c/busses/i2c-imx.c:696:6: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
>           i2c_slave_event(i2c_imx->slave,
>           ^
>>> drivers/i2c/busses/i2c-imx.c:697:7: error: 'I2C_SLAVE_READ_REQUESTED' undeclared (first use in this function)
>            I2C_SLAVE_READ_REQUESTED, &data);
>            ^
>     drivers/i2c/busses/i2c-imx.c:697:7: note: each undeclared identifier is reported only once for each function it appears in
>>> drivers/i2c/busses/i2c-imx.c:706:7: error: 'I2C_SLAVE_WRITE_REQUESTED' undeclared (first use in this function)
>            I2C_SLAVE_WRITE_REQUESTED, &data);
>            ^
>>> drivers/i2c/busses/i2c-imx.c:719:8: error: 'I2C_SLAVE_READ_PROCESSED' undeclared (first use in this function)
>             I2C_SLAVE_READ_PROCESSED, &data);
>             ^
>>> drivers/i2c/busses/i2c-imx.c:744:7: error: 'I2C_SLAVE_WRITE_RECEIVED' undeclared (first use in this function)
>            I2C_SLAVE_WRITE_RECEIVED, &data);
>            ^
>>> drivers/i2c/busses/i2c-imx.c:755:37: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)
>          i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &data);
>                                          ^
>     drivers/i2c/busses/i2c-imx.c: At top level:
>>> drivers/i2c/busses/i2c-imx.c:1283:2: error: unknown field 'reg_slave' specified in initializer
>       .reg_slave = i2c_imx_reg_slave,
>       ^
>>> drivers/i2c/busses/i2c-imx.c:1283:2: warning: excess elements in struct initializer
>     drivers/i2c/busses/i2c-imx.c:1283:2: warning: (near initialization for 'i2c_imx_algo')
>>> drivers/i2c/busses/i2c-imx.c:1284:2: error: unknown field 'unreg_slave' specified in initializer
>       .unreg_slave = i2c_imx_unreg_slave,
>       ^
>     drivers/i2c/busses/i2c-imx.c:1284:2: warning: excess elements in struct initializer
>     drivers/i2c/busses/i2c-imx.c:1284:2: warning: (near initialization for 'i2c_imx_algo')
>     cc1: some warnings being treated as errors
>
> vim +/i2c_slave_event +696 drivers/i2c/busses/i2c-imx.c
>
>     690				status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>     691				ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>     692	
>     693				if (status & I2SR_IAAS) {
>     694					if (status & I2SR_SRW) {
>     695						/* master wants to read from us */
>   > 696						i2c_slave_event(i2c_imx->slave,
>   > 697							I2C_SLAVE_READ_REQUESTED, &data);
>     698						ctl |= I2CR_MTX;
>     699						imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>     700	
>     701						/*send data */
>     702						imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
>     703					} else {
>     704						dev_dbg(&i2c_imx->adapter.dev, "write requested");
>     705						i2c_slave_event(i2c_imx->slave,
>   > 706							I2C_SLAVE_WRITE_REQUESTED, &data);
>     707						/*slave receive */
>     708						ctl &= ~I2CR_MTX;
>     709						imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>     710	
>     711						/*dummy read */
>     712						data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
>     713					}
>     714				} else {
>     715					/* slave send */
>     716					if (ctl & I2CR_MTX) {
>     717						if (!(status & I2SR_RXAK)) {	/*ACK received */
>     718							i2c_slave_event(i2c_imx->slave,
>   > 719								I2C_SLAVE_READ_PROCESSED, &data);
>     720							ctl |= I2CR_MTX;
>     721							imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>     722							/*send data */
>     723							imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
>     724						} else {
>     725							/*no ACK. */
>     726							/*dummy read */
>     727							dev_dbg(&i2c_imx->adapter.dev, "read requested");
>     728							i2c_slave_event(i2c_imx->slave,
>     729								I2C_SLAVE_READ_REQUESTED, &data);
>     730	
>     731							ctl &= ~I2CR_MTX;
>     732							imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>     733							imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
>     734						}
>     735					} else {	/*read */
>     736						ctl &= ~I2CR_MTX;
>     737						imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>     738	
>     739						/*read */
>     740						data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
>     741						dev_dbg(&i2c_imx->adapter.dev, "received %x",
>     742							(unsigned int) data);
>     743						i2c_slave_event(i2c_imx->slave,
>   > 744							I2C_SLAVE_WRITE_RECEIVED, &data);
>     745					}
>     746				}
>     747			}
>     748	
>     749			if (atomic_read(&i2c_imx->slave_state) == I2C_IMX_SLAVE_POLLING) {
>     750				udelay(50);
>     751				status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>     752	
>     753				if ((status & I2SR_IBB) == 0) {
>     754					pr_debug("end of package");
>   > 755					i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &data);
>     756					atomic_set(&i2c_imx->slave_state, I2C_IMX_SLAVE_IDLE);
>     757					timeout	= HZ;
>     758				}
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
