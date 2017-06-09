From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 5/6] i2c: designware: add SLAVE mode functions
Date: Fri, 09 Jun 2017 11:53:52 +0300
Message-ID: <1496998432.22624.70.camel@linux.intel.com>
References: <201706091426.kwfaxkBk%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201706091426.kwfaxkBk%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: kbuild-all@01.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Fri, 2017-06-09 at 14:57 +0800, kbuild test robot wrote:
> Hi Luis,
> 

Luis, it seems you didn't rebase your patches against Wolfram's i2c-next 
tree.

Please, rebase and retest.

> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.12-rc4 next-20170608]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Luis-Oliveira/i2c-des
> ignware-add-I2C-SLAVE-support/20170609-143533
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> i2c/for-next
> config: x86_64-randconfig-x012-201723 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/i2c/busses/i2c-designware-slave.c: In function
> 'i2c_dw_irq_handler_slave':
> > > drivers/i2c/busses/i2c-designware-slave.c:285:3: error: implicit
> > > declaration of function 'i2c_slave_event' [-Werror=implicit-
> > > function-declaration]
> 
>       i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
>       ^~~~~~~~~~~~~~~
> > > drivers/i2c/busses/i2c-designware-slave.c:285:31: error:
> > > 'I2C_SLAVE_WRITE_REQUESTED' undeclared (first use in this
> > > function)
> 
>       i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/i2c/busses/i2c-designware-slave.c:285:31: note: each
> undeclared identifier is reported only once for each function it
> appears in
> > > drivers/i2c/busses/i2c-designware-slave.c:293:9: error:
> > > 'I2C_SLAVE_WRITE_RECEIVED' undeclared (first use in this function)
> 
>             I2C_SLAVE_WRITE_RECEIVED, &val)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/i2c/busses/i2c-designware-slave.c:305:8: error:
> > > 'I2C_SLAVE_READ_REQUESTED' undeclared (first use in this function)
> 
>            I2C_SLAVE_READ_REQUESTED, &val))
>            ^~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/i2c/busses/i2c-designware-slave.c:311:36: error:
> > > 'I2C_SLAVE_READ_PROCESSED' undeclared (first use in this function)
> 
>       if (!i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED,
>                                        ^~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/i2c/busses/i2c-designware-slave.c:315:31: error:
> > > 'I2C_SLAVE_STOP' undeclared (first use in this function)
> 
>       i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
>                                   ^~~~~~~~~~~~~~
>    drivers/i2c/busses/i2c-designware-slave.c: At top level:
> > > drivers/i2c/busses/i2c-designware-slave.c:351:2: error: unknown
> > > field 'reg_slave' specified in initializer
> 
>      .reg_slave = i2c_dw_reg_slave,
>      ^
> > > drivers/i2c/busses/i2c-designware-slave.c:351:15: warning: excess
> > > elements in struct initializer
> 
>      .reg_slave = i2c_dw_reg_slave,
>                   ^~~~~~~~~~~~~~~~
>    drivers/i2c/busses/i2c-designware-slave.c:351:15: note: (near
> initialization for 'i2c_dw_algo')
> > > drivers/i2c/busses/i2c-designware-slave.c:352:2: error: unknown
> > > field 'unreg_slave' specified in initializer
> 
>      .unreg_slave = i2c_dw_unreg_slave,
>      ^
>    drivers/i2c/busses/i2c-designware-slave.c:352:17: warning: excess
> elements in struct initializer
>      .unreg_slave = i2c_dw_unreg_slave,
>                     ^~~~~~~~~~~~~~~~~~
>    drivers/i2c/busses/i2c-designware-slave.c:352:17: note: (near
> initialization for 'i2c_dw_algo')
>    cc1: some warnings being treated as errors
> 
> vim +/i2c_slave_event +285 drivers/i2c/busses/i2c-designware-slave.c
> 
>    279		dev_dbg(dev->dev,
>    280			"%#x STAUTS SLAVE_ACTTVITY=%#x :
> RAW_INTR_STAT=%#x"
>    281			" : INTR_STAT=%#x\n",
>    282			enabled, slave_activity, raw_stat,
> stat);
>    283	
>    284		if ((stat & DW_IC_INTR_RX_FULL) && (stat &
> DW_IC_INTR_STOP_DET))
>  > 285			i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_REQUESTED, &val);
>    286	
>    287		if (stat & DW_IC_INTR_RD_REQ) {
>    288			if (slave_activity) {
>    289				if (stat & DW_IC_INTR_RX_FULL) {
>    290				    val = dw_readl(dev,
> DW_IC_DATA_CMD);
>    291	
>    292					if
> (!i2c_slave_event(dev->slave,
>  > 293					    I2C_SLAVE_WRITE_RECE
> IVED, &val)) {
>    294						dev_vdbg(dev-
> >dev, "Byte %X acked!",
>    295						val);
>    296						}
>    297					dw_readl(dev,
> DW_IC_CLR_RD_REQ);
>    298					stat =
> i2c_dw_read_clear_intrbits_slave(dev);
>    299				} else {
>    300					dw_readl(dev,
> DW_IC_CLR_RD_REQ);
>    301					dw_readl(dev,
> DW_IC_CLR_RX_UNDER);
>    302					stat =
> i2c_dw_read_clear_intrbits_slave(dev);
>    303				}
>    304				if (!i2c_slave_event(dev->slave,
>  > 305				    I2C_SLAVE_READ_REQUESTED,
> &val))
>    306					dw_writel(dev, val,
> DW_IC_DATA_CMD);
>    307			}
>    308		}
>    309	
>    310		if (stat & DW_IC_INTR_RX_DONE) {
>  > 311			if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_READ_PROCESSED,
>    312			    &val))
>    313				dw_readl(dev,
> DW_IC_CLR_RX_DONE);
>    314	
>  > 315			i2c_slave_event(dev->slave,
> I2C_SLAVE_STOP, &val);
>    316			stat =
> i2c_dw_read_clear_intrbits_slave(dev);
>    317			return 1;
>    318		}
>    319	
>    320		if (stat & DW_IC_INTR_RX_FULL) {
>    321			val = dw_readl(dev, DW_IC_DATA_CMD);
>    322			if (!i2c_slave_event(dev->slave,
> I2C_SLAVE_WRITE_RECEIVED,
>    323				&val))
>    324				dev_vdbg(dev->dev, "Byte %X
> acked!", val);
>    325		} else {
>    326			i2c_slave_event(dev->slave,
> I2C_SLAVE_STOP, &val);
>    327			stat =
> i2c_dw_read_clear_intrbits_slave(dev);
>    328		}
>    329	
>    330		//~ if (stat & DW_IC_INTR_TX_OVER)
>    331			//~ dw_readl(dev, DW_IC_CLR_TX_OVER);
>    332	
>    333		return 1;
>    334	}
>    335	
>    336	static irqreturn_t i2c_dw_isr_slave(int this_irq, void
> *dev_id)
>    337	{
>    338		struct dw_i2c_dev *dev = dev_id;
>    339		int ret;
>    340	
>    341		i2c_dw_read_clear_intrbits_slave(dev);
>    342		ret = i2c_dw_irq_handler_slave(dev);
>    343		if (ret > 0)
>    344			complete(&dev->cmd_complete);
>    345	
>    346		return IRQ_RETVAL(ret);
>    347	}
>    348	
>    349	static struct i2c_algorithm i2c_dw_algo = {
>    350		.functionality = i2c_dw_func,
>  > 351		.reg_slave = i2c_dw_reg_slave,
>  > 352		.unreg_slave = i2c_dw_unreg_slave,
>    353	};
>    354	
>    355	int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
