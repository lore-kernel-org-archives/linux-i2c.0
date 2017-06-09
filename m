From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v10 5/6] i2c: designware: add SLAVE mode functions
Date: Fri, 9 Jun 2017 14:57:13 +0800
Message-ID: <201706091426.kwfaxkBk%fengguang.wu@intel.com>
References: <434489944ec5de13e1ac4e8ad4ab161e22cb718c.1496942505.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21912 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdFIG5g (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Jun 2017 02:57:36 -0400
Content-Disposition: inline
In-Reply-To: <434489944ec5de13e1ac4e8ad4ab161e22cb718c.1496942505.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
Cc: kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luis,

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.12-rc4 next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Luis-Oliveira/i2c-designware-add-I2C-SLAVE-support/20170609-143533
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: x86_64-randconfig-x012-201723 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-designware-slave.c: In function 'i2c_dw_irq_handler_slave':
>> drivers/i2c/busses/i2c-designware-slave.c:285:3: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
      i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
      ^~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-designware-slave.c:285:31: error: 'I2C_SLAVE_WRITE_REQUESTED' undeclared (first use in this function)
      i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-designware-slave.c:285:31: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/i2c/busses/i2c-designware-slave.c:293:9: error: 'I2C_SLAVE_WRITE_RECEIVED' undeclared (first use in this function)
            I2C_SLAVE_WRITE_RECEIVED, &val)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-designware-slave.c:305:8: error: 'I2C_SLAVE_READ_REQUESTED' undeclared (first use in this function)
           I2C_SLAVE_READ_REQUESTED, &val))
           ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-designware-slave.c:311:36: error: 'I2C_SLAVE_READ_PROCESSED' undeclared (first use in this function)
      if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED,
                                       ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-designware-slave.c:315:31: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)
      i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
                                  ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-designware-slave.c: At top level:
>> drivers/i2c/busses/i2c-designware-slave.c:351:2: error: unknown field 'reg_slave' specified in initializer
     .reg_slave = i2c_dw_reg_slave,
     ^
>> drivers/i2c/busses/i2c-designware-slave.c:351:15: warning: excess elements in struct initializer
     .reg_slave = i2c_dw_reg_slave,
                  ^~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-designware-slave.c:351:15: note: (near initialization for 'i2c_dw_algo')
>> drivers/i2c/busses/i2c-designware-slave.c:352:2: error: unknown field 'unreg_slave' specified in initializer
     .unreg_slave = i2c_dw_unreg_slave,
     ^
   drivers/i2c/busses/i2c-designware-slave.c:352:17: warning: excess elements in struct initializer
     .unreg_slave = i2c_dw_unreg_slave,
                    ^~~~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-designware-slave.c:352:17: note: (near initialization for 'i2c_dw_algo')
   cc1: some warnings being treated as errors

vim +/i2c_slave_event +285 drivers/i2c/busses/i2c-designware-slave.c

   279		dev_dbg(dev->dev,
   280			"%#x STAUTS SLAVE_ACTTVITY=%#x : RAW_INTR_STAT=%#x"
   281			" : INTR_STAT=%#x\n",
   282			enabled, slave_activity, raw_stat, stat);
   283	
   284		if ((stat & DW_IC_INTR_RX_FULL) && (stat & DW_IC_INTR_STOP_DET))
 > 285			i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
   286	
   287		if (stat & DW_IC_INTR_RD_REQ) {
   288			if (slave_activity) {
   289				if (stat & DW_IC_INTR_RX_FULL) {
   290				    val = dw_readl(dev, DW_IC_DATA_CMD);
   291	
   292					if (!i2c_slave_event(dev->slave,
 > 293					    I2C_SLAVE_WRITE_RECEIVED, &val)) {
   294						dev_vdbg(dev->dev, "Byte %X acked!",
   295						val);
   296						}
   297					dw_readl(dev, DW_IC_CLR_RD_REQ);
   298					stat = i2c_dw_read_clear_intrbits_slave(dev);
   299				} else {
   300					dw_readl(dev, DW_IC_CLR_RD_REQ);
   301					dw_readl(dev, DW_IC_CLR_RX_UNDER);
   302					stat = i2c_dw_read_clear_intrbits_slave(dev);
   303				}
   304				if (!i2c_slave_event(dev->slave,
 > 305				    I2C_SLAVE_READ_REQUESTED, &val))
   306					dw_writel(dev, val, DW_IC_DATA_CMD);
   307			}
   308		}
   309	
   310		if (stat & DW_IC_INTR_RX_DONE) {
 > 311			if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED,
   312			    &val))
   313				dw_readl(dev, DW_IC_CLR_RX_DONE);
   314	
 > 315			i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
   316			stat = i2c_dw_read_clear_intrbits_slave(dev);
   317			return 1;
   318		}
   319	
   320		if (stat & DW_IC_INTR_RX_FULL) {
   321			val = dw_readl(dev, DW_IC_DATA_CMD);
   322			if (!i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
   323				&val))
   324				dev_vdbg(dev->dev, "Byte %X acked!", val);
   325		} else {
   326			i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
   327			stat = i2c_dw_read_clear_intrbits_slave(dev);
   328		}
   329	
   330		//~ if (stat & DW_IC_INTR_TX_OVER)
   331			//~ dw_readl(dev, DW_IC_CLR_TX_OVER);
   332	
   333		return 1;
   334	}
   335	
   336	static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
   337	{
   338		struct dw_i2c_dev *dev = dev_id;
   339		int ret;
   340	
   341		i2c_dw_read_clear_intrbits_slave(dev);
   342		ret = i2c_dw_irq_handler_slave(dev);
   343		if (ret > 0)
   344			complete(&dev->cmd_complete);
   345	
   346		return IRQ_RETVAL(ret);
   347	}
   348	
   349	static struct i2c_algorithm i2c_dw_algo = {
   350		.functionality = i2c_dw_func,
 > 351		.reg_slave = i2c_dw_reg_slave,
 > 352		.unreg_slave = i2c_dw_unreg_slave,
   353	};
   354	
   355	int i2c_dw_probe_slave(struct dw_i2c_dev *dev)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
orcK3upws/8BZxFZ9p02AQA=

--LQksG6bCIzRHxTLp--
