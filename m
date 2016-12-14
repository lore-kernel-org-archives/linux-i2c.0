From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [[RFC V3] 1/1] i2c: imx: add slave support
Date: Wed, 14 Dec 2016 15:30:04 +0200
Message-ID: <eee9e6a2-e4cc-cbe1-efd2-58686f051844@mentor.com>
References: <1481695291-11444-1-git-send-email-joshua_frkuska@mentor.com>
 <1481695291-11444-2-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:45285 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbcLNOTt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:19:49 -0500
In-Reply-To: <1481695291-11444-2-git-send-email-joshua_frkuska@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joshua Frkuska <joshua_frkuska@mentor.com>, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, syrchin@dev.rtsoft.ru, peda@axentia.se, Jiada_Wang@mentor.com

Hi Joshua,

please find review comments below, mainly stylistic ones.

On 12/14/2016 08:01 AM, Joshua Frkuska wrote:
> Add I2C slave provider using the generic slave interface.
> It also supports master transactions when the slave in the idle mode.
>
> Signed-off-by: Maxim Syrchin <msyrchin@dev.rtsoft.ru>
> Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>

should you preserve Maxim's authorship?

> ---
>  drivers/i2c/busses/i2c-imx.c | 724 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 694 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 47fc1f1..7b2aeb8 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -53,6 +53,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/kthread.h>

Please insert #include keeping the list alphabetically numbered.

>
>  /* This will be the driver name the kernel reports */
>  #define DRIVER_NAME "imx-i2c"
> @@ -60,6 +61,13 @@
>  /* Default value */
>  #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
>
> +/* Wait delays */
> +#define STATE_MIN_WAIT_TIME	1 /* 1 jiffy */
> +#define STATE_WAIT_TIME	(HZ / 10)
> +
> +#define MAX_EVENTS (1<<4)

checkpatch warnings:

CHECK: spaces preferred around that '<<' (ctx:VxV)
#35: FILE: drivers/i2c/busses/i2c-imx.c:68:
+#define MAX_EVENTS (1<<4)
                       ^

CHECK: Prefer using the BIT macro
#35: FILE: drivers/i2c/busses/i2c-imx.c:68:
+#define MAX_EVENTS (1<<4)

The second warning seems to be irrelevant, please fix the first one.

> +#define EUNDEFINED 4000

I would recommend to avoid introduction of new errnos, please use
one of the existing.

> +
>  /*
>   * Enable DMA if transfer byte size is bigger than this threshold.
>   * As the hardware request, it must bigger than 4 bytes.\
> @@ -171,6 +179,30 @@ enum imx_i2c_type {
>  	VF610_I2C,
>  };
>
> +enum i2c_imx_state {
> +	STATE_IDLE = 0,
> +	STATE_SLAVE,
> +	STATE_MASTER,
> +	STATE_SP
> +};
> +
> +enum i2c_imx_events {
> +	EVT_AL = 0,
> +	EVT_SI,
> +	EVT_START,
> +	EVT_STOP,
> +	EVT_POLL,
> +	EVT_INVALID,
> +	EVT_ENTRY
> +};
> +
> +struct evt_queue {
> +	atomic_t count;
> +	atomic_t ir;
> +	atomic_t iw;
> +	unsigned int evt[MAX_EVENTS];
> +};
> +
>  struct imx_i2c_hwdata {
>  	enum imx_i2c_type	devtype;
>  	unsigned		regshift;
> @@ -193,6 +225,7 @@ struct imx_i2c_dma {
>
>  struct imx_i2c_struct {
>  	struct i2c_adapter	adapter;
> +	struct i2c_client	*slave;
>  	struct clk		*clk;
>  	void __iomem		*base;
>  	wait_queue_head_t	queue;
> @@ -210,6 +243,18 @@ struct imx_i2c_struct {
>  	struct pinctrl_state *pinctrl_pins_gpio;
>
>  	struct imx_i2c_dma	*dma;
> +
> +	unsigned int		state;
> +	struct evt_queue	events;
> +	atomic_t		last_error;

Please replace 'last_error' type to 'int', this will require changes
in the code as well.

In general the usage of this variable is questionable, while
it can be set to 0, -EBUSY, -ETIMEDOUT, -EAGAIN and -EUNDEFINED,
from the code there are only two classes impact runtime behaviour:
-EUNDEFINED and anything else, I didn't notice the difference between
e.g. 0 and -EBUSY.

> +
> +	int			master_interrupt;
> +	int			start_retry_cnt;
> +	int			slave_poll_cnt;
> +
> +	struct task_struct	*slave_task;
> +	wait_queue_head_t	state_queue;
> +

Please drop the empty line above.

>  };
>
>  static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
> @@ -414,17 +459,29 @@ static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
>  static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
>  {
>  	unsigned long orig_jiffies = jiffies;
> -	unsigned int temp;
> +	unsigned int temp, ctl;
> +
>
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>
>  	while (1) {
>  		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +
> +		/*
> +		 *	Check for arbitration lost. Datasheet recommends to
> +		 *	clean IAL bit in interrupt handler before any other
> +		 *	action.
> +		 *
> +		 *	We can detect if controller resets MSTA bit, because
> +		 *	hardware is switched to slave mode if arbitration was
> +		 *	lost.
> +		 */
>
> -		/* check for arbitration lost */
> -		if (temp & I2SR_IAL) {
> -			temp &= ~I2SR_IAL;
> -			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> +		if (for_busy && !(ctl & I2CR_MSTA)) {
> +			dev_dbg(&i2c_imx->adapter.dev,
> +				"<%s> Lost arbitration (SR = %02x, CR = %02x)\n",
> +				__func__, temp, ctl);
>  			return -EAGAIN;
>  		}
>
> @@ -443,16 +500,501 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
>  	return 0;
>  }
>
> +#ifdef CONFIG_I2C_SLAVE
> +
> +static void i2c_imx_enable_i2c_controller(struct imx_i2c_struct *i2c_imx);
> +static void set_state(struct imx_i2c_struct *i2c_imx, unsigned int new);
> +static int i2c_imx_hw_start(struct imx_i2c_struct *i2c_imx);
> +static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx);
> +
> +static inline int evt_find_next_idx(atomic_t *v)
> +{
> +	return atomic_inc_return(v) & (MAX_EVENTS - 1);
> +}
> +
> +static unsigned int evt_put(struct evt_queue *stk, unsigned int evt)
> +{
> +	int count = atomic_inc_return(&stk->count);
> +	int idx;
> +
> +	if (count < MAX_EVENTS) {
> +		idx = evt_find_next_idx(&stk->iw);
> +		stk->evt[idx] = evt;
> +	} else {
> +		atomic_dec(&stk->count);
> +		return EVT_INVALID;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int evt_get(struct evt_queue *stk)
> +{
> +	int count = atomic_dec_return(&stk->count);
> +	int idx;
> +
> +	if (count >= 0) {
> +		idx = evt_find_next_idx(&stk->ir);
> +	} else {
> +		atomic_inc(&stk->count);
> +		return EVT_INVALID;
> +	}
> +
> +	return stk->evt[idx];
> +}
> +
> +static unsigned int evt_is_empty(struct evt_queue *stk)

static bool evt_is_empty()

> +{
> +	int ret = atomic_read(&stk->count);
> +
> +	return (ret <= 0);
> +}
> +
> +static void evt_init(struct evt_queue *stk)
> +{
> +	atomic_set(&stk->count, 0);
> +	atomic_set(&stk->iw, 0);
> +	atomic_set(&stk->ir, 0);
> +}
> +
> +

Please don't use multiple blank lines.

> +static void i2c_imx_clear_ial_bit(struct imx_i2c_struct *i2c_imx)
> +{
> +	unsigned int status;
> +
> +	status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +	status &= ~I2SR_IAL;
> +	imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR);
> +}
> +
> +static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
> +{
> +	unsigned int temp;
> +
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +
> +	i2c_imx_enable_i2c_controller(i2c_imx);
> +
> +	/* Set Slave mode with interrupt enable */
> +	temp = i2c_imx->hwdata->i2cr_ien_opcode | I2CR_IIEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +}
> +
> +

Please don't use multiple blank lines.

> +static void i2c_imx_slave_process_irq(struct imx_i2c_struct *i2c_imx)
> +{
> +	unsigned int status, ctl;
> +	u8 data;
> +
> +	status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +	ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +
> +	if (status & I2SR_IAAS) {
> +		if (status & I2SR_SRW) {
> +			/* master wants to read from us */
> +			i2c_slave_event(i2c_imx->slave,
> +				I2C_SLAVE_READ_REQUESTED, &data);

Alignment should match open parenthesis.

> +			ctl |= I2CR_MTX;
> +			imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> +
> +			/*send data */
> +			imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
> +		} else {
> +			dev_dbg(&i2c_imx->adapter.dev, "write requested");
> +			i2c_slave_event(i2c_imx->slave,
> +				I2C_SLAVE_WRITE_REQUESTED, &data);

Alignment should match open parenthesis.

> +			/*slave receive */
> +			ctl &= ~I2CR_MTX;
> +			imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> +
> +			/*dummy read */
> +			data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);

For dummy read there is no need to assign the result to 'data'.

> +		}
> +	} else {
> +		/* slave send */
> +		if (ctl & I2CR_MTX) {
> +			if (!(status & I2SR_RXAK)) {	/*ACK received */
> +				i2c_slave_event(i2c_imx->slave,
> +					I2C_SLAVE_READ_PROCESSED, &data);

Alignment should match open parenthesis.

> +				ctl |= I2CR_MTX;
> +				imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> +				/*send data */
> +				imx_i2c_write_reg(data, i2c_imx, IMX_I2C_I2DR);
> +			} else {
> +				/*no ACK. */
> +				/*dummy read */
> +				dev_dbg(&i2c_imx->adapter.dev, "read requested");
> +				i2c_slave_event(i2c_imx->slave,
> +					I2C_SLAVE_READ_REQUESTED, &data);

Alignment should match open parenthesis.

> +
> +				ctl &= ~I2CR_MTX;
> +				imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> +				imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +			}
> +		} else {	/*read */
> +			ctl &= ~I2CR_MTX;
> +			imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> +
> +			/*read */
> +			data = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +			dev_dbg(&i2c_imx->adapter.dev, "received %x",
> +				(unsigned int) data);

Cast is not needed here IMHO.

> +			i2c_slave_event(i2c_imx->slave,
> +				I2C_SLAVE_WRITE_RECEIVED, &data);

Alignment should match open parenthesis.

> +		}
> +	}
> +}
> +
> +

Please don't use multiple blank lines.

> +static int idle_evt_handler(struct imx_i2c_struct *i2c_imx, unsigned int event)
> +{
> +	u8 reg;
> +
> +	switch (event) {
> +	case EVT_ENTRY:
> +		imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
> +			i2c_imx, IMX_I2C_I2CR);

Alignment should match open parenthesis.

> +		i2c_imx_enable_i2c_controller(i2c_imx);
> +		imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode | I2CR_IIEN,
> +				 i2c_imx, IMX_I2C_I2CR);

Alignment should match open parenthesis.

> +		if (atomic_read(&i2c_imx->last_error) == -EUNDEFINED) {
> +			dev_dbg(&i2c_imx->adapter.dev, "Reset lost START event\n");
> +			atomic_set(&i2c_imx->last_error, -EBUSY);
> +		}
> +		i2c_imx->start_retry_cnt = 0;
> +		return 0;
> +	case EVT_AL:
> +		i2c_imx_clear_ial_bit(i2c_imx);
> +		break;
> +	case EVT_SI:
> +		set_state(i2c_imx, STATE_SLAVE);
> +		i2c_imx_slave_process_irq(i2c_imx);
> +		break;
> +	case EVT_START:
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if ((reg & I2SR_IBB) != 0) {
> +			atomic_set(&i2c_imx->last_error, -EBUSY);
> +			break;
> +		}
> +
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		reg |= I2CR_MSTA;
> +		imx_i2c_write_reg(reg, i2c_imx, IMX_I2C_I2CR);
> +		set_state(i2c_imx, STATE_SP);
> +		i2c_imx->start_retry_cnt = 0;
> +		return 0;
> +	case EVT_STOP:
> +	case EVT_POLL:
> +	default:
> +		break;
> +	}
> +
> +	return STATE_WAIT_TIME;
> +}
> +
> +static int master_evt_handler(struct imx_i2c_struct *i2c_imx,
> +			      unsigned int event)
> +{
> +	switch (event) {
> +	case EVT_ENTRY:
> +		i2c_imx->start_retry_cnt = 0;
> +		return 0;
> +	case EVT_AL:
> +		set_state(i2c_imx, STATE_IDLE);
> +		break;
> +	case EVT_SI:
> +		break;
> +	case EVT_START:
> +		atomic_set(&i2c_imx->last_error, -EBUSY);
> +		break;
> +	case EVT_STOP:
> +		imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> +				IMX_I2C_I2SR);

Alignment should match open parenthesis.

> +		imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode | I2CR_IIEN,
> +				i2c_imx, IMX_I2C_I2CR);

Alignment should match open parenthesis.

> +
> +		i2c_imx->stopped = 1;
> +		udelay(50);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
#352: FILE: drivers/i2c/busses/i2c-imx.c:717:
+		udelay(50);


> +		set_state(i2c_imx, STATE_IDLE);
> +		return 0;
> +	case EVT_POLL:
> +	default:
> +		break;
> +	}
> +
> +	return STATE_WAIT_TIME;
> +}
> +
> +static int slave_evt_handler (struct imx_i2c_struct *i2c_imx,

Please drop the space         ^^^^

> +			      unsigned int event)
> +{
> +	u8 reg, data;
> +
> +	switch (event) {
> +	case EVT_ENTRY:
> +		if (atomic_read(&i2c_imx->last_error) == -EUNDEFINED) {
> +			dev_dbg(&i2c_imx->adapter.dev, "Reset lost START event\n");
> +			atomic_set(&i2c_imx->last_error, -EBUSY);
> +		}
> +		i2c_imx->start_retry_cnt = 0;
> +		i2c_imx->slave_poll_cnt = 0;
> +		return 0;
> +	case EVT_AL:
> +		set_state(i2c_imx, STATE_IDLE);
> +		break;
> +	case EVT_START:
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		atomic_set(&i2c_imx->last_error, -EBUSY);
> +		break;
> +	case EVT_STOP:
> +		break;
> +	case EVT_SI:
> +		i2c_imx_slave_process_irq(i2c_imx);
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if ((reg & I2SR_IBB) == 0) {
> +			data = 0;
> +			set_state(i2c_imx,  STATE_IDLE);
> +			dev_dbg(&i2c_imx->adapter.dev, "end of package");
> +			i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &data);
> +		}
> +		if (i2c_imx->slave_poll_cnt > 10) {
> +			dev_err(&i2c_imx->adapter.dev,
> +				"Too much slave loops (%i)\n",
> +				i2c_imx->slave_poll_cnt);
> +		}
> +
> +		i2c_imx->slave_poll_cnt = 0;
> +		break;
> +	case EVT_POLL:
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if ((reg & I2SR_IBB) == 0) {
> +			data = 0;
> +			set_state(i2c_imx,  STATE_IDLE);
> +			dev_dbg(&i2c_imx->adapter.dev, "end of package");
> +			i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &data);
> +			if (i2c_imx->slave_poll_cnt > 10) {
> +				dev_err(&i2c_imx->adapter.dev,
> +					"Too much slave loops (%i)\n",
> +					i2c_imx->slave_poll_cnt);
> +			}
> +
> +			i2c_imx->slave_poll_cnt = 0;
> +		}
> +
> +		/*
> +		 * TODO: do "dummy read" if no interrupts or stop condition
> +		 * for more then 10 wait loops
> +		 */
> +		i2c_imx->slave_poll_cnt += 1;
> +		if (i2c_imx->slave_poll_cnt % 10 == 0)
> +			imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return STATE_MIN_WAIT_TIME;
> +}
> +
> +static int sp_evt_handler (struct imx_i2c_struct *i2c_imx, unsigned int event)

Please drop the space      ^^^^

> +{
> +	u8 reg;
> +
> +	switch (event) {
> +	case EVT_AL:
> +		dev_dbg(&i2c_imx->adapter.dev, "Lost arbitration on START");
> +		atomic_set(&i2c_imx->last_error, -EAGAIN);
> +		set_state(i2c_imx, STATE_IDLE);
> +		return 0;
> +	case EVT_SI:
> +		set_state(i2c_imx, STATE_IDLE);
> +		evt_put(&i2c_imx->events, EVT_SI);
> +	case EVT_START:
> +		atomic_set(&i2c_imx->last_error, -EBUSY);
> +		break;
> +	case EVT_STOP:
> +		break;
> +	case EVT_ENTRY:
> +		return 0;
> +	case EVT_POLL:
> +		reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +		if ((reg & I2SR_IBB) && !(reg & I2SR_IAL)) {
> +

Please drop the empty line above.

> +			set_state(i2c_imx,  STATE_MASTER);
> +			reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +
> +			i2c_imx->stopped = 0;
> +			reg |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> +			reg &= ~I2CR_DMAEN;
> +			imx_i2c_write_reg(reg, i2c_imx, IMX_I2C_I2CR);
> +			atomic_set(&i2c_imx->last_error, 0);
> +			i2c_imx->start_retry_cnt = 0;
> +			return 0;
> +		}
> +		break;
> +	default:
> +		break;
> +

Please drop the empty line above.

> +	}
> +
> +	if (i2c_imx->start_retry_cnt++ < 100) {
> +		dev_dbg(&i2c_imx->adapter.dev,
> +			"wait for busy cnt = %i evt = %i",
> +			i2c_imx->start_retry_cnt, event);
> +	} else {
> +

Please drop the empty line above.

> +		dev_dbg(&i2c_imx->adapter.dev, "start timeout");
> +		i2c_imx->start_retry_cnt = 0;
> +		atomic_set(&i2c_imx->last_error, -ETIMEDOUT);
> +		set_state(i2c_imx, STATE_IDLE);
> +		return STATE_WAIT_TIME;
> +	}
> +
> +	return STATE_MIN_WAIT_TIME;
> +}
> +
> +static void set_state(struct imx_i2c_struct *i2c_imx, unsigned int new)
> +{
> +	i2c_imx->state = new;
> +
> +	switch (new) {
> +	case STATE_IDLE:
> +		idle_evt_handler(i2c_imx, EVT_ENTRY);
> +		break;
> +	case STATE_SLAVE:
> +		slave_evt_handler(i2c_imx, EVT_ENTRY);
> +		break;
> +	case STATE_SP:
> +		sp_evt_handler(i2c_imx, EVT_ENTRY);
> +		break;
> +	case STATE_MASTER:
> +		master_evt_handler(i2c_imx, EVT_ENTRY);
> +		break;
> +	}
> +}
> +
> +

Please drop one empty line above.

> +static int i2c_imx_slave_threadfn(void *pdata)
> +{
> +	unsigned int event, delay;
> +	struct imx_i2c_struct *i2c_imx = (struct imx_i2c_struct *) pdata;

Please remove the cast and swap the lines.

> +
> +	do {
> +

Please drop one empty line above.

> +		event = evt_get(&i2c_imx->events);
> +		if (event == EVT_INVALID)
> +			event = EVT_POLL;
> +
> +		switch (i2c_imx->state) {
> +		case STATE_IDLE:
> +			delay = idle_evt_handler(i2c_imx, event);
> +			break;
> +		case STATE_SLAVE:
> +			delay = slave_evt_handler(i2c_imx, event);
> +			break;
> +		case STATE_SP:
> +			delay = sp_evt_handler(i2c_imx, event);
> +			break;
> +		case STATE_MASTER:
> +			delay = master_evt_handler(i2c_imx, event);
> +			break;
> +		default:
> +			delay = 0;
> +			break;
> +		}
> +
> +		if (delay)
> +			wait_event_interruptible_timeout(i2c_imx->state_queue,
> +				(evt_is_empty(&i2c_imx->events) == 0),
> +				delay);

I would propose to add here the handling of the return value of
wait_event_interruptible_timeout()

> +
> +	} while (kthread_should_stop() == 0);
> +
> +	return 0;
> +}
> +
> +static int i2c_imx_reg_slave(struct i2c_client *slave)
> +{
> +	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(slave->adapter);
> +	int result;
> +	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
> +
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +
> +	if (i2c_imx->slave)
> +		return -EBUSY;
> +
> +	if (slave->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;
> +
> +	i2c_imx->slave = slave;
> +
> +	/* Set the Slave address */
> +	imx_i2c_write_reg((i2c_imx->slave->addr << 1), i2c_imx, IMX_I2C_IADR);
> +
> +	result = i2c_imx_hw_start(i2c_imx);
> +	if (result != 0)

if (result)

> +		return result;
> +
> +	i2c_imx->slave_task = kthread_run(i2c_imx_slave_threadfn,
> +		(void *)i2c_imx, "i2c-slave-%s", i2c_imx->adapter.name);

(void *) cast is unneeded.

> +
> +	sched_setscheduler(i2c_imx->slave_task, SCHED_FIFO, &param);

i2c_imx->slave_task may be set to a ERR_PTR() value, please move this line
after the check for a potential error.

> +
> +	if (IS_ERR(i2c_imx->slave_task))
> +		return PTR_ERR(i2c_imx->slave_task);
> +
> +	i2c_imx_slave_init(i2c_imx);
> +
> +	return 0;
> +

Please drop the emtpy line above.

> +}
> +
> +static int i2c_imx_unreg_slave(struct i2c_client *slave)
> +{
> +	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(slave->adapter);
> +
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +	if (i2c_imx->slave_task != NULL)

Who does set "i2c_imx->slave_task" to NULL ?

Here it looks like a redundant check, please confirm.

> +		kthread_stop(i2c_imx->slave_task);
> +
> +	wake_up(&i2c_imx->state_queue);
> +
> +	i2c_imx->slave_task = NULL;
> +
> +	i2c_imx->slave = NULL;
> +
> +	i2c_imx_stop(i2c_imx);
> +
> +	return 0;
> +}
> +
> +

Please drop one of two empty lines above.

> +#else
> +
> +static void evt_init(struct evt_queue *stk)
> +{
> +	return;
> +}
> +
> +static unsigned int evt_put(struct evt_queue *stk, unsigned int evt)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>  {
> -	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10);
> +	wait_event_timeout(i2c_imx->queue, i2c_imx->master_interrupt,
> +				STATE_WAIT_TIME);
>
> -	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> +	if (unlikely(!(i2c_imx->master_interrupt))) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
>  		return -ETIMEDOUT;
>  	}
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
> -	i2c_imx->i2csr = 0;
> +	i2c_imx->master_interrupt = 0;
>  	return 0;
>  }
>
> @@ -510,27 +1052,92 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
>  #endif
>  }
>
> +static int i2c_imx_configure_clock(struct imx_i2c_struct *i2c_imx)
> +{
> +	int result;
> +
> +	i2c_imx_set_clk(i2c_imx);
> +
> +	result = clk_prepare_enable(i2c_imx->clk);
> +	if (result == 0)

if (!result)

> +		imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
> +
> +	return result;
> +}
> +
> +static void i2c_imx_enable_i2c_controller(struct imx_i2c_struct *i2c_imx)
> +{
> +	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> +		IMX_I2C_I2SR);
> +	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx,
> +		IMX_I2C_I2CR);
> +
> +	/* Wait controller to be stable */
> +	udelay(50);
> +}
> +
> +static int i2c_imx_hw_start(struct imx_i2c_struct *i2c_imx)
> +{
> +	int result;
> +
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +
> +	result = i2c_imx_configure_clock(i2c_imx);
> +	if (result != 0)
> +		return result;
> +	i2c_imx_enable_i2c_controller(i2c_imx);
> +	return 0;
> +}
> +
> +
>  static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>  {
>  	unsigned int temp = 0;
> -	int result;
> +	int result, cnt = 0;
>
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>
> -	i2c_imx_set_clk(i2c_imx);
> +	if (i2c_imx->slave_task != NULL) {

if (i2c_imx->slave_task)

>
> -	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
> -	/* Enable I2C controller */
> -	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
> -	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx, IMX_I2C_I2CR);
> +		atomic_set(&i2c_imx->last_error, -EUNDEFINED);
> +		if (evt_put(&i2c_imx->events, EVT_START) != 0) {
> +			dev_err(&i2c_imx->adapter.dev,
> +				"Event buffer overflow\n");
> +			return -EBUSY;
> +		}
>
> -	/* Wait controller to be stable */
> -	usleep_range(50, 150);
> +		wake_up(&i2c_imx->state_queue);
> +
> +		while ((result = atomic_read(&i2c_imx->last_error)) == -EUNDEFINED) {
> +			schedule();
> +
> +			/* TODO: debug workaround - start hung monitoring */
> +			cnt++;
> +			if (cnt == 500000) {
> +				dev_err(&i2c_imx->adapter.dev,
> +					"Too many start loops\n");
> +				imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
> +						i2c_imx, IMX_I2C_I2CR);
> +				i2c_imx_enable_i2c_controller(i2c_imx);
> +				imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode | I2CR_IIEN,
> +						i2c_imx, IMX_I2C_I2CR);
> +
> +				return -ETIMEDOUT;
> +			}
> +
> +		};

Please drop the trailing semicolon.

> +		return result;
> +	}
> +
> +	result = i2c_imx_hw_start(i2c_imx);
> +	if (result != 0)

if (result)

> +		return result;
>
>  	/* Start I2C transaction */
>  	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>  	temp |= I2CR_MSTA;
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
>  	result = i2c_imx_bus_busy(i2c_imx, 1);
>  	if (result)
>  		return result;
> @@ -542,10 +1149,9 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>  	return result;
>  }
>
> -static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> +static void i2c_imx_hw_stop(struct imx_i2c_struct *i2c_imx)
>  {
>  	unsigned int temp = 0;
> -

Please don't drop this empty line.

>  	if (!i2c_imx->stopped) {
>  		/* Stop I2C transaction */
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> @@ -555,6 +1161,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>  			temp &= ~I2CR_DMAEN;
>  		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  	}
> +
>  	if (is_imx1_i2c(i2c_imx)) {
>  		/*
>  		 * This delay caused by an i.MXL hardware bug.
> @@ -568,24 +1175,58 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>  		i2c_imx->stopped = 1;
>  	}
>
> -	/* Disable I2C controller */
> -	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
> +	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN;
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	clk_disable_unprepare(i2c_imx->clk);
> +
> +}

Please drop the empty line before closing curly bracket.

> +
> +static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> +{
> +	if (i2c_imx->slave == NULL) {

if (!i2c_imx->slave)

> +		i2c_imx_hw_stop(i2c_imx);
> +	} else {
> +

Please drop the empty line above.

> +		dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +
> +		evt_put(&i2c_imx->events, EVT_STOP);
> +		wake_up(&i2c_imx->state_queue);
> +	}
> +}
> +
> +static void i2c_imx_clear_isr_bit(struct imx_i2c_struct *i2c_imx,
> +	unsigned int status)

Alignment should match open parenthesis.

> +{
> +	status &= ~I2SR_IIF;
> +	status |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> +	imx_i2c_write_reg(status, i2c_imx, IMX_I2C_I2SR);
>  }
>
> +
> +

No new empty lines here please.

>  static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  {
>  	struct imx_i2c_struct *i2c_imx = dev_id;
> -	unsigned int temp;
> +	unsigned int status, ctl;
> +
> +	status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +	ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	if (status & I2SR_IIF) {
> +		i2c_imx_clear_isr_bit(i2c_imx, status);
> +
> +		if (ctl & I2CR_MSTA) {
> +			dev_dbg(&i2c_imx->adapter.dev, "master interrupt");
> +			i2c_imx->master_interrupt = 1;
> +			wake_up(&i2c_imx->queue);
> +		} else if (status & I2SR_IAL) {
> +			evt_put(&i2c_imx->events, EVT_AL);
> +		} else {
> +			dev_dbg(&i2c_imx->adapter.dev, "slave interrupt");
> +			evt_put(&i2c_imx->events, EVT_SI);
> +			wake_up(&i2c_imx->state_queue);
> +		}
>
> -	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> -	if (temp & I2SR_IIF) {
> -		/* save status register */
> -		i2c_imx->i2csr = temp;
> -		temp &= ~I2SR_IIF;
> -		temp |= (i2c_imx->hwdata->i2sr_clr_opcode & I2SR_IIF);
> -		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> -		wake_up(&i2c_imx->queue);
>  		return IRQ_HANDLED;
>  	}
>
> @@ -895,7 +1536,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>
>  	/* Start I2C transfer */
>  	result = i2c_imx_start(i2c_imx);
> -	if (result) {
> +	if (result == -ETIMEDOUT) {
> +		/*
> +		 * Recovery is not started on arbitration lost, since it can
> +		 * break slave transfer. But in case of "bus timeout" recovery
> +		 * it could be useful to bring controller out of "strange state".
> +		 */
> +		dev_dbg(&i2c_imx->adapter.dev, "call bus recovery");
>  		if (i2c_imx->adapter.bus_recovery_info) {
>  			i2c_recover_bus(&i2c_imx->adapter);
>  			result = i2c_imx_start(i2c_imx);
> @@ -1040,6 +1687,10 @@ static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  static struct i2c_algorithm i2c_imx_algo = {
>  	.master_xfer	= i2c_imx_xfer,
>  	.functionality	= i2c_imx_func,
> +#ifdef CONFIG_I2C_SLAVE
> +	.reg_slave	= i2c_imx_reg_slave,
> +	.unreg_slave	= i2c_imx_unreg_slave,
> +#endif
>  };
>
>  static int i2c_imx_probe(struct platform_device *pdev)
> @@ -1099,6 +1750,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(i2c_imx->pinctrl)) {
> +		ret = PTR_ERR(i2c_imx->pinctrl);
> +		goto clk_disable;
> +	}
> +

This change is irrelevant to slave support and questionalble, please drop it.

>  	/* Request IRQ */
>  	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
>  				pdev->name, i2c_imx);
> @@ -1109,6 +1766,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>
>  	/* Init queue */
>  	init_waitqueue_head(&i2c_imx->queue);
> +	init_waitqueue_head(&i2c_imx->state_queue);
>
>  	/* Set up adapter data */
>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> @@ -1160,6 +1818,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	/* Init DMA config if supported */
>  	i2c_imx_dma_request(i2c_imx, phy_addr);
>
> +	/* init slave_state to IDLE */
> +	i2c_imx->state = STATE_IDLE;
> +	evt_init(&i2c_imx->events);

Please insert an empty line here to impreove readability.

>  	return 0;   /* Return OK */
>
>  rpm_disable:
> @@ -1186,6 +1847,9 @@ static int i2c_imx_remove(struct platform_device *pdev)
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
>  	i2c_del_adapter(&i2c_imx->adapter);
>
> +	if (i2c_imx->slave_task != NULL)

if (i2c_imx->slave_task)

> +		kthread_stop(i2c_imx->slave_task);
> +
>  	if (i2c_imx->dma)
>  		i2c_imx_dma_free(i2c_imx);
>
>

The patch contains changes to controller start/stop sequences, this part
is better to separate into another patch, if possible.

Review of more important functional changes, which include changes to the
I2C master functionality, are postponed until we are done with bike shedding.

--
With best wishes,
Vladimir
