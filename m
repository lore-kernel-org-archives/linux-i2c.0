From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/5] i2c: MPC837xRDB Power Management and GPIO expander
	driver
Date: Thu, 27 Mar 2008 23:02:34 +0300
Message-ID: <20080327200234.GA17818@localhost.localdomain>
References: <20080326202511.GD1772@localhost.localdomain>
	<20080327171044.GA1582@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20080327171044.GA1582@localhost.localdomain>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: i2c@lm-sensors.org
Cc: linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Incidentally I used some weird .config without preemption and
CONFIG_ENABLE_MUST_CHECK. Heh.

[...]
> + * I don't have specifications for the MCU firmware that is used on the
> + * MPC8349E-mITX/MPC837XRDB boards, I found this register and bits positions
> + * by the trial&error method.
> + */
> +#define MCU_REG_CTRL	0x20
> +#define MCU_CTRL_POFF	0x40
> +#define MCU_NUM_GPIO	2
> +
> +struct mcu {
> +	spinlock_t lock;

This should be mutex of course, otherwise preemptable kernel
will complain.

[...]
> +	gpiochip_remove(&mcu->of_gc.gc);

Should check return value.

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
