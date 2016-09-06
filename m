From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch 2/2] i2c: mux: mellanox: add driver
Date: Tue, 6 Sep 2016 13:00:16 +0200
Message-ID: <28257715-935c-a924-ecc6-e58e109a79f8@axentia.se>
References: <1472492176-195844-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472492176-195844-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-08-29 19:36, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> This driver allows I2C routing controlled through CPLD select registers on
> wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).
> 
> Connectivity schema.
> i2c-mlxcpld                                 Digital               Analog
> driver
> *--------*                                 * -> mux1 (virt bus2) -> mux ->|
> | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux ->|
> | bridge | bus 1                 *---------*                              |
> | logic  |---------------------> * mux reg *                              |
> | in CPLD|                       *---------*                              |
> *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux ->|
>     |        driver                   |                                   |
>     |        *---------------*        |                             Devices
>     |        * CPLD (LPC bus)* select |
>     |        * registers for *--------*
>     |        * mux selection * deselect
>     |        *---------------*
>     |                 |
> <-------->     <----------->
> i2c cntrl      Board cntrl reg
> reg space      space (mux select,
>     |          IO, LED, WD, info)
>     |                 |                  *-----*   *-----*
>     *------------- LPC bus --------------| PCH |---| CPU |
>                                          *-----*   *-----*
> 
> i2c-mux-mlxpcld does not necessary required i2c-mlxcpld. It can be use
> along with another bus driver, and still control i2c routing through CPLD
> mux selection, in case the system is equipped with CPLD capable of mux
> selection control.
> 
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/muxes/Kconfig:config I2C_MUX_MLXCPLD
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>

BTW, it just occurred to me that you could perhaps use (and extend if
needed) the i2c_mux_reg driver for the lpc_access cases. Have you
explored that option? It looks like a nice fit, and limiting this new
driver to i2c_access would make it significantly simpler with only
one device (mux module) and one access method (i2c) to support.

Cheers,
Peter
