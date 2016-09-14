From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v5] i2c: mux: mellanox: add driver
Date: Wed, 14 Sep 2016 09:49:45 +0200
Message-ID: <eb927385-4598-2fd0-8200-7d6c4945569f@axentia.se>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-09-13 22:37, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> This driver allows I2C routing controlled through CPLD select registers on
> a wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).

*snip*

> +/* Platform data for the CPLD I2C multiplexers */
> +
> +/* mlxcpld_mux_plat_data - per mux data, used with i2c_register_board_info
> + * @adap_ids - adapter array
> + * @num_adaps - number of adapters
> + * @sel_reg_addr - mux select register offset in CPLD space
> + */
> +struct mlxcpld_mux_plat_data {
> +	int *adap_ids;
> +	int num_adaps;
> +	int sel_reg_addr;
> +};
> +
> +#endif /* _LINUX_I2C_MLXCPLD_H */
> 

Hmm, you never confirmed that you need to support different register
values in the CPLD with sel_reg_addr. I can see that there is a
possibility that you actually really need it, but I'd like to remove
that variable if at all possible.

If you can confirm that you need that, this is

Acked-by: Peter Rosin <peda@axentia.se>

Otherwise, please just hard code the register address.

Cheers,
Peter
