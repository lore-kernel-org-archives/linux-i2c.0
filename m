From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 6/8] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Tue, 31 Mar 2020 12:39:49 -0700
Message-ID: <20200331193949.GK199755@google.com>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-7-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1585652976-17481-7-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Akash,

On Tue, Mar 31, 2020 at 04:39:34PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
>  - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
> Changes in V3:
>  - As per Matthias comment, use common library APIs defined in geni-se
>    driver for ICC functionality.
> 
>  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 8c5d97c..2befe72 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -965,6 +965,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>  
> +	/*
> +	 * Bump up BW vote on CPU path as driver supports FIFO mode only.
> +	 * Assume peak_bw as twice of avg_bw.
> +	 */
> +	port->se.from_cpu.avg_bw = Bps_to_icc(baud);
> +	port->se.from_cpu.peak_bw = Bps_to_icc(2 * baud);
> +	geni_icc_vote_on(&port->se);
> +
>  	/* parity */
>  	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>  	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
> @@ -1202,11 +1210,14 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  	if (old_state == UART_PM_STATE_UNDEFINED)
>  		old_state = UART_PM_STATE_OFF;
>  
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> +		geni_icc_vote_on(&port->se);
>  		geni_se_resources_on(&port->se);
> -	else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON)
> +	} else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		geni_icc_vote_off(&port->se);
> +	}
>  }
>  
>  static const struct uart_ops qcom_geni_console_pops = {
> @@ -1304,6 +1315,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  	}
>  
> +	ret = geni_icc_get(&port->se, "qup-core", "qup-config", NULL);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	port->se.to_core.avg_bw = console ? GENI_DEFAULT_BW :
> +		Bps_to_icc(CORE_2X_50_MHZ);
> +	port->se.to_core.peak_bw = console ? GENI_DEFAULT_BW :
> +		Bps_to_icc(CORE_2X_100_MHZ);

I'm still unconvinced about the setting of the core bandwidth based on
whether the port is used as console or not. It could possibly break
consoles working at speeds > 115kbs and reserve more bandwidth than
necessary for ports with 'slow' devices.

Why not scale the core bandwidth dynamically? You said earlier that there
is no clear/linear translation of port speed to bandwidth, but you could
use the same logic that is implicitly used here:

	if (baudrate <= 115200) {
		avg_bw = GENI_DEFAULT_BW;
		peak_bw = GENI_DEFAULT_BW;
	} else {
		avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
		peak_bw = Bps_to_icc(CORE_2X_100_MHZ);
	}

This would be more robust, power efficient and future readers of the
code don't have to wonder "why is the console special?" when our
discussions on this will be long forgotten.
