From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1 1/3] i3c: master: Add a driver for Qualcomm GENI I3C master IP
Date: Thu, 09 Aug 2018 08:18:10 -0700
Message-ID: <153382789086.220756.18206801803605161314@swboyd.mtv.corp.google.com>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
 <1533101942-29442-2-git-send-email-mshettel@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533101942-29442-2-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: Mike Shettel <mshettel@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, dianders@chromium.org, mka@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-i2c@vger.kernel.org

Quoting Mike Shettel (2018-07-31 22:39:00)
> Signed-off-by: Mike Shettel <mshettel@codeaurora.org>

Some commit text please.

> ---
> This patch is to be applied on top of the I3C subsystem patchset v6.
>  drivers/i3c/master/Kconfig                |   13 +
>  drivers/i3c/master/Makefile               |    1 +
>  drivers/i3c/master/i3c-master-qcom-geni.c | 1243 +++++++++++++++++++++++=
++++++
>  3 files changed, 1257 insertions(+)
>  create mode 100644 drivers/i3c/master/i3c-master-qcom-geni.c
> =

> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 56b9a18..18ca523 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -3,3 +3,16 @@ config CDNS_I3C_MASTER
>         depends on I3C
>         help
>           Enable this driver if you want to support Cadence I3C master bl=
ock.
> +
> +config I3C_MASTER_QCOM_GENI
> +       tristate "Qualcomm Technologies Inc GENI based I3C master"
> +       depends on ARCH_QCOM
> +    depends on I3C

This line is incorrectly indented.

> +       help
> +         If you say yes to this option, support will be included for the
> +         built-in I3C interface on the Qualcomm Technologies Inc SoCs.

Drop 'built-in' because everything is built-in to the SoC.

> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i3c-master-qcom-geni
> +
> +
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index 4c4304a..5d084a9 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_CDNS_I3C_MASTER)          +=3D i3c-master-cdns.o
> +obj-$(CONFIG_I3C_MASTER_QCOM_GENI)     +=3D i3c-master-qcom-geni.o
> diff --git a/drivers/i3c/master/i3c-master-qcom-geni.c b/drivers/i3c/mast=
er/i3c-master-qcom-geni.c
> new file mode 100644
> index 0000000..dfbc257
> --- /dev/null
> +++ b/drivers/i3c/master/i3c-master-qcom-geni.c
> @@ -0,0 +1,1243 @@
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/qcom-geni-se.h>
> +
> +#define SE_I3C_SCL_HIGH                 0x268
> +#define SE_I3C_TX_TRANS_LEN             0x26C
> +#define SE_I3C_RX_TRANS_LEN             0x270
> +#define SE_I3C_DELAY_COUNTER            0x274
> +#define SE_I2C_SCL_COUNTERS             0x278
> +#define SE_I3C_SCL_CYCLE                0x27C
> +#define SE_GENI_HW_IRQ_EN               0x920
> +#define SE_GENI_HW_IRQ_IGNORE_ON_ACTIVE 0x924
> +#define SE_GENI_HW_IRQ_CMD_PARAM_0      0x930
> +
> +/* SE_GENI_M_CLK_CFG field shifts */
> +#define CLK_DEV_VALUE_SHFT 4
> +#define SER_CLK_EN_SHFT 0
> +
> +/* SE_GENI_HW_IRQ_CMD_PARAM_0 field shifts */
> +#define M_IBI_IRQ_PARAM_7E_SHFT 0
> +#define M_IBI_IRQ_PARAM_STOP_STALL_SHFT 1
> +
> +/* SE_I2C_SCL_COUNTERS field shifts */
> +#define I2C_SCL_HIGH_COUNTER_SHFT  20
> +#define I2C_SCL_LOW_COUNTER_SHFT   10
> +
> +#define SE_I3C_ERR  (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE=
_EN |\
> +       M_CMD_ABORT_EN | M_GP_IRQ_0_EN | M_GP_IRQ_1_EN | M_GP_IRQ_2_EN | \
> +       M_GP_IRQ_3_EN | M_GP_IRQ_4_EN)
> +
> +/* M_CMD OP codes for I2C/I3C */
> +#define I3C_READ_IBI_HW          0
> +#define I2C_WRITE                1
> +#define I2C_READ                 2
> +#define I2C_WRITE_READ           3
> +#define I2C_ADDR_ONLY            4
> +#define I3C_INBAND_RESET         5
> +#define I2C_BUS_CLEAR            6
> +#define I2C_STOP_ON_BUS          7
> +#define I3C_HDR_DDR_EXIT         8
> +#define I3C_PRIVATE_WRITE        9
> +#define I3C_PRIVATE_READ         10
> +#define I3C_HDR_DDR_WRITE        11
> +#define I3C_HDR_DDR_READ         12
> +#define I3C_DIRECT_CCC_ADDR_ONLY 13
> +#define I3C_BCAST_CCC_ADDR_ONLY  14
> +#define I3C_READ_IBI             15
> +#define I3C_BCAST_CCC_WRITE      16
> +#define I3C_DIRECT_CCC_WRITE     17
> +#define I3C_DIRECT_CCC_READ      18
> +/* M_CMD params for I3C */
> +#define PRE_CMD_DELAY          BIT(0)
> +#define TIMESTAMP_BEFORE       BIT(1)
> +#define STOP_STRETCH           BIT(2)
> +#define TIMESTAMP_AFTER        BIT(3)
> +#define POST_COMMAND_DELAY     BIT(4)
> +#define IGNORE_ADD_NACK        BIT(6)
> +#define READ_FINISHED_WITH_ACK BIT(7)
> +#define CONTINUOUS_MODE_DAA    BIT(8)
> +#define SLV_ADDR_MSK           GENMASK(15, 9)
> +#define SLV_ADDR_SHFT          9
> +#define CCC_HDR_CMD_MSK        GENMASK(23, 16)
> +#define CCC_HDR_CMD_SHFT       16
> +#define IBI_NACK_TBL_CTRL      BIT(24)
> +#define USE_7E                 BIT(25)
> +#define BYPASS_ADDR_PHASE      BIT(26)
> +
> +enum geni_i3c_err_code {
> +       RD_TERM,
> +       NACK,
> +       CRC_ERR,
> +       BUS_PROTO,
> +       NACK_7E,
> +       NACK_IBI,
> +       GENI_OVERRUN,
> +       GENI_ILLEGAL_CMD,
> +       GENI_ABORT_DONE,
> +       GENI_TIMEOUT,
> +};
> +
> +#define DM_I3C_CB_ERR   ((BIT(NACK) | BIT(BUS_PROTO) | BIT(NACK_7E)) << =
5)
> +
> +#define I3C_AUTO_SUSPEND_DELAY  250
> +#define KHZ(freq)               (1000 * freq)
> +#define PACKING_BYTES_PW        4
> +#define XFER_TIMEOUT            HZ
> +#define DFS_INDEX_MAX           7
> +
> +#define I3C_DDR_READ_CMD BIT(7)
> +
> +#define I3C_ADDR_MASK 0x7f
> +
> +enum i3c_trans_dir {
> +       WRITE_TRANSACTION =3D 0,
> +       READ_TRANSACTION =3D 1
> +};
> +
> +struct geni_i3c_dev {
> +       struct geni_se se;
> +       unsigned int tx_wm;
> +       int irq;
> +       int err;
> +       struct i3c_master_controller ctrlr;
> +       struct completion done;
> +       struct mutex lock;
> +       spinlock_t spinlock;
> +       u32 clk_src_freq;
> +       u32 dfs_idx;
> +       u8 *cur_buf;
> +       enum i3c_trans_dir cur_rnw;
> +       int cur_len;
> +       int cur_idx;
> +       unsigned long newaddrslots[(I3C_ADDR_MASK + 1) / BITS_PER_LONG];
> +       const struct geni_i3c_clk_fld *clk_fld;
> +};
> +
> +struct geni_i3c_i2c_dev_data {
> +       u32 dummy;  /* placeholder for now, later will hold IBI informati=
on */
> +};
> +
> +
> +struct i3c_xfer_params {
> +       enum geni_se_xfer_mode mode;
> +       u32 m_cmd;
> +       u32 m_param;
> +};
> +
> +static inline struct geni_i3c_dev*
> +to_geni_i3c_master(struct i3c_master_controller *master)
> +{
> +       return container_of(master, struct geni_i3c_dev, ctrlr);
> +}
> +
> +struct geni_i3c_err_log {
> +       int err;
> +       const char *msg;
> +};
> +
> +static struct geni_i3c_err_log gi3c_log[] =3D {

const?

> +       [RD_TERM] =3D { -EINVAL, "I3C slave early read termination" },
> +       [NACK] =3D { -ENOTCONN, "NACK: slave unresponsive, check power/re=
set" },
> +       [CRC_ERR] =3D { -EINVAL, "CRC or parity error" },
> +       [BUS_PROTO] =3D { -EPROTO, "Bus proto err, noisy/unexpected start=
/stop" },
> +       [NACK_7E] =3D { -EBUSY, "NACK on 7E, unexpected protocol error" },
> +       [NACK_IBI] =3D { -EINVAL, "NACK on IBI" },
> +       [GENI_OVERRUN] =3D { -EIO, "Cmd overrun, check GENI cmd-state mac=
hine" },
> +       [GENI_ILLEGAL_CMD] =3D { -EILSEQ,
> +                               "Illegal cmd, check GENI cmd-state machin=
e" },
> +       [GENI_ABORT_DONE] =3D { -ETIMEDOUT, "Abort after timeout successf=
ul" },
> +       [GENI_TIMEOUT] =3D { -ETIMEDOUT, "I3C transaction timed out" },
> +};
> +
> +struct geni_i3c_clk_fld {
> +       u32 clk_freq_out;
> +       u32 clk_src_freq;
> +       u8  clk_div;
> +       u8  i2c_t_high_cnt;
> +       u8  i2c_t_low_cnt;
> +       u8  i2c_t_cycle_cnt;
> +       u8  i3c_t_high_cnt;
> +       u8  i3c_t_cycle_cnt;
> +};
> +
> +/*
> + * Hardware uses the underlying formula to calculate time periods of
> + * SCL clock cycle. Firmware uses some additional cycles excluded from t=
he
> + * below formula and it is confirmed that the time periods are within
> + * specification limits.
> + *
> + * time of high period of I2C SCL:
> + *         i2c_t_high =3D (i2c_t_high_cnt * clk_div) / source_clock
> + * time of low period of I2C SCL:
> + *         i2c_t_low =3D (i2c_t_low_cnt * clk_div) / source_clock
> + * time of full period of I2C SCL:
> + *         i2c_t_cycle =3D (i2c_t_cycle_cnt * clk_div) / source_clock
> + * time of high period of I3C SCL:
> + *         i3c_t_high =3D (i3c_t_high_cnt * clk_div) / source_clock
> + * time of full period of I3C SCL:
> + *         i3c_t_cycle =3D (i3c_t_cycle_cnt * clk_div) / source_clock
> + * clk_freq_out =3D t / t_cycle
> + */
> +static const struct geni_i3c_clk_fld geni_i3c_clk_map[] =3D {
> +       { KHZ(100),    19200, 7, 10, 11, 26, 0, 0 },
> +       { KHZ(400),    19200, 2,  5, 12, 24, 0, 0 },
> +       { KHZ(1000),   19200, 1,  3,  9, 18, 0, 0 },
> +       { KHZ(12500), 100000, 1, 60, 140, 250, 8, 16 },
> +};
> +
> +static int geni_i3c_clk_map_idx(struct geni_i3c_dev *gi3c)
> +{
> +       int i;
> +       const struct geni_i3c_clk_fld *itr =3D geni_i3c_clk_map;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(geni_i3c_clk_map); i++, itr++) {
> +               if ((!gi3c->ctrlr.bus ||
> +                        itr->clk_freq_out =3D=3D gi3c->ctrlr.bus->scl_ra=
te.i3c) &&
> +                        KHZ(itr->clk_src_freq) =3D=3D gi3c->clk_src_freq=
) {
> +                       gi3c->clk_fld =3D itr;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static void set_new_addr_slot(unsigned long *addrslot, u8 addr)
> +{
> +       unsigned long *ptr;
> +
> +       if (addr > I3C_ADDR_MASK)
> +               return;
> +
> +       ptr =3D addrslot + (addr / BITS_PER_LONG);
> +       *ptr |=3D 1 << (addr % BITS_PER_LONG);
> +}
> +
> +static void clear_new_addr_slot(unsigned long *addrslot, u8 addr)
> +{
> +       unsigned long *ptr;
> +
> +       if (addr > I3C_ADDR_MASK)
> +               return;
> +
> +       ptr =3D addrslot + (addr / BITS_PER_LONG);
> +       *ptr &=3D ~(1 << (addr % BITS_PER_LONG));
> +}
> +
> +static bool is_new_addr_slot_set(unsigned long *addrslot, u8 addr)
> +{
> +       unsigned long *ptr;
> +
> +       if (addr > I3C_ADDR_MASK)
> +               return false;
> +
> +       ptr =3D addrslot + (addr / BITS_PER_LONG);
> +       return ((*ptr & (1 << (addr % BITS_PER_LONG))) !=3D 0);
> +}

These look generic, almost like they should go into the i3c driver core.

> +
> +
> +static int i3c_geni_execute_read_command
> +(
> +       struct geni_i3c_dev *gi3c,
> +       struct i3c_xfer_params *xfer,
> +       u8 *buf,
> +       u32 len
> +)

This is not kernel style. Please run checkpatch and look at
other code/documentation on how to write proper style.

> +{
> +       gi3c->cur_rnw =3D READ_TRANSACTION;
> +       gi3c->cur_buf =3D buf;
> +       gi3c->cur_len =3D len;
> +       return _i3c_geni_execute_command(gi3c, xfer);
> +}
> +
> +static int i3c_geni_execute_write_command
> +(
> +       struct geni_i3c_dev *gi3c,
> +       struct i3c_xfer_params *xfer,
> +       u8 *buf,
> +       u32 len
> +)
> +{
> +       gi3c->cur_rnw =3D WRITE_TRANSACTION;
> +       gi3c->cur_buf =3D buf;
> +       gi3c->cur_len =3D len;
> +       return _i3c_geni_execute_command(gi3c, xfer);
> +}
> +
> +static void geni_i3c_perform_daa(struct geni_i3c_dev *gi3c)
> +{
> +       u8 last_dyn_addr =3D 0;
> +       int ret;
> +
> +       while (1) {
> +               u8 rx_buf[8], tx_buf[8];
> +               struct i3c_xfer_params xfer =3D { GENI_SE_FIFO };
> +               struct i3c_device_info info =3D { 0 };
> +               struct i3c_dev_desc *i3cdev;
> +               bool new_device =3D true;
> +               u64 pid;
> +               u8 bcr, dcr, addr;
> +
> +               dev_dbg(gi3c->se.dev, "i3c entdaa read\n");
> +
> +               xfer.m_cmd =3D I2C_READ;
> +               xfer.m_param =3D STOP_STRETCH | CONTINUOUS_MODE_DAA | USE=
_7E;
> +
> +               ret =3D i3c_geni_execute_read_command(gi3c, &xfer, rx_buf=
, 8);
> +               if (ret)
> +                       break;
> +
> +               dcr =3D rx_buf[7];
> +               bcr =3D rx_buf[6];
> +               pid =3D ((u64)rx_buf[0] << 40) |
> +                       ((u64)rx_buf[1] << 32) |
> +                       ((u64)rx_buf[2] << 24) |
> +                       ((u64)rx_buf[3] << 16) |
> +                       ((u64)rx_buf[4] <<  8) |
> +                       ((u64)rx_buf[5]);
> +
> +               i3c_bus_for_each_i3cdev(gi3c->ctrlr.bus, i3cdev) {
> +                       i3c_device_get_info(i3cdev->dev, &info);
> +                       if (pid =3D=3D info.pid &&
> +                               dcr =3D=3D info.dcr &&
> +                               bcr =3D=3D info.bcr) {
> +                               new_device =3D false;
> +                               addr =3D (info.dyn_addr) ? info.dyn_addr :

Drop useless parenthesis.

> +                                       info.static_addr;
> +                               break;
> +                       }
> +               }
> +
> +               if (new_device) {
> +                       ret =3D i3c_master_get_free_addr(&gi3c->ctrlr,
> +                                               last_dyn_addr + 1);
> +                       if (ret < 0)
> +                               goto daa_err;
> +                       addr =3D last_dyn_addr =3D (u8)ret;
> +                       set_new_addr_slot(gi3c->newaddrslots, addr);
> +               }
> +
> +               tx_buf[0] =3D (addr & I3C_ADDR_MASK) << 1;
> +               tx_buf[0] |=3D ~(hweight8(addr & I3C_ADDR_MASK) & 1);
> +
> +               dev_dbg(gi3c->se.dev, "i3c entdaa write\n");
> +
> +               xfer.m_cmd =3D I2C_WRITE;
> +               xfer.m_param =3D STOP_STRETCH | BYPASS_ADDR_PHASE | USE_7=
E;
> +
> +               ret =3D i3c_geni_execute_write_command(gi3c, &xfer, tx_bu=
f, 1);
> +               if (ret)
> +                       break;
> +       }
> +daa_err:

Drop the label and just return wherever goto is.

> +       return;
> +}
> +
> +static int geni_i3c_master_send_ccc_cmd
> +(
> +       struct i3c_master_controller *m,
> +       struct i3c_ccc_cmd *cmd
> +)
> +{
> +       struct geni_i3c_dev *gi3c =3D to_geni_i3c_master(m);
> +       int i, ret;
> +
> +       if (!(cmd->id & I3C_CCC_DIRECT) && (cmd->ndests !=3D 1))
> +               return -1;
> +
> +       ret =3D i3c_geni_runtime_get_mutex_lock(gi3c);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < cmd->ndests; i++) {
> +               int stall =3D (i < (cmd->ndests - 1)) ||
> +                       (cmd->id =3D=3D I3C_CCC_ENTDAA);
> +               struct i3c_xfer_params xfer =3D { GENI_SE_FIFO };
> +
> +               xfer.m_param  =3D (stall ? STOP_STRETCH : 0);
> +               xfer.m_param |=3D (cmd->id << CCC_HDR_CMD_SHFT);

So many useless parenthesis.

> +               xfer.m_param |=3D IBI_NACK_TBL_CTRL;
> +               if (cmd->id & I3C_CCC_DIRECT) {
> +                       xfer.m_param |=3D ((cmd->dests[i].addr & I3C_ADDR=
_MASK)
> +                                       << SLV_ADDR_SHFT);
> +                       if (cmd->rnw) {
[..]
> +}
> +
> +static int geni_i3c_master_priv_xfers
> +(
> +       struct i3c_dev_desc *dev,
> +       struct i3c_priv_xfer *xfers,
> +       int nxfers
> +)
> +{
> +       struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
> +       struct geni_i3c_dev *gi3c =3D to_geni_i3c_master(m);
> +       int i, ret;
> +       bool use_7e =3D true;
> +
> +       if (nxfers <=3D 0)
> +               return 0;
> +
> +       ret =3D i3c_geni_runtime_get_mutex_lock(gi3c);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < nxfers; i++) {
> +               bool stall =3D (i < (nxfers - 1));
> +               struct i3c_xfer_params xfer =3D { GENI_SE_FIFO };
> +
> +               xfer.m_param  =3D (stall ? STOP_STRETCH : 0);
> +               xfer.m_param |=3D ((dev->info.dyn_addr & I3C_ADDR_MASK)
> +                               << SLV_ADDR_SHFT);
> +               xfer.m_param |=3D (use_7e) ? USE_7E : 0;
> +
> +               /* Update use_7e status for next loop iteration */

That's obvious from reading the code, but why do it at all? That's what
the comment should say.

> +               use_7e =3D !stall;
> +
> +               if (xfers[i].rnw) {
> +                       xfer.m_cmd =3D I3C_PRIVATE_READ;
> +                       ret =3D i3c_geni_execute_read_command(gi3c, &xfer,
> +                               (u8 *)xfers[i].data.in,
> +                               xfers[i].len);
> +               } else {
> +                       xfer.m_cmd =3D I3C_PRIVATE_WRITE;
> +                       ret =3D i3c_geni_execute_write_command(gi3c, &xfe=
r,
> +                               (u8 *)xfers[i].data.out,
> +                               xfers[i].len);
> +               }
> +
> +               if (ret)
> +                       break;
> +       }
> +
> +       dev_dbg(gi3c->se.dev, "i3c priv: txn ret:%d\n", ret);
> +
> +       i3c_geni_runtime_put_mutex_unlock(gi3c);
> +
> +       return ret;
> +}
[..]
> +
> +static int geni_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +       struct i3c_master_controller *m =3D i2c_dev_get_master(dev);
> +       struct geni_i3c_dev *gi3c =3D to_geni_i3c_master(m);
> +       struct geni_i3c_i2c_dev_data *data;
> +
> +       data =3D devm_kzalloc(gi3c->se.dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       memset(data, 0, sizeof(*data));

Useless memset, kzalloc already did this.

> +
> +       i2c_dev_set_master_data(dev, data);
> +
> +       return 0;
> +}
> +
> +
[...]
> +
> +static bool geni_i3c_master_supports_ccc_cmd
> +(
> +       struct i3c_master_controller *m,
> +       const struct i3c_ccc_cmd *cmd
> +)
> +{
> +       switch (cmd->id) {
> +       case I3C_CCC_ENEC(true):
> +       /* fallthrough */

Please remove all the fallthrough comments.

> +       case I3C_CCC_ENEC(false):
> +       /* fallthrough */
> +       case I3C_CCC_DISEC(true):
> +       /* fallthrough */
> +       case I3C_CCC_DISEC(false):
> +       /* fallthrough */
> +       case I3C_CCC_ENTAS(0, true):
> +       /* fallthrough */
> +       case I3C_CCC_ENTAS(0, false):
> +       /* fallthrough */
> +       case I3C_CCC_RSTDAA(true):
> +       /* fallthrough */
> +       case I3C_CCC_RSTDAA(false):
> +       /* fallthrough */
> +       case I3C_CCC_ENTDAA:
> +       /* fallthrough */
> +       case I3C_CCC_SETMWL(true):
> +       /* fallthrough */
> +       case I3C_CCC_SETMWL(false):
> +       /* fallthrough */
> +       case I3C_CCC_SETMRL(true):
> +       /* fallthrough */
> +       case I3C_CCC_SETMRL(false):
> +       /* fallthrough */
> +       case I3C_CCC_DEFSLVS:
> +       /* fallthrough */
> +       case I3C_CCC_ENTHDR(0):
> +       /* fallthrough */
> +       case I3C_CCC_SETDASA:
> +       /* fallthrough */
> +       case I3C_CCC_SETNEWDA:
> +       /* fallthrough */
> +       case I3C_CCC_GETMWL:
> +       /* fallthrough */
> +       case I3C_CCC_GETMRL:
> +       /* fallthrough */
> +       case I3C_CCC_GETPID:
> +       /* fallthrough */
> +       case I3C_CCC_GETBCR:
> +       /* fallthrough */
> +       case I3C_CCC_GETDCR:
> +       /* fallthrough */
> +       case I3C_CCC_GETSTATUS:
> +       /* fallthrough */
> +       case I3C_CCC_GETACCMST:
> +       /* fallthrough */
> +       case I3C_CCC_GETMXDS:
> +       /* fallthrough */
> +       case I3C_CCC_GETHDRCAP:
> +               return true;
> +       default:
> +               break;
> +       }
> +
> +       return false;
> +}
[...]
> +
> +static int geni_i3c_probe(struct platform_device *pdev)
> +{
> +       struct geni_i3c_dev *gi3c;
> +       struct resource *res;
> +       u32 proto, tx_depth;
> +       int ret;
> +
> +       gi3c =3D devm_kzalloc(&pdev->dev, sizeof(*gi3c), GFP_KERNEL);
> +       if (!gi3c)
> +               return -ENOMEM;
> +
> +       gi3c->se.dev =3D &pdev->dev;
> +       gi3c->se.wrapper =3D dev_get_drvdata(pdev->dev.parent);
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       gi3c->se.base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(gi3c->se.base))
> +               return PTR_ERR(gi3c->se.base);
> +
> +       gi3c->se.clk =3D devm_clk_get(&pdev->dev, "se");
> +       if (IS_ERR(gi3c->se.clk)) {
> +               ret =3D PTR_ERR(gi3c->se.clk);
> +               dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D device_property_read_u32(&pdev->dev, "se-clock-frequency",
> +               &gi3c->clk_src_freq);

Looks like it should be DT assigned clock rates. Otherwise, binding
should indicate unit of measurement (Hz presumably).

> +       if (ret) {
> +               dev_info(&pdev->dev,
> +                       "SE clk freq not specified, default to 100 MHz.\n=
");
> +               gi3c->clk_src_freq =3D 100000000;
> +       }
> +
> +
> +       ret =3D device_property_read_u32(&pdev->dev, "dfs-index",
> +               &gi3c->dfs_idx);
> +       if (ret)
> +               gi3c->dfs_idx =3D 0xf;
> +
> +       gi3c->irq =3D platform_get_irq(pdev, 0);
> +       if (gi3c->irq < 0) {
> +               dev_err(&pdev->dev, "IRQ error for i3c-master-geni\n");
> +               return gi3c->irq;
> +       }
> +
> +       ret =3D geni_i3c_clk_map_idx(gi3c);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Invalid source clk frequency %d Hz: =
%d\n",
> +                       gi3c->clk_src_freq, ret);
> +               return ret;
> +       }
> +
> +       init_completion(&gi3c->done);
> +       mutex_init(&gi3c->lock);
> +       spin_lock_init(&gi3c->spinlock);
> +       platform_set_drvdata(pdev, gi3c);
> +       ret =3D devm_request_irq(&pdev->dev, gi3c->irq, geni_i3c_irq,
> +               IRQF_TRIGGER_HIGH, dev_name(&pdev->dev), gi3c);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
> +                       gi3c->irq, ret);
> +               return ret;
> +       }
> +       /* Disable the interrupt so that the system can enter low-power m=
ode */
> +       disable_irq(gi3c->irq);

Why is this done? I'm also curious why it's done for the i2c driver.

> +
> +       ret =3D geni_se_resources_on(&gi3c->se);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Error turning on resources %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       proto =3D geni_se_read_proto(&gi3c->se);
> +       if (proto !=3D GENI_SE_I3C) {
> +               dev_err(&pdev->dev, "Invalid proto %d\n", proto);
> +               geni_se_resources_off(&gi3c->se);
> +               return -ENXIO;
> +       }
> +
> +       tx_depth =3D geni_se_get_tx_fifo_depth(&gi3c->se);
> +       gi3c->tx_wm =3D tx_depth - 1;
> +       geni_se_init(&gi3c->se, gi3c->tx_wm, tx_depth);
> +       geni_se_config_packing(&gi3c->se, BITS_PER_BYTE, PACKING_BYTES_PW,
> +               true, true, true);
> +       geni_se_resources_off(&gi3c->se);
> +       dev_dbg(&pdev->dev, "i3c fifo/se-dma mode. fifo depth:%d\n", tx_d=
epth);
> +
> +       pm_runtime_set_suspended(gi3c->se.dev);
> +       pm_runtime_set_autosuspend_delay(gi3c->se.dev, I3C_AUTO_SUSPEND_D=
ELAY);
> +       pm_runtime_use_autosuspend(gi3c->se.dev);
> +       pm_runtime_enable(gi3c->se.dev);
> +
> +       ret =3D i3c_master_register(&gi3c->ctrlr, &pdev->dev,
> +               &geni_i3c_master_ops, false);
> +
> +       if (ret)
> +               return ret;
> +
> +       dev_err(&pdev->dev, "I3C probed\n");

No.

> +       return ret;
> +}
> +
> +static int geni_i3c_remove(struct platform_device *pdev)
> +{
> +       struct geni_i3c_dev *gi3c =3D platform_get_drvdata(pdev);
> +       int ret =3D 0;
> +
> +       pm_runtime_disable(gi3c->se.dev);
> +       ret =3D i3c_master_unregister(&gi3c->ctrlr);
> +       return ret;
> +}
> +
