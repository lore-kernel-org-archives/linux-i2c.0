From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 23 May 2008 09:21:41 +0200
Message-ID: <20080523092141.2f408a17@hyperion.delvare>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1210883799-25188-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

One thing I forgot in my initial review:

On Thu, 15 May 2008 22:36:39 +0200, Wolfram Sang wrote:
> +	/* Use I2C operations unless we're stuck with SMBus extensions. */
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		if (chip->flags & AT24_EE_ADDR2) {
> +			err = -ECOMM;
> +			goto fail;
> +		}
> +		if (!i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +			err = -EBADMSG;
> +			goto fail;
> +		}
> +		use_smbus = true;
> +	}

For a read-only EEPROM, you only need I2C_FUNC_SMBUS_READ_I2C_BLOCK,
not I2C_FUNC_SMBUS_I2C_BLOCK. It would matter if the underlying adapter
supports I2C block read but not I2C block write.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
