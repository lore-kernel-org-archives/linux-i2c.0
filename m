From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO expander
	driver
Date: Fri, 10 Oct 2008 09:22:02 -0500
Message-ID: <683C10AE-E5F2-4196-B2C7-1E1CC317EC24@kernel.crashing.org>
References: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org, Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org


On Sep 23, 2008, at 9:13 AM, Anton Vorontsov wrote:

> On MPC8349E-mITX, MPC8315E-RDB and MPC837x-RDB boards there is a
> Freescale MC9S08QG8 (MCU) chip with the custom firmware
> pre-programmed. The chip is used to power-off the board by the
> software, and to control some GPIO pins.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/i2c/chips/Kconfig            |   11 ++
> drivers/i2c/chips/Makefile           |    1 +
> drivers/i2c/chips/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 221 insertions(+), 0 deletions(-)
> create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

is the plan to connect ppc_md.machine_shutdown() with this?

- k
