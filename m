From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
Date: Wed, 14 Oct 2009 20:53:27 +0200
Message-ID: <20091014185327.GD11789@tarshish>
References: <4AD3E974.8080200@necel.com>
 <4AD3EBDD.50105@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4AD3EBDD.50105@necel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

Hi Shinya,

On Tue, Oct 13, 2009 at 11:54:21AM +0900, Shinya Kuribayashi wrote:
> This will ease our testing a bit with i2c-tools.  Note that DW I2C core
> doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
> addressing-only I2C transactions.

Is this supposed to be applied to mainline?

baruch

> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> ---
> drivers/i2c/busses/i2c-designware.c |    9 ++++++++-
> 1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index 6f85e28..80c8b8a 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -529,7 +529,14 @@ done:
> 
> static u32 i2c_dw_func(struct i2c_adapter *adap)
> {
> -	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> +	return	I2C_FUNC_I2C |
> +		I2C_FUNC_10BIT_ADDR |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK |
> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;
> }
> 
> static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
> -- 
> 1.6.5
> 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
